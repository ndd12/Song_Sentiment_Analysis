from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import re
from sklearn.feature_extraction.text import CountVectorizer

def TEST(F):
  return "Hello World!!!!!"
  
def process(f):
  
def process(happy, sad):
    stemmer = SnowballStemmer("english")
    stop_words = set(stopwords.words('english'))

    happySongsLyrics = open(happy).readlines()
    sadSongsLyrics = open(sad).readlines()
    Y = ["happy"] * len(happySongsLyrics) + ["sad"] * len(sadSongsLyrics)
    allSongsLyrics = happySongsLyrics + sadSongsLyrics

    processed_allSongsLyrics = []
    for lyrics in allSongsLyrics:
        lyrics = word_tokenize(re.sub('[^A-Za-z ]', '', lyrics).lower())
        tokenized_line = []
        for word in lyrics:
            if word not in stop_words:
                tokenized_line.append(stemmer.stem(word))
        processed_allSongsLyrics.append(" ".join(tokenized_line))

    matrix = CountVectorizer(max_features=1000)
    X = matrix.fit_transform(processed_allSongsLyrics).toarray()

    return (X, Y)


happyFile = 'trainingData/happy_lyrics.txt'
sadFile = 'trainingData/sad_lyrics.txt'
X,Y = process(happyFile, sadFile)
#print(x)





