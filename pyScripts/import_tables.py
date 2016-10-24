import csv
import psycopg2
import sys
import datetime
import imdb

#imported imdbid - testing
def copy_links():
    f = open("ml-latest-small/movies.csv", 'rb')
    reader = csv.reader(f)
    for line in reader:
        print line


def readin_reviews():
    #data
    query =  "INSERT INTO reviews (reviewid, date, rating, review, movie_movieid, user_userid) VALUES (%s, to_timestamp(%s), %s, %s, %s, %s);"
    
    try:
        # get a connection, if a connect cannot be made an exception will be raised here
        conn = psycopg2.connect("host='localhost' dbname='movievultures' user='swan' password='abcdabcd'")
        # conn.cursor will return a cursor object, you can use this cursor to perform queries
        cursor = conn.cursor()
        print "Connected!\n"
        reviewFile = open("ml-latest-small/ratings.csv", 'rb')
        reader = csv.reader(reviewFile)
        i = 1000000
        for line in reader:
                data = (i, line[3], line[2], None, line[1], line[0])
                cursor.execute(query, data)
                conn.commit()
                i += 1
    finally:
        reviewFile.close()
        conn.close()


def readin_movies():
    ia = imdb.IMDb() # by default access the web.
    query = "INSERT INTO movies (movieId, title, date, eloRating, plot) VALUES (%s, %s, to_timestamp(%s), %s, %s);"
    queryDirectors = "INSERT INTO movie_directors (movieid, director) VALUES (%s, %s);"
    queryGenres = "INSERT INTO movie_genres (movieid, genre) VALUES (%s, %s);"
    queryCast = "INSERT INTO movie_cast (movieid, actor) VALUES (%s, %s);"
    try:
        conn = psycopg2.connect("host='localhost' dbname='movievultures' user='swan' password='abcdabcd'")
        cursor = conn.cursor()
        print "Connected!\n"
        movieFile = open("ml-latest-small/movie.csv", 'rb')
        reader = csv.reader(movieFile)
        count = 0;
        for line in reader:
            imdbid = line[3]
            movie = ia.get_movie(imdbid)
            #scrape from imdb and insert into directors, genre,
            movie_data = (line[0], line[1], movie['year'], 0.0, movie['plot'])
            cursor.execute(query, movie_data)
            conn.commit()
            print "scraping for movie: " + line[1]
            #scrape directors
            if 'director' in movie.keys():
                for person in movie['director']:
                    director_data = (line[0], person['name'])
                    cursor.execute(queryDirectors, director_data)
                    conn.commit()
            #scrape genres
            if 'genre' in movie.keys():
                for genre in movie['genres']:
                    genreData = (line[0], genre)
                    cursor.execute(queryGenres, genreData)
                    conn.commit()
            #scrape actors - top 5 in list
            if 'cast' in movie.keys():
                cast = movie['cast']
                count = 3
                for actor in cast[:count]:
                    #print "inserting an actor into movie_cast"
                    cast_data = (line[0], actor['name'])
                    cursor.execute(queryCast, cast_data)
                    conn.commit()
  
    finally:
        movieFile.close()
        conn.close()





def main():
    readin_movies()

if __name__ == "__main__":
    main()



