source("webScrape/webScrape.R")
require(rPython)
library(reticulate)

fileAsList <- function(iFile) {
  conn <- file(iFile,open="r")
  lines <- readLines(conn)
  
  l <- list();
  n <- "\n"
  for (i in 1:length(lines)){
    SadSongs <- (strsplit(lines[i], " ; ")[[1]])
    song <- gsub("\n", " ", scrapeLyrics(SadSongs[1],SadSongs[2]))
    write.table(song, "happylyrics.txt", append = TRUE, sep = "\n", dec = ".",
                row.names = FALSE, col.names = FALSE)
    print("song")
  }
  close(conn)
  return(l)
}

test <- function() {
  python.load("./test.py")
  x <- python.call("requestAuth")
  x
}
