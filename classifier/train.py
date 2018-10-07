from sklearn.linear_model import LogisticRegression
from processLyrics import process
from sklearn.externals import joblib
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.pipeline import Pipeline

happyFile = 'trainingData/happy_lyrics.txt'
sadFile = 'trainingData/sad_lyrics.txt'

happySongsLyrics = open(happyFile, encoding="utf8").readlines()
sadSongsLyrics = open(sadFile, encoding="utf8").readlines()

Y = ["happy"] * len(happySongsLyrics) + ["sad"] * len(sadSongsLyrics)
allSongsLyrics = happySongsLyrics + sadSongsLyrics
processed_allSongsLyrics = process(allSongsLyrics)

vectorizer = CountVectorizer(max_features=1000)
X = vectorizer.fit_transform(processed_allSongsLyrics).toarray()

classifier = LogisticRegression()
classifier.fit(X, Y)

joblib.dump(vectorizer, 'vectorizer.pk1')
joblib.dump(classifier, 'classifier.pk1')