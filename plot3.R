# Plot of global active power against time

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

energy$Sub_metering_1 <- as.numeric(as.character(energy$Sub_metering_1))
energy$Sub_metering_2 <- as.numeric(as.character(energy$Sub_metering_2))

# Keeping relevant subset of dates
energy <- energy[ which(energy$Date == "2007-02-01" | energy$Date == "2007-02-02"),]

# Creating plot and exporting to .png format
png(filename = "plot3.png", 
    width = 480,
    height = 480)
par(bg = "transparent",
    cex = 0.90)
with(energy, plot(datetime, Sub_metering_1, 
                  type = "n",
                  ylab = "Energy sub metering",
                  xlab = " ",))
lines(energy$datetime, energy$Sub_metering_1,
      col = "black")
lines(energy$datetime, energy$Sub_metering_2,
      col = "red")
lines(energy$datetime, energy$Sub_metering_3,
      col = "blue")
legend("topright", 
       lwd = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()