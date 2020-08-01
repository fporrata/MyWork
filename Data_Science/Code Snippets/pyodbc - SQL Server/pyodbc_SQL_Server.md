
## Simple script below to determine the max value for each string column in a Dataframe.  

This is very useful if you need to build a database from the Dataframe to determine the length of each field.


```python
import pandas as pd

employee = pd.read_csv("Report to IT (all data)_1854_10_01_2018_08_08.CSV", header = 0, skiprows = 2, parse_dates = ['Hire Date','Termination Date', 'Birth Date'  ])
print([ [col, int(employee[col].str.encode(encoding='utf-8').str.len().max())] for col in employee.select_dtypes(include=['O'], exclude = 'datetime').columns ])

```

    [['User Last Name', 35], ['User First Name', 34], ['User Name', 38], ['Citizenship 1', 26], ['User Address 1', 61], ['User Address 2', 37], ['User City', 29], ['User State', 14], ['User Zip', 12], ['User Country', 3], ['User Email', 44], ['User Manager Name', 31], ['User Manager Email', 34], ['User Mobile Number', 20], ['User Phone', 27], ['Building/Floor/Room Number', 44], ['Company provided mobile number', 20], ['UPI', 10], ['Division ID', 15], ['Division', 46], ['Job Title', 99], ['Cost Center', 74], ['Cost Center ID', 10], ['Location', 36], ['User type', 8], ['CSL', 9], ['Home address (1)', 88], ['Home address (2)', 52], ['Home address (3)', 49], ['Home address - City', 28], ['Home address - State', 19], ['Home address - Country', 20]]
    

# Use of pyodbc to insert pandas Dataframe in a SQL Server database table


```python
import pandas as pd
import pyodbc

employee = pd.read_csv("Report to IT (all data)_1854_10_01_2018_08_08.CSV", header = 0, skiprows = 2, parse_dates = ['Hire Date','Termination Date', 'Birth Date'  ])

#The code below makes it easy to insert NULLs in the database
employee1 = employee.where((pd.notnull(employee)), None)
employee1['Hire Date'] = employee1['Hire Date'].astype(object).where(employee1['Hire Date'].notnull(), None)
employee1['Termination Date'] = employee1['Termination Date'].astype(object).where(employee1['Termination Date'].notnull(), None)
employee1['Birth Date'] = employee1['Birth Date'].astype(object).where(employee1['Birth Date'].notnull(), None)

connStr = pyodbc.connect('DRIVER={ODBC Driver 13 for SQL Server}; SERVER=*******; DATABASE=*******; Trusted_Connection=yes')
cursor = connStr.cursor()
i = 1
for index,row in employee1.iterrows():
    cursor.execute("INSERT INTO dbo.Current_Info([User ID] \
           ,[Hire Date] \
           ,[Termination Date] \
           ,[User Last Name] \
           ,[User First Name] \
           ,[User Name] \
           ,[Birth Date] \
           ,[Citizenship 1] \
           ,[User Address 1] \
           ,[User Address 2] \
           ,[User City] \
           ,[User State] \
           ,[User Zip] \
           ,[User Country] \
           ,[User Email] \
           ,[User Manager Name] \
           ,[User Manager Email] \
           ,[User Mobile Number] \
           ,[User Phone] \
           ,[Building/Floor/Room Number] \
           ,[Company provided mobile number] \
           ,[UPI] \
           ,[Division ID] \
           ,[Division] \
           ,[Job Title] \
           ,[Weekly working hours] \
           ,[Cost Center] \
           ,[Cost Center ID] \
           ,[Location] \
           ,[User type] \
           ,[CSL] \
           ,[Home address (1)] \
           ,[Home address (2)] \
           ,[Home address (3)] \
           ,[Home address - City] \
           ,[Home address - State] \
           ,[Home address - Country] \
           ) values (" + "?," * 36 + "?)", \
            row["User ID"] \
           ,row["Hire Date"] \
           ,row["Termination Date"] \
           ,row["User Last Name"] \
           ,row["User First Name"] \
           ,row["User Name"] \
           ,row["Birth Date"] \
           ,row["Citizenship 1"] \
           ,row["User Address 1"] \
           ,row["User Address 2"] \
           ,row["User City"] \
           ,row["User State"] \
           ,row["User Zip"] \
           ,row["User Country"] \
           ,row["User Email"] \
           ,row["User Manager Name"] \
           ,row["User Manager Email"] \
           ,row["User Mobile Number"] \
           ,row["User Phone"] \
           ,row["Building/Floor/Room Number"] \
           ,row["Company provided mobile number"] \
           ,row["UPI"] \
           ,row["Division ID"] \
           ,row["Division"] \
           ,row["Job Title"] \
           ,row["Weekly working hours"] \
           ,row["Cost Center"] \
           ,row["Cost Center ID"] \
           ,row["Location"] \
           ,row["User type"] \
           ,row["CSL"] \
           ,row["Home address (1)"] \
           ,row["Home address (2)"] \
           ,row["Home address (3)"] \
           ,row["Home address - City"] \
           ,row["Home address - State"] \
           ,row["Home address - Country"]
            ) 
    
    connStr.commit()
cursor.close()
connStr.close()
print("Finished")
```

    Finished

# Create SQLite table using


```python
import pyodbc
conn = pyodbc.connect('Driver={SQLite3 ODBC Driver};'
                      'Server=localhost;'
                      'Database=testDB.db;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()
cursor.execute('''
 CREATE TABLE PeopleInfo (
        PersonId INTEGER PRIMARY KEY,
        FirstName TEXT NOT NULL,
        LastName  TEXT NOT NULL,
        Age INTEGER NULL,
        CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL
 
);

               ''')
conn.commit()

cursor.execute('''
                INSERT INTO PeopleInfo (PersonId, FirstName, LastName, Age)
                VALUES
                (1,'Bob','Smith', 55),
                (2, 'Jenny','Smith', 66)
                ''')
conn.commit()

cursor.execute('SELECT * FROM PeopleInfo ')
for row in cursor:
    print(row)

conn.close()
```
