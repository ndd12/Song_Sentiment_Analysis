#Loading the rvest package
library('rvest')
options(warn = -1) 

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
  
  # if webscrape url was incorrect ----------
  if(webpage == "Error in band or song") {
    # try to scrape from lyric search page
    searchScrape <- scrapeSearch(band, song)
    if(searchScrape == "Error in band or song") {
      return("Error in band or song")
    }
    webpage <- searchScrape
  }
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
  lyrics <- gsub("<i>", "", lyrics)
  lyrics <- gsub("<div class=\"lyricsbreak\"></div>", "", lyrics)
  lyrics <- gsub("</div>", "", lyrics)
  lyrics <- gsub("<b>", "", lyrics)
  lyrics <- gsub("</b>", "", lyrics)
  lyrics <- gsub("</i>", "", lyrics)
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
    }
  )
  return(out)
}

# Scapes via websearch and returns HTML of searched page
scrapeSearch <- function(band, song) {
  # Replaces spaces in band name with +
  bandSub <- gsub(" ", "+", band)
  # Replaces spaces in song name with +
  songSub <- gsub(" ", "+", song)
  
  url <- paste("http://lyrics.wikia.com/wiki/Special:Search?search=",bandSub, sep="")
  url <- paste(url, "%3A", sep="")
  url <- paste(url, songSub, sep="")
  url <- paste(url, "&fulltext=Search&ns0=1#", sep="")
  
  # Scrape webpage data ----------------------
  webpage <- readUrl(url)

  # -----------------------------------------
  if(webpage == "Error in band or song") {
    return("Error in band or song")
  }
  # have a valid search HTML in webpage
  # Now check if contains no-result class
  noResult <- html_node(webpage, ".no-result")
  # if there is no result then return
  if(class(noResult) != "xml_missing") {
    return("Error in band or song")
  }
  
  # if result get the top result and check if it is a song
  result <- html_node(webpage, ".result") %>% html_node("article")
  # if page contains 'This song is' then it is a song
  if(grep("This song is", html_text(result)) == 0) {
    return("Error in band or song")
  }
  
  # we have a valid song now capture the url and pass to readUrl
  link <- webpage %>% html_node(".result") %>% html_node("a") %>% html_attr("href")
  return(readUrl(link))
}