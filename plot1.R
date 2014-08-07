install.packages("sqldf")
library(sqldf)

# Load data from these 2 days, Feb 1st and Feb 2nd in the year of 2007, into R data frame
data <- read.csv.sql("household_power_consumption.txt", sep=";", header=TRUE, sql = 'select * from file where Date ="1/2/2007" OR Date = "2/2/2007"')

# Plot and annotate histogram for plot 1
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Copy the histogram (i.e. plot 1) to PNG file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()