Here is a short example of using databases (SQLite) and the leaflet package.

In the first part I create a dataframe from scratch with some of the countries mentioned in the intro.  

The goal is to get the data into a SQLite database, retrieve it and display a map using leaflet.  
In real life you will be given access to a database and then you do your magic.

#------------- CODE --------------------------------------

library(DBI)
library(leaflet)
library(magrittr)
library(htmltools)

#create new dataframe of some locations mentioned in the intros
location <- c("US", "Puerto Rico", "Egypt", "Mozambique", "Barbados", "Mexico")
longitude <- c(-98.35,-66.105,30.80,35.52, -59.54, -99.13)
latitude <- c(39.50,18.46,26.82,-25.95, 13.19, 19.43)

#create a dataframe from the data

data511_loc <-data.frame(location, longitude, latitude)

#Create an in-memory database.  SQLite allows you to do that so there are no files created.  This works for small databases

con <- dbConnect(RSQLite::SQLite(), ":memory:")

#Create the table from the dataframe.  In real life you do not need to do this.  You just need to find the table or tables of interests

dbWriteTable(con, "data511_loc", data511_loc)

#Find the tables in the db
dbListTables(con)

#Run SQL to get all data
loc_result <- dbGetQuery(con, "SELECT * FROM data511_loc")

#Create leaflet map.  The htmlEscape function allows you to display the name by hovering the mouse over the circles.  In the image you will not see this

loc_result %>% 
  leaflet() %>% 
  addTiles() %>% 
  # Sanitize any html in our labels
  addCircleMarkers(radius = 2, label = ~htmlEscape(location))

#disconnect from db.  This really should be done after you create your loc_result dataframe unless you are running more queries.

dbDisconnect(con)

#------------------------------------------------------------
