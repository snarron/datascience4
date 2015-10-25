# Q2
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)
" set of 3 panels showing the relationship between weight and time for each diet."

# Q4
p <- xyplot(Ozone ~ Wind | factor(Month), data=airquality)
print(p)
"The object 'p' has not yet been printed with the appropriate print method."

# Q7
library(datasets)
data(airquality)
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

# Q10

