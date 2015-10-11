# Principles of Analytic Graphics
"
Principle 1: Show comparisons
- Evidence is always relative to another competing hypothesis.
- Always ask - 'compared to what?'

Principle 2: Show causality, mechanism, explanation, systematic structure
- What is your causal framework thinking about a question?

Principle 3: Show multivariate data
- multivariate = more than 2 variables
- the real world is multivariate
- need to 'escape flatland'

Principle 4: Integration of evidence
- completely integrate words, numbers, images, diagrams
- data graphics should make use of many modes of data presentation
- don't let the tool drive the analysis

Principle 5: Describe and document the evidence with appropriate labels, scales, sources, etc.
- a data graphic should tell a complete story that is credible

Principle 6: Content is king
- analytical presentations ultimately stand or fall depending on the quality, relevance, and integrity of their content
"

# Exploratory Graphs (Part 1)
# Data
pollution <- read.csv("./data/avgpm25.csv",colClasses=c("numberic","character","factor","numeric","numeric"))
head(pollution)

# Simple summaries of data
"
One dimension
- five-number summary
- boxplots
- histograms
- density plot
- barplot
"

# Five-number summary
summary(pollution$pm25)

# Boxplot
boxplot(pollution$pm25, col="blue")

# Histogram
hist(pollution$pm25, col="green")
rug(pollution$pm25)

hist(pollution$pm25, col="green", breaks=100) # you'll get a rougher histogram

# Overlaying features
boxplot(pollution$pm25, col="blue")
abline(h=12)

hist(pollution$pm25, col="green")
abline(v=12, lwd=2)
abline(v = median(pollution$pm25), col="magenta", lwd=4)

# Barplot
barplot(table(pollutions$region), col="wheat", main="Number of Counties in Each Region")

# Exploratory Graphs (Part 2)
"
Two-dimensions
- Multiple/overlayed 1-D plots
- scatterplots
- smooth scatterpots

> 2 dimensions
- overlayed/multiple 2-D plots
- use color, size, shape to add dimensions
- spinning plots
- actual 3-D plots
"
# Multiple boxplots
boxplot(pm25 ~ region, data=pollution, col="red")

# Multiple histograms
par(mfrow=c(2,1),mar=c(4,4,2,1))
hist(subset(pollution, region=="east")$pm25, col="green")
hist(subset(pollution, region=="west")$pm25, col="green")

# Scatterplot
with(pollution, plot(latitide, pm24))
abline(h=12, lwd=2, lty=2)

# Scatterplot - using color
with(pollution, plot(latitude, pm25, col=region))
abline(h=12, lwd=2, lty=2)

# Multiple scatterplots
par(mfrow=c(1,2),mar=c(5,4,2,1))
with(subset(pollution, region=="west"), plot(latitude, pm25, main="West"))
with(subset(pollution, region=="east"), plot(latitude, pm25, main="East"))

# Plotting Systems in R
# The base plotting system
"
- Artist's palette model
- start with blank canvas and build up form there
- start with plot function (or similar)
- use annotation functions to add/modify (text, lines, points, axis)

- convenient, and mirrors how we think of building plots and analyzing data
- can't go abck once plot has started; need to plan in advance
- difficult to translate to others once a new plot has been created
- plot is just a series of R commands
"

# Base plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# The lattice system
"
- plots are created with a simgle function call (xyplot, bwplot, etc.)
- most useful for conditioning types of plots: looking at how y changes with x across levels of z
- Things like margins / spacing set automatically becaue entire plot is specified at once
- good for putting many many plots on a screen

- sometimes awkward to specify an entire plot in a single function call
- annotation in plot is not especially intuitive
- use of panel functions and subscripts difficult to wield and requires intense preparation
- cannot addto a plot once it's created
"

# Lattice plot
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

# The ggplot2 system
"
- splits the difference between abse and lattice in a number of ways
- automatically deals with spacings, text, titles, but also allows you to annotate by adding to a plot
- superficial similarity to lattice but generally easier/more intuitive to use
- default mode makes many choices for you, but you can still customize to your heart's desire
"

# ggplot2 plot
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)

# Base Plotting System (Part 1)
# Plotting system
"
The core plotting and graphics engine in R is encapsulated in the following packages:
- graphics: contains plotting functions for the base graphing systems.
- grDevices: contains all the code implementing the various graphic devices

The lattice plotting system is implemented using the following packages:
- lattice: contains code for producing Trellis graphics, which are independent of the base graphing system.
- grid: implements a different graphing system independent of the base system.;
        the lattice package builds on top of grid.
"

# Base graphics
"
Two phases:
- initializing a new plot
- annotating / adding to an existing plot

Calling plot(x,y) or hist(x) will launch a graphics device.
If the arguments to plot are not of some special class, the the default method for plot is called.
The base graphics system has many parameters that can be set and tweaked (?par).
"

# Simple base graphics: histogram
library(datasets)
hist(airquality$Ozone) # Draw a new plot

# Simple base graphics: scatterplot
library(datasets)
with(airquality, plot(Wind, Ozone))

# Simple base graphics: boxplot
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone (ppb)")

# Some important base graphics params
"
- pch: the plotting symbol (def: open circle)
- lty: the line type (def: solid line)
- lwd: the line width
- col: the plotting color; the colors() function gives you a vector of colors by name
- xlab: character string for the x-axis label
- ylab: character string for the y-axis label

The par() function is used to specify global graphics params that affect all plots in an R session.
These params can be overridden when specified as arguments to specific plotting functions.
- las: the orientation of the axis labels on the plot
- bg: the background color
- mar: the margin size
- oma: the outer margin size (default is 0 for all sides)
- mfrow: number of plots per row, column (plots are filled row-wise)
- mfcol: number of plots per row, column (plots are filled column-wise)
"

# Base Plotting System (Part 2)
# Base plotting functions
"
- plot: make a scatterplot, or other types of plot
- lines: add lines to a plot
- points: add points to a plot
- text: add text labels to a plot usig specified x, y coordinates
- title: add annotations to x, y axis labels, title, subtitle, outer margin
- mtext: add arbitrary text to the margins (inner or outer) of the plot
- axis: adding axis ticks / labels
"

# Base plot with annotation
library(datasets)
with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New York City") # Add a title
#---
with(airquality, plot(Wind, Ozone), main="Ozone and Wind in New York City")
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))
#---
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", type="n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col="red"))
legend("topright", pch=1, col=c("blue","red"),legend=c("May", "Other Months"))

# Base plot with regression line
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City", pch=20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)

# Multiple base plots
par(mfrow=c(1,2))
with(airquality, {
  plot(Wind, Ozone, main="Ozone and Wind")
  plot(Solar.R, Ozone, main="Ozone and Slar Radiation")
  plot(Temp, Ozone, main="Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer=TRUE)
})

# Summary
"
Plots in the base plotting system are created by calling successive R functions to build up a plot
Plotting occurs in two stages:
- Creation of a plot
- Annotation of a plot
The base plotting system is very flexible and offers a high degree of control over plotting
"

# Graphics Devices in R
# What is a graphics device?
"
A graphics device is something where you can make a plot appear
- A window on your computer (screen device)
- A pdf file (file device)
- a jpeg file (file device)

The most common place for a plot to be sent is the screen device
- Mac: quartz()
- Windows: windows()
- Unix/Linus: x11()
"

# How does a plot get created?
"
Two basic approaches:
- call a plotting function like plot, xyplot, or quplot
- the plot appears on the screen device
- annotate plot if necesary
- enjoy
"
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser Ddata")

"
The second approach is most commonly used for file devices.
- explicitly launch a graphics device,
- call a plotting function to make a plot
- annotate plot if necessary
- explicitly close graphics device with dev.off() (this is very important)
"
pdf(file="myplot.pdf")
with(faithful, plot(eruptions, waiting))
title(main="Old Faithful Geyser data")
dev.off() # close pdf file device
## Now you can view the file myplot.pdf on your computer

# Graphics Devices in R (Part 2)
# Graphic file devices
"
Two basic types of file devices: vecor and bitmap
Vector formats:
- pdf: useful for line-type graphics
- svg: xml-based scalable vector graphics
- win.metafile: windows metafile format (windows only())
- postscript: older format, resizes well, usually portable; Windows systems often don't have a postscript viewer

Bitmap formats:
- png: lossless compression; most web browsers can read this natively; does not resize well
- jpeg: good for natural scenes, uses lossy compression; does not resize well; not great for line drawings
- tiff: creates bitmap files with lossless compression
- bmp: a native Windows bitmapped format
"

# Multiple open graphics devices
"
- it is possible to open multiple graphics devices
- plotting can occur only on one graphics device at a time
- every open graphics device is assigned an integer >=2
- you can change the active graphics device with dev.set(<integer>) where <integer> is the number associated with the graphics device
"

# Copying plots
"
- dev.copy: copy a plot from one device to another
- dev.copy2pdf: copy a plot to a pdf file
"
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data")
dev.copy(png, file="geyserplot.png")
dev.off()
