"
6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater
changes over time in motor vehicle emissions?
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(ggplot2)

# Subset Baltimore and LA data
NEIBaltimore <- NEI[NEI$fips=="24510",]
NEILosAngeles <- NEI[NEI$fips=="06037",]

# Obtain vehicle-related SCC
vehicleRelatedCode <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicleRelatedCode,]$SCC

# Baltimore
NEIBaltimoreVehicle <- NEIBaltimore[NEIBaltimore$SCC %in% vehicleSCC,]
sumPM25Baltimore <- aggregate(Emissions ~ year, NEIBaltimoreVehicle, sum)
sumPM25Baltimore$city <- "Baltimore City"

# Los Angeles
NEILosAngelesVehicle <- NEILosAngeles[NEILosAngeles$SCC %in% vehicleSCC,]
sumPM25LosAngeles <- aggregate(Emissions ~ year, NEILosAngelesVehicle, sum)
sumPM25LosAngeles$city <- "Los Angeles"

finalSumPM25 <- rbind(sumPM25Baltimore, sumPM25LosAngeles)

ggplot(finalSumPM25, aes(x=factor(year), y=Emissions, fill=city))+
  geom_bar(stat="identity")+
  facet_grid(scales="free", space="free", .~city)+
  labs(title="Total Emissions by City, Year Over Year")+
  labs(x="Year",y="Emissions in Tons")

dev.copy(png, file="plot6.png", width=720, height=720, units="px", bg="transparent")
dev.off()