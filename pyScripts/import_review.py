import csv
import psycopg2
import sys

##############################
# Import Reviews to DataBase
##############################

def main():

	#data
	query =  "INSERT INTO reviews (reviewid, date, rating, review, movie_movieid, user_userid) VALUES (%s, to_timestamp(%s), %s, %s, %s, %s);"
	try:
		# get a connection, if a connect cannot be made an exception will be raised here
		conn = psycopg2.connect("host='localhost' dbname='movievultures' user='swan' password='abcdabcd'")
		# conn.cursor will return a cursor object, you can use this cursor to perform queries
		cursor = conn.cursor()
		print "Connected!\n"
		reviewFile = open("ratings.csv", 'rb')
		reader = csv.reader(reviewFile)
		i = 1000000
		for line in reader:
				#skip header row
     			data = (i, line[3], line[2], None, line[1], line[0])
     			cursor.execute(query, data)
     			conn.commit()
     			i += 1

	finally:
		reviewFile.close()
		conn.close()
	
 
if __name__ == "__main__":
	main()




