plot3 <- function(){
  library(dplyr)
  if (!exists("FullData",envir=.GlobalEnv)){
    fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="DataDownload.zip")
    unzip("DataDownload.zip")
    FullData <- as_tibble(read.csv("household_power_consumption.txt",sep=";"))
    assign("FullData",FullData,envir=.GlobalEnv)
  }
  
  DateSub <- FullData %>% filter(((Date == "1/2/2007") | (Date == "2/2/2007")))
  
  DateStr <- as.character(levels(DateSub$Date))[DateSub$Date]
  TimeStr <- as.character(levels(DateSub$Time))[DateSub$Time]
  RefTimes <- as.POSIXct(paste(DateStr,TimeStr),format="%d/%m/%Y %H:%M:%S")
  
  SubMet1 <- suppressWarnings(as.numeric(levels(DateSub$Sub_metering_1))[DateSub$Sub_metering_1])
  SubMet2 <- suppressWarnings(as.numeric(levels(DateSub$Sub_metering_2))[DateSub$Sub_metering_2])
  SubMet3 <- DateSub$Sub_metering_3
  
  
  png(filename="plot3.png")
  plot(RefTimes,SubMet1,type="l",xlab="",ylab="Energy sub metering")
  lines(RefTimes,SubMet2,type="l",col="red")
  lines(RefTimes,SubMet3,type="l",col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
  dev.off()
  
}
