install.packages("sqldf")
library(sqldf)

# Load data from these 2 days, Feb 1st and Feb 2nd in the year of 2007, into R data frame
data <- read.csv.sql("household_power_consumption.txt", sep=";", header=TRUE, sql = 'select * from file where Date ="1/2/2007" OR Date = "2/2/2007"')

# Change the Date variable to Date plus Time format
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Plot and annotate a single scatterplot containing 3 groups of energy sub metering for plot 3
plot(data$Date, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$Date, data$Sub_metering_1, col="black")
lines(data$Date, data$Sub_metering_2, col="red")
lines(data$Date, data$Sub_metering_3, col="blue")
legend("topright", lty="solid", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy the scatterplot (i.e. plot 3) to PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()