"
1. Have total emissions from PM2.5 decreased in the United States from 1999
to 2008? Using the base plotting system, make a plot showing the total
PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
and 2008.
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(base)

# Select entries with pollutants classified as PM25-PRI
NEI_PM25 <- NEI[NEI$Pollutant=="PM25-PRI",]

# Aggregate emissions by year
sumPm25 <- aggregate(Emissions ~ year, NEI_PM25, sum)

# Create plot
plot(x=sumPm25$year,y=sumPm25$Emissions, col="black",main="Total PM25 Emission Trend, Year Over Year", xlab="Year", ylab="Total Emissions in Tons", type="o")

# Create png file
dev.copy(png, file="plot1.png", width=480, height=480, units="px", bg="transparent")
dev.off()