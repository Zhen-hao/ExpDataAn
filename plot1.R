
# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Reshaping data for plot1
library(reshape2)
meltData <- melt(NEI,id = "year", measure.vars="Emissions")
yearEmissions <- dcast(meltData, year ~ variable,sum)

#Coverting the units from ton to million tons
yearEmissions$Emissions <- yearEmissions$Emissions/1000000

png("plot1.png")
par(mar=c(5,5,4,2))
with(yearEmissions, 
     plot(year,Emissions,main="Yearly Total PM2.5 Emissions",type="p", pch = 17,col=year, xlab="year",ylab="Total PM2.5 Emissions of the year \n (million tons)")
)
with(yearEmissions, 
     lines(x=year , y=Emissions, type="l")
    )
abline(h = yearEmissions$Emissions, lwd = 2, lty = 2,col=yearEmissions$year)
legend("topright", pch = 17, col = yearEmissions$year, legend = yearEmissions$year)
dev.off()
