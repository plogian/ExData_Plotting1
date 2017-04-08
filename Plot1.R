library(data.table)
library(chron)

zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipURL, destfile="./data/EPCDataset.zip")
unzip("./data/EPCDataset.zip", exdir="./data/41Proj")

EPC <- fread('./data/41Proj/household_power_consumption.txt')
EPC$Date <- as.Date(as.character(EPC$Date),format = '%d/%m/%Y')
EPCSub <- subset(EPC, EPC$Date>="2007-02-01" & EPC$Date<="2007-02-02")
EPCSub$Time <- chron(times.=EPCSub$Time, format=c(times="h:m:s"))
EPCSub <- as.data.frame(EPCSub)
cols <- c(3:9)
EPCSub[,cols] <- apply(EPCSub[,cols], 2, function(x) as.numeric(as.character(x)))
png("./data/41Proj/Plot1.png", width = 480, height = 480)
with(EPCSub, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power"))
dev.off()