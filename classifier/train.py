from sklearn.linear_model import LogisticRegression
from processLyrics import process
from sklearn.externals import joblib

happyFile = 'trainingData/happy_lyrics.txt'
sadFile = 'trainingData/sad_lyrics.txt'
X,Y = process(happyFile, sadFile)

logisticRegr = LogisticRegression()
logisticRegr.fit(X, Y)

joblib.dump(logisticRegr, "model.joblib")