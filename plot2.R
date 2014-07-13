#Read in the unzipped file from this link:
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
raw <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")

#Format the Date column as a Date and filter to the data from 2007-02-01 and
#2007-02-02 only
raw$Date <- as.Date(raw$Date, "%d/%m/%Y")
raw <- raw[raw$Date > as.Date("2007-01-31") & raw$Date < as.Date("2007-02-03"),]

#Combine the Date and Time columns into one column DTG and format as a Date
raw$DTG <- paste(raw$Date, raw$Time)
raw$DTG <- strptime(raw$DTG, format = "%Y-%m-%d %H:%M:%S")

#Open PNG file "plot2.png" and create line plot of Global Active Power over time
#Don't forget to close the PNG file
png(filename="plot2.png")
with(raw,plot(DTG,Global_active_power,type="l",xlab="",
              ylab="Global Active Power (kilowatts)"))
dev.off()