# Required install.packages: sqldf

plot4 <- function() {
      library(sqldf)
      
      # load the data using sqldf
      f <- file("household_power_consumption.txt")
      df <- sqldf("select * from f where Date=='1/2/2007' or Date=='2/2/2007'", 
                  file.format=list(header=T,sep=";"))
      close(f)
      
      # add date/time column to the dataset
      df <- cbind(df,DateTime=strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))

      #prepare png file
      png(filename = 'plot4.png', width = 504, height = 504, units = 'px')
      
      #prepare 2x2 plotting canvas
      par(mfrow=c(2,2))

      #plot 1
      plot(df$DateTime, df$Global_active_power, typ="l", xlab="", 
           ylab="Global Active Power", cex.axis=1.1, cex.lab=1.1)
      #plot 2
      plot(df$DateTime, df$Voltage, typ="l", xlab="datetime",
           ylab="Voltage", cex.axis=1.1, cex.lab=1.1)
      
      #plot 3
      with(df, plot(DateTime, Sub_metering_1, type="l", col="black",
                    xlab="",ylab="Energy sub metering",cex.axis=1.1, cex.lab=1.1))
      with(df, lines(DateTime, Sub_metering_2, type="l", col="red"))
      with(df, lines(DateTime, Sub_metering_3, type="l", col="blue"))
      legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
             lty=c(1,1),col=c("black","red","blue"),cex=1.1,bty="n")
      
      #plot 4
      plot(df$DateTime, df$Global_reactive_power, typ="l", xlab="datetime",
           ylab="Global_reactive_power", cex.axis=1.1, cex.lab=1.1)

      #close png file
      dev.off()
}