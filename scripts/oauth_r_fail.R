
library(streamR)

setwd('C:/etc/Projects/Data/_Ongoing/Tweet Clock/')

a<-sampleStream(file="test.txt", user = "harkjackhark", password = "capjack")


library(ROAuth)
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumer.key <- "NmmwYFIkJ8ePcZSyiCiOQ"
consumer.secret <- "KOdDBCvuZZfywqDbaPIpE8HQykEuqJ4PjM0WaUOUUUU"

access.token.key <- "1654961214-BVFMMFyMt9vvexPwZ8I8YQW9sqbu5vf8ML8OQFF"
access.token.secret <- "u1sdJ3bseOpPggtaY4yYKpGIS9eIThwg9106fuEO0E4"


my_oauth <- OAuthFactory$new(consumerKey=consumer.key,
							 consumerSecret=consumer.secret, requestURL=reqURL,
							 accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
sampleStream(file="tweets_sample.json", oauth=my_oauth)





