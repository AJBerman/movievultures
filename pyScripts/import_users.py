# -*- coding: utf-8 -*-
import csv
import sys
import psycopg2

#Database
#       userId int4 not null,
#        email varchar(255),
#        password varchar(255),
#        username varchar(255),
#        primary key (userId)

userIdList = set()
userNameList = set()

#Connecting to the database
try:
    conn = psycopg2.connect("dbname='movievultures' user='swan' host='localhost' password='abcdabcd'")    
    cur = conn.cursor()    
    
    # Reading in the 2 CSV files
    ratingsFile = open('ratings.csv', 'rt')
    randomUsersFile = open('randomUsers.csv', 'rt')
    try:
        allRatings = csv.reader(ratingsFile)
        allUsers = csv.reader(randomUsersFile)
        
        #add userIds to the userIdList
        for row in allRatings:
            #print row[0]
            userIdList.add(row[0])

        #add userNames to the userNameList
        for user in allUsers:
            #print user[0]
            userNameList.add(user[0])
            
        '''
        #print tests
        for a in userIdList:
            print a
            
        print "==============="
            
        for b in userNameList:
            print b
            
        print "==============="
        print len(userIdList)
        print len(userNameList)
        '''
        
    finally:
        ratingsFile.close()
        randomUsersFile.close()

    
    #sql query to add to the DB
    for i in range(len(userIdList)):
        cur.execute("INSERT INTO users VALUES (%s,%s,%s,%s)", (userIdList.pop(), None, None, userNameList.pop()))
        conn.commit()
        
# Database error
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
finally:
    if conn:
        conn.close()