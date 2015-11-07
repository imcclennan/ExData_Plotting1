# Read the data
data <- read.table('household_power_consumption.txt', sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')

# Convert time and date to datetime
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Only look at date range from Feb 1, 2007 to Feb 2, 2007
data <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & 
                    as.Date(DateTime) <= as.Date("2007-02-02"))

png("plot4.png", height=480, width=480)

# we want a 2x2 grid of charts
par(mfrow=c(2,2))

# Top Left 
plot(data$DateTime, data$Global_active_power, type="n", xlab="",  
     ylab="Global Active Power")
lines(data$DateTime, data$Global_active_power)

# Top Right
plot(data$DateTime, data$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(data$DateTime, data$Voltage)

# Bottom Left 
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c('black', 'red', 'blue'), bty = 'n')

# Bottom Right
plot(data$DateTime, data$Global_reactive_power, type="n", xlab='datetime')
lines(data$DateTime, data$Global_reactive_power)

# close the device
dev.off()
