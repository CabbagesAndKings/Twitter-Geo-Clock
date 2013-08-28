
require(rworldmap)


setwd('C:/etc/Projects/Data/_Ongoing/Twitter Geo Clock/scripts')
df <- read.csv('../data/Run1.csv',head=F,colClasses=c('character','numeric','numeric'))
colnames(df) <- c('timestamp','long','lat')

df$time <- sapply(df$timestamp,function(x) strsplit(x,' ')[[1]][4])
df$secs.since.midnight <- sapply(df$time, function(x){
			hms=as.numeric(strsplit(x,':')[[1]])
			secs=(hms[1]*3600) + (hms[2]*60) + hms[3]
})

interval.length <- 60 #seconds
df$interval <- cut(df$secs.since.midnight,seq(0,86400,interval.length))

u <- unique(df$interval)
i <- 5

newmap <- getMap(resolution = "low")
#plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)


noll <- lapply(1:length(u), function(i){
	plot(newmap)
	indices <- df$interval==u[i]
	points(df$lon[indices], df$lat[indices], col = "red", pch=19, cex=1)
})


#########################
#						#
# Check out ggmap, no?	#
#						#
#########################

############################
#TO DO:
# - Collect full data
# - figure out ranges and stuff
# - animate
# - Is there a cleaner map
##############################
