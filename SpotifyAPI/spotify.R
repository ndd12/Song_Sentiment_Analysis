library('httr')
library('spotifyr')
library(devtools)
library("Rspotify")
library('rvest')
install_github("tiagomendesdantas/Rspotify")

getRelatedArtists <- function(band) {
  keys <- spotifyOAuth("Song_Sentiment_Analysis","17a725c0d5714ec1a9c830d5c10a1b06","4384de3ac3d54f55ad063959baeaedb7")
  user <- getUser("t.mendesdantas",token=keys)
  related<-getRelated(band, keys)
  artists <- head(related,5)[,1:2, drop=FALSE]
  return(artists)
}

getSpotifyPicture <- function(artistID) {
  url <- paste("https://open.spotify.com/artist/",artistID, sep="")
  webpage <- read_html(url)
  lyrics <- html_nodes(webpage, 'meta')
  #<meta property="og:image" content="https://i.scdn.co/image/c2fe5d1e00a76b69ecd53164304ce2004f6064e9">
  imageURL <- regmatches(lyrics, regexpr("og:image.*>", lyrics))
  imageURL <- regmatches(imageURL, regexpr("http.*", imageURL))
  imageURL <- gsub("\"", "", imageURL)
  imageURL <- gsub(">", "", imageURL)
  return(imageURL)
}