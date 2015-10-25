library(data.table)
library(lubridate)
powerConsumption <- data.table(read.table("./household_power_consumption.txt", sep=";", header=TRUE, na.strings="?"))
# tail(powerConsumptionFeb2007)
powerConsumptionFeb2007 <- powerConsumption[powerConsumption$Date == "1/2/2007" | powerConsumption$Date == "2/2/2007"]
powerConsumptionFeb2007$datetime <- as.POSIXct(paste(as.Date(powerConsumptionFeb2007$Date, format="%d/%m/%Y"), powerConsumptionFeb2007$Time), format="%Y-%m-%d %H:%M")
par(mfrow=c(2,2))


# Plot 1
plot(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Global_active_power, type="l", ylab="Global Active Power",xlab="")

# Plot 2
plot(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Voltage, type="l", ylab="Voltage",xlab="")


# Plot 3
plot(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
lines(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Sub_metering_2, col="red")
lines(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot 4
plot(x=powerConsumptionFeb2007$datetime, y=powerConsumptionFeb2007$Global_reactive_power, type="l", ylab="Global Reactive Power",xlab="")


dev.copy(png, file="plot4.png")
dev.off()
