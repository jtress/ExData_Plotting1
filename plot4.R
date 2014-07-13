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

#Open PNG file "plot4.png" and create 4 line plots
png(filename="plot4.png")

#Set the display device to display 2x2 plots
par(mfcol=c(2,2))

#Draw the top left plot (same as plot 2)
with(raw,plot(DTG,Global_active_power,type="l",xlab="",
              ylab="Global Active Power (kilowatts)"))

#Draw the bottom left plot (same as plot 3)
with(raw,plot(DTG,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(raw,points(DTG,Sub_metering_1,type="l",col="black"))
with(raw,points(DTG,Sub_metering_2,type="l",col="red"))
with(raw,points(DTG,Sub_metering_3,type="l",col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Draw the top right plot
with(raw,plot(DTG,Voltage,type="l",xlab="datetime",ylab="Voltage"))

#Draw the bottom right plot
with(raw,plot(DTG,Global_reactive_power,type="l",xlab="datetime",
              ylab="Global_reactive_power"))

#Don't forget to close the PNG file
dev.off()