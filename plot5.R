## TASK 5.
## Total motor vehicle emissions in Baltimore City

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

set5 <- select(NEI.motor, fips, SCC, Emissions, year)
set5 <- filter(set5, fips == "24510")
set5 <- group_by(set5, year)
set5 <- summarise(set5, SumEmissions = sum(Emissions))

# Plot with ggplot function and save to png file
png('plot5.png')
g <- ggplot(set5, aes(year, SumEmissions))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by Motor Vehicle")) + ggtitle(expression("Total emissions by Motor Vehicle in Baltimore"))
print(g)
dev.off()
