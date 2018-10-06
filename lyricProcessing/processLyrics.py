from __future__ import print_function
from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
import re

sw = set(stopwords.words('english'))

def wordList(str):
    str = str.translate(None, ',.!?;')
    str = re.split('\n| ', str)
    return str

def removeStopWords(wordList):
    v = []
    for word in wordList:
        if word not in sw:
            v.append(word)
    return v

def stem(word):
    stemmer = SnowballStemmer("english")
    return stemmer.stem(word)

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

lyrics = "this is an example\nsong, lyric.\nthis is another, line of a song."
print(lyrics)

print(processLyricString(lyrics))

print(stem("example"))





