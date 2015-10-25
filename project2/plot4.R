"
4. Across the United States, how have emissions from
coal combustion-related sources changed from 1999–2008?
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(ggplot2)

# Find SCC rows related to combustion
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
# Find SCC rows related to coal
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
# Find SCC rows related to both combustion and coal
coalCombustionRelated <- combustion & coal
# Obtain SCC codes related to coal and combustion
coalCombustionCode <- SCC[coalCombustionRelated,]$SCC

# Aggregate emission amount by year
coalCombustPM25 <- aggregate(Emissions ~ year, NEI[NEI$SCC %in% coalCombustionCode,], sum)

# Plot
ggplot(data=coalCombustPM25, aes(x=factor(year),y=Emissions))+
  geom_bar(stat="identity")+
  guides(fill=FALSE)+
  labs(title="Total Emissions Year Over Year in Tons - Coal- and Combustion-Related")+
  labs(x="Year",y="Emission in Tons")

dev.copy(png, file="plot4.png", width=480, height=480, units="px", bg="transparent")
dev.off()