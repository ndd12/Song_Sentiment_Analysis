from __future__ import print_function
from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize




import re
sw = set(stopwords.words('english'))

def process(f):
    lines = open(f).readlines()
    tokenized_docs = []
    for line in lines:
        line = re.sub('[^A-Za-z ]', '', line).lower()
        t = word_tokenize(line)
        for word in t:
            if word not in stopwords.words('english'):
                tokenized_docs.append(t)

    print(tokenized_docs)


def removeStopWords(wordList):
    v = []
    for word in wordList:
        if word not in sw:
            v.append(word)
    return v

def stem(word):
    stemmer = SnowballStemmer("english")
    s = stemmer.stem(word)
    return s

def processLyricString(str):
    wl = wordList(str)
    wl = removeStopWords(wl)
    stemmedwl = []
    for word in wl:
        s = stem(word)
        stemmedwl.append(s.encode("latin-1"))
    return stemmedwl



file = 'trainingData/sad_lyrics.txt'
print(process(file))





