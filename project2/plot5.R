"
5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(ggplot2)

# Get Baltimore data
NEIBaltimore <- NEI[NEI$fips==24510,]

# Get codes related to vehicles
vehicleRelatedCode <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicleRelatedCode,]$SCC
NEIBaltimoreVehicle <- NEIBaltimore[NEIBaltimore$SCC %in% vehicleSCC,]

# Aggregate emission amount by year
sumPM25 <- aggregate(Emissions ~ year, NEIBaltimoreVehicle, sum)

# Plot
ggplot(data=sumPM25, aes(x=factor(year), y=Emissions))+
  geom_bar(stat="identity")+
  labs(title="Total Emissions from Vehicles in Baltimore, Year Over Year")+
  labs(x="Year", y="Emission in Tons")

dev.copy(png, file="plot5.png", width=480, height=480, units="px", bg="transparent")
dev.off()