# Histogram of global active power

#Reading in the data
rm(list = ls())

# Importing the data
if(!file.exists("./data")) {
  dir.create("./data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,"./data/Dataset.zip", mode="wb")
unzip("./data/Dataset.zip")

energy <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Processing the data
is.na(energy) <- energy == "?"

energy$datetime <- paste(energy$Date, energy$Time, sep = " ")
energy$datetime <- strptime(energy$datetime, "%d/%m/%Y %H:%M:%S")
energy$Date <- as.Date(energy$Date, "%d/%m/%Y")

energy$Global_active_power <- as.numeric(as.character(energy$Global_active_power))

# Keeping relevant subset of dates
energy <- energy[ which(energy$Date == "2007-02-01" | energy$Date == "2007-02-02"),]

# Creating histogram and exporting to .png format
png(filename = "plot1.png", 
    width = 480,
    height = 480)
par(bg = "transparent",
    cex = 0.90)
hist(energy$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()