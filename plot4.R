install.packages("sqldf")
install.packages("lubridate")
library(sqldf)
library(lubridate)

# Load data from these 2 days, Feb 1st and Feb 2nd in the year of 2007, into R data frame
data <- read.csv.sql("household_power_consumption.txt", sep=";", header=TRUE, sql = 'select * from file where Date ="1/2/2007" OR Date = "2/2/2007"')

# Change the Date variable to Date plus Time format
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Use par() to set the page margin and add 4 plots column-wise to a page 
par(mfcol=c(2, 2), mar=c(4, 4, 1, 0.5))

# Plot and annotate 4 scatterplots for plot 4
  # Plot top left scatterplot
plot(data$Date, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  # Plot bottom left scatterplot
plot(data$Date, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$Date, data$Sub_metering_1, col="black")
lines(data$Date, data$Sub_metering_2, col="red")
lines(data$Date, data$Sub_metering_3, col="blue")
legend("topright", lty="solid", bty="n", cex=0.70, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # Plot top right scatterplot
with(data, plot(data$Date, data$Voltage, type="n", xlab="datetime", ylab="Voltage"))
with(subset(data, hour(hms(data$Time)) >= 6 & hour(hms(data$Time)) <= 18), lines(data$Date, data$Voltage))
  # Plot bottom right scatterplot
with(data, plot(data$Date, data$Global_reactive_power, type="n", yaxt="n", xlab="datetime", ylab="Global_reactive_power"))
axis(side=2, at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
with(subset(data, hour(hms(data$Time)) >= 6 & hour(hms(data$Time)) <= 18), lines(data$Date, data$Global_reactive_power))

# Copy plot 4 to PNG File
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
