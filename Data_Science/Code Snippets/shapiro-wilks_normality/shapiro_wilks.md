A useful function to run simulations is the replicate function.  It allows you to run different function(s) any number of times.  Here are some examples to give you an idea:

#Example 1

#Select 10 samples of two location names each

location <- c("US", "Puerto Rico", "Egypt", "Mozambique", "Barbados", "Mexico")
samples_10 <- replicate(10,{
  locs = sample(location,2)
})
samples_10

#\RESULT

    [,1]          [,2]          [,3]         [,4]     [,5]       [,6]      
[1,] "Barbados"    "Puerto Rico" "Mozambique" "Egypt"  "Barbados" "US"      
[2,] "Puerto Rico" "Mozambique"  "US"         "Mexico" "Egypt"    "Barbados"
     [,7]    [,8]         [,9]     [,10]       
[1,] "Egypt" "Barbados"   "US"     "Mozambique"
[2,] "US"    "Mozambique" "Mexico" "Egypt"    


#Example 2 - sample 2 numbers from a vector and add them up.  Run the simulation 10 times

numbers <- c(1,2,3,4,5,6,7,8,9)
samples_10 <- replicate(10,{
  num1 = sample(numbers,1)
  num2 = sample(numbers,1)
  num1 + num2
})
samples_10

RESULT

[1] 14  6  4 17  8  8 10  3  7 12

#Example 3 - same as Example 2 but running it 1000 times to get a distribution of the sums

numbers <- c(1,2,3,4,5,6,7,8,9)
samples_1000 <- replicate(1000,{
  num1 = sample(numbers,1)
  num2 = sample(numbers,1)
  num1 + num2
})
hist(samples_1000)



 

#Example 4 is to test if the distribution of sums is normal.  Here it gets ify for me and Prof. Larose will probably laugh at this.  There is a normality test called shapiro.test.  I Googled it 😀.  It is part of base R and it is usually loaded by default.  The package name is "stats"

numbers <- c(1,2,3,4,5,6,7,8,9)
samples_1000 <- replicate(1000,{
  num1 = sample(numbers,1)
  num2 = sample(numbers,1)
  num1 + num2
})
hist(samples_1000)

plot(density(samples_1000))

## Perform the test
shapiro.test(samples_1000)

## Plot using a qqplot
qqnorm(samples_1000)
qqline(samples_1000, col = 2)



 



 


Here is the definition of the Shapiro-Wilk test: 

Shapiro-Wilks Normality Test. The Shapiro-Wilks test for normality is one of three general normality tests designed to detect all departures from normality. It is comparable in power to the other two tests. The test rejects the hypothesis of normality when the p-value is less than or equal to 0.05.

Here is the definition of the qqline:

qqline adds a line to a “theoretical”, by default normal, quantile-quantile plot which passes through the probs quantiles, by default the first and third quartiles.

RESULT

The p value is less than 0.05 so the distribution is not normal.  The qqline does not follow the plotted values.
