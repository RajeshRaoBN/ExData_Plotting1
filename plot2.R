# 1) Download the dataset from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 2) Extract the text file and save it in ~/R/Coursera/ExploratoryAnalysis/Project1 directory

# Set working directory
setwd("~/R/Coursera/ExploratoryAnalysis/Project1")

# Install sqldf package and open the library
library(sqldf)

# Load the dataset into R as required and perform the transformation
# When loading the dataset into R, please consider the following:
#   
# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
# 
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# 
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.
hps = read.csv.sql("household_power_consumption.txt", sep = ";", sql = "SELECT * FROM file WHERE Date = '1/2/2007' or Date = '2/2/2007'")
transform(hps, Date = as.Date(strptime(paste(hps[,"Date"] , hps[,"Time"] ), format = "%d/%m/%Y %T")))
transform(hps, Global_active_power = as.numeric(Global_active_power))

# Generate Plot1 as per instruction
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dates = strptime(paste(hps[,"Date"] , hps[,"Time"] ), format = "%d/%m/%Y %T")
datetime = dates - dates[1]
datetime = datetime / 60 /60 /24
datetime  = as.numeric(datetime)
plot(datetime, hps[,"Global_active_power"], ylim=range(hps[,"Global_active_power"]), ylab="Global Active Power (kilowatts)",type="l", xaxt="n", xlab="")
axis(1, at= seq(0, 2,1), labels = c("Thu", "Fri", "Sat"))
dev.copy(png,'./plot2.png')
dev.off()
