
## 1.  The power of data science

<p>I believe a certain uncle once said to his benevolent nephew</p>
<blockquote>
  <p><em>With great power comes great responsibility</em></p>
</blockquote>
<p>This, of course, is an oft-quoted Spider-man line. I don't think any individual need bear the responsibility of a superhero, but it is important to understand the value of technical analysis skills in the context of modern social issues. Within the workplace, data science skills can greatly increase your utility as an employee or prospective applicant. What is not always  mentioned is that these same skills can be applied to positively impact your community. The concept of <strong>open science</strong> has led to new standards in <strong>open data</strong>, and there is an exciting plethora of raw information ready to be probed for insights. Organizations focused on <em>data science for social good</em> are rapidly growing, and the volunteer soup  kitchen seems to have a 21st-century rendition.</p>
<p>Many local and federal governments support access to interesting datasets; as this trend grows, the utility of open information becomes more robust. Data is begging for audacious volunteers to poke and prod it, and make use of the raw input in an impactful way. We can now fight crime as a vigilante - all from behind a computer. </p>
<p>In this notebook, we will explore San Francisco crime data in order to understand the relationship between civilian-reported incidents of crime and police-reported incidents of crime. Along the way we will use table intersection methods to subset our data, aggregation methods to calculate important statistics, and simple visualizations to understand crime trends. </p>


```R
# Load required packages
library(tidyverse)
library(lubridate)

# Read in incidents dataset
incidents <- read_csv("datasets/downsample_police-department-incidents.csv")

# Read in calls dataset
calls <- read_csv("datasets/downsample_police-department-calls-for-service.csv")

print('Done!')
```

## 2. First poke and prod
<p>First things first: we need to wrap our heads around the data in order to understand <em>what</em> we have. Let’s <code>glimpse()</code> the data to see if there are any variables in the two datasets that are the same or similar. Then we can ask an investigative question about these variables, and return a simple statistic such as a frequency count.</p>


```R
# Glimpse the structure of both datasets
glimpse(incidents) 
glimpse(calls)

# Aggregate the number of reported incidents by Date
daily_incidents <- incidents %>%
    count(Date, sort = TRUE) %>%
    rename(n_incidents = n)

# Aggregate the number of calls for police service by Call Date
daily_calls <- calls %>%
    count(`Call Date`, sort = TRUE) %>%
    rename(n_calls = n)

```

    Observations: 84,000
    Variables: 13
    $ IncidntNum <dbl> 176122807, 160569314, 160362475, 160435298, 90543656, 18...
    $ Category   <chr> "LARCENY/THEFT", "ASSAULT", "ROBBERY", "KIDNAPPING", "MI...
    $ Descript   <chr> "GRAND THEFT FROM UNLOCKED AUTO", "BATTERY", "ROBBERY, B...
    $ DayOfWeek  <chr> "Saturday", "Thursday", "Tuesday", "Friday", "Tuesday", ...
    $ Date       <dttm> 2017-05-13, 2016-07-14, 2016-05-03, 2016-05-27, 2009-05...
    $ Time       <time> 10:20:00, 16:00:00, 14:19:00, 23:57:00, 07:40:00, 18:00...
    $ PdDistrict <chr> "SOUTHERN", "MISSION", "NORTHERN", "SOUTHERN", "TARAVAL"...
    $ Resolution <chr> "NONE", "NONE", "ARREST, BOOKED", "ARREST, BOOKED", "LOC...
    $ Address    <chr> "800 Block of BRYANT ST", "MISSION ST / CESAR CHAVEZ ST"...
    $ X          <dbl> -122.4034, -122.4182, -122.4299, -122.4050, -122.4612, -...
    $ Y          <dbl> 37.77542, 37.74817, 37.77744, 37.78512, 37.71912, 37.806...
    $ Location   <chr> "{'latitude': '37.775420706711', 'human_address': '{\"ad...
    $ PdId       <dbl> 1.761228e+13, 1.605693e+13, 1.603625e+13, 1.604353e+13, ...
    Observations: 100,000
    Variables: 14
    $ `Crime Id`                 <dbl> 163003307, 180870423, 173510362, 1632728...
    $ `Original Crime Type Name` <chr> "Bicyclist", "586", "Suspicious Person",...
    $ `Report Date`              <dttm> 2016-10-26, 2018-03-28, 2017-12-17, 201...
    $ `Call Date`                <dttm> 2016-10-26, 2018-03-28, 2017-12-17, 201...
    $ `Offense Date`             <dttm> 2016-10-26, 2018-03-28, 2017-12-17, 201...
    $ `Call Time`                <time> 17:47:00, 05:49:00, 03:00:00, 17:39:00,...
    $ `Call Date Time`           <dttm> 2016-10-26 17:47:00, 2018-03-28 05:49:0...
    $ Disposition                <chr> "GOA", "HAN", "ADV", "NOM", "GOA", "ADV"...
    $ Address                    <chr> "The Embarcadero Nor/kearny St", "Ingall...
    $ City                       <chr> "San Francisco", "San Francisco", "San F...
    $ State                      <chr> "CA", "CA", "CA", "CA", "CA", "CA", "CA"...
    $ `Agency Id`                <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ `Address Type`             <chr> "Intersection", "Intersection", "Interse...
    $ `Common Location`          <chr> NA, NA, NA, NA, NA, NA, "Midori Hotel Sr...


## 3. Mutating join
<p>Now that we have a better understanding of what variables are present in our information set we can see there are shared variables that will allow us to ask a wider variety of questions. We can inquire about the relationship between civilian-reported incidents and police-reported incidents by the date on which the incidents were documented. To combine this information we will perform a type of mutating join between the data frames. The new dataset structure preserves only days on which both civilians reported incidents and police encountered incidents.</p>


```R
# Join data frames to create a new "mutated" set of information
#glimpse(daily_incidents)
#glimpse(daily_calls)
shared_dates <- daily_incidents %>% inner_join(daily_calls, by = c("Date" = "Call Date") )

# Take a glimpse of this new data frame
glimpse(shared_dates)
```

    Observations: 776
    Variables: 3
    $ Date        <dttm> 2017-03-01, 2017-09-01, 2016-04-01, 2017-03-17, 2016-1...
    $ n_incidents <int> 124, 124, 120, 118, 117, 114, 111, 110, 110, 110, 109, ...
    $ n_calls     <int> 133, 138, 124, 129, 115, 120, 127, 106, 124, 108, 111, ...



## 4. Inspect frequency trends
<p>We now have a data frame that contains new information generated by combining datasets. In order to understand this new information we must visualize it. And I don't mean just giving the data a <code>glimpse()</code> - a table of raw information limits our comprehension of crime patterns. A picture is worth a thousand words, right? So let's try to represent the information in a concise way that will lead to other questions. We will look at the frequency of calls and incidents across time to help discern if there is a relationship between these variables.</p>
<p>Often times restructuring of data is required to perform new operations like plotting. <code>ggplot2</code> is amenable to "long format" data rather than "wide format" data. To plot time series data in <code>ggplot2</code> we would like one column to represent the dates, one column to represent the counts, and one column to map each observation to either <code>n_calls</code> or <code>n_incidents</code>. This allows us to pass a single column to each <code>x</code>, <code>y</code>, and <code>color</code> argument in <code>ggplot()</code>. We want the <code>key</code> column in <code>gather()</code> to define the columns <code>n_incidents</code> and <code>n_calls</code>. The <code>value</code> column will define the each of these variable's corresponding counts. By leaving the <code>Date</code> column out of <code>key</code>, the result is a long and narrow data frame with multiple rows for each  date observation.</p>


```R
# Gather into long format using the "Date" column to define observations
plot_shared_dates <- shared_dates %>%
  gather(key = report, value = count, -Date)

# Plot points and regression trend lines
ggplot(plot_shared_dates, aes(x = Date, y = count, color = report)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)
```
![png](output_10_1.png)



## 5. Correlation between trends
<p>A more quantitive way to discern the relationship between 2 variables is to calculate a correlation coefficient between vectors of data. This statistic is represented between a range from -1 to +1; specifically it represents the linear dependence between two sets of data. The correlation coefficient can be interpreted as perfect negative correlation when -1, no correlation whatsoever when 0, and perfect positive correlation when +1. We will look at 2 different but related correlation coefficients in order to understand how our interpretation of statistics can greatly influence the conclusions we come to.</p>
<p>We will first check if there is a correlation between the frequency of incidents and calls on a day-to-day basis. However, this may be too granular of a statistic as daily correlations are probably unlikely except for on big events (New Year's Eve, Halloween, Bay to Breakers). It may be helpful to take a broader view of inherent trends by summarising the data into monthly counts and calculating a correlation coefficient.</p>


```R
# Calculate correlation coefficient between daily frequencies
daily_cor <- cor(shared_dates$n_incidents, shared_dates$n_calls)
daily_cor

# Summarize frequencies by month
correlation_df <- shared_dates %>% 
  mutate(month = month(Date)) %>%
  group_by(month) %>% 
  summarize(n_incidents = sum(n_incidents),
            n_calls = sum(n_calls))

# Calculate correlation coefficient between monthly frequencies
monthly_cor <- cor(correlation_df$n_incidents, correlation_df$n_calls)
monthly_cor
```


0.146968821239074



0.970682977463344


## 6. Filtering joins
<p>When working with relational datasets there are situations in which it is helpful to subset information based on another set of values. Remember mutating joins? Filtering joins are a complementary type of join which allows us to keep all specific cases within a data frame while preserving the structure of the data frame itself. It will be helpful to have all the information from each police reported incident and each civilian call on their shared dates so we can calculate similar statistics from each dataset and compare results. In this case we will use <code>shared_dates</code> to subset down both the full <code>calls</code> and <code>incidents</code> data frames.</p>


```R
# Subset calls to police by shared_dates
calls_shared_dates <- calls  %>% semi_join(shared_dates, by = c("Call Date" = "Date"))

# Perform a sanity check that we are using this filtering join function appropriately
identical(sort(unique(calls_shared_dates$`Call Date`)), sort(unique(shared_dates$Date)))

# Filter recorded incidents by shared_dates
incidents_shared_dates <- incidents  %>% semi_join(shared_dates, by = c("Date" = "Date"))



```


TRUE



## 7. True crime
<p>Back to some data viz! Now we need to see what the data look like after joining the datasets. Previously we made a scatterplot and fit a linear model to the data to see if there was a trend in the frequency of calls and the frequency of reported incidents over time. Scatterplots are a great tool to look at overall trends of continuous data. However, to see trends in categorical data, we need to visualize the ranked order of the variables to wrap our heads around their levels of importance.</p>


```R
# Create a bar chart of the number of calls for each crime
plot_calls_freq <- calls_shared_dates %>% 
  count(`Original Crime Type Name`) %>% 
  top_n(15, n) %>% 
  ggplot(aes(x = reorder(`Original Crime Type Name`, n), y = n)) +
  geom_bar(stat = 'identity') +
  ylab("Count") +
  xlab("Crime Description") +
  ggtitle("Calls Reported Crimes") +
  coord_flip()
  

# Create a bar chart of the number of reported incidents for each crime
plot_incidents_freq <- incidents_shared_dates %>% 
  count(Descript) %>% 
  top_n(15, n)  %>% 
  ggplot(aes(x = reorder(Descript, n), y = n)) +
  geom_bar(stat = 'identity') +
  ylab("Count") +
  xlab("Crime Description") +
  ggtitle("Incidents Reported Crimes") +
  coord_flip()

# Output the plots
plot_calls_freq 
plot_incidents_freq


```






![png](output_19_2.png)



![png](output_19_3.png)

## 8. Grand theft auto
<p>Interesting - far and away the crime of highest incidence is "grand theft from locked auto". This category probably captures many crimes of opportunity where unsupervised vehicles are broken into. However, there <strong>are</strong> vigilantes out there trying to prevent crime! The 12th most civilian reported crime is "Auto Boost / Strip"! Maybe these civilians are truly helping to prevent crime. Yet, this is probably only the case where the location of a called-in-crime is similar to the location of crime incidence. Let's check to see if the locations of the most frequent civilian reported crime and police reported crime are similar.</p>


```R
# Arrange the top 10 locations of called in crimes in a new variable
location_calls <- calls_shared_dates %>%
  filter(`Original Crime Type Name` == "Auto Boost / Strip") %>% 
  count(Address) %>% 
  arrange(desc(n))%>% 
  top_n(10, n)

# Arrange the top 10 locations of reported incidents in a new variable
location_incidents <- incidents_shared_dates %>%
  filter(Descript  == 'GRAND THEFT FROM LOCKED AUTO') %>% 
  count(Address) %>% 
  arrange(desc(n))%>% 
  top_n(10, n)

# Print the top locations of each dataset for comparison
location_calls
location_incidents
```


<table>
<thead><tr><th scope=col>Address</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>1100 Block Of Point Lobos Av        </td><td>21                                  </td></tr>
	<tr><td>3600 Block Of Lyon St               </td><td>20                                  </td></tr>
	<tr><td>100 Block Of Christmas Tree Point Rd</td><td>18                                  </td></tr>
	<tr><td>1300 Block Of Webster St            </td><td>12                                  </td></tr>
	<tr><td>500 Block Of 6th Av                 </td><td>12                                  </td></tr>
	<tr><td>800 Block Of Vallejo St             </td><td>10                                  </td></tr>
	<tr><td>1000 Block Of Great Hy              </td><td> 9                                  </td></tr>
	<tr><td>100 Block Of Hagiwara Tea Garden Dr </td><td> 7                                  </td></tr>
	<tr><td>1100 Block Of Fillmore St           </td><td> 7                                  </td></tr>
	<tr><td>3300 Block Of 20th Av               </td><td> 7                                  </td></tr>
	<tr><td>800 Block Of Mission St             </td><td> 7                                  </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>Address</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>800 Block of BRYANT ST      </td><td>441                         </td></tr>
	<tr><td>500 Block of JOHNFKENNEDY DR</td><td> 89                         </td></tr>
	<tr><td>1000 Block of POINTLOBOS AV </td><td> 84                         </td></tr>
	<tr><td>800 Block of MISSION ST     </td><td> 61                         </td></tr>
	<tr><td>2600 Block of GEARY BL      </td><td> 38                         </td></tr>
	<tr><td>3600 Block of LYON ST       </td><td> 36                         </td></tr>
	<tr><td>1300 Block of WEBSTER ST    </td><td> 35                         </td></tr>
	<tr><td>1100 Block of FILLMORE ST   </td><td> 34                         </td></tr>
	<tr><td>22ND ST / ILLINOIS ST       </td><td> 33                         </td></tr>
	<tr><td>400 Block of 6TH AV         </td><td> 30                         </td></tr>
</tbody>
</table>


## 9. Density map
<p>It appears the datasets share locations where auto crimes occur and are reported most frequently - such as on Point Lobos Avenue, Lyon Street, and Mission Street. It would be great to plot co-occurrence of these locations to visualize overlap, however we only have longitude and latitude data for police reported <code>incidents</code>. No matter, it will still be very valuable to inspect the frequency of auto crime occurrence on a map of San Francisco. This will give us immediate insight as to where auto crimes occur. Most importantly, this visualization will provide a powerful means of communication.</p>
<p>As we ask deeper questions it becomes obvious that many details of each dataset are not standardized (such as the <code>Address</code> variable in each data frame and the lack of exact location data in <code>calls</code>) and thus require more advanced analysis. Now this is the fun part - applying your technical creativity to difficult questions. Go forth from here, check out the <a href="https://www.kaggle.com/san-francisco/sf-police-calls-for-service-and-incidents">original dataset</a>, and ask some new questions!</p>


```R
# Load ggmap
library(ggmap)

# Read in a static map of San Francisco 
sf_map <- readRDS("datasets/sf_map.RDS")

# Filter grand theft auto incidents
auto_incidents <- incidents_shared_dates %>% 
    filter(Descript == "GRAND THEFT FROM LOCKED AUTO")

# Overlay a density plot of auto incidents on the map
ggmap(sf_map) +
  stat_density_2d(
    aes(x = X, y = Y, fill = ..level..), alpha = 0.15,
    size = 0.01, bins = 30, data = auto_incidents,
    geom = "polygon")
```

![png](output_25_1.png)

