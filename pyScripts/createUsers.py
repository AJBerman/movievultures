# -*- coding: utf-8 -*-
import csv
import string

# Reading in the CSV file
ratingsFile = open('loremipsum.csv', 'r')
test = set()

try:
    allRatings = csv.reader(ratingsFile, delimiter=' ')
    with open('test.csv', "wb") as csv_file:
        for row in allRatings:
            for r in row:
                r = "".join(c for c in r if c not in string.punctuation)
                test.add(r)
        
        #for t in test:
        #    print t
        
        print "length of set: "
        print len(test)

        with open('randomUsers.csv', "wb") as csv_file:
            writer = csv.writer(csv_file)
            for line in test:
                writer.writerow([line])
                
        csv_file.close()

finally:
    ratingsFile.close()