import csv
from processLyrics import processLyricString

f = open('processedlyrics.txt', 'w')

with open('lyrics.csv') as csvfile:
     reader = csv.DictReader(csvfile)
     for row in reader:
         l = row['lyrics']
         l = str(processLyricString(l))
         f.write(l + "\n")

f.close
