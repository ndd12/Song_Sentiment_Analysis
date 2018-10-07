from bs4 import BeautifulSoup
import requests
import re
    
# Please run this main func
def scrapeLyrics(band, song):
  band_ = band.replace(" ", "-").replace("'","%27")
  song_ = song.replace(" ", "-").replace("'","%27")
  url = "http://lyrics.wikia.com/wiki/"+band_+":"+song_
  lyricParse = urlParse(url)
  if lyricParse == "Error in band or song":
    return findSearch(band, song)
  return urlParse(url)

# Helper func for secondary search
def findSearch(band, song):
  error = "Error in band or song"
  band_ = band.replace(" ", "+").replace("'","%27").replace(":","%3A")
  song_ = song.replace(" ", "+").replace("'","%27").replace(":","%3A")
  url = "http://lyrics.wikia.com/wiki/Special:Search?search="+band_+"%3A"+song_+"&fulltext=Search&ns0=1#"

  r = requests.get(url)
  data = r.text
  soup = BeautifulSoup(data, 'html.parser')

  if soup.find("p", class_="no-result"):
    return error

  article = soup.find("article")
  if "song" not in article.text:
    return error

  href = soup.find("a", class_="result-link")['href']
  if "http" in href:
    return urlParse(href)
  return error

# Parses lyric page text
def urlParse(url):
  r = requests.get(url)
  data = r.text
  soup = BeautifulSoup(data, 'html.parser')
  soup = soup.find("div", class_="lyricbox")
  if soup == None:
    return "Error in band or song"
  
  for br in soup.find_all("br"):
    br.replace_with("\n")
  return soup.text
