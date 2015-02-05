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

png('plot1.png', width = 480, height = 480)
par(mar = c(3,3,1,0)+0.1)
par(mgp = c(2,0.75,0))
hist(epcData$Global_active_power, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()