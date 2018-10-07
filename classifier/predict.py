from sklearn.externals import joblib

model = joblib.load('model.joblib')

def predict(lyrics):
    model.predict([lyrics])


