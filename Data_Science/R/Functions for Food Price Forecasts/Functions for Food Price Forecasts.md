
## 1. Importing important price data
<p>Every time I go to the supermarket, my wallet weeps a little. But how expensive is food around the world? In this notebook, we'll explore time series of food prices in Rwanda from the <a href="https://data.humdata.org/dataset/wfp-food-prices">United Nations Humanitarian Data Exchange Global Food Price Database</a>. Agriculture makes up over 30% of Rwanda's economy, and over 60% of its export earnings (<a href="https://www.cia.gov/library/publications/the-world-factbook/geos/rw.html">CIA World Factbook</a>), so the price of food is very important to the livelihood of many Rwandans.</p>
<p>The map below shows the layout of Rwanda; it is split into five administrative regions. The central area around the Captial city, Kigali, is one region, and the others are North, East, South, and West.</p>

![png](0.PNG)

<p>In this notebook, we're going to import, manipulate, visualize and forecast Rwandan potato price data. We'll also wrap our analysis into functions to make it easy to analyze prices of other foods.</p>


```R
# Load the readr and dplyr packages
library(readr)
library(dplyr)

# Import the potatoes dataset
potato_prices <- read_csv("datasets/Potatoes (Irish).csv")

# Take a glimpse at the contents
glimpse(potato_prices)
```

    Parsed with column specification:
    cols(
      adm0_id = col_integer(),
      adm0_name = col_character(),
      adm1_id = col_integer(),
      adm1_name = col_character(),
      mkt_id = col_integer(),
      mkt_name = col_character(),
      cm_id = col_integer(),
      cm_name = col_character(),
      cur_id = col_integer(),
      cur_name = col_character(),
      pt_id = col_integer(),
      pt_name = col_character(),
      um_id = col_integer(),
      um_name = col_character(),
      mp_month = col_integer(),
      mp_year = col_integer(),
      mp_price = col_double(),
      mp_commoditysource = col_character()
    )


    Observations: 4,320
    Variables: 18
    $ adm0_id            <int> 205, 205, 205, 205, 205, 205, 205, 205, 205, 205...
    $ adm0_name          <chr> "Rwanda", "Rwanda", "Rwanda", "Rwanda", "Rwanda"...
    $ adm1_id            <int> 21973, 21973, 21973, 21973, 21973, 21973, 21973,...
    $ adm1_name          <chr> "$West/Iburengerazuba", "$West/Iburengerazuba", ...
    $ mkt_id             <int> 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, ...
    $ mkt_name           <chr> "Birambo", "Birambo", "Birambo", "Birambo", "Bir...
    $ cm_id              <int> 148, 148, 148, 148, 148, 148, 148, 148, 148, 148...
    $ cm_name            <chr> "Potatoes (Irish)", "Potatoes (Irish)", "Potatoe...
    $ cur_id             <int> 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, 77, ...
    $ cur_name           <chr> "RWF", "RWF", "RWF", "RWF", "RWF", "RWF", "RWF",...
    $ pt_id              <int> 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, ...
    $ pt_name            <chr> "Retail", "Retail", "Retail", "Retail", "Retail"...
    $ um_id              <int> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, ...
    $ um_name            <chr> "KG", "KG", "KG", "KG", "KG", "KG", "KG", "KG", ...
    $ mp_month           <int> 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1...
    $ mp_year            <int> 2010, 2010, 2011, 2011, 2011, 2011, 2011, 2011, ...
    $ mp_price           <dbl> 157.0000, 133.3333, 96.5000, 97.0000, 107.8000, ...
    $ mp_commoditysource <chr> "MINAGRI", "MINAGRI", "MINAGRI", "MINAGRI", "MIN...

## 2. Once more, with feeling
<p>Many of the columns in the potato data aren't very useful for our analysis. For example, the <code>adm1_name</code> column is always <code>"Rwanda"</code>, and <code>cur_name</code> is always <code>"RWF"</code>. (This is short for Rwandan Franc; for context, 1000 RWF is a little over 1 USD.) Similarly, we don't really need any of the ID columns or the data source.</p>
<p>Even the columns we do need have slightly obscure names. For example, <code>adm1_id</code> isn't as clear as <code>region</code>, and <code>mkt_name</code> isn't as clear as <code>market</code>. One of the most types of data analysis disaster is to misunderstand what a variable means, so naming variable clearly is a useful way to avoid this. One trick is that any variable that includes a unit should include that unit in the variable name. Here, the prices are given in Rwandan Francs, so <code>price_rwf</code> is a good name.</p>


```R
# Import again, only reading specific columns
potato_prices <- read_csv("datasets/Potatoes (Irish).csv", col_types = cols_only(
  adm1_name = col_character(),
  mkt_name = col_character(),
  cm_name = col_character(),
  mp_month = col_integer(),
  mp_year =  col_integer(),
  mp_price =  col_double() ))
    

# Rename the columns to be more informative
potato_prices_renamed <- rename(potato_prices, region = adm1_name,
                               market = mkt_name, 
                               commodity_kg =  cm_name, 
                               month = mp_month, 
                               year = mp_year,  
                               price_rwf = mp_price)


# Check the result
glimpse(potato_prices_renamed)
```

    Observations: 4,320
    Variables: 6
    $ region       <chr> "$West/Iburengerazuba", "$West/Iburengerazuba", "$West...
    $ market       <chr> "Birambo", "Birambo", "Birambo", "Birambo", "Birambo",...
    $ commodity_kg <chr> "Potatoes (Irish)", "Potatoes (Irish)", "Potatoes (Iri...
    $ month        <int> 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3...
    $ year         <int> 2010, 2010, 2011, 2011, 2011, 2011, 2011, 2011, 2011, ...
    $ price_rwf    <dbl> 157.0000, 133.3333, 96.5000, 97.0000, 107.8000, 125.50...


## 3. Spring cleaning
<p>As is often the case in a data analysis, the data we are given isn't in quite the form we'd like it to be. For example, we may have noticed in the last task that the month and year given as integers. Since we'll be performing some time series analysis, it would be helpful if they were provided as dates. Before we can analyze the data, we need to spring clean it.</p>


```R
# Load lubridate
library(lubridate)

# Convert year and month to Date
potato_prices_cleaned <- potato_prices_renamed %>% mutate(date = ymd(paste(year,month, '01') ))
potato_prices_cleaned <- potato_prices_cleaned %>% select (-c(year, month))
# See the result
glimpse(potato_prices_cleaned)
```

    Observations: 4,320
    Variables: 5
    $ region       <chr> "$West/Iburengerazuba", "$West/Iburengerazuba", "$West...
    $ market       <chr> "Birambo", "Birambo", "Birambo", "Birambo", "Birambo",...
    $ commodity_kg <chr> "Potatoes (Irish)", "Potatoes (Irish)", "Potatoes (Iri...
    $ price_rwf    <dbl> 157.0000, 133.3333, 96.5000, 97.0000, 107.8000, 125.50...
    $ date         <date> 2010-11-01, 2010-12-01, 2011-01-01, 2011-02-01, 2011-...


## 4. Potatoes are not a balanced diet
<p>As versatile as potatoes are, with their ability to be boiled, roasted, mashed, fried, or chipped, the people of Rwanda have more varied culinary tastes. That means you are going to have to look at some other food types!</p>
<p>If we want to do a similar task many times, we could just cut and paste our code and change bits here and there. This is a terrible idea, since changing code in one place doesn't keep it up to date in the other places, and we quickly end up with lots of bugs.</p>
<p>A better idea is to write a function. That way we avoid cut and paste errors and can have more readable code.</p>


```R
# Wrap this code into a function
read_price_data <- function(commodity) {


potato_prices <- read_csv(
  paste("datasets/", commodity,".csv", sep = ""),
  col_types = cols_only(
    adm1_name = col_character(),
    mkt_name = col_character(),
    cm_name = col_character(),
    mp_month = col_integer(),
    mp_year = col_integer(),
    mp_price = col_double()
  )
)

potato_prices_renamed <- potato_prices %>% 
  rename(
    region = adm1_name, 
    market = mkt_name,
    commodity_kg = cm_name,
    month = mp_month,
    year = mp_year,
    price_rwf = mp_price
  )

potato_prices_cleaned <- potato_prices_renamed %>% 
  mutate(
    date = ymd(paste(year, month, "01"))
  ) %>% 
  select(-month, -year)
}
# Test it
pea_prices <- read_price_data("Peas (fresh)")
glimpse(pea_prices)
```

    Observations: 1,893
    Variables: 5
    $ region       <chr> "$West/Iburengerazuba", "$West/Iburengerazuba", "$West...
    $ market       <chr> "Birambo", "Birambo", "Birambo", "Birambo", "Birambo",...
    $ commodity_kg <chr> "Peas (fresh)", "Peas (fresh)", "Peas (fresh)", "Peas ...
    $ price_rwf    <dbl> 403.5000, 380.0000, 277.5000, 450.0000, 450.0000, 375....
    $ date         <date> 2011-01-01, 2011-02-01, 2011-04-01, 2011-05-01, 2011-...


## 5. Plotting the price of potatoes
<p>A great first step in any data analysis is to look at the data. In this case, we have some prices, and we have some dates, so the obvious thing to do is to see how those prices change over time.</p>


```R
# Load ggplot2
library(ggplot2)

# Draw a line plot of price vs. date grouped by market 
ggplot(potato_prices_cleaned, aes(x = date, y= price_rwf, group = market )) + geom_line(alpha = 0.2) + ggtitle("Potato price over time")
```

![png](output_13_1.png)


## 6. What a lotta plots
<p>There is a bit of a trend in the potato prices, with them increasing until 2013, after which they level off. More striking though is the seasonality: the prices are lowest around December and January, and have a peak around August. Some years also show a second peak around April or May.</p>
<p>Just as with the importing and cleaning code, if we want to make lots of similar plots, we need to wrap the plotting code into a function.</p>


```R
# Wrap this code into a function
plot_price_vs_time <- function(prices, commodity) {
    prices %>% 
  ggplot(aes(date, price_rwf, group = market)) +
  geom_line(alpha = 0.2) +
  ggtitle(paste(commodity,  "price over time"))
    
}

# Try the function on the pea data
plot_price_vs_time(pea_prices, "Pea")


```

![png](output_16_1.png)


## 7. Preparing to predict the future (part 1)
<p>While it's useful to see how the prices have changed in the past, what's more exciting is to forecast how they will change in the future. Before we get to that, there are some data preparation steps that need to be performed.</p>
<p>The datasets for each commodity are very rich: rather than being a single time series, they consist of a time series for each market. The fancy way of analyzing this is to treat it as a single hierarchical time series. The easier way that we'll try here, is to take the average price across markets at each time and analyze the resulting single time series.</p>
<p>Looking at the plots from the potato and pea datasets, we can see that occasionally there is a big spike in the price. That probably indicates a logistic problem where that food wasn't easily available at a particular market, or the buyer looked like a tourist and got ripped off. The consequence of these outliers is that it is a bad idea to use the <em>mean</em> price of each time point: instead, the <em>median</em> makes more sense since it is robust against outliers.</p>


```R
# Group by date, and calculate the median price
potato_prices_summarized <- potato_prices_cleaned %>% group_by(date) %>% summarize(median_price_rwf = median(price_rwf))

# See the result
glimpse(potato_prices_summarized)
```

    Observations: 96
    Variables: 2
    $ date             <date> 2008-01-01, 2008-02-01, 2008-03-01, 2008-04-01, 2...
    $ median_price_rwf <dbl> 97.5000, 100.0000, 95.0000, 96.2500, 95.0000, 110....

## 8. Preparing to predict the future (part 2)
<p>Time series analysis in R is at a crossroads. The best and most mature tools for analysis are based around a time series data type called <code>ts</code>, which predates the tidyverse by several decades. That means that we have to do one more data preparation step before we can start forecasting: we need to convert our summarized dataset into a <code>ts</code> object.</p>


```R
# Load magrittr
library(magrittr)

# Extract a time series
potato_time_series <- potato_prices_summarized %$% ts(data = median_price_rwf,  
                                                      start = c(year(min(date)),month(min(date))) , 
                                                      end =  c(year(max(date)), month(max(date))), 
                                                      frequency = 12)


# See the result
glimpse(potato_time_series)
```

     Time-Series [1:96] from 2008 to 2016: 97.5 100 95 96.2 95 ...


## 9. Another day, another function to write
<p>Those data preparation steps were tricky! Wouldn't it be really nice if we never had to write them again? Well, if we wrap that code into a function, then we won't have to.</p>


```R
# Wrap this code into a function
create_price_time_series <- function(prices) {
prices_summarized <- prices %>%
  group_by(date) %>% 
  summarize(median_price_rwf = median(price_rwf))

time_series <- prices_summarized %$% 
  ts(
    median_price_rwf, 
    start = c(year(min(date)), month(min(date))), 
    end   = c(year(max(date)), month(max(date))), 
    frequency = 12
  )
}
# Try the function on the pea data
pea_time_series <- create_price_time_series(pea_prices)
pea_time_series
```


               Jan       Feb       Mar       Apr       May       Jun       Jul
    2011  561.6667  700.0000  958.0000  710.0000  591.5000  597.8572  666.3572
    2012  655.0000  950.0000 1272.1667 1166.0000  945.8750  822.3333  714.2857
    2013  668.7500  781.6334  829.9875  975.0000  908.2500  789.9444  806.8000
    2014  695.5000 1025.0000 1166.6250 1083.2500  825.0000  816.6667  809.5714
    2015  800.0000 1066.6667 1100.0000 1051.8889  950.0000  873.6667  804.1250
               Aug       Sep       Oct       Nov       Dec
    2011  758.5000  938.8333 1506.2500  787.5000  548.9375
    2012  788.1250  990.7222 1413.7500  964.2619  661.8571
    2013 1000.0000 1162.4583 1316.7500  916.6667  623.8571
    2014 1000.0000 1000.0000 1666.6667  700.0000  633.3333
    2015  900.0000 1166.6667 1550.0000 1066.6667  802.1250


## 10. The future of potato prices
<p>All the preparation is done and we are ready to start forecasting. One question we might ask is "how do I know if I can trust our forecast?". Recall that both the potato and the pea data had strong seasonality (for example, potatoes were most expensive around August and cheapest around December). For agricultural data, a good forecast should show a similar shape throughout the seasons.</p>
<p>Now then, are we ready to see the future?</p>


```R
# Load forecast
library(forecast)

# Forecast the potato time series
potato_price_forecast <- forecast(potato_time_series)

# View it
potato_price_forecast

# Plot the forecast
autoplot(potato_price_forecast, main = "Potato price forecast")
```


             Point Forecast     Lo 80    Hi 80     Lo 95    Hi 95
    Jan 2016       190.0093 171.35706 208.6615 161.48317 218.5354
    Feb 2016       202.6099 174.14582 231.0740 159.07783 246.1420
    Mar 2016       220.0317 181.72222 258.3413 161.44238 278.6211
    Apr 2016       231.5932 184.48380 278.7026 159.54559 303.6408
    May 2016       226.2626 174.20438 278.3209 146.64641 305.8789
    Jun 2016       229.1587 170.73454 287.5829 139.80665 318.5108
    Jul 2016       230.8787 166.57270 295.1848 132.53113 329.2263
    Aug 2016       251.1739 175.53815 326.8096 135.49902 366.8487
    Sep 2016       279.3573 189.13187 369.5827 141.36943 417.3451
    Oct 2016       262.7887 172.33073 353.2467 124.44516 401.1323
    Nov 2016       236.0485 149.89274 322.2042 104.28465 367.8123
    Dec 2016       205.0924 126.05584 284.1290  84.21640 325.9684
    Jan 2017       205.0036 121.88813 288.1190  77.88948 332.1177
    Feb 2017       218.4941 125.58323 311.4050  76.39917 360.5891
    Mar 2017       237.1698 131.67270 342.6669  75.82591 398.5137
    Apr 2017       249.5154 133.68437 365.3465  72.36711 426.6638
    May 2017       243.6602 125.85363 361.4667  63.49061 423.8297
    Jun 2017       246.6667 122.68387 370.6496  57.05130 436.2822
    Jul 2017       248.4066 118.81644 377.9967  50.21556 446.5976
    Aug 2017       270.1226 124.07681 416.1684  46.76484 493.4804
    Sep 2017       300.3005 132.25584 468.3452  43.29837 557.3027
    Oct 2017       282.3675 119.02591 445.7092  32.55807 532.1770
    Nov 2017       253.5265 102.08787 404.9651  21.92111 485.1319
    Dec 2017       220.1852  84.51341 355.8570  12.69310 427.6773


![png](output_28_2.png)

## 11. The final function
<p>Nice! The forecast shows the spike in potato prices in late summer and the dip toward the end of the year.</p>
<p>With this analysis step, just as the previous steps, to make things repeatable, we need to wrap the code into a function.</p>


```R
# Wrap the code into a function
plot_price_forecast <- function(time_series, commodity){
     price_forecast <- forecast(time_series)
     autoplot(price_forecast, main = paste(commodity, "price forecast"))
}
# Try the function on the pea data
plot_price_forecast( pea_time_series, "Pea")
    
    
    

```

![png](output_31_1.png)


## 12. Do it all over again
<p>That was a lot of effort writing all that code to analyze the potato data. Fortunately, since we wrapped all the code into functions, we can easily take a look at any other food type.</p>


```R
# Choose dry beans as the commodity
commodity <- "Beans (dry)"

# Read the price data
bean_prices <- read_price_data("Beans (dry)")

# Plot price vs. time
plot_price_vs_time(bean_prices, "Beans")

# Create a price time series
bean_time_series <- create_price_time_series(bean_prices)

# Plot the price forecast
plot_price_forecast(bean_time_series, "Beans")
```


![png](output_34_2.png)



![png](output_34_3.png)

