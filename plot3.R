
# Reading files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Selecting data of Baltimore City
Baltimore <- subset(NEI, fips == "24510")



##Reshaping data for plot3
library(reshape2)
meltBal <- melt(Baltimore,id = c("year","type"), measure.vars="Emissions")
yearBal <- dcast(meltBal, year + type ~ variable,sum)

##ploting
library(ggplot2)
#xlab(), ylab(), labs(), ggtitle()

g <- ggplot(yearBal, aes(year, Emissions))
g1 <- g + geom_point(aes(col=type),size = 4)
plot <- g1  + geom_line(aes(col=type)) 
plot + ggtitle("Baltimore City Yearly Total PM2.5 Emissions by Source Type") + ylab("Total PM2.5 Emissions of the year \n (tons)")

dev.copy(png, file="plot3.png")

dev.off()

