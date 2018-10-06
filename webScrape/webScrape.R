#Loading the rvest package
library('rvest')

# USE SCRAPE LYRICS FUNCTION
# INPUT BAND/ARTIST AND SONG
# USE SPACES IF THERE ARE SPACES

# Scrapes lyrics of a specified band and song to HTML
scrapeLyrics <- function(band, song) {
  # Replaces spaces in band name with _
  bandSub <- gsub(" ", "_", band)
  # Replaces spaces in song name with _
  songSub <- gsub(" ", "_", song)
  
  # Inputs scraping url
  url <- paste("http://lyrics.wikia.com/wiki/",bandSub, sep="")
  url <- paste(url,":",sep="")
  url <- paste(url, songSub, sep="")
  
  # Scrape webpage data ----------------------
  webpage <- readUrl(url)
  
  # Gets <div class="lyricbox"> data
  lyrics <- returnLyrics(webpage)
  
  # Return scraped lyrics
  return(lyrics)
}

# Returns String of Lyrics from HTML object
returnLyrics <- function(HTMLObject) {
  lyrics <- html_nodes(HTMLObject,".lyricbox")
  
  # Removes html tags from data and cleans.
  lyrics <- gsub("<div class=\"lyricbox\">", "", lyrics)
  lyrics <- gsub("<br>", "\n", lyrics)
  lyrics <- gsub("<div class=\"lyricsbreak\"></div>", "", lyrics)
  lyrics <- gsub("</div>", "", lyrics)
  return(lyrics)
}

# Reads a url to HTML and returns either HTML or an error
readUrl <- function(url) {
  out <- tryCatch(
    {
      webpage <- read_html(url)
    },
    error=function(cond) {
      returnStatement <- "Error in band or song"
      return(returnStatement)
    },
    warning=function(cond) {
      returnStatement <- "Error in band or song"
      return(returnStatement)
    },
    finally={
      message(paste("Processed URL:", url))
      message("--------------------")
    }
  )    
  return(out)
}