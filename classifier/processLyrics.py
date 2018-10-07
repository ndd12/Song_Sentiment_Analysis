from nltk.stem.snowball import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import re
# http://spotlistr.herokuapp.com/#/export/spotify-playlist

# takes a list of list of strings, where each string is the entire lyrics of a song
# returns a list of list of strings, where the lyric strings have been cleaned, stemmed, and have stop words removed
def process(allSongsLyrics):

    stemmer = SnowballStemmer("english")
    stop_words = set(stopwords.words('english'))

    processed_allSongsLyrics = []
    for lyrics in allSongsLyrics:
        lyrics = word_tokenize(re.sub('[^A-Za-z ]', '', lyrics).lower())
        tokenized_line = []
        for word in lyrics:
            if word not in stop_words:
                tokenized_line.append(stemmer.stem(word))
        processed_allSongsLyrics.append(" ".join(tokenized_line))

    return processed_allSongsLyrics





