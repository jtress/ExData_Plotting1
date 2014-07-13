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

#Open PNG file "plot3.png" and create line plot of sub meter readings over time
#Don't forget to close the PNG file
png(filename="plot3.png")
with(raw,plot(DTG,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(raw,points(DTG,Sub_metering_1,type="l",col="black"))
with(raw,points(DTG,Sub_metering_2,type="l",col="red"))
with(raw,points(DTG,Sub_metering_3,type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()