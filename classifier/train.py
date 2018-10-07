from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB
from processLyrics import process
from sklearn.externals import joblib
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split

happyFile = 'trainingData/happy_lyrics.txt'
sadFile = 'trainingData/sad_lyrics.txt'

happySongsLyrics = open(happyFile, encoding="utf8").readlines()
sadSongsLyrics = open(sadFile, encoding="utf8").readlines()

Y = ["happy"] * len(happySongsLyrics) + ["sad"] * len(sadSongsLyrics)
allSongsLyrics = happySongsLyrics + sadSongsLyrics
processed_allSongsLyrics = process(allSongsLyrics)

vectorizer = CountVectorizer(max_features=750)
X = vectorizer.fit_transform(processed_allSongsLyrics).toarray()

X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2)

classifier = GaussianNB(var_smoothing=1e-09)
classifier.fit(X_train, y_train)

predictions = classifier.predict(X_test)
print("Score: " , classifier.score(X_test, y_test))

joblib.dump(vectorizer, 'vectorizer.pk1')
joblib.dump(classifier, 'classifier.pk1')