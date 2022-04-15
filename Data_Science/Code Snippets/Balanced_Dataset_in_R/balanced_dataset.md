```R
library(caret)

bank$prev_outcome <- as.factor(bank$prev_outcome)
bank$response <- as.factor(bank$response)
summary(bank)

# Create a data partition, stratified on the response variable.
inTrain_b <- createDataPartition(
  y = bank$response, p = .67,
  list = FALSE)

# Assign the records to training and test sets.
bank.train <- bank[ inTrain_b,]
bank.test  <- bank[-inTrain_b,]

#parameters to function
#rare_indices
rare_indices <- which(bank.train$response == "yes")
p <- .30

balancedataset <- function(train.dataset, rare_indices, p) {
  records <- nrow(train.dataset)
  rare_count <- length(rare_indices)
  balance_count = (p * records - rare_count)/( 1-p)
  train.resampled.ind <- sample(x = rare_indices, size = balance_count, replace = TRUE)
  train.resample <- train.dataset[train.resampled.ind,]
  train.balanced <- rbind(train.dataset, train.resample)
  return (train.balanced)
  
}

bank.train.balanced <- balancedataset(bank.train, rare_indices, p)
table(bank.train.balanced$response)

10494/(24488 + 10494)
```

The function is called balancedataset.  You pass it the train data set, the rare indices (this changes per data set so it has to be passed to the function) and the percent for rebalancing.  The function does the rest.  It calculates the formula for you to do the resampling and creates the balanced data set.
