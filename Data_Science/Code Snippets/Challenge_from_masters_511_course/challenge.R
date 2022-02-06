#CHALLENGE INFO
#The challenge is how to automate replacing imputed values in the original dataset.  The process shown in the video is manual.  
#Here is a possible solution.  This solution can be optimized and made into a function.   I just wanted to show a possible way to solve the challenge.  
#Also, I added an imputed column instead of updating the column to be imputed to show the solution.

#The dataset used is the cars_missing dataset shown in the video.  The brand column has a missing value in row 4.  
#The imputed value should be "US" as explained in the video.

#Here is the code to prepare the dataset as shown in the video and the "solution" to the challenge comes after:
# CODE -----------------------------------------------------------------------------------
library(caret)
library(dplyr)
library(stringr)

#DATA PREPARATION STEPS FROM VIDEO
#Note - this step I added
#Need to cleanup the data first.  Having an empty string cause knnImpute not to work
#correctly and assign Europe instead of US to the missing value
cars_missing[cars_missing == "" ] <- NA
head(cars_missing)

#steps from video 10
dummy_mod2 <- dummyVars(" ~ . ", data = cars_missing) 
cars_dm <- data.frame( predict(dummy_mod2, newdata = cars_missing)) 
imputation_mod2 <- preProcess(cars_dm, method = c("knnImpute")) 
cars_missing_imputed2 <- predict(imputation_mod2, cars_dm)
cars_miss_imp <- cars_missing
head(cars_miss_imp) 
 
#START OF SOLUTION
# TO make this solution generic first find all character columns to later check if they have missing values.
# The code below checks for both factor and character columns.  Have not tested the solution with factor columns.
char_col_names = colnames(cars_miss_imp)[grepl('factor|character', sapply(cars_miss_imp,class))]

#After running the above code, char_col_names will have the value "brand" which is the column we want to impute

#remove column
cars_missing_imputed2[, char_col_names] <- NULL
#This step is important for a latter step.  If kept the solution will not work

#This steps check all the dummy columns that have brand in the name and assigns the maxvalue of all those columns to the maxval column.  
#The column with the max value is the column used for the imputation as explained in the video.  
#Here the setdiff is not necessary anymore because the column brand was removed in the previous step.  
#This is why I needed to do that step before.  For the solution I did not remove setdiff.

 cars_missing_imputed2[, "maxval"] <- apply(cars_missing_imputed2[, 
                                     grepl(char_col_names, setdiff(names(cars_missing_imputed2), char_col_names))
                                     ]
                                     ,1
                                     , max)
 


#just to see the imputed value, I created an imputed column.  The process should just update the brand column directly with the imputed value.
cars_missing$imputed <- NA

#Loop through the rows and find where column brand is NA to impute it.
for (row in 1:nrow(cars_missing_imputed2)) {
  #if brand is na then get the maxval to then determine the column name
  if (is.na(cars_missing[row, char_col_names])) {
           maxval <- cars_missing_imputed2[row, "maxval"]
           #loop through the columns to get the name of the column with the maxval
           for (col in 1:ncol(cars_missing_imputed2)){
                  if (cars_missing_imputed2[row, col] == maxval &
                     !(names(cars_missing_imputed2)[col] %in% c(char_col_names, "maxval")) ) {
                          #remove "brand" from the column name and the result will be the imputation value.  In our case is US
                          cars_missing[row, "imputed"] <- str_replace(names(cars_missing_imputed2)[col],char_col_names, "") 
                     
                  }

          }
  }
}

#head(cars_missing_imputed2)
head(cars_missing)
# END OF CODE ----------------------------------------------------

CONSOLE OUTPUT

> #need to cleanup the data first.  Having an empty string cause knnImpute not to work
> #correctly and assign Europe instead of US to the missing value
> cars_missing[cars_missing == "" ] <- NA
> head(cars_missing)
  mpg cubicinches  hp  brand
1  14         350 165     US
2  31          NA  71 Europe
3  17         302 140     US
4  15         400 150   <NA>
5  30          98  63     US
6  23         350 125     US
> 
> 
> dummy_mod2 <- dummyVars(" ~ . ", data = cars_missing) 
> cars_dm <- data.frame( predict(dummy_mod2, newdata = cars_missing)) 
> imputation_mod2 <- preProcess(cars_dm, method = c("knnImpute")) 
> cars_missing_imputed2 <- predict(imputation_mod2, cars_dm)
> cars_miss_imp <- cars_missing
> head(cars_miss_imp) 
  mpg cubicinches  hp  brand
1  14         350 165     US
2  31          NA  71 Europe
3  17         302 140     US
4  15         400 150   <NA>
5  30          98  63     US
6  23         350 125     US
> char_col_names = colnames(cars_miss_imp)[grepl('factor|character', sapply(cars_miss_imp,class))]
> 
> #remove column
> cars_missing_imputed2[, char_col_names] <- NULL
>   cars_missing_imputed2[, "maxval"] <- apply(cars_missing_imputed2[, 
+                                      grepl(char_col_names, setdiff(names(cars_missing_imputed2), char_col_names))
+                                      ]
+                                      ,1
+                                      , max)
> cars_missing$imputed <- NA
> for (row in 1:nrow(cars_missing_imputed2)) {
+   if (is.na(cars_missing[row, char_col_names])) {
+            maxval <- cars_missing_imputed2[row, "maxval"]
+            for (col in 1:ncol(cars_missing_imputed2)){
+                   if (cars_missing_imputed2[row, col] == maxval &
+                      !(names(cars_missing_imputed2)[col] %in% c(char_col_names, "maxval")) ) {
+                           cars_missing[row, "imputed"] <- str_replace(names(cars_missing_imputed2)[col],char_col_names, "") 
+                      
+                   }
+ 
+           }
+   }
+ }
> head(cars_missing)
  mpg cubicinches  hp  brand imputed
1  14         350 165     US    <NA>
2  31          NA  71 Europe    <NA>
3  17         302 140     US    <NA>
4  15         400 150   <NA>      US
5  30          98  63     US    <NA>
6  23         350 125     US    <NA>

Please note that I added a lot of comments after running the code so you have a better understanding of the solution.  
As you can see at the end the imputed value for row 4 is US.
