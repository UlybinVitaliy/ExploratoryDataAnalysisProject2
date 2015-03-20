## TASK 3.
## Total emissions from PM2.5 in the Baltimore City, Maryland by Source of emission

# Set working directory
setwd("")

# Download and open data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileUrl, destfile ="./data/exdata-data-NEI_data.zip")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")

# Read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# Aggregate data
set3 <- select(NEI, fips, Emissions, type, year)
set3 <- filter(set3, fips == "24510")
set3 <- group_by(set3, type, year)
set3 <- summarise(set3, SumEmissions = sum(Emissions))

# Plot with ggplot function and save to png file
png('plot3.png')
g <- ggplot(set3, aes(year, SumEmissions, color = type))
summary(g)
g <- g + geom_line() + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions")) + ggtitle(expression("Total PM"[2.5]*" emissions in Baltimore City by sources"))
print(g)
dev.off()
