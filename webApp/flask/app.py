from flask import Flask, render_template, request
import sys
import os
from webScrape import webScrape2

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
      print(sys.path)
      lyrics = 1
      return render_template("base.html", result = result)

if __name__ == '__main__':
    app.run(debug=True)