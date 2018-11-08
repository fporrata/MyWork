
## 1. Just how thirsty *is* Thursday?
<p><img style="float: left;margin:5px 20px 5px 1px;width:55%" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_489/img/shots.jpg"> </p>
<p>We have previously explored some breathalyzer test data from Ames, Iowa, USA, <a href="https://www.datacamp.com/projects/208">here</a>. Now, we focus on working with the date and time information in the data. As a college town (Go <a href="http://image.cdnllnwnl.xosnetwork.com/pics/400/NO/NOEFYIAGQIRAYLN.20090102181254.jpg">Cyclones</a>!), Ames has had its fair share of alcohol-related incidents. (For example, Google "VEISHEA riots 2014".) In this project, we examine breath alcohol test data in Ames from January 2013 to December 2017 that is published by the State of Iowa, specifically focusing on <em>when</em> these tests are administered. </p>
<p>The data file "breath<em>alcohol</em>datetimes.csv" contains 1,556 observations from breath alcohol tests collected by the Ames and Iowa State University Police Departments. The columns in this dataset are: </p>
<ol>
<li><strong>DateTime</strong> - date &amp; time of test (datetime, "America/Chicago")              </li>
<li><strong>Location</strong> - who administered the test, Ames PD or ISU PD? (char.)</li>
<li><strong>Gender</strong> - gender (M,F) of person being tested (char.)</li>
<li><strong>Res1</strong> - first breath alcohol reading (num.)</li>
<li><strong>Res2</strong> - second breath alcohol reading (num.)</li>
</ol>
<p>First, we create a bar chart showing number of tests by day of the week to see when the most tests were done.   </p>


```R
# load necessary packages 
library(tidyverse)
library(lubridate)

# read in the data from breath_alcohol_datetimes.csv
ba_dates <- read_csv("datasets/breath_alcohol_datetimes.csv")

# change DateTime column to America/Chicago with force_tz
ba_dates <- ba_dates %>% mutate(DateTime = force_tz(DateTime, "America/Chicago"))

# create a wkday column in the ba_dates 
ba_dates <- ba_dates %>% mutate(wkday = wday(DateTime,label = TRUE))

# create a bar chart of # tests by day of week
ggplot(data = ba_dates, aes(x = wkday)) + 
 geom_bar()
```

    Parsed with column specification:
    cols(
      DateTime = col_datetime(format = ""),
      Location = col_character(),
      Gender = col_character(),
      Res1 = col_double(),
      Res2 = col_double()
    )





![png](output_1_2.png)



```R
# These packages need to be loaded in the first @tests cell. 
library(testthat) 
library(IRkernel.testthat)

# function to use when testing plots from D. Rob's project. 
get_aesthetics <- function(p) {
    unlist(c(list(p$mapping), purrr::map(p$layers, "mapping")))
}

run_tests({
  test_that("timezone was changed to America/Chicago", {
      expect_true(tz(ba_dates$DateTime)== "America/Chicago", 
                 info = "Did you change the timezone of DateTime to America/Chicago?")
  })  
  test_that("use label = T in wday()", {
    expect_equivalent(class(ba_dates$wkday),c("ordered", "factor"), 
                      info = "Did you use label = T in wday() to get the names of the days?")
  })
  test_that("the plot is correct", {
    expect_true("ggplot2" %in% .packages(), info = "Did you load the ggplot2 package?")
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_bar()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomBar", info = "Did you create a plot with geom_bar()?")
    # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put wkday on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "wkday",
                     info = "Did you put wkday on the x-axis?")
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
        current_start_time: 16.459 0.218 1057.728 0.004 0.001
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


## 2. What makes Sunday so fun-day?
<p>Well, that wasn't terribly surprising: Friday and Saturday are two of the most common days of the week for breathalyzer tests in a college town. But what might be <em>somewhat</em> surprising is that more tests occur on Sunday than on Friday.  But <em>when</em> on Sunday are these tests being administered?  To investigate, we look at the hour of the test and compare this data for Friday, Saturday, and Sunday. </p>


```R
# create hour variable
ba_dates <- ba_dates %>% mutate(hr = hour(DateTime))

# create weekend data frame
weekend <- ba_dates %>% filter(wkday %in% c("Fri", "Sat", "Sun"))

# plot side-by side bar charts counting hour of the day of tests for each weekend day
ggplot(data = weekend) + geom_bar(aes(x = hr)) + 
    facet_grid(.~wkday) + 
    scale_x_continuous(breaks = 1:12*2-1) # for ease of readability 
```




![png](output_4_1.png)



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("hour variable is correct", {
    expect_equal(range(ba_dates$hr), c(0,23), 
                 info = "Make sure you used the hour() function in lubridate. Hour should be an integer from 0-23.")
  })
  # 
  test_that("weekend only has Fri, Sat, Sun data", {
    expect_equal(as.character(unique(weekend$wkday)), c( "Sun", "Sat", "Fri"),       
                 info = "Did you create an object from ba_dates called weekend with ONLY Fri, Sat, Sun in wkday?")   
  })
  # 
  test_that("the plot is correct", {
    student_plot <- last_plot() 
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_bar()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomBar", info = "Did you create a plot with geom_bar()?")
    # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put hr on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "hr",
                     info = "Did you put hr on the x-axis?")
    # facet check
    expect_true(!is.null(student_plot$facet$params$cols[[1]]), info = "Did you facet by wkday using .~wkday?")  
    expect_equal(rlang::quo_name(student_plot$facet$params$cols[[1]]), "wkday",
                info = "Did you facet by wkday using .~wkday?")
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
        current_start_time: 16.849 0.222 1058.121 0.004 0.001
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


## 3. Trends in testing over time
<p>We learned that most of the tests administered on Sundays are during early morning, from midnight to 5am. Strangely, the same pattern also exists on Friday mornings. (This is likely because Thursdays are "Mug Nights" in Ames, where you can get discounted drinks if you bring in the designated reusable mug.) Returning to the full dataset, we now explore  the pattern of alcohol tests over the years. To look at the "bigger picture," let's count up the number of tests per day, and visualize the resulting time series using a line plot.</p>


```R
# create a date column rounded to the nearest day. as.Date() is for the plot later
ba_dates <- ba_dates %>% mutate(date = as.Date(round_date(DateTime,"day" ))) 

# count number of tests per date 
ba_summary <- ba_dates %>% count(date)

# pipe the result from above into ggplot() using geom_line to create a time series plot.
ba_summary %>% 
  ggplot() + 
  geom_line(aes(x = date, y = n), alpha = .7) + # change alpha for readability 
  scale_x_date(date_breaks = "6 months") + 
  theme(axis.text.x = element_text(angle = 30)) # make x-axis more readable 
```




![png](output_7_1.png)



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("date rounded correctly", {
    ba_dates_correct <- ba_dates %>% mutate(date = as.Date(round_date(DateTime, unit = "day")))  
    expect_true(sum(hour(ba_dates$date)) == 0, 
                info = "Did you use round_date(unit = 'day') to create the date column?")
    expect_equivalent(ba_dates$date, ba_dates_correct$date, 
                     info = "Did you use round_date(unit = 'day') to create the date column?")
  })
  #
  test_that("time series plot is correct", {
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_line()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomLine", info = "Did you create a plot with geom_line()?")
    # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put date on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "date",
                     info = "Did you put date on the x-axis?")
    expect_true(!is.null(aesthetics$y), info = "Did you put n on the y-axis?")
    expect_equal(rlang::quo_name(aesthetics$y), "n",
                     info = "Did you put n on the y-axis?")  
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
        current_start_time: 17.14 0.222 1058.412 0.004 0.001
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


## 4. College football
<p>In the time series, we see many days that have zero breathalyzer tests administered. In the entire five year period, there were at most eight tests in a day. There are many days with three or more tests in a day, and we wonder if the Iowa State football schedule may match up with some of those high test days. We next explore the Iowa State football schedule for 2013-2017. Data were downloaded from <a href="https://www.sports-reference.com/cfb/">sports-reference.com</a>.</p>
<p><img style="float: left;margin:5px 20px 5px 1px;width:95%" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_489/img/football.jpg"> </p>


```R
# read in the football data 
isu_fb <- read_csv("datasets/isu_football.csv")

# make Date a date variable 
isu_fb <- isu_fb %>% mutate(Date = parse_date(Date, format = "%b %d, %Y"))

# filter ba_summary
ba_fb <- ba_summary %>% filter(date %in% isu_fb$Date)

# arrange ba_fb by number of tests from high to low and print first six rows 
ba_fb %>% arrange(desc(n)) %>% head(6)
```

    Parsed with column specification:
    cols(
      G = col_integer(),
      Date = col_character(),
      Time = col_time(format = ""),
      Day = col_character(),
      School = col_character(),
      Home = col_character(),
      Opponent = col_character(),
      Conf = col_character(),
      Res = col_character(),
      Pts = col_integer(),
      Opp = col_integer(),
      W = col_integer(),
      L = col_integer(),
      Streak = col_character(),
      Notes = col_character(),
      TV = col_character()
    )



<table>
<thead><tr><th scope=col>date</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>2016-09-24</td><td>6         </td></tr>
	<tr><td>2017-10-28</td><td>5         </td></tr>
	<tr><td>2013-08-31</td><td>4         </td></tr>
	<tr><td>2013-09-14</td><td>4         </td></tr>
	<tr><td>2013-11-16</td><td>4         </td></tr>
	<tr><td>2016-09-03</td><td>4         </td></tr>
</tbody>
</table>




```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("Date is a date", {
    expect_true(class(isu_fb$Date) == "Date", 
        info = "Did you make the Date column in isu_fb a date with parse_date(Date, format = '%b %d, %Y')?")
    })
    # 
    test_that("ba_fb is correct", {
    correct_isufb <- read_csv("datasets/isu_football.csv") %>% 
        mutate(Date = parse_date(Date, format = "%b %d, %Y"))
    correct_bafb <- ba_summary %>% filter(date %in% correct_isufb$Date)  
    expect_equivalent(ba_fb, correct_bafb, 
                     info = "Did you filter ba_summary to include only dates %in% isu_fb%Date?")
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
        current_start_time: 17.193 0.222 1058.464 0.004 0.001
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


## 5. Home vs. away? Win vs. lose?
<p>The most breathalyzer tests given on a football game day was on Sept. 24, 2016. This was a home game against San Jose State that Iowa State won 44-10. Could the home game win have led to some excessive celebrations that resulted in more breathalyzer tests than an away win or a home loss? </p>


```R
# join ba_summary to isu_fb 
isu_fb2 <- isu_fb %>% left_join(ba_summary, by = c("Date" = "date"))

# change nas to 0s 
isu_fb2 <- isu_fb2 %>% mutate(n = ifelse(is.na(n), 0, n))

# plot 
ggplot(data = isu_fb2, aes(x = n, fill = Home)) + 
 geom_bar() + facet_grid(.~Res) + xlab("Number of breathalyzer tests") + ylab("Count of the number of breathalyzer tests")
```




![png](output_13_1.png)



```R
# One or more tests of the student's code.  
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("isu_fb2 is correct", {
    correct_isu_fb2 <- isu_fb %>% left_join(ba_summary, by = c("Date" = "date")) %>% 
                       mutate(n = ifelse(is.na(n), 0, n))
    expect_equivalent(isu_fb2$Date, correct_isu_fb2$Date, info = 
                        'Did you use by = c("Date" = "date") in left_join?')
    expect_equivalent(isu_fb2$n, correct_isu_fb2$n, info = 
                        'Did you replace all NAs with 0 in isu_fb2$n?')
  })
  # 
  test_that("plot is correct", {
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_bar()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomBar", info = "Did you create a plot with geom_bar()?")
    # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put n on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "n",
                     info = "Did you put n on the x-axis?")
    expect_true(!is.null(aesthetics$fill), info = "Did you fill the bars by Home?")
    expect_equal(rlang::quo_name(aesthetics$fill), "Home",
                     info = "Did you fill the bars by home?")  
    # facet check  
    expect_true(!is.null(student_plot$facet$params$cols[[1]]), 
                info = "Did you facet by Res using .~Res in facet_grid?")
    expect_equal(rlang::quo_name(student_plot$facet$params$cols[[1]]), "Res",
                 info = "Did you facet by Res using .~Res in facet_grid?")
    
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
        current_start_time: 17.61 0.222 1058.88 0.004 0.001
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


## 6. Monthly counts
<p>The football season typically lasts from September through November. As we just saw, Iowa State football has more losses than wins in the last few years. The men's basketball team, however, has traditionally been very successful. The basketball season usually lasts from November through March. We now investigate the number of breathalyzer tests by month to see if the basketball months have more tests than the football months. </p>


```R
# create a mo and a yr column in ba_dates
ba_dates <- ba_dates %>% mutate(mo = month(DateTime, label = TRUE), yr =year(DateTime))

# make bar chart by mo.
ggplot(data = ba_dates, aes(x = mo)) + 
 geom_bar()

# color by year 
ggplot(data = ba_dates, aes(x = mo, fill = as.factor(yr))) + 
 geom_bar()
```






![png](output_16_2.png)



![png](output_16_3.png)



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("mo, yr columns are correct", {
    expect_equal(as.character(sort(unique(ba_dates$mo))), month.abb,
                 info = "Did you use label = T in the month() function to create the mo column?")
    expect_equal(sort(unique(ba_dates$yr)), 2013:2017, 
                 info = 'Did you use year() to create the yr column in ba_dates?')
  })
  # 
  test_that("colored bar chart is correct", {
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_bar()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomBar", info = "Did you create a plot with geom_bar()?")
    # aes check 
    expect_true(!is.null(aesthetics$x), info = "Did you put mo on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "mo",
                     info = "Did you put mo on the x-axis?")  
    expect_true(!is.null(aesthetics$fill), info = "Did you use as.factor(yr) to fill the bars?")
    expect_equal(rlang::quo_name(aesthetics$fill), "as.factor(yr)",
                     info = "Did you use as.factor(yr) to fill the bars?")
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
        current_start_time: 18.448 0.223 1059.722 0.004 0.001
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


## 7. VEISHEA: an old tradition
<p>The monthly bar charts show that the months with the most test per day are August and April. April is a surprise because there are no major college sports in April, and students are busy studying for finals and finishing semester projects. Well, at Iowa State, there was a historical weeklong festival known as VEISHEA held in April every year.  It was cancelled in 2014 due to the many drinking-related arrests, violence, and vandalism that occurred yearly. Looking at the VEISHEA weeks and subsequent non-VEISHEA weeks, can we see the effect of the cancellation in the breathalyzer data? </p>


```R
# In 2013, VEISHEA was held from April 15-21. In 2014, it was held from April 7-13. 
v13 <- interval(make_date(2013, 4, 15) , make_date(2013, 4, 21), tzone = "America/Chicago")
v14 <- interval(make_date(2014, 4, 7) , make_date(2014, 4, 13), tzone = "America/Chicago")
# Other comparable VEISHEA weeks in 2015-2017
v15 <- interval(make_date(2015, 4, 13) , make_date(2015, 4, 19), tzone = "America/Chicago")
v16 <- interval(make_date(2016, 4, 11) , make_date(2016, 4, 17), tzone = "America/Chicago")
v17 <- interval(make_date(2017, 4, 10) , make_date(2017, 4, 16), tzone = "America/Chicago")

# filter ba_dates for only the 5 veishea intervals
veishea <- ba_dates %>% filter(date %within% v13 | date %within% v14 | date %within% v15 | date %within% v16 | date %within% v17)

# count up years 
veishea %>% count(date)
```


<table>
<thead><tr><th scope=col>date</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>2013-04-16</td><td>1         </td></tr>
	<tr><td>2013-04-17</td><td>1         </td></tr>
	<tr><td>2013-04-19</td><td>2         </td></tr>
	<tr><td>2013-04-20</td><td>3         </td></tr>
	<tr><td>2013-04-21</td><td>5         </td></tr>
	<tr><td>2014-04-08</td><td>3         </td></tr>
	<tr><td>2014-04-09</td><td>1         </td></tr>
	<tr><td>2014-04-10</td><td>2         </td></tr>
	<tr><td>2014-04-11</td><td>3         </td></tr>
	<tr><td>2014-04-12</td><td>7         </td></tr>
	<tr><td>2014-04-13</td><td>8         </td></tr>
	<tr><td>2015-04-16</td><td>2         </td></tr>
	<tr><td>2015-04-17</td><td>1         </td></tr>
	<tr><td>2015-04-18</td><td>3         </td></tr>
	<tr><td>2015-04-19</td><td>2         </td></tr>
	<tr><td>2016-04-12</td><td>1         </td></tr>
	<tr><td>2016-04-13</td><td>1         </td></tr>
	<tr><td>2016-04-16</td><td>2         </td></tr>
	<tr><td>2016-04-17</td><td>4         </td></tr>
	<tr><td>2017-04-10</td><td>1         </td></tr>
	<tr><td>2017-04-12</td><td>3         </td></tr>
	<tr><td>2017-04-13</td><td>5         </td></tr>
	<tr><td>2017-04-15</td><td>2         </td></tr>
</tbody>
</table>




```R
# One or more tests of the student's code.
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("intervals are correct", {
    expect_equivalent(v13, interval(make_date(2013, 4, 15) , make_date(2013, 4, 21)), 
                      info = "Does your v13 interval cover April 15-21 in 2013?")
    expect_equivalent(v14, interval(make_date(2014, 4, 7) , make_date(2014, 4, 13)), 
                      info = "Does your v13 interval cover April 7-13 in 2014?")
  })
  # 
  test_that("veishea data is correct", {
    expect_true(nrow(veishea) == 63, info = "Did you filter date %within% all 5 intervals?")
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
        current_start_time: 18.512 0.223 1059.786 0.004 0.001
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


## 8. Looking at BAC
<p>Finally, let's look at the actual results of the breathalyzer tests. Based on our knowledge from Section 2, we suspect that the highest BAC results occur late and night and in the early morning, since those times are most common for tests on the weekends. </p>


```R
# take a mean of res1, res2
ba_dates <- ba_dates %>% mutate(res = (Res1 + Res2)/2)

# library the ggridges package
library(ggridges)

# make ridgeline plot 
ggplot(data = ba_dates, aes(x = res, y = hr, group = hr)) +
  # some style choices made already
  geom_density_ridges(alpha = 0.7, fill = "steelblue", bandwidth = .01, rel_min_height = 0.0001) + 
  scale_y_continuous(breaks = 0:23)
```




![png](output_22_1.png)



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("mean column is correct", {
    expect_equal(ba_dates$res, (ba_dates$Res1 + ba_dates$Res2)/2,
                 info = "Did you create a column res = (Res1 + Res2)/2 in the mutate() function?")
  })
  # 
  test_that("ggridges plot is correct", {
    expect_true("ggridges" %in% .packages(), info = "Did you load the ggridges package?")
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_density_ridges()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomDensityRidges", info = "Did you create a plot with geom_density_ridges()?")
    # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put res on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "res",
                     info = "Did you put res on the x-axis?")
    expect_true(!is.null(aesthetics$y), info = "Did you put hr on the y-axis?")
    expect_equal(rlang::quo_name(aesthetics$y), "hr",
                     info = "Did you put hour on the y-axis?")  
    expect_true(!is.null(aesthetics$group), info = "Did you group by hr?")
    expect_equal(rlang::quo_name(aesthetics$group), "hr",
                     info = "Did you group by hr?")  
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
        current_start_time: 19.035 0.231 1060.316 0.004 0.001
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


## 9. A more honest plot
<p>In the previous ridgeline plot, there are values below zero. This is impossible given the context: you cannot have negative alcohol concentration in your blood. We examine the zeroes below and make a more honest ridgeline plot. </p>


```R
# create a zero indicator variable 

ba_dates <- ba_dates %>% mutate(zero = res == 0)
# tabulate the data by the zero column
ba_dates %>% count(zero)

# redo ridge with no 0s
ba_dates %>% filter(zero == FALSE) %>% 
ggplot(aes(x = res, y = hr, group = hr)) +
  geom_density_ridges(alpha = 0.7, fill = "steelblue", bandwidth = .01, rel_min_height = 0.005) + 
  scale_y_continuous(breaks = 0:23)
```


<table>
<thead><tr><th scope=col>zero</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>FALSE</td><td>1353 </td></tr>
	<tr><td> TRUE</td><td> 203 </td></tr>
</tbody>
</table>






![png](output_25_2.png)



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("zero column in ba_dates is correct", {
    expect_is(ba_dates$zero, "logical", info = "Did you create a vector of TRUE/FALSE in ba_dates?")
    expect_equivalent(count(ba_dates, zero)$n, c(1353, 203), 
                      info = "Did you count ba_dates by the zero column?")
  })
  # 
  test_that("ggridges plot is correct", {
    student_plot <- last_plot()
    aesthetics <- get_aesthetics(student_plot)
    expect_true(sum(student_plot$data$res == 0) == 0, 
                info = "Did you remove the zero values in ba_dates before ggplot()?")
    expect_is(student_plot, "ggplot", info = "Did you create a ggplot figure?")
    expect_equal(length(student_plot$layers), 1, info = "Did you create a plot with geom_density_ridges()?")
    expect_is(student_plot$layers[[1]]$geom, "GeomDensityRidges", info = "Did you create a plot with geom_density_ridges()?")
     # aes check
    expect_true(!is.null(aesthetics$x), info = "Did you put res on the x-axis?")
    expect_equal(rlang::quo_name(aesthetics$x), "res",
                     info = "Did you put res on the x-axis?")
    expect_true(!is.null(aesthetics$y), info = "Did you put hr on the y-axis?")
    expect_equal(rlang::quo_name(aesthetics$y), "hr",
                     info = "Did you put hr on the y-axis?")  
    expect_true(!is.null(aesthetics$group), info = "Did you group by hr?")
    expect_equal(rlang::quo_name(aesthetics$group), "hr",
                     info = "Did you group by hr?")  
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
        current_start_time: 19.546 0.235 1060.83 0.004 0.001
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


## 10. The dangers of binge drinking
<p>At a breath alcohol level of 0.16-0.30, a person will experience significant "speech, memory, coordination, attention, reaction time, [and] balance" impairment. Someone's "driving-related skills" and "judgement and decision making" are dangerously impaired, and they may experience "blackouts, vomiting [...] and loss of consciousness". BAC of 0.31 or above is life-threatening with "significant risk of death" (<a href="https://medlineplus.gov/magazine/issues/spring14/articles/spring14pg23.html">source</a>). We conclude by looking at the time of day during which the most dangerous levels of alcohol consumption appear in the Ames data. Do the dates, times, and days of week match what one would expect? </p>
<p>While this report has taken a fun and playful tone, it is important to be aware of the seriousness of this issue. According to <a href="https://www.niaaa.nih.gov/alcohol-health/overview-alcohol-consumption/alcohol-facts-and-statistics">research</a>, nearly 2,000 college students die each year from alcohol-related injuries. If you or a loved one are struggling with alcohol abuse, please seek <a href="https://pubs.niaaa.nih.gov/publications/treatment/treatment.htm">help</a>. </p>


```R
# filter the ba_dates data to contain only those with the most dangerous result
danger <- ba_dates %>% filter(res >= 0.31)

# print danger
print(danger)
```

    # A tibble: 4 x 12
      DateTime            Location Gender  Res1  Res2 wkday    hr date       mo   
      <dttm>              <chr>    <chr>  <dbl> <dbl> <ord> <int> <date>     <ord>
    1 2015-01-05 20:49:00 Ames PD  M      0.313 0.312 Mon      20 2015-01-06 Jan  
    2 2014-11-13 19:23:00 Ames PD  F      0.352 0.351 Thu      19 2014-11-14 Nov  
    3 2014-10-21 18:03:00 Ames PD  F      0.325 0.324 Tue      18 2014-10-22 Oct  
    4 2013-05-28 21:01:00 ISU PD   F      0.352 0.351 Tue      21 2013-05-29 May  
    # ... with 3 more variables: yr <dbl>, res <dbl>, zero <lgl>



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
  test_that("danger data was created", {
    expect_equivalent(danger, ba_dates %>% filter(res >= 0.31), 
                      info = "Did you run the code provided?")
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
        current_start_time: 19.68 0.235 1060.963 0.004 0.001
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

