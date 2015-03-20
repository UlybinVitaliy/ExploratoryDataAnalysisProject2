## TASK 1.
## Plot total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 2008

# Set working directory
setwd("C:/Users/Бригада/Downloads/New/ExploratoryDataAnalysis/ExploratoryDataAnalysisProject2")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
library(dplyr)

# Aggregate data
set1 <- select(NEI, Emissions, year)
set1 <- group_by(set1, year)
x <- tapply(set1$Emissions, set1$year, sum)

# Plot bar graph and save to png file
png('plot1.png')
barplot(x, col = "skyblue", xlab="Year", ylab=expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emissions by year'))
dev.off()
