 # read subset of the data
dataset <- read.table("data/household_power_consumption.txt", skip=grep("1/2/2007", readLines("data/household_power_consumption.txt")), nrows=3000, sep=';')
names(dataset) <- c('Date','Time','Global_active_power','Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2' ,'Sub_metering_3')

# convert date & cut off the dates
dataset$DateTime <- paste(dataset$Date, dataset$Time)
dataset$DateTime <- as.POSIXct(strptime(dataset$DateTime, '%d/ %m/ %Y %H:%M:%S' ) )
data_subset <- dataset[ dataset$DateTime < '2007-02-03 00:00:00', ]

png( filename = 'plot4.png', width = 480, height = 480, bg = NA )

par( mfrow = c(2, 2) )

# 1
plot( data_subset$DateTime, data_subset$Global_active_power,
      type = 'l',
      xlab = '',
      ylab = 'Global Active Power'
)
# 2
plot( data_subset$DateTime, data_subset$Voltage,
      type = 'l',
      xlab = 'datetime',
      ylab = 'Voltage'
)

# 3
plot( data_subset$DateTime, data_subset$Sub_metering_1,
      ylab = 'Energy sub metering',
      xlab = '',
      type='n' )

lines( data_subset$DateTime, data_subset$Sub_metering_1,
      col = 'black',
      type = 'l'
      )
lines( data_subset$DateTime, data_subset$Sub_metering_2,
       col = 'red',
       type = 'l'
       )
lines( data_subset$DateTime, data_subset$Sub_metering_3,
       col = 'blue',
       type = 'l'
       )
legend( 'topright', lty = c(1,1,1), box.col = NA, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )


# 4
plot( data_subset$DateTime, data_subset$Global_reactive_power,
      type = 'l',
      col = 'black',
      ylab = 'Global_reactive_power',
      xlab = 'datetime'
      )

dev.off()