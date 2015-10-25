"
3. Of the four types of sources indicated by the
type (point, nonpoint, onroad, nonroad) variable,
which of these four sources have seen decreases in
emissions from 1999–2008 for Baltimore City? Which have
seen increases in emissions from 1999–2008? Use the
ggplot2 plotting system to make a plot answer this
question.
"

# Read in appropriate files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Load base graphing package
library(ggplot2)

# Select entries within Baltimore City, Maryland
NEIBaltimore <- NEI[NEI$fips==24510,]

# Plot
ggplot(data=NEIBaltimore, aes(x=factor(year), y=Emissions, fill=type))+
  facet_grid(.~type, scales="free", space="free")+
  geom_bar(stat="identity") +
  guides(fill=FALSE) +
  labs(title="Total Emissions In Baltimore, Year Over Year by Type")+
  labs(x="Year", y="Total Emissions in Tons")

dev.copy(png, file="plot3.png", width=720, height=720, units="px", bg="transparent")
dev.off()