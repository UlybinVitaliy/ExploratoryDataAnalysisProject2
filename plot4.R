## TASK 4.
## Total coal combustion-related sources emissions

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
names(SCC)

library(lattice)
library(dplyr)

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

set4 <- group_by(NEI.coal, year)
set4 <- summarise(set4, SumEmissions = sum(Emissions))
set4

library(ggplot2)

# Plot with ggplot function and save to png file
png('plot4.png')
g <- ggplot(set4, aes(year, SumEmissions))
summary(g)
g <- g  + geom_line() + geom_point(colour = "steelblue", size = 4) + xlab("Year") + ylab(expression("Total PM"[2.5]*" emissions by coal combustion-related sources")) + ggtitle(expression("Total PM"[2.5]*" emissions by coal combustion-related sources"))
print(g)
dev.off()

