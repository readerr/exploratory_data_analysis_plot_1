 # read subset of the data
dataset <- read.table("data/household_power_consumption.txt", skip=grep("1/2/2007", readLines("data/household_power_consumption.txt")), nrows=3000, sep=';')
names(dataset) <- c('Date','Time','Global_active_power','Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2' ,'Sub_metering_3')

# convert date & cut off the dates
dataset$DateTime <- paste(dataset$Date, dataset$Time)
dataset$DateTime <- as.POSIXct(strptime(dataset$DateTime, '%d/ %m/ %Y %H:%M:%S' ) )
data_subset <- dataset[ dataset$DateTime < '2007-02-03 00:00:00', ]


png(filename = 'plot3.png', width = 480, height = 480, bg = NA)
# setup plot 3
with( data_subset, 
      plot( DateTime, Sub_metering_1,
            xlab = '',
            ylab = 'Energy sub metering',
            type = 'n'  ) 
     )

# add lines
lines( data_subset$DateTime, data_subset$Sub_metering_1, col='black', type = 'l' )
lines( data_subset$DateTime, data_subset$Sub_metering_2, col = 'red', type = 'l' )
lines( data_subset$DateTime, data_subset$Sub_metering_3, col = 'blue', type = 'l' )

# add legend
legend('topright', lty=c(1,1,1), lwd = 1, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )

dev.off()
