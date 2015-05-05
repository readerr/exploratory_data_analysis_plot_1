 # read subset of the data
dataset <- read.table("data/household_power_consumption.txt", skip=grep("1/2/2007", readLines("data/household_power_consumption.txt")), nrows=3000, sep=';')
names(dataset) <- c('Date','Time','Global_active_power','Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2' ,'Sub_metering_3')

# convert date & cut off the dates
dataset$DateTime <- paste(dataset$Date, dataset$Time)
dataset$DateTime <- as.POSIXct(strptime(dataset$DateTime, '%d/ %m/ %Y %H:%M:%S' ) )
data_subset <- dataset[ dataset$DateTime < '2007-02-03 00:00:00', ]

par( mfrow = c(2, 2) )

plot( data_subset$Global_active_power ~ data_subset$DateTime,
      type = 'l',
      xlab = '',
      ylab = 'Global Active Power'
)

plot( data_subset$Voltage ~ data_subset$DateTime,
      type = 'l',
      xlab = 'datetime',
      ylab = 'Voltage'
)

plot( data_subset$Sub_metering_1 ~ data_subset$DateTime, 
      
      type='n' )
