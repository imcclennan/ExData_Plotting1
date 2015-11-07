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

png("plot2.png", height=480, width=480)

plot(data$DateTime, data$Global_active_power, type="n", xlab="", 
     ylab="Global Active Power (kilowatts)")

lines(data$DateTime, data$Global_active_power)


# close the device
dev.off()
