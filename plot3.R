# Course Project1 -- Exploratory Data Analysis
# By fvdgeer
library(readr)
library(dplyr)
library(lubridate)

dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
targetDir <- file.path(".", "data")
targetFile <- file.path(targetDir, "household_power_consumption.zip")
dataFile <- sub("zip", "txt", targetFile)

if (!dir.exists(targetDir)) dir.create(targetDir)
if (!file.exists(targetFile)) download.file(dataUrl, targetFile)
if (!file.exists(dataFile)) unzip(targetFile, exdir=targetDir)

powerdata<-read_csv2(dataFile, na="?", col_names=TRUE, col_types = list(
    Date=col_date(format = "%d/%m/%Y"), 
    Time=col_character(),
    Global_active_power=col_double(),
    Global_reactive_power=col_double(),
    Voltage=col_double(),
    Global_intensity=col_double(),
    Sub_metering_1=col_double(),
    Sub_metering_2=col_double(),
    Sub_metering_3=col_double() ))

powerdata %>% 
    filter(year(Date)==2007 & month(Date)==2 & day(Date) %in% c(1,2)) %>%
    mutate(Timestamp=as.POSIXct(paste(Date, Time))) %>%
    select(Timestamp, starts_with("Sub_metering")) -> plot3data

with(plot3data, plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(plot3data, lines(Timestamp, Sub_metering_2, type="l", col="red"))
with(plot3data, lines(Timestamp, Sub_metering_3, type="l", col="blue"))
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), legend=names(plot3data)[2:4])
dev.off(dev.copy(png, "plot3.png"))
