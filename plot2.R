## TASK 2.
## Total emissions from PM2.5 in the Baltimore City, Maryland

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
names(NEI)

# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Aggregate data
# Select intrested columns
set2 <- select(NEI, fips, Emissions, year)
# Group by year
set2 <- group_by(set2, year)
# Filter Baltimor City
set2 <- filter(set2, fips == "24510")
# Find total emissions in different years
set2 <- summarise(set2, SumEmissions = sum(Emissions), Year = unique(year))
set2 <- select(set2, Year, SumEmissions)

# Plot bar graph and save to png file
png('plot2.png')
barplot(height = set2$SumEmissions, names.arg = set2$Year, col = "skyblue", xlab = "Year", ylab=expression('Total PM'[2.5]*' emission'), main = expression('Total PM'[2.5]*' emission in the Baltimore City'))
dev.off()
