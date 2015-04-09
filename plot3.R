##Read the file
dat <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

##Format the date
dat$Date <- strptime(dat$Date, format="%d/%m/%Y")

##Filter to just 2 days of data
subsetted <- subset(dat, dat$Date >= "2007-02-01" & dat$Date <= "2007-02-02")

##Add a new DateTime column to the data set
DateTime <- paste(as.Date(subsetted$Date), subsetted$Time)
subsetted$DateTime <- as.POSIXct(DateTime)

##Plotting the graph
png("plot3.png", width=480, height=480)

plot(subsetted$DateTime, subsetted$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")
lines(subsetted$DateTime, subsetted$Sub_metering_2, col="red")
lines(subsetted$DateTime, subsetted$Sub_metering_3, col="blue")
legend("topright", lwd=1, col = c("black","red","blue"), legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()