#setwd("C:/Users/n8/Desktop/coursera/exdata-011")
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#destfile <- "./exdata-data-household_power_consumption.zip"
#download.file(url, destfile)
#unzip(destfile)
#dir()

library(data.table)
library(dplyr)

epcData <- tbl_df(fread("household_power_consumption.txt"))
epcData <- filter(epcData, Date == "1/2/2007" | Date == "2/2/2007")
epcData$Time <- paste(epcData$Date,epcData$Time)
epcData$Date <- as.Date(epcData$Date, "%d/%m/%Y")
epcData$Time <- strptime(epcData$Time, "%d/%m/%Y %H:%M:%S")
epcData[,3:9] <- sapply(epcData[,3:9], as.numeric)

png('plot3.png', width = 480, height = 480)
par(mar = c(2,3,0,0)+0.1)
par(mgp = c(2,0.75,0))
plot(epcData$Time, epcData$Sub_metering_1, type = "l", xlab="",
     ylab = "Energy sub metering")
lines(epcData$Time, epcData$Sub_metering_2, type = "l", col = "red")
lines(epcData$Time, epcData$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=1, col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()