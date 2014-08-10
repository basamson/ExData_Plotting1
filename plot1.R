# Required install.packages: sqldf

plot1 <- function() {
      library(sqldf)
      
      # load the data using sqldf
      f <- file("household_power_consumption.txt")
      df <- sqldf("select * from f where Date=='1/2/2007' or Date=='2/2/2007'", file.format=list(header=T,sep=";"))
      close(f)
      
      # add date/time column to the dataset
      df <- cbind(df,DateTime=strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S"))
      
      #create histogram
      hist(df$"Global_active_power", main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
      
      #export to png file
      dev.copy(png, file="plot1.png", width=480, height=480, bg="white")
      dev.off()
}