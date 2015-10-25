"
2. Have total emissions from PM2.5 decreased in the
Baltimore City, Maryland (fips == "24510") from 1999 to
2008? Use the base plotting system to make a plot
answering this question.
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(base)

# Select entries within Baltimore City, Maryland
NEIBaltimore <- NEI[NEI$fips==24510,]

# Aggregate emissions by year
sumPm25 <- aggregate(Emissions ~ year, NEIBaltimore, sum)

# Create plot
plot(x=sumPm25$year,y=sumPm25$Emissions, col="black",main="Total PM25 Emission Trend In Baltimore, Year Over Year", xlab="Year", ylab="Total Emissions in Tons", type="o")

# Create png file
dev.copy(png, file="plot2.png", width=480, height=480, units="px", bg="transparent")
dev.off()