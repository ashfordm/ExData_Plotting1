##plot2.R
##set work direcory and load zip file
setwd("C:/Users/ashfordm/Documents/R")
hh_con <- unzip("exdata_data_household_power_consumption.zip")

##Date;Time;Global_active_powerer;Global_reactive_powerer;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
##read file into table
pow <- read.table(hh_con, header=T, sep=";")

##convert the Date variables
pow$Date <- as.Date(pow$Date, format="%d/%m/%Y")

##using data from the dates 2007-02-01 and 2007-02-02
dfile <- pow[(pow$Date=="2007-02-01") | (pow$Date=="2007-02-02"),]

##convert data to numeric and handle "?"
##missing values are coded as ?
dfile$Global_active_power<- as.numeric(as.character(ifelse(dfile$Global_active_power=="?",NA,dfile$Global_active_power)))
dfile$Global_reactive_power <- as.numeric(as.character(ifelse(dfile$Global_reactive_power=="?",NA,dfile$Global_reactive_power)))
dfile$Voltage <- as.numeric(as.character(ifelse(dfile$Voltage=="?",NA,dfile$Voltage)))
dfile$Sub_metering_1 <- as.numeric(as.character(ifelse(dfile$Sub_metering_1=="?",NA,dfile$Sub_metering_1)))
dfile$Sub_metering_2 <- as.numeric(as.character(ifelse(dfile$Sub_metering_2=="?",NA,dfile$Sub_metering_2)))
dfile$Sub_metering_3 <- as.numeric(as.character(ifelse(dfile$Sub_metering_3=="?",NA,dfile$Sub_metering_3)))

##create timestamp data
dfile <- transform(dfile, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##plot2
with(dfile,plot(timestamp,(Global_active_power/1000), type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
