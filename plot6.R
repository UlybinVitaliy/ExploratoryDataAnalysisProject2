## TASK 6.
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County

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

library(dplyr)

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

set6 <- select(NEI.motor, fips, SCC, Emissions, year)
set6 <- filter(set6, fips == "24510" | fips == "06037" )
set6 <- group_by(set6, year, fips)
set6 <- summarise(set6, SumEmissions = sum(Emissions))
set6$fips <- as.factor(set6$fips) 
levels(set6$fips) <- list("Baltimore"="24510", "Los Angeles"="06037")


# Plot with ggplot function and save to png file
png('plot6.png')
g <- ggplot(set6, aes(year, SumEmissions, color = fips))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by Motor Vehicle")) + ggtitle(expression("Comparassion of emissions in LA and Baltimore"))
print(g)
dev.off()
