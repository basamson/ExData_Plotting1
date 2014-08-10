# Required install.packages: sqldf

plot3 <- function() {
      library(sqldf)
      
      # load the data using sqldf
      f <- file("household_power_consumption.txt")
      df <- sqldf("select * from f where Date=='1/2/2007' or Date=='2/2/2007'", 
                  file.format=list(header=T,sep=";"))
      close(f)
      
      # add date/time column to the dataset
      df <- cbind(df,DateTime=strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))
      
      #prepare png file
      png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
      
      #create graph
      with(df, plot(DateTime, Sub_metering_1, type="l", col="black",
                    xlab="",ylab="Energy sub metering",cex.axis=0.8, cex.lab=0.8))
      with(df, lines(DateTime, Sub_metering_2, type="l", col="red"))
      with(df, lines(DateTime, Sub_metering_3, type="l", col="blue"))
      legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
             lty=c(1,1),col=c("black","red","blue"),cex=0.8)
      
      #close png file
      #dev.copy(png, file="plot3.png", width=480, height=480, bg="white")
      dev.off()
}