# Lattice Plotting System (Part 1)
"
The lattice system is imlpemented using the following packages:
- lattice: contains code for producing Trellis graphics; includes functions like xyplot, bwplot, levelplot
- grid: implements a different graphing system independent of the base system; the lattice package
        builds on top of grid
- the lattice plotting system does not have a two-phase aspect with separate plotting and annotation like in base plotting
- All plotting and annotation is done at once with a single funciton call
"

# Lattice functions
"
- xyplot: main function for creating scatterplots
- bwplot: box-and-whiskers plots (boxplots)
- histogram: histograms
- stripplot: like a boxplot but with actual points
- dotplot: plot dots on violin strings
- splom: scatterplot matrix; like pairs in base plotting system
- levelplot, contourplot: for plotting image data
"

# Lattice functions
"
xyplot(y ~ x | f * g, data)
- we use the formula notation here, hence the ~
- on the left of the ~ is the y-axis variable, on the right is the x-axis variable
- f and g are conditioning variables - they are optional
-- the * indicates an interaction between two variables
- the second argument is the data frame or list from which the variables in the formula should be looked up
-- if no data frame or list is passed, then the parent frame is used
- if no other arguments are passed, there are defaults that can be used.
"

# Simple latticep plot
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data=airquality)

library(lattice)
library(datasets)
## Convert Month to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# Lattice behavior
"
- Lattice graphics functions return an object of class trellis
- lattice functions return plot objects that can, in principle, be stored
"

p <- xyplot(Ozone ~ Wind, data = airquality) ## Nothing happens
print(p) ## Plot appears

# Lattice Plotting System (Part 2)
# Lattice panel functions
"
- lattice functions have a panel function which controls what happens inside each panel of the plot
- the lattice package comes with default panel functions, but you can supply your own if you want to customize what happens in each panel
- panel functions receive the x/y coordinates of the data poitns in their panel
"

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x + f - f ** x + rnorm(100, sd=0.5)
f <- factor(f, labels=c("Group 1","Group 2"))
xyplot(y ~ x|f, layout=c(2,1)) # plot with 2 panels

## Custom panel function
xyplot(y ~ x | f, panel = function(x,y,...) {
  panel.xyplot(x,y,...) # first call the defaul panel function for xyplot
  panel.abline(h=median(y), lty=2) # add a horizontal line at the median
})

xyplot(y ~ x | f, panel = function(x,y,...) {
  panel.xyplot(x,y,...) # first call the defaul panel function for xyplot
  panel.lmline(x,y,col=2) # overlay a simple linear regression line
})

# Summary
"
- lattice plots are constructed using a single function call
- the lattice system is ideal for creating conditioning plots where you examine the same
  data under many different conditions
- panel functions can be specified / customized to modify what is plotted in each of the plot panels
"

# The ggplot2 System (Part 1)
# What is ggplot2?
"
- an implementation of the Grammar of Graphics by Lleland Wilkinson
- written by Hadley Wickham
- This verb, noun, adjective for graphing
"

# The basics: qplot()
"
- works much like the plot function in the base system
- looks for data in a data frame, similar to the lattice, or in the parent environment
- plots are made up of aesthetics (size, shape, color) and geoms (points, lines)
- ggplot() is the core function and very flexible for doing things qplot() cannot do
"

# The ggplot2 System (Part 2)
# Example dataset
library(ggplot2)
str(mpg)
mpg$drv

# ggplot2 "Hello, World!"
library(ggplot2)
qplot(displ, hwy, data=mpg) # qplot(x coordinates, y coordinates, data frame)

# Modifying aesthetics
qplot(displ, hwy, data=mpg, color=drv)

# Adding a geom
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

# Histograms
qplot(hwy, data=mpg, fill=drv)  # histograms are craeted by only specifying one coordinate

# Facets
## variable to the left of ~ indicates the row, to the right indicates columns
qplot(displ, hwy, data=mpg, facets=.~drv)
qplot(hwy, data=mpg, facets=drv~., binwidth=2)

# The ggplot2 System (Part 3)
# Building plots with ggplot2
"
plots are built up in layers
- plot the data
- overlay a summary
- metadata and annotation
"

# Building up in layers
head(maacs[,1:3]) ## Data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt)) ## Initial call to ggplot; includes aesthetics
summary(g) ## summary of ggplot object

# No plot yet!
> g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
> print(g)
Error: No layers in plot

> p<- g + geom_point() ## Explicitly save and print ggplot object
> print(p)

> g + geom_point() ## auto-print ggplot object without saving

# The ggplot2 System (Part 4)
# adding more layers: smooth
g + geom_point() + geom_smooth() # default: loes smoother
g + geom_point() + geom_smooth(method="lm") # linear regression

# adding more layers: facets
g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method="lm")

# Annotation
"
- labels: xlab(), ylab(), labs(), ggtitle()
- each of the geom functions has options to modify
- for things that only make sense globally, use theme()
-- example: theme(legend.position = 'none')
- two standard appearance themes are included
-- theme_gray(): the default theme (gray background)
-- theme_bw(): more stark/plain
"

# Modifying aesthetics
g + geom_point(color="steelblue", size=4, alpha=1/2)
g + geom_point(aes(color=bmicat), size=4, alpha=1/2)

# Modifying labels
...+labs(title="MAACS Cohort") + labs(x=expression("log " * PM[2.5]), y="Nocturnal Symptoms")+...

# The ggplot2 System (Part 5)
# A note about axis limits