library(ggplot2)
library(ggmap)
library(png)
library(grid)
library(animation)


setwd('C:/etc/Projects/Data/_Ongoing/Twitter Geo Clock/scripts')

df <- read.csv('../data/LongRun_1948-2252_0824.csv',head=F,colClasses=c('character','numeric','numeric'))
colnames(df) <- c('timestamp','long','lat')
df$time <- sapply(df$timestamp,function(x) strsplit(x,' ')[[1]][4])
df$secs.since.midnight <- sapply(df$time, function(x){
	hms=as.numeric(strsplit(x,':')[[1]])
	secs=(hms[1]*3600) + (hms[2]*60) + hms[3]
})

interval.length <- 60 #seconds
df$interval <- cut(df$secs.since.midnight,seq(0,86400,interval.length))

all.intervals <- unique(df$interval)

CreateMap <- function(dfpoints,basemap=NULL,
					  center=data.frame(lon=0,lat=0), maptype="roadmap",zoom=1,color="bw",
					  pointsize=4){

	#If a basemap is provided, go with it; Otherwise download it
	if(is.null(basemap)){
		basemap <- get_googlemap(
			as.matrix(center),
			maptype = maptype,   # roadmap / terrain / satellite / hybrid
			langauage = "en-EN",  
			zoom  = zoom,         
			color = color, 	# "color" or "bw" 
			scale = 2,		# 2 for high resolution output
		)
			
	}
	
	baseggmap <- ggmap(basemap, extent = "panel") + coord_cartesian()
	print(baseggmap + geom_point(aes(x = long, y = lat/2.25),
						   	size = pointsize, pch=19, alpha=0.5,
							color="#AA2244", data = dfpoints)
		  			+ xlim(-180,180) + ylim(-45,45) 
		  )

}



#Test
i <- 5
indices <- df$interval==all.intervals[i]
CreateMap(df[indices,],color="bw")

#create base map once
basemap <- get_googlemap(
	as.matrix(data.frame(lon=0,lat=0)),
	maptype = "roadmap",   # roadmap / terrain / satellite / hybrid)
	langauage = "en-EN",  
	zoom  = 1,         
	color = "bw",
	size=c(640,640),
	scale = 2,
)

CreateMap(df[indices,],basemap=basemap)

############################
###Create the Animation ####
############################

ani.options(ani.width=640,ani.height=480,
			interval=0.01,
			outdir = paste(getwd(),"..","data",sep="/"),
			autobrowse=T)

saveGIF({
	for (i in 1:length(u)){
		indices <- df$interval==all.intervals[i]
		CreateMap(df[indices,],basemap=basemap)
	} 
},movie.name="test.gif",replace=T)



###########################################
#TO DO:
# - Collect full data
# - figure out ranges and stuff
# - alpha as a function of interval.length
############################################
