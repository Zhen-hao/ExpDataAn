
# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Selecting data of Baltimore City
Baltimore <- subset(NEI, fips == "24510")

##Reshaping data for plot2
library(reshape2)
meltBal <- melt(Baltimore,id = "year", measure.vars="Emissions")
yearBal <- dcast(meltBal, year ~ variable,sum)

png("plot2.png")
par(mar=c(5,5,4,2))
with(yearBal, plot(year,Emissions,main="Yearly Total PM2.5 Emissions of Baltimore City",type="p", pch = 15,col=year, xlab="year",ylab="Total PM2.5 Emissions of the year \n (tons)"))
with(yearBal, 
     lines(x=year , y=Emissions, type="l")
)
abline(h = yearBal$Emissions, lwd = 2, lty = 2,col=yearBal$year)
legend("topright", pch = 15, col = yearBal$year, legend = yearBal$year)
dev.off()