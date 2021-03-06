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
    select(Timestamp, Global_active_power) -> plot1data

# Create the plot on a png device
png(width=480, height=480, filename="plot1.png")
par(mfcol=c(1,1))
hist(plot1data$Global_active_power, breaks=15, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off(dev.list()[["png"]])
