# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##Selecting data for Coal 
## Based on the goverment documment available on "http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf", we know that this is the correct way to select the subset of SCC that is coal combustion-related. 
mobVehSCC <- subset(SCC, EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles"))

##subletting from NEI data for car emission in Baltimore
carEmBal <- subset(NEI, SCC %in% mobVehSCC$SCC & fips == "24510")

library(reshape2)
##get car emission in Baltimore for each year 
meltDataB <- melt(carEmBal ,id = "year", measure.vars="Emissions")
CarEmissionsB <- dcast(meltDataB, year ~ variable,sum)

##subletting from NEI data for car emission in Baltimore
carEmLA <- subset(NEI, SCC %in% mobVehSCC$SCC & fips == "06037")

##get car emission in LA for each year 
meltDataLA <- melt(carEmLA ,id = "year", measure.vars="Emissions")
CarEmissionsLA <- dcast(meltDataLA, year ~ variable,sum)


png("plot6.png")
# CarEmissionsLA
# CarEmissionsB
par(mar=c(5,5,4,2))
with(CarEmissionsLA, plot(year,Emissions,main="Yearly PM2.5 Emissions in Baltimore City \n and Los Angeles County from motor vehicles",
                          type="p",pch=16, col="blue", ylim=c(0, 5000), xlab="year",ylab="Total PM2.5 Emissions of the year \n (tons)"))
with(CarEmissionsLA, 
     lines(x=year , y=Emissions, col="blue")
)
abline(h = c(min(CarEmissionsLA$Emissions),max(CarEmissionsLA$Emissions)), lty = 2,col="blue")

with(CarEmissionsB, 
     points(x=year , y=Emissions, col="red",type="p",pch=16)
)
with(CarEmissionsB, 
     lines(x=year , y=Emissions, col="red")
)

abline(h = c(min(CarEmissionsB$Emissions),max(CarEmissionsB$Emissions)), lty = 2,col="red")

legend("center", lty=2,pch = 16, col = c("blue","red"), legend = c("LA County", "Baltimore City"))

dev.off()


