```R
#=======================================================================

# Rattle is Copyright (c) 2006-2020 Togaware Pty Ltd.
# It is free (as in libre) open source software.
# It is licensed under the GNU General Public License,
# Version 2. Rattle comes with ABSOLUTELY NO WARRANTY.
# Rattle was written by Graham Williams with contributions
# from others as acknowledged in 'library(help=rattle)'.
# Visit https://rattle.togaware.com/ for details.

#=======================================================================
# Rattle timestamp: 2022-02-22 10:05:13 x86_64-redhat-linux-gnu 

# Rattle version 5.4.0 user 'franciscoporrata'

# This log captures interactions with Rattle as an R script. 

# For repeatability, export this activity log to a 
# file, like 'model.R' using the Export button or 
# through the Tools menu. Th script can then serve as a 
# starting point for developing your own scripts. 
# After xporting to a file called 'model.R', for exmample, 
# you can type into a new R Console the command 
# "source('model.R')" and so repeat all actions. Generally, 
# you will want to edit the file to suit your own needs. 
# You can also edit this log in place to record additional 
# information before exporting the script. 
 
# Note that saving/loading projects retains this log.

# We begin most scripts by loading the required packages.
# Here are some initial packages to load and others will be
# identified as we proceed through the script. When writing
# our own scripts we often collect together the library
# commands at the beginning of the script here.

library(rattle)   # Access the weather dataset and utilities.
library(magrittr) # Utilise %>% and %<>% pipeline operators.

# This log generally records the process of building a model. 
# However, with very little effort the log can also be used 
# to score a new dataset. The logical variable 'building' 
# is used to toggle between generating transformations, 
# when building a model and using the transformations, 
# when scoring a dataset.

building <- TRUE
scoring  <- ! building

# A pre-defined value is used to reset the random seed 
# so that results are repeatable.

crv$seed <- 42 

#=======================================================================
# Rattle timestamp: 2022-02-22 10:05:45 x86_64-redhat-linux-gnu 

# Load a dataset from file.

fname         <- "file:///home/franciscoporrata/R/511/week 3/db.txt" 
crs$dataset <- read.csv(fname,
			sep="\t",
			na.strings=c(".", "NA", "", "?"),
			strip.white=TRUE, encoding="UTF-8")

#=======================================================================
# Rattle timestamp: 2022-02-22 10:05:46 x86_64-redhat-linux-gnu 

# Action the user selections from the Data tab. 

# Build the train/validate/test datasets.

# nobs=101763 train=71234 validate=15264 test=15265

set.seed(crv$seed)

crs$nobs <- nrow(crs$dataset)

crs$train <- sample(crs$nobs, 0.7*crs$nobs)

crs$nobs %>%
  seq_len() %>%
  setdiff(crs$train) %>%
  sample(0.15*crs$nobs) ->
crs$validate

crs$nobs %>%
  seq_len() %>%
  setdiff(crs$train) %>%
  setdiff(crs$validate) ->
crs$test

# The following variable selections have been noted.

crs$input     <- c("gender", "time_in_hospital",
                   "num_lab_procedures", "num_procedures",
                   "num_medications", "number_outpatient",
                   "number_emergency", "number_inpatient",
                   "number_diagnoses")

crs$numeric   <- c("time_in_hospital", "num_lab_procedures",
                   "num_procedures", "num_medications",
                   "number_outpatient", "number_emergency",
                   "number_inpatient", "number_diagnoses")

crs$categoric <- "gender"

crs$target    <- "Readmission"
crs$risk      <- NULL
crs$ident     <- NULL
crs$ignore    <- NULL
crs$weights   <- NULL

#=======================================================================
# Rattle timestamp: 2022-02-22 10:07:09 x86_64-redhat-linux-gnu 

# Action the user selections from the Data tab. 

# Build the train/validate/test datasets.

# nobs=101763 train=71234 validate=15264 test=15265

set.seed(crv$seed)

crs$nobs <- nrow(crs$dataset)

crs$train <- sample(crs$nobs, 0.7*crs$nobs)

crs$nobs %>%
  seq_len() %>%
  setdiff(crs$train) %>%
  sample(0.15*crs$nobs) ->
crs$validate

crs$nobs %>%
  seq_len() %>%
  setdiff(crs$train) %>%
  setdiff(crs$validate) ->
crs$test

# The following variable selections have been noted.

crs$input     <- "num_lab_procedures"

crs$numeric   <- "num_lab_procedures"

crs$categoric <- NULL

crs$target    <- "time_in_hospital"
crs$risk      <- NULL
crs$ident     <- NULL
crs$ignore    <- c("gender", "num_procedures", "num_medications", "number_outpatient", "number_emergency", "number_inpatient", "number_diagnoses", "Readmission")
crs$weights   <- NULL

#=======================================================================
# Rattle timestamp: 2022-02-22 10:07:18 x86_64-redhat-linux-gnu 

# Regression model 

# Build a Regression model.

crs$glm <- lm(time_in_hospital ~ ., data=crs$dataset[crs$train,c(crs$input, crs$target)])

# Generate a textual view of the Linear model.

print(summary(crs$glm))
cat('==== ANOVA ====

')
print(anova(crs$glm))
print("
")

# Time taken: 0.12 secs

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])

#=======================================================================
# Rattle timestamp: 2022-02-22 10:12:30 x86_64-redhat-linux-gnu 

# Regression model 

# Build a Regression model.

crs$glm <- lm(time_in_hospital ~ ., data=crs$dataset[crs$train,c(crs$input, crs$target)])

# Generate a textual view of the Linear model.

print(summary(crs$glm))
cat('==== ANOVA ====

')
print(anova(crs$glm))
print("
")

# Time taken: 0.07 secs

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])

# Plot the model evaluation.

ttl <- genPlotTitleCmd("Linear Model",crs$dataname,vector=TRUE)
plot(crs$glm, main=ttl[1])
```
OUTPUT
```R
Summary of the Linear Regression model (built using lm):

Call:
lm(formula = time_in_hospital ~ ., data = crs$dataset[crs$train, 
    c(crs$input, crs$target)])

Residuals:
    Min      1Q  Median      3Q     Max 
-6.6779 -2.0652 -0.6066  1.4280 11.6207 

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)        2.3311634  0.0256252   90.97   <2e-16 ***
num_lab_procedures 0.0481686  0.0005405   89.12   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 2.834 on 71232 degrees of freedom
Multiple R-squared:  0.1003,    Adjusted R-squared:  0.1003 
F-statistic:  7942 on 1 and 71232 DF,  p-value: < 2.2e-16

==== ANOVA ====

Analysis of Variance Table

Response: time_in_hospital
                      Df Sum Sq Mean Sq F value    Pr(>F)    
num_lab_procedures     1  63785   63785  7941.8 < 2.2e-16 ***
Residuals          71232 572110       8                      
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
[1] "\n"
Time taken: 0.07 secs

Rattle timestamp: 2022-02-22 10:12:30 franciscoporrata
======================================================================
```
GRAPHS


