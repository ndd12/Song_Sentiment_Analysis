from classifier/predict import predict

def PredictRInterface(lyrics):
    lyrics = str(lyrics)
    return predict(lyrics)
