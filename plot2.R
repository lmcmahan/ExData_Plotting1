install.packages("sqldf")
library(sqldf)

# Load data from these 2 days, Feb 1st and Feb 2nd in the year of 2007, into R data frame
data <- read.csv.sql("household_power_consumption.txt", sep=";", header=TRUE, sql = 'select * from file where Date ="1/2/2007" OR Date = "2/2/2007"')

# Change the Date variable to Date plus Time format
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# Plot and annotate global_active_power(y) vs Date(x) scatterplot for plot 2
plot(data$Date, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Copy the scatterplot (i.e. plot 2) to PNG file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
