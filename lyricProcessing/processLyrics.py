from __future__ import print_function
from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.sentiment import SentimentAnalyzer

import re

sw = set(stopwords.words('english'))

def wordList(str):
    #str = str.translate(None, ',.!?;')
    str = re.sub('[^A-Za-z \n]+', '', str)
    str = re.split('\n| ', str)
    return str

def removeStopWords(wordList):
    v = []
    for word in wordList:
        if word not in sw:
            word.encode('ascii', 'ignore')
            v.append(word)
    return v

def stem(word):
    stemmer = SnowballStemmer("english")
    s = stemmer.stem(word)
    return s

def processLyricString(str):
    wl = wordList(str)
    print(wl)
    wl = removeStopWords(wl)
    print(wl)
    stemmedwl = []
    for word in wl:
        s = stem(word)
        print(s)
        stemmedwl.append(s)
    return stemmedwl

lyrics = "this is an example\nsong, lyric.\nthis is another, line of a song. not good"
print(lyrics)

print(processLyricString(lyrics))

print(stem("example"))





