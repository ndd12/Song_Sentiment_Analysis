from sklearn.feature_extraction.text import CountVectorizer

def vectorize():
    vectorizer = CountVectorizer(strip_accents='unicode')
    sad = open('trainingData/sad_lyrics.txt')
    happy = open('trainingData/happy_lyrics.txt')
    docs = sad.readlines()
    vectors = vectorizer.fit_transform(docs)
    print(vectors)
    #print(vectorizer.vocabulary_)