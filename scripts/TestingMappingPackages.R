library(ggmap)
library(mapproj)
map <- get_map(location = 'Europe', zoom = 4)
ggmap(map)

library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap)

plot(newmap,
  xlim = c(-20, 59),
  ylim = c(35, 71),
  asp = 1
)

library(ggmap)
europe.limits <- geocode(c("CapeFligely,RudolfIsland,Franz Josef Land,Russia",
  "Gavdos,Greece",
  "Faja Grande,Azores",
  "SevernyIsland,Novaya Zemlya,Russia")
)
europe.limits

plot(newmap,
  xlim = range(europe.limits$lon),
  ylim = range(europe.limits$lat),
  asp = 1
)



####################
airports <- read.csv("http://sourceforge.net/p/openflights/code/757/tree/openflights/data/airports.dat?format=raw", header = FALSE)
colnames(airports) <- c("ID", "name", "city", "country", "IATA_FAA", "ICAO", "lat", "lon", "altitude", "timezone", "DST")
head(airports)

library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap)
plot(newmap,xlim=c(75,85),ylim=c(8,35))
#plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)
points(airports$lon, airports$lat, col = "#88222204", pch=19, cex=2)



###
routes <- read.csv("http://openflights.svn.sourceforge.net/viewvc/openflights/openflights/data/routes.dat", header=F)
colnames(routes) <- c("airline", "airlineID", "sourceAirport", "sourceAirportID", "destinationAirport", "destinationAirportID", "codeshare", "stops", "equipment")
head(routes)

library(plyr)
departures <- ddply(routes, .(sourceAirportID), "nrow")
names(departures)[2] <- "flights"
arrivals <- ddply(routes, .(destinationAirportID), "nrow")
names(arrivals)[2] <- "flights"

airportD <- merge(airports, departures, by.x = "ID", by.y = "sourceAirportID")
airportA <- merge(airports, arrivals, by.x = "ID", by.y = "destinationAirportID")

map <- get_map(location = 'Europe', zoom = 4)
mapPoints <- ggmap(map) + 
	geom_point(aes(x = lon, y = lat,
				   size = sqrt(flights)),
			   data = airportD, alpha = .5)

mapPoints










