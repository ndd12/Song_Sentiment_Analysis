from sklearn.linear_model import LogisticRegression

def train(happy, sad):
    logisticRegr = LogisticRegression()
    logisticRegr.fit(x_train, y_train)