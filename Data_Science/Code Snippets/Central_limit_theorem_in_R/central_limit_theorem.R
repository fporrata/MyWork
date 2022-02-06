Here is proof of the Central Limit Theorem using R.  

#CODE ----------------------------------------

#The central limit theorem states that if you have a population with mean μ and standard deviation σ 
#and take sufficiently large random samples from the population with replacement , 
#then the distribution of the sample means will be approximately normally distributed

# Population of 100 with mean = 5 and sd = 10
population <- rnorm(n=100, mean=5, sd=10)

#Create empty vector
central_limit <- c()

# Loop 1000 times and add the mean of a sample of 30 with replacement to the central_limit vector
n <- 1000
for(i in 1:n) {
     central_limit <- append(central_limit, mean(sample(population, 30, replace = TRUE)))
}

# Plot the histogram to see if it looks approx. normal
hist(central_limit)

#-----------------------------------------------------------------------------

Ran the loop 100, 200, 300 and 1000 times.  Attached is a Word document with the histograms.  They look approximately normally distributed.  
Maybe selecting a sample size > 30 will be better. 
