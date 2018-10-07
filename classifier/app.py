from flask import Flask, render_template, request
import sys
import os
from webScrape.webScrape2 import scrapeLyrics
from predict import predict

app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template("base.html")

@app.route('/result',methods = ['POST', 'GET'])
def result():
   if request.method == 'POST':
      result = request.form

      Artist = result['Artist']
      Song = result['Song']
      lyrics = scrapeLyrics(Artist, Song)
      p = predict(lyrics)[0]
      happy = False
      sad = False
      if p=='sad':
          sad = True
      else:
          happy = True

      return render_template("base.html", result = p, lyrics = lyrics, happy = happy, sad = sad)

if __name__ == '__main__':
    app.run(debug=True)
