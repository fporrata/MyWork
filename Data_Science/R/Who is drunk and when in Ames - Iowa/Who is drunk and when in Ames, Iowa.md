
## 1. Breath alcohol tests in Ames, Iowa, USA
<p>Ames, Iowa, USA is the home of Iowa State University, a land grant university with over 36,000 students. By comparison, the city of Ames, Iowa, itself only has about 65,000 residents. As with any other college town, Ames has had its fair share of alcohol-related incidents. (For example, Google 'VEISHEA riots 2014'.) We will take a look at some breath alcohol test data from Ames that is published by the State of Iowa.</p>
<p><img style="width:500px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_208/img/usa.jpg"> </p>
<p>The data file 'breath_alcohol_ames.csv' contains 1,556 readings from breath alcohol tests administered by the Ames and Iowa State University Police Departments from January 2013 to December 2017. The columns in this data set are year, month, day, hour, location, gender, Res1, Res2.</p>


```R
# load the tidyverse suite of packages 
library(tidyverse)

# read the data into your workspace
ba_data <- read_csv("datasets/breath_alcohol_ames.csv")

# quickly inspect the data
head(ba_data)

# obtain counts for each year 
ba_year <- ba_data %>% group_by(year) %>% count()
ba_year
```

    Parsed with column specification:
    cols(
      year = col_integer(),
      month = col_integer(),
      day = col_integer(),
      hour = col_integer(),
      location = col_character(),
      gender = col_character(),
      Res1 = col_double(),
      Res2 = col_double()
    )



<table>
<thead><tr><th scope=col>year</th><th scope=col>month</th><th scope=col>day</th><th scope=col>hour</th><th scope=col>location</th><th scope=col>gender</th><th scope=col>Res1</th><th scope=col>Res2</th></tr></thead>
<tbody>
	<tr><td>2017   </td><td>12     </td><td>17     </td><td>1      </td><td>Ames PD</td><td>M      </td><td>0.046  </td><td>0.046  </td></tr>
	<tr><td>2017   </td><td>12     </td><td>14     </td><td>3      </td><td>ISU PD </td><td>F      </td><td>0.121  </td><td>0.120  </td></tr>
	<tr><td>2017   </td><td>12     </td><td>10     </td><td>5      </td><td>ISU PD </td><td>F      </td><td>0.068  </td><td>0.067  </td></tr>
	<tr><td>2017   </td><td>12     </td><td>10     </td><td>3      </td><td>ISU PD </td><td>F      </td><td>0.077  </td><td>0.077  </td></tr>
	<tr><td>2017   </td><td>12     </td><td> 9     </td><td>2      </td><td>ISU PD </td><td>M      </td><td>0.085  </td><td>0.084  </td></tr>
	<tr><td>2017   </td><td>12     </td><td> 9     </td><td>1      </td><td>Ames PD</td><td>M      </td><td>0.160  </td><td>0.161  </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>year</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>2013</td><td>397 </td></tr>
	<tr><td>2014</td><td>344 </td></tr>
	<tr><td>2015</td><td>286 </td></tr>
	<tr><td>2016</td><td>269 </td></tr>
	<tr><td>2017</td><td>260 </td></tr>
</tbody>
</table>




```R
# These packages need to be loaded in the first `@tests` cell. 
library(testthat) 
library(IRkernel.testthat)

library(tidyverse)

run_tests({
    correct_ba_data <- read_csv("datasets/breath_alcohol_ames.csv")
    correct_count_data <- ba_data %>% count(year)
    test_that("read_csv is used", {
        expect_true("tbl_df" %in% class(ba_data),
                    info = "Use read_csv (with an underscore) to read in datasets/breath_alcohol_ames.csv")
    })
    test_that("ba_data is read in correctly", {
        expect_equal(correct_ba_data, ba_data,
                     info = "ba_data should contain the data in datasets/breath_alcohol_ames.csv")
    })
    test_that("ba_year is created correctly", {
        expect_equal(correct_count_data, ba_year, 
                     info = "ba_year should be a tbl.df with 5 rows and 2 columns called year and n")
    })
})
```

    Parsed with column specification:
    cols(
      year = col_integer(),
      month = col_integer(),
      day = col_integer(),
      hour = col_integer(),
      location = col_character(),
      gender = col_character(),
      Res1 = col_double(),
      Res2 = col_double()
    )





    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 13.589 0.207 1140.841 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 2. What is the busiest police department in Ames?
<p>There are two police departments in the data set: the Iowa State University Police Department and the Ames Police Department. Which one administers more breathalyzer tests? </p>


```R
# use count to tally up the totals for each department
pds <-  ba_data %>% group_by(location) %>% count() 
```


```R
run_tests({
    correct_pds_data <- ba_data %>% count(location)
    test_that("pds data is correct", {
        expect_equal(correct_pds_data, pds,
                     info = "Count by the location variable to get one column named location and one column named n. There should be 2 rows.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 13.627 0.207 1140.878 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 3. Nothing Good Happens after 2am
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_208/img/himym02.jpg" style="float: left;margin:5px 20px 5px 1px;width:300px"></p>
<p>We all know that "nothing good happens after 2am." Thus, there are inevitably some times of the day when breath alcohol tests, especially in a college town like Ames, are most and least common. Which hours of the day have the most and least breathalyzer tests?  </p>


```R
# count by hour and arrange by descending frequency
hourly <- ba_data %>% group_by(hour) %>% count() %>% arrange(desc(n))

# use a geom_ to create the appropriate bar chart
ggplot(hourly, aes(x = hour, y = n)) + geom_bar(stat = 'identity')
```




![png](output_7_1.png)



```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_hour_data <- ba_data %>% count(hour) %>% arrange(desc(n))
    test_that("hourly data is correct", {
        expect_equal(correct_hour_data, hourly,
                     info = "The object hourly should have 24 rows and 2 columns, called hour and n. The first row should contain the largest n value, and the last row should contain the smallest n value.")
    })
    test_that("plot is a bar chart",{
        p <- last_plot()
        q <- p$layers[[1]]
        expect_is(q$geom, "GeomBar", 
                  info = "You should plot a bar chart with hour on the x-axis and count ('n') on the y-axis.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 13.873 0.207 1141.124 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 4. Breathalyzer tests by month
<p>Now that we have discovered which time of day is most common for breath alcohol tests, we will determine which time of the year has the most breathalyzer tests. Which month will have the most recorded tests?</p>


```R
# count by month and arrange by descending frequency
monthly <- ba_data %>% group_by(month) %>% count() %>% arrange(desc(n))

# make month a factor
monthly$month <- as.factor(monthly$month)

# use a geom_ to create the appropriate bar chart
ggplot(monthly, aes(x = month, y = n)) + geom_bar(stat = 'identity')
```




![png](output_10_1.png)



```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_month_data <- ba_data %>% count(month) %>% arrange(desc(n)) %>% ungroup() %>% mutate(month = as.factor(month))
    test_that("monthly data is correct", {
        expect_equal(correct_month_data, monthly,
                     info = "The object monthly should have 12 rows and 2 columns, called month and n. The first row should contain the largest n value, and the last row should contain the smallest n value.")
    })
    test_that("plot is a bar chart",{
        p <- last_plot()
        q <- p$layers[[1]]
        expect_is(q$geom, "GeomBar", 
                  info = "You should plot a bar chart with month on the x-axis and count ('n') on the y-axis.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 14.102 0.207 1141.352 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 5. COLLEGE
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_208/img/PF2081John-Belushi-College-Posters.jpg" style="float: left;margin:5px 20px 5px 1px"> </p>
<p>When we think of (binge) drinking in college towns in America, we usually think of something like this image at the left. And so, one might suspect that breath alcohol tests are given to men more often than women and that men drink more than women. </p>


```R
# count by gender 
ba_data %>% group_by(gender) %>% count()

# create a dataset with no NAs in gender 
clean_gender <- ba_data %>% filter(!is.na(gender)) 

# create a mean test result variable and save as mean_bas
mean_bas <- clean_gender %>% mutate(meanRes = (Res1 + Res2)/2)

# create side-by-side boxplots to compare the mean blood alcohol levels of men and women
ggplot(mean_bas, aes(x = gender, y = meanRes)) + geom_boxplot()
```


<table>
<thead><tr><th scope=col>gender</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>F   </td><td> 425</td></tr>
	<tr><td>M   </td><td>1102</td></tr>
	<tr><td>NA  </td><td>  29</td></tr>
</tbody>
</table>






![png](output_13_2.png)



```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_clean_gender <- ba_data %>% filter(!is.na(gender))
    correct_meanbas <- clean_gender %>% mutate(meanRes = (Res1 + Res2)/2)
    test_that("clean_gender is correct", {
        expect_equal(clean_gender, correct_clean_gender,
                     info = "Use filter and !is.na().")
    })
    test_that("mean_bas is correct", {
        expect_equal(mean_bas, correct_meanbas,
                     info = "Try creating the mean column with mutate(meanRes = (col1 + col2)/2) in the clean_gender data.")
    }) 
    test_that("plot is a boxplot",{
        p <- last_plot()
        q <- p$layers[[1]]
        expect_is(q$geom, "GeomBoxplot", 
                  info = "You should plot a boxplot with gender on the x-axis and meanRes on the y-axis.")
    })

  # You can have more than one test
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 14.425 0.21 1141.677 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 6. Above the legal limit
<p>In the USA, it is illegal to drive with a blood alcohol concentration (BAC) above 0.08%. This is the case for <a href="https://www.dmv.org/automotive-law/dui.php">all 50 states</a>. Assuming everyone tested in our data was driving (though we have no way of knowing this from the data), if either of the results (<code>Res1</code>, <code>Res2</code>) are above 0.08, the person would be charged with DUI (driving under the influence). </p>


```R
# Filter the data
duis <- ba_data %>% filter(Res1 > 0.08 | Res2 > 0.08)

# proportion of tests that would have resulted in a DUI
p_dui <- nrow(duis) / nrow(ba_data)
```


```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_duis <- ba_data %>% filter(Res1 > 0.08 | Res2 > 0.08)
    p_correct <- nrow(correct_duis)/nrow(ba_data)
    test_that("duis is correct", {
        expect_equivalent(duis, correct_duis, 
                          info = "Make sure you included Res1 and Res2 values that are greater than 0.08.")
    })
    test_that("p is correct", {
        expect_equivalent(p_dui, p_correct, 
                          info = "The proportion should be the number of rows in duis divided by the number of rows in ba_data.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 14.474 0.211 1141.727 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 7. Breathalyzer tests: is there a pattern over time?
<p>We previously saw that 2am is the most common time of day for breathalyzer tests to be administered, and August is the most common month of the year for breathalyzer tests. Now, we look at the weeks in the year over time. We briefly use the <a href="http://lubridate.tidyverse.org/"><code>lubridate</code></a> package for a bit of date-time manipulation. </p>


```R
library(lubridate) 

# Create date variable using paste() and ymd()
ba_data <- ba_data %>% mutate(date = ymd(paste(year, month, day)))

# Create a week variable using week()
ba_data <- ba_data %>% mutate(week = week(date))
```


```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_ba_data <- ba_data %>% mutate(date = ymd(paste(year, month, day, sep = "-")), 
                                          week = week(date))
    test_that("ba_data is correct", {
        expect_equivalent(ba_data, correct_ba_data, 
                          info = "Did you create two new columns, date (a date variable) and week (a numeric variable)?")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 14.524 0.215 1141.78 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 8. Looking at timelines
<p>How do the weeks differ over time? One of the most common data visualizations is the time series, a line tracking the changes in a variable over time. We will use the new <code>week</code> variable to look at test frequency over time. We end with a time series plot showing frequency of breathalyzer tests by week in year, with one line for each year. </p>


```R
# create the weekly data set 
weekly <- ba_data %>% group_by(year, week) %>% count()

# uncomment and run the following line
weekly <- weekly %>% ungroup() # ungroup is necessary for the plot later

# make year a factor
weekly <- weekly %>% mutate(year = as.factor(year))

# create the time series plot with one line for each year
ggplot(weekly, aes(x = week, y = n, color = year)) + 
  geom_line() + 
  geom_point(aes(color = year)) +  # included to make the plot more readable 
  scale_x_continuous(breaks = seq(0,52,2))  # to make the x-axis more readable 
```




![png](output_22_1.png)



```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    correct_weekly <- ba_data %>% count(week, year) %>% ungroup %>% mutate(year = as.factor(year))
    test_that("weekly is correct", {
        expect_equivalent(weekly, correct_weekly,
                          info = "Did you ungroup the data for the plot?")
    })
    test_that("plot is a line plot",{
        p <- last_plot()
        q <- p$layers[[1]]
        expect_is(q$geom, "GeomLine", 
                  info = "You should plot a line plot with week on the x-axis, count ('n') on the y-axis, and year mapped to color.")
    })

# You can have more than one test
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 15.005 0.219 1142.265 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 9. The end of VEISHA
<p>From <a href="https://en.wikipedia.org/wiki/VEISHEA">Wikipedia</a>: 
"VEISHEA was an annual week-long celebration held each spring on the campus of Iowa State University in Ames, Iowa. The celebration featured an annual parade and many open-house demonstrations of the university facilities and departments. Campus organizations exhibited products, technologies, and held fundraisers for various charity groups. In addition, VEISHEA brought speakers, lecturers, and entertainers to Iowa State. [...] VEISHEA was the largest student-run festival in the nation, bringing in tens of thousands of visitors to the campus each year."</p>
<p>This over 90-year tradition in Ames was <a href="https://www.news.iastate.edu/news/2014/08/07/veisheaend">terminated permanently</a> after <a href="https://www.desmoinesregister.com/story/news/crime-and-courts/2014/04/09/veishea-ames-car-tipping/7495935/">riots in 2014</a>, where drunk celebrators flipped over multiple vehicles and tore light poles down. This was not the first incidence of violence and severe property damage in VEISHEA's history. Did former President Leath make the right decision?</p>


```R
## Run this code to create the plot 
ggplot() + 
  geom_point(data = weekly, aes(x = week, y = n, color = year)) + 
  geom_line(data = weekly, aes(x = week, y = n, color = year)) +  # included to make the plot more readable 
  geom_segment(data = NULL, arrow = arrow(angle = 20, length = unit(0.1, "inches"),
                                          ends = "last", type = "closed"), 
               aes(x = c(20,20), xend = c(15.5,16), y = c(21, 20), yend = c(21, 12.25))) + 
  geom_text(data = NULL, aes(x = 23, y = 20.5, label = "VEISHEA Weeks"), size = 3) + 
  scale_x_continuous(breaks = seq(0,52,2)) 

## Make a decision about VEISHEA. TRUE or FALSE?  
cancelling_VEISHEA_was_right <- TRUE
```




![png](output_25_1.png)



```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("decision is made", {
        expect_true(is.logical(cancelling_VEISHEA_was_right), info = "Did you make a decision about VEISHEA? Assign TRUE or FALSE to the variable cancelling_VEISHEA_was_right.")
    })
# You can have more than one test
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 15.509 0.223 1142.772 0.005 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 

