
0. Display Version


```python
import pandas as pd
import sqlite3

conn = sqlite3.connect('Db-IMDB.db')
query = " select sqlite_version() ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

      sqlite_version()
    0           3.28.0
    

<font color=red>IMPORTANT NOTE - Question 8 uses the windows function LAG.  This function is available after sqlite version 3.25.  If your version is below that then question 8 will return an error</font>

After checking the database and trying a few queries, I decided to fix the deficiencies in the database.  There are no indexes to the necessary fields and spaces need to be removed.   This allows me to practice DDL and DML commands.

**PREPROCESSING OF TABLES**

FIX Movie Table


```python
#year field is messy.  It has ROMAN numerals and the year itself is in the last four characters of the string.  I am 
#creating a yearfixed field

conn = sqlite3.connect('Db-IMDB.db')
# Cursor object
cursor  = conn.cursor()
query = " ALTER TABLE Movie "
query += "     ADD yearfixed INTEGER; "
cursor.execute(query)
conn.commit()
conn.close()

```


```python
#removing spaces to TEXT columns.  This will allow me to not use TRIM on fields used for joins which I can then create an index.
#This has GREATLY improved the performance of the queries.
conn = sqlite3.connect('Db-IMDB.db')
query = " UPDATE Movie set MID = TRIM(MID), title = TRIM(title), yearfixed = CAST(substr(year, -4) AS INTEGER); "
cursor  = conn.cursor()
cursor.execute(query)
conn.commit()
conn.close()
```


```python
conn = sqlite3.connect('Db-IMDB.db')
query = "CREATE INDEX ix_Movie_MID ON Movie (MID); "
cursor  = conn.cursor()
cursor.execute(query)
conn.commit()
conn.close()

```

FIX Genre Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE Genre set Name = TRIM(Name); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_Genre_GID ON Genre (GID); "
cursor.execute(query)
conn.commit()

conn.close()

```

FIX Language Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE Language set Name = TRIM(Name); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_Language_LAID ON Language (LAID); "
cursor.execute(query)
conn.commit()

conn.close()

```

FIX Country Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE Country set Name = TRIM(Name); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_Country_CID ON Country (CID); "
cursor.execute(query)
conn.commit()

conn.close()


```

FIX Location Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE Location set Name = TRIM(Name); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_Location_LID ON Location (LID); "
cursor.execute(query)
conn.commit()

conn.close()



```

FIX M_Location Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Location set MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Location_MID ON M_Location (MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Location_LID ON M_Location (LID); "
cursor.execute(query)
conn.commit()

conn.close()


```

FIX M_Country Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Country set MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Country_MID ON M_Country (MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Country_LID ON M_Country (CID); "
cursor.execute(query)
conn.commit()

conn.close()

```

FIX M_Language Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Language set MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Language_MID ON M_Language (MID);"
cursor.execute(query)
conn.commit()

query = "CREATE INDEX ix_M_Language_LID ON M_Language (LAID);"
cursor.execute(query)
conn.commit()

conn.close()


```

FIX M_Genre Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Genre set MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Genre_MID ON M_Genre (MID);"
cursor.execute(query)
conn.commit()

query = "CREATE INDEX ix_M_Genre_GID ON M_Genre (GID);"
cursor.execute(query)
conn.commit()

conn.close()

```

FIX Person Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE Person set PID = TRIM(PID), Name = TRIM(Name), Gender = TRIM(Gender); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_Person_PID ON Person (PID);"
cursor.execute(query)
conn.commit()


conn.close()

```

FIX M_Producer Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Producer set PID = TRIM(PID), MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Producer_MID ON M_Producer (MID);"
cursor.execute(query)
conn.commit()

query = "CREATE INDEX ix_M_Producer_PID ON M_Producer (PID);"
cursor.execute(query)
conn.commit()

conn.close()

```

FIX M_Director Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Director set PID = TRIM(PID), MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Director_MID ON M_Director (MID);"
cursor.execute(query)
conn.commit()

query = "CREATE INDEX ix_M_Director_PID ON M_Director (PID);"
cursor.execute(query)
conn.commit()

conn.close()





```

FIX M_Cast Table


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = "UPDATE M_Cast set PID = TRIM(PID), MID = TRIM(MID); "
cursor.execute(query)
conn.commit()


query = "CREATE INDEX ix_M_Cast_MID ON M_Cast (MID);"
cursor.execute(query)
conn.commit()

query = "CREATE INDEX ix_M_Cast_PID ON M_Cast (PID);"
cursor.execute(query)
conn.commit()

conn.close()


```

1. List all the directors who directed a 'Comedy' movie in a leap year. (You need to check that the genre is 'Comedy’ and year is a leap year) Your query should return director name, the movie name, and the year.


```python
#Version 1 - Just get Genre = Comedy
conn = sqlite3.connect('Db-IMDB.db')
query = "SELECT DISTINCT Person.name as director_name, Movie.title as movie_name, yearfixed as year "
query += "FROM Genre INNER JOIN M_Genre ON  M_Genre.GID = Genre.GID "
query += " INNER JOIN  Movie ON Movie.MID = M_Genre.MID "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += " INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Genre.Name = 'Comedy' and ((yearfixed % 4 = 0) and (yearfixed % 100 != 0) or (yearfixed % 400 = 0));"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()
```

                director_name                        movie_name  year
    0            Milap Zaveri                        Mastizaade  2016
    1            Umesh Ghadge              Kyaa Kool Hain Hum 3  2016
    2           Sameer Sharma      Luv Shuv Tey Chicken Khurana  2012
    3          Sanjeev Sharma                     Saat Uchakkey  2016
    4            Nitin Kakkar                        Filmistaan  2012
    5       Krishnadev Yagnik                    Days of Tafree  2016
    6         Abhishek Sharma     Tere Bin Laden: Dead Or Alive  2016
    7            Mahesh Bhatt                   Papa Kahte Hain  1996
    8            Sachin Yardi          Kyaa Super Kool Hain Hum  2012
    9                  Sachin              Navra Mazha Navsacha  2004
    10           Kawal Sharma                         Maalamaal  1988
    11            Aditya Datt                 Will You Marry Me  2012
    12         Rajnish Thakur  Mere Dost Picture Abhi Baaki Hai  2012
    13           Karan Razdan               Mr Bhatti on Chutti  2012
    14     Jagdish Rajpurohit                            Bumboo  2012
    15            Suhas Kadav         Motu Patlu: King of Kings  2016
    16       Vickrant Mahajan                     Challo Driver  2012
    17              Bhagyaraj                       Mr. Bechara  1996
    18           Rakesh Mehta              Life Ki Toh Lag Gayi  2012
    19           Anand Balraj          Daal Mein Kuch Kaala Hai  2012
    20           Govind Menon                 Kis Kis Ki Kismat  2004
    21        Pankaj Parashar                    Ab Ayega Mazaa  1984
    22           Jabbar Patel                  Ek Hota Vidushak  1992
    23      Srinivas Bhashyam                      Paisa Vasool  2004
    24            Raj Kaushal                  Shaadi Ka Laddoo  2004
    25  Siddharth Anand Kumar                       Let's Enjoy  2004
    


```python
#Version 2- Genre LIKE Comedy.   NOTE - Takes a long time to run
conn = sqlite3.connect('Db-IMDB.db')
query = "SELECT DISTINCT Person.name as director_name, Movie.title as movie_name, yearfixed as year "
query += "FROM Genre INNER JOIN M_Genre ON  M_Genre.GID = Genre.GID "
query += " INNER JOIN  Movie ON Movie.MID = M_Genre.MID "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += " INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Genre.Name LIKE '%Comedy%' and ((yearfixed % 4 = 0) and (yearfixed % 100 != 0) or (yearfixed % 400 = 0));"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()
```

                 director_name                         movie_name  year
    0             Milap Zaveri                         Mastizaade  2016
    1             Danny Leiner  Harold & Kumar Go to White Castle  2004
    2           Anurag Kashyap                 Gangs of Wasseypur  2012
    3             Frank Coraci        Around the World in 80 Days  2004
    4            Griffin Dunne             The Accidental Husband  2008
    5              Anurag Basu                             Barfi!  2012
    6          Gurinder Chadha                  Bride & Prejudice  2004
    7               Mike Judge    Beavis and Butt-Head Do America  1996
    8         Tarun Mansukhani                            Dostana  2008
    9             Shakun Batra                      Kapoor & Sons  2016
    10           Aditya Chopra                Rab Ne Bana Di Jodi  2008
    11            Rohit Dhawan                            Dishoom  2016
    12             Nitya Mehra                    Baar Baar Dekho  2016
    13        Dibakar Banerjee              Oye Lucky! Lucky Oye!  2008
    14            Umesh Shukla                    OMG: Oh My God!  2012
    15           Aditya Chopra                            Befikre  2016
    16             Karan Johar                Student of the Year  2012
    17              Farah Khan                       Main Hoon Na  2004
    18          Shoojit Sircar                        Vicky Donor  2012
    19          Abbas Tyrewala            Jaane Tu... Ya Jaane Na  2008
    20            Priyadarshan                         Hera Pheri  2000
    21    Shubhashish Bhutiani                    Hotel Salvation  2016
    22            James Dodson          The Other End of the Line  2008
    23           Homi Adajania                           Cocktail  2012
    24           Joy Augustine                    Tere Mere Sapne  1996
    25           Mudassar Aziz                  Happy Bhag Jayegi  2016
    26            Gauri Shinde                   English Vinglish  2012
    27          S.S. Rajamouli                               Eega  2012
    28            Remo D'Souza                      A Flying Jatt  2016
    29             Sohail Khan                         Freaky Ali  2016
    ..                     ...                                ...   ...
    202              Joe Rajan                       Luv U Soniyo  2012
    203           Anand Balraj           Daal Mein Kuch Kaala Hai  2012
    204           Govind Menon                  Kis Kis Ki Kismat  2004
    205            Mohan Segal                          New Delhi  1956
    206        Pankaj Parashar                     Ab Ayega Mazaa  1984
    207         Tarun Majumdar                        Dadar Kirti  1980
    208             Salim Raza                       Bach ke Zara  2008
    209           Jabbar Patel                   Ek Hota Vidushak  1992
    210           Sanjay Chhel           Maan Gaye Mughall-E-Azam  2008
    211   Sachin Kamlakar Khot                     Ugly Aur Pagli  2008
    212           David Dhawan                      Bol Radha Bol  1992
    213              Kalpataru                Ghar Ghar Ki Kahani  1988
    214            Vimal Kumar                      Suno Sasurjee  2004
    215      Srinivas Bhashyam                       Paisa Vasool  2004
    216       Ganapathy Bharat                            Hari Om  2004
    217               Debu Sen                      Do Dooni Char  1968
    218            Raj Kaushal                   Shaadi Ka Laddoo  2004
    219         Kabir Sadanand          Popcorn Khao! Mast Ho Jao  2004
    220                Mehmood                    Ginny Aur Johny  1976
    221        Basu Chatterjee                     Lakhon Ki Baat  1984
    222            Shankaraiya                          Khokababu  2012
    223   Chandrakant Kulkarni                   Meerabai Not Out  2008
    224            Yograj Bhat                      Ranga S.S.L.C  2004
    225           Deepak Anand                Yaad Rakhegi Duniya  1992
    226           Vijaya Mehta                          Pestonjee  1988
    227  Siddharth Anand Kumar                        Let's Enjoy  2004
    228        Amma Rajasekhar                            Sathyam  2008
    229          Oliver Paulus                      Tandoori Love  2008
    230            Raja Chanda                        Le Halua Le  2012
    231       K.S. Prakash Rao                  Raja Aur Rangeeli  1996
    
    [232 rows x 3 columns]
    

2. List the names of all the actors who played in the movie 'Anand' (1971)


```python
#Person M_Cast #Movie
conn = sqlite3.connect('Db-IMDB.db')
query = "SELECT DISTINCT Person.name "
query += "FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE Movie.title = 'Anand' ;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()
```

                    Name
    0      Rajesh Khanna
    1   Amitabh Bachchan
    2      Sumita Sanyal
    3         Ramesh Deo
    4          Seema Deo
    5     Asit Kumar Sen
    6         Dev Kishan
    7       Atam Prakash
    8      Lalita Kumari
    9             Savita
    10    Brahm Bhardwaj
    11      Gurnam Singh
    12      Lalita Pawar
    13       Durga Khote
    14        Dara Singh
    15     Johnny Walker
    16         Moolchand
    

3. List all the actors who acted in a film before 1970 and in a film after 1990. (That is: < 1970 and > 1990.)


```python
conn = sqlite3.connect('Db-IMDB.db')
query = "SELECT DISTINCT Person.name as actor "
query += "FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE yearfixed > 1990   AND Person.PID IN (SELECT Person.PID "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE yearfixed < 1970);"
result = pd.read_sql_query(query, conn) 
print(result)
conn.close()
```

                      actor
    0      Amitabh Bachchan
    1    Mohandas K. Gandhi
    2                 Rekha
    3            Dharmendra
    4     Prithviraj Kapoor
    5         Shammi Kapoor
    6         Shashi Kapoor
    7         Rajesh Khanna
    8           Hema Malini
    9           Sanjay Dutt
    10           Sunil Dutt
    11       Rajendra Kumar
    12          Ashok Kumar
    13          Manoj Kumar
    14         Subhash Ghai
    15            Dev Anand
    16                Abbas
    17                Abdul
    18           Jalal Agha
    19                 Ajay
    20                 Ajit
    21           Haidar Ali
    22         Mohammed Ali
    23                 Amar
    24                 Arun
    25                 Aziz
    26          Aruna Irani
    27               Sarika
    28             Tabassum
    29           Saira Banu
    ..                  ...
    270             Jaswant
    271         Miss Firoza
    272          Gopal Dutt
    273             Pardesi
    274    Ghanshyam Rohera
    275         Master Amar
    276        Brij Bhushan
    277        Baby Deepali
    278              Chhaya
    279    Satyendra Kapoor
    280             Jambura
    281      Shamsher Singh
    282       Rakesh Sharma
    283               Thapa
    284              Naseem
    285       Ramesh Sharma
    286    Pradeep Chaudhry
    287               Amrit
    288               Ameer
    289        Rohit Chopra
    290              Samina
    291            Raj Dutt
    292              Merlyn
    293     Babbanlal Yadav
    294              Asrani
    295         Mohamad Ali
    296                Dube
    297      Aachi Manorama
    298       Surendra Rahi
    299             Shirley
    
    [300 rows x 1 columns]
    

4. List all directors who directed 10 movies or more, in descending order of the number of movies they directed. Return the directors' names and the number of movies each of them directed.


```python
conn = sqlite3.connect('Db-IMDB.db')
query = "SELECT Person.name as director_name, count(Movie.title) as number_of_movies "
query += "FROM Movie INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += " INNER JOIN  Person on Person.PID = M_Director.PID "
query += " GROUP BY Person.name "
query += " HAVING count(Movie.title) >= 10 "
query += " ORDER BY count(Movie.title) DESC;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()
```

                    director_name  number_of_movies
    0                David Dhawan                78
    1                Mahesh Bhatt                72
    2             Ram Gopal Varma                60
    3                Vikram Bhatt                58
    4        Hrishikesh Mukherjee                54
    5                 Yash Chopra                42
    6             Basu Chatterjee                38
    7              Shakti Samanta                38
    8                Subhash Ghai                36
    9    Abbas Alibhai Burmawalla                34
    10              Shyam Benegal                34
    11                     Gulzar                32
    12             Manmohan Desai                32
    13               Raj N. Sippy                32
    14           Mahesh Manjrekar                30
    15               Priyadarshan                30
    16                 Raj Kanwar                30
    17                Indra Kumar                28
    18               Rahul Rawail                28
    19                 Raj Khosla                28
    20          Rajkumar Santoshi                28
    21   Ananth Narayan Mahadevan                26
    22             Anurag Kashyap                26
    23                  Dev Anand                26
    24               Harry Baweja                26
    25         K. Raghavendra Rao                26
    26              Rakesh Roshan                26
    27                Vijay Anand                26
    28               Anees Bazmee                24
    29                Anil Sharma                24
    ..                        ...               ...
    126              Krishna D.K.                10
    127               Kunal Kohli                10
    128               Lekh Tandon                10
    129                Mohan Babu                10
    130               Mohan Segal                10
    131             Neeraj Pandey                10
    132           Nishikant Kamat                10
    133           Pankaj Parashar                10
    134               Pooja Bhatt                10
    135            Pradeep Sarkar                10
    136             Prawaal Raman                10
    137                  R. Balki                10
    138              Rajat Kapoor                10
    139           Rajkumar Hirani                10
    140              Rakesh Kumar                10
    141   Rakeysh Omprakash Mehra                10
    142            Ramanand Sagar                10
    143              Remo D'Souza                10
    144            S.S. Rajamouli                10
    145        Saeed Akhtar Mirza                10
    146                Sajid Khan                10
    147             Sanjay Gadhvi                10
    148         Shankar Mukherjee                10
    149         Shashilal K. Nair                10
    150            Shoojit Sircar                10
    151           Siddharth Anand                10
    152            Subhash Kapoor                10
    153           Subodh Mukherji                10
    154               Sujoy Ghosh                10
    155               Zoya Akhtar                10
    
    [156 rows x 2 columns]
    

5.<br/>
     a. For each year, count the number of movies in that year that had only female actors.<br/>
     b. Now include a small change: report for each year the percentage of movies in that year with only female actors, and the total number of movies made that year. For example, one answer will be: 1990 31.81 13522 meaning that in 1990 there were 13,522 movies, and 31.81% had only female actors. You do not need to round your answer.


```python
#a. Select all the movies with female actors and remove the ones that had a male actor.  Use of NOT IN 
conn = sqlite3.connect('Db-IMDB.db')
query = "select yearfixed as year, count(Movie.Title) as number_of_movies "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " where Person.Gender = 'Female' and Movie.Title NOT IN  "
query += " (SELECT Movie.Title  "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID   "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID  "
query += " where Person.Gender = 'Male')  "
query += " GROUP BY  yearfixed; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

       year  number_of_movies
    0  1939                 2
    1  1999                11
    2  2000                11
    3  2018                 2
    


```python
#b.  CReate a temp table with the information in #a and use this temp table to determine the percent of female only movies
# that year

conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

query = " CREATE TEMP TABLE Female_Only_Movies AS "
query += " Select yearfixed as year, count(Movie.Title) as number_of_movies "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " where Person.Gender = 'Female' and Movie.Title NOT IN  "
query += " (SELECT Movie.Title  "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID   "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID  "
query += " where Person.Gender = 'Male')  "
query += " GROUP BY  yearfixed; "

cursor.execute(query)
conn.commit()

query = "SELECT Movie.yearfixed as year, count(Movie.Title) as total_movies, cast(number_of_movies as real)/cast(count(Movie.Title) as real) *100 as percent_female_only_movies "
query += "FROM temp.Female_Only_Movies INNER JOIN Movie on temp.Female_Only_Movies.year = Movie.yearfixed "
query += " GROUP BY  Movie.yearfixed, number_of_movies ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

       year  total_movies  percent_female_only_movies
    0  1939             2                  100.000000
    1  1999            66                   16.666667
    2  2000            64                   17.187500
    3  2018           104                    1.923077
    


```python
#b Version 2 - Using CTE   - One query
conn = sqlite3.connect('Db-IMDB.db')
query = " WITH Female_Only_Movies AS "
query += " (Select yearfixed as year, count(Movie.Title) as number_of_movies "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " where Person.Gender = 'Female' and Movie.Title NOT IN  "
query += " (SELECT Movie.Title  "
query += " FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID   "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID  "
query += " where Person.Gender = 'Male')  "
query += " GROUP BY  yearfixed) "
query += " SELECT Movie.yearfixed as year, count(Movie.Title) as total_movies, cast(number_of_movies as real)/cast(count(Movie.Title) as real) *100 as percent_female_only_movies "
query += " FROM Female_Only_Movies INNER JOIN Movie on Female_Only_Movies.year = Movie.yearfixed "
query += " GROUP BY  Movie.yearfixed, number_of_movies ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()





```

       year  total_movies  percent_female_only_movies
    0  1939             2                  100.000000
    1  1999            66                   16.666667
    2  2000            64                   17.187500
    3  2018           104                    1.923077
    

6. Find the film(s) with the largest cast. Return the movie title and the size of the cast. By "cast size" we mean the number of distinct actors that played in that movie: if an actor played multiple roles, or if it simply occurs multiple times in casts, we still count her/him only once.


```python
#Use count(distinct()) to determine unique members of the cast

conn = sqlite3.connect('Db-IMDB.db')

query = " Select Movie.title, count(distinct(Person.name)) as Total_Cast "
query += "FROM Movie INNER JOIN  M_Cast ON Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " GROUP BY  Movie.title "
query += " ORDER BY  count(distinct(Person.name)) DESC LIMIT 1; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()
```

               title  Total_Cast
    0  Ocean's Eight         238
    

7. A decade is a sequence of 10 consecutive years. For example, say in your database you have movie information starting from 1965. Then the first decade is 1965, 1966, ..., 1974; the second one is 1967, 1968, ..., 1976 and so on. Find the decade D with the largest number of films and the total number of films in D.


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

#Total movies per year
query = " CREATE TEMP TABLE Movies_per_year AS "
query += " Select yearfixed as year, count(Movie.Title) as Total_movies "
query += " FROM Movie "
query += " GROUP BY  yearfixed; "
cursor.execute(query)
conn.commit()

#define decades
query = " CREATE TEMP TABLE Decades AS "
query += " Select distinct yearfixed as first_year, yearfixed + 9 as last_year, (CAST(yearfixed as TEXT) || '-' || CAST(yearfixed + 9 AS TEXT)) as decade  "
query += " FROM Movie ;"
cursor.execute(query)
conn.commit()

#Use CROSS JOIN to determine the movies per decade
query = " CREATE TEMP TABLE Movies_per_decade AS "
query += " SELECT Decades.decade, SUM(Movies_per_year.Total_movies) AS sum_movies  "
query += " FROM Movies_per_year CROSS JOIN Decades "
query += " WHERE Movies_per_year.year BETWEEN Decades.first_year AND Decades.last_year "
query += " GROUP BY Decades.decade ;"
cursor.execute(query)
conn.commit()

#get the decade with most movies by using LIMIT 1 and DESC
query = " select decade , sum_movies as total_movies FROM Movies_per_decade "
query += " order by sum_movies DESC "
query += " LIMIT 1 ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()



```

          decade  total_movies
    0  2008-2017          1205
    


```python
#Version2 using CTE  - One query
conn = sqlite3.connect('Db-IMDB.db')

#Total movies per year
query = " WITH Movies_per_year AS "
query += " (Select yearfixed as year, count(Movie.Title) as Total_movies "
query += " FROM Movie "
query += " GROUP BY  yearfixed), "
#define decades
query += " Decades AS "
query += " (Select distinct yearfixed as first_year, yearfixed + 9 as last_year, (CAST(yearfixed as TEXT) || '-' || CAST(yearfixed + 9 AS TEXT)) as decade  "
query += " FROM Movie), "
#Use CROSS JOIN to determine the movies per decade
query += " Movies_per_decade AS "
query += " (SELECT Decades.decade, SUM(Movies_per_year.Total_movies) AS sum_movies  "
query += " FROM Movies_per_year CROSS JOIN Decades "
query += " WHERE Movies_per_year.year BETWEEN Decades.first_year AND Decades.last_year "
query += " GROUP BY Decades.decade ) "
#get the decade with most movies by using LIMIT 1 and DESC
query += " select decade , sum_movies as total_movies FROM Movies_per_decade "
query += " order by sum_movies DESC "
query += " LIMIT 1 ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

          decade  total_movies
    0  2008-2017          1205
    

8. Find the actors that were never unemployed for more than 3 years at a stretch. (Assume that the actors remain unemployed between two consecutive movies).


```python
#ONLY WORKS WITH sqlite version 3.25 and above

conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

#get the actors and the years they were in a movie
query = " CREATE TEMP TABLE Actors_year AS "
query += " SELECT DISTINCT Person.name as actor, yearfixed as year "
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID; "
cursor.execute(query)
conn.commit()

#use the LAG function to determine the number of years between movies
query = " CREATE TEMP TABLE Actors_lag AS "
query += " SELECT  actor, year, (year - LAG(year, 1, 0) OVER (PARTITION BY actor ORDER BY year)) diff "
query += " FROM Actors_year "
query += " ORDER BY actor; "
cursor.execute(query)
conn.commit()

#Select the max difference of years for each actors assuming that there can not be a difference of 100 years between movies.
#This query also removes actors who have benn in just one movie.
query = " CREATE TEMP TABLE Actors_diff AS "
query += " SELECT actor, MAX(diff) AS max_unemployed_years "
query += " FROM Actors_lag "
query += " WHERE (diff < 100) "
query += " GROUP BY actor; "
cursor.execute(query)
conn.commit()

#Select the actors where the max difference has been 3 years or less
query = " select actor from Actors_diff "
query += " where max_unemployed_years <=3 ;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()


```

                       actor
    0        'Ganja' Karuppu
    1        A. Abdul Hameed
    2        A.R. Manikandan
    3        A.R. Murugadoss
    4              A.R. Rama
    5     A.V.S. Subramanyam
    6                  Aadhi
    7           Aadil Chahal
    8           Aahana Kumra
    9         Aahuthi Prasad
    10                Aakash
    11        Aakash Dabhade
    12         Aakash Dahiya
    13       Aakash Maheriya
    14         Aalok Pradhan
    15       Aamir Ali Malik
    16          Aamir Yaseen
    17       Aanchal Dwivedi
    18        Aaradhna Uppal
    19         Aarnaa Sharma
    20                Aarthi
    21         Aarti Agarwal
    22        Aarti Chhabria
    23        Aashin A. Shah
    24     Aashish Chaudhary
    25           Aashu Mohil
    26            Aasif Shah
    27           Aayam Mehta
    28       Abdul Hakim Joy
    29     Abdul Quadir Amin
    ...                  ...
    2987         Yugesh Anil
    2988          Yugi Sethu
    2989     Yulian Shchukin
    2990        Yunus Parvez
    2991           Yuri Suri
    2992          Yusuf Bawa
    2993       Yusuf Hussain
    2994         Yusuf Irani
    2995    Yuvraaj Parashar
    2996              Yuvraj
    2997        Yuvraj Singh
    2998  Yuvraj Singh Bajwa
    2999          Zabyn Khan
    3000      Zachary Coffin
    3001  Zachary Culbertson
    3002             Zaheeda
    3003              Zaheer
    3004           Zain Khan
    3005         Zaira Wasim
    3006         Zareen Khan
    3007          Zayed Khan
    3008          Zeb Rehman
    3009        Zeena Bhatia
    3010         Zehra Naqvi
    3011      Zeishan Quadri
    3012    Zivile Matikiene
    3013       Ziyah Vastani
    3014        Zoya Hussain
    3015         Zubeen Garg
    3016         Zulfi Sayed
    
    [3017 rows x 1 columns]
    


```python
#Version 2 using CTE  - One query
conn = sqlite3.connect('Db-IMDB.db')

#get the actors and the years they were in a movie
query = " WITH Actors_year AS "
query += " (SELECT DISTINCT Person.name as actor, yearfixed as year "
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID), "
#use the LAG function to determine the number of years between movies
query += " Actors_lag AS "
query += " (SELECT  actor, year, (year - LAG(year, 1, 0) OVER (PARTITION BY actor ORDER BY year)) diff "
query += " FROM Actors_year "
query += " ORDER BY actor), "
#Select the max difference of years for each actors assuming that there can not be a difference of 100 years between movies.
#This query also removes actors who have benn in just one movie.
query += " Actors_diff AS "
query += " (SELECT actor, MAX(diff) AS max_unemployed_years "
query += " FROM Actors_lag "
query += " WHERE (diff < 100) "
query += " GROUP BY actor) "
#Select the actors where the max difference has been 3 years or less
query += " select actor from Actors_diff "
query += " where max_unemployed_years <=3 ;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

                       actor
    0        'Ganja' Karuppu
    1        A. Abdul Hameed
    2        A.R. Manikandan
    3        A.R. Murugadoss
    4              A.R. Rama
    5     A.V.S. Subramanyam
    6                  Aadhi
    7           Aadil Chahal
    8           Aahana Kumra
    9         Aahuthi Prasad
    10                Aakash
    11        Aakash Dabhade
    12         Aakash Dahiya
    13       Aakash Maheriya
    14         Aalok Pradhan
    15       Aamir Ali Malik
    16          Aamir Yaseen
    17       Aanchal Dwivedi
    18        Aaradhna Uppal
    19         Aarnaa Sharma
    20                Aarthi
    21         Aarti Agarwal
    22        Aarti Chhabria
    23        Aashin A. Shah
    24     Aashish Chaudhary
    25           Aashu Mohil
    26            Aasif Shah
    27           Aayam Mehta
    28       Abdul Hakim Joy
    29     Abdul Quadir Amin
    ...                  ...
    2987         Yugesh Anil
    2988          Yugi Sethu
    2989     Yulian Shchukin
    2990        Yunus Parvez
    2991           Yuri Suri
    2992          Yusuf Bawa
    2993       Yusuf Hussain
    2994         Yusuf Irani
    2995    Yuvraaj Parashar
    2996              Yuvraj
    2997        Yuvraj Singh
    2998  Yuvraj Singh Bajwa
    2999          Zabyn Khan
    3000      Zachary Coffin
    3001  Zachary Culbertson
    3002             Zaheeda
    3003              Zaheer
    3004           Zain Khan
    3005         Zaira Wasim
    3006         Zareen Khan
    3007          Zayed Khan
    3008          Zeb Rehman
    3009        Zeena Bhatia
    3010         Zehra Naqvi
    3011      Zeishan Quadri
    3012    Zivile Matikiene
    3013       Ziyah Vastani
    3014        Zoya Hussain
    3015         Zubeen Garg
    3016         Zulfi Sayed
    
    [3017 rows x 1 columns]
    

9. Find all the actors that made more movies with Yash Chopra than any other director.


```python
#Note: Yash Chopra appears in the Cast and Director tables so he appears as part of the output
#M_Cast
#Yash Chopra  nm0007181
#M_Director
#Yash Chopra  nm0007181


conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

#select actors and the count of movies made with Yash Chopra as director
query = " CREATE TEMP TABLE Cast_in_YashChopra AS "
query += " SELECT Person.name, count(Movie.title) as movies_in "
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE Movie.MID IN "
query += " ( SELECT Movie.MID FROM Movie "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += "  INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Person.name = 'Yash Chopra') "
query += " GROUP BY Person.name; "

cursor.execute(query)
conn.commit()


#select actors and the count of movies made NOT with Yash Chopra as director
query = " CREATE TEMP TABLE Cast_not_in_YashChopra AS "
query += " SELECT Person.name , count(Movie.title) as movies_not_in"
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE Movie.MID IN "
query += " ( SELECT Movie.MID FROM Movie "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += "  INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Person.name <> 'Yash Chopra') "
query += " GROUP BY Person.name; "
cursor.execute(query)
conn.commit()

#compare the counts and get the ones that have more movies with Yash Chopra as director
query = " SELECT temp.Cast_in_YashChopra.name "
query += " FROM temp.Cast_in_YashChopra INNER JOIN temp.Cast_not_in_YashChopra ON  temp.Cast_in_YashChopra.name = temp.Cast_not_in_YashChopra.name "
query += " WHERE movies_in > movies_not_in ;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()




```

               Name
    0   Ashok Verma
    1         Nazir
    2  Varun Thakur
    3   Yash Chopra
    


```python
#Version 2 Using CTE  - One query
conn = sqlite3.connect('Db-IMDB.db')

#select actors and the count of movies made with Yash Chopra as director
query = " WITH Cast_in_YashChopra AS "
query += " (SELECT Person.name, count(Movie.title) as movies_in "
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE Movie.MID IN "
query += " ( SELECT Movie.MID FROM Movie "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += "  INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Person.name = 'Yash Chopra') "
query += " GROUP BY Person.name), "
#select actors and the count of movies made NOT with Yash Chopra as director
query += "  Cast_not_in_YashChopra AS "
query += " (SELECT Person.name , count(Movie.title) as movies_not_in"
query += " FROM Movie INNER JOIN M_Cast ON  Movie.MID = M_Cast.MID "
query += " INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " WHERE Movie.MID IN "
query += " ( SELECT Movie.MID FROM Movie "
query += " INNER JOIN  M_Director ON Movie.MID = M_Director.MID "
query += "  INNER JOIN  Person on Person.PID = M_Director.PID "
query += " WHERE Person.name <> 'Yash Chopra') "
query += " GROUP BY Person.name) "
#compare the counts and get the ones that have more movies with Yash Chopra as director
query +=  " SELECT Cast_in_YashChopra.name "
query += " FROM Cast_in_YashChopra INNER JOIN Cast_not_in_YashChopra ON  Cast_in_YashChopra.name = Cast_not_in_YashChopra.name "
query += " WHERE movies_in > movies_not_in ;"
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

               name
    0   Ashok Verma
    1         Nazir
    2  Varun Thakur
    3   Yash Chopra
    

10. The Shahrukh number of an actor is the length of the shortest path between the actor and Shahrukh Khan in the "co-acting" graph. That is, Shahrukh Khan has Shahrukh number 0; all actors who acted in the same film as Shahrukh have Shahrukh number 1; all actors who acted in the same film as some actor with Shahrukh number 1 have Shahrukh number 2, etc. Return all actors whose Shahrukh number is 2.


```python
conn = sqlite3.connect('Db-IMDB.db')
cursor  = conn.cursor()

#get the MID of Shah Rukh Khan movies
query = " CREATE TEMP TABLE Movies_by_Shahrukhkhan AS "
query += " SELECT DISTINCT M_Cast.MID as MID "
query += " FROM M_Cast INNER JOIN  Person on Person.PID = M_Cast.PID  "
query += " where LTRIM(RTRIM(Person.name)) = 'Shah Rukh Khan'; "
cursor.execute(query)
conn.commit()

#Shahrukh number 1.  Get the cast of the movies with Shah Rukh Khan
query = " CREATE TEMP TABLE Cast_with_Shahrukhkhan AS "
query += " Select distinct M_Cast.PID as PID "
query += " FROM M_Cast where  M_Cast.MID IN (SELECT MID FROM  Movies_by_Shahrukhkhan) ; "
cursor.execute(query)
conn.commit()

#Get the movies of the coactors of Shah Rukh Khan
query = " CREATE TEMP TABLE Movies_of_coactors AS "
query += " Select M_Cast.MID from M_Cast WHERE PID IN (Select PID FROM Cast_with_Shahrukhkhan) ; "
cursor.execute(query)
conn.commit()

#Shahrukh number 2.  Do not include Shahrukh number 1 (NOT IN)
query = "Select distinct Person.name from M_Cast INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " where MID in (SELECT MID FROM Movies_of_coactors) AND M_Cast.PID NOT IN (SELECT PID FROM Cast_with_Shahrukhkhan) ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()


```

                                 Name
    0                     Devika Rani
    1                        Monorama
    2                         Pramila
    3                    Kamta Prasad
    4                    Kusum Kumari
    5                          Anwari
    6                  P.F. Pithawala
    7                     Kishori Lal
    8                          Ishrat
    9                      N.M. Joshi
    10                         Khosla
    11                     Mumtaz Ali
    12                    Sunita Devi
    13                    Najam Naqvi
    14                  Mumtaz Shanti
    15                     Shah Nawaz
    16                  Chandraprabha
    17                     V.H. Desai
    18                       Kanu Roy
    19               Jagannath Aurora
    20                        Prahlad
    21                         Haroon
    22                        Mubarak
    23                  Kamala Kumari
    24                  David Abraham
    25     Shantaram Rajaram Vankudre
    26                      Jayashree
    27                 Keshavrao Date
    28                   Pratima Devi
    29                 Prof. Hudlikar
    ...                           ...
    24278                 Advita Tank
    24279                  Kunal Teli
    24280                Prisha Vohra
    24281                 Varun Mitra
    24282                 Arya Poorti
    24283                Aanya Dureja
    24284             Sanchay Goswami
    24285               Arjun Kanungo
    24286                Sonali Sudan
    24287                Shataf Figar
    24288              Daanish Gandhi
    24289            Intekhab Mahmood
    24290                   Rashi Mal
    24291             Chirag Malhotra
    24292                Akash Thosar
    24293                      Kierra
    24294               Kritika Kamra
    24295           Perlene Bhersaina
    24296               Rishi Panchal
    24297                  Neha Reddy
    24298                    Maya Ben
    24299                  Panna Bhen
    24300               Bhumika Dubey
    24301               Pratik Gandhi
    24302                Brinda Nayak
    24303               Shivam Parekh
    24304                 Chhaya Vora
    24305                        Avii
    24306                   Sayed Gul
    24307                Jyoti Malshe
    
    [24308 rows x 1 columns]
    


```python
#Version 2 Using CTE - One query
conn = sqlite3.connect('Db-IMDB.db')

#get the MID of Shah Rukh Khan movies
query = " WITH Movies_by_Shahrukhkhan AS "
query += " (SELECT DISTINCT M_Cast.MID as MID "
query += " FROM M_Cast INNER JOIN  Person on Person.PID = M_Cast.PID  "
query += " where LTRIM(RTRIM(Person.name)) = 'Shah Rukh Khan'),  "
#Shahrukh number 1.  Get the cast of the movies with Shah Rukh Khan
query += " Cast_with_Shahrukhkhan AS "
query += " (Select distinct M_Cast.PID as PID "
query += " FROM M_Cast where  M_Cast.MID IN (SELECT MID FROM  Movies_by_Shahrukhkhan)), "
#Get the movies of the coactors of Shah Rukh Khan
query +=" Movies_of_coactors AS "
query += " (Select M_Cast.MID from M_Cast WHERE PID IN (Select PID FROM Cast_with_Shahrukhkhan)) "
#Shahrukh number 2.  Do not include Shahrukh number 1 (NOT IN)
query += "Select distinct Person.name from M_Cast INNER JOIN  Person on Person.PID = M_Cast.PID "
query += " where MID in (SELECT MID FROM Movies_of_coactors) AND M_Cast.PID NOT IN (SELECT PID FROM Cast_with_Shahrukhkhan) ; "
result = pd.read_sql_query(query, conn)
print(result)
conn.close()

```

                                 Name
    0                     Devika Rani
    1                        Monorama
    2                         Pramila
    3                    Kamta Prasad
    4                    Kusum Kumari
    5                          Anwari
    6                  P.F. Pithawala
    7                     Kishori Lal
    8                          Ishrat
    9                      N.M. Joshi
    10                         Khosla
    11                     Mumtaz Ali
    12                    Sunita Devi
    13                    Najam Naqvi
    14                  Mumtaz Shanti
    15                     Shah Nawaz
    16                  Chandraprabha
    17                     V.H. Desai
    18                       Kanu Roy
    19               Jagannath Aurora
    20                        Prahlad
    21                         Haroon
    22                        Mubarak
    23                  Kamala Kumari
    24                  David Abraham
    25     Shantaram Rajaram Vankudre
    26                      Jayashree
    27                 Keshavrao Date
    28                   Pratima Devi
    29                 Prof. Hudlikar
    ...                           ...
    24278                 Advita Tank
    24279                  Kunal Teli
    24280                Prisha Vohra
    24281                 Varun Mitra
    24282                 Arya Poorti
    24283                Aanya Dureja
    24284             Sanchay Goswami
    24285               Arjun Kanungo
    24286                Sonali Sudan
    24287                Shataf Figar
    24288              Daanish Gandhi
    24289            Intekhab Mahmood
    24290                   Rashi Mal
    24291             Chirag Malhotra
    24292                Akash Thosar
    24293                      Kierra
    24294               Kritika Kamra
    24295           Perlene Bhersaina
    24296               Rishi Panchal
    24297                  Neha Reddy
    24298                    Maya Ben
    24299                  Panna Bhen
    24300               Bhumika Dubey
    24301               Pratik Gandhi
    24302                Brinda Nayak
    24303               Shivam Parekh
    24304                 Chhaya Vora
    24305                        Avii
    24306                   Sayed Gul
    24307                Jyoti Malshe
    
    [24308 rows x 1 columns]
    
