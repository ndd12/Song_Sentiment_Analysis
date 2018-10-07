from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import re
from sklearn.feature_extraction.text import CountVectorizer

def TEST(F):
  return "Hello World!!!!!"
  
def process(f):
    stemmer = SnowballStemmer("english")
    stop_words = set(stopwords.words('english'))

    lines = open(f).readlines()
    processed_docs = []
    for line in lines:
        line = word_tokenize(re.sub('[^A-Za-z ]', '', line).lower())
        tokenized_line = []
        for word in line:
            if word not in stop_words:
                tokenized_line.append(stemmer.stem(word))
        processed_docs.append(" ".join(tokenized_line))

    return processed_docs

def toBagOfWords(docs):
    matrix = CountVectorizer(max_features=1000)
    X = matrix.fit_transform(docs).toarray()
    return X


file = 'trainingData/sad_lyrics.txt'
x = process(file)
print(x)
print(toBagOfWords(x))





