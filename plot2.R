# Project1 for 
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

powerdata<-filter(powerdata, year(Date)==2007 & month(Date)==2 & day(Date) %in% c(1,2))
