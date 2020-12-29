plot1 <- function(){
  library(dplyr)
  if (!exists("FullData",envir=.GlobalEnv)){
    fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="DataDownload.zip")
    unzip("DataDownload.zip")
    FullData <- as_tibble(read.csv("household_power_consumption.txt",sep=";"))
    assign("FullData",FullData,envir=.GlobalEnv)
  }
  
  DateSub <- FullData %>% filter(((Date == "1/2/2007") | (Date == "2/2/2007")))
  
  ActPowSub <- suppressWarnings(as.numeric(levels(DateSub$Global_active_power))[DateSub$Global_active_power])
  
  png(filename="plot1.png")
  hist(ActPowSub,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
  dev.off()
}
