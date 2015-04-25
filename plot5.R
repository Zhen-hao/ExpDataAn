# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##Selecting data for Coal 
## Based on the goverment documment available on "http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf", we know that this is the correct way to select the subset of SCC that is coal combustion-related. 
mobVehSCC <- subset(SCC, EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles"))

##subletting from NEI data for car emission in Baltimore
carEmBal <- subset(NEI, SCC %in% mobVehSCC$SCC & fips == "24510")

library(reshape2)
meltData <- melt(carEmBal ,id = "year", measure.vars="Emissions")
CarEmissions <- dcast(meltData, year ~ variable,sum)


g <- ggplot(CarEmissions, aes(year, Emissions))
g + geom_point() + geom_smooth(method="lm", col="steelblue") + ggtitle("Baltimore Yearly PM2.5 Emissions\n from motor vehicles") + ylab("Total PM2.5 Emissions of the year \n (tons)")


dev.copy(png, file="plot5.png")

dev.off()

