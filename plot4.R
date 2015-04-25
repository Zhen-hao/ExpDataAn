# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Selecting data for Coal 
## Based on the goverment documment available on "http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf", we know that this is the correct way to select the subset of SCC that is coal combustion-related. 
subSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal", "Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal"))
sources <- subSCC[,c("SCC","EI.Sector")]
coalEm <- subset(NEI, SCC %in% sources$SCC)

## Because the instruction of the project is not very clear whether we need to show the changes of total emissions of all coal sourses 
## or show the changes by each sourse, we chose to show the changes with all coal-related sourses combined. 
library(reshape2)
meltData <- melt(coalEm,id = "year", measure.vars="Emissions")
totalCoalEmissions <- dcast(meltData, year ~ variable,sum)

g <- ggplot(coalEmissions, aes(year, Emissions))
g + geom_point() + geom_smooth(method="lm", col="steelblue") + ggtitle("US Yearly Total PM2.5 Emissions\n from coal combustion-related sources") + ylab("Total PM2.5 Emissions of the year \n (tons)")


dev.copy(png, file="plot4.png")

dev.off()


