
## 1. TV, halftime shows, and the Big Game
<p>Whether or not you like American football, the Super Bowl is a spectacle. There is always a little something for everyone. For the die-hard fans, there is the game itself with blowouts, comebacks, and controversy. For the not so die-hard fans, there are the ridiculously expensive ads that are hilarious, gut-wrenching, thought-provoking, and sometimes weird. And of course, there are the halftime shows with the biggest musicians in the world entertaining us by <a href="https://youtu.be/ZD1QrIe--_Y?t=14">riding a giant mechanical tiger</a> or <a href="https://youtu.be/mjrdywp5nyE?t=62">leaping from the roof of the stadium</a>. It is a grand show! In this notebook, we're going to explore how some of these elements interact with each other. After exploring and cleaning the data, we're going to answer questions like:</p>
<ul>
<li>What are the most extreme game outcomes?</li>
<li>How does the score difference affect television viewership?</li>
<li>How have viewership, TV ratings, and advertisement costs evolved?</li>
<li>Who are the most prolific musicians in terms of halftime show performances?</li>
</ul>
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_691/img/left_shark.jpg" alt="Left Shark Steals The Show">
<em><a href="https://www.flickr.com/photos/huntleypaton/16464994135/in/photostream/">Left Shark Steals The Show</a>. Katy Perry performing at halftime of Super Bowl XLIX. Photo by Huntley Paton. Attribution-ShareAlike 2.0 Generic (CC BY-SA 2.0).</em></p>
<p>The dataset we'll use was <a href="https://en.wikipedia.org/wiki/Web_scraping">scraped</a> and polished from Wikipedia. It is made up of three CSV files, one with <a href="https://en.wikipedia.org/wiki/List_of_Super_Bowl_champions">game data</a>, one with <a href="https://en.wikipedia.org/wiki/Super_Bowl_television_ratings">TV data</a>, and one with <a href="https://en.wikipedia.org/wiki/List_of_Super_Bowl_halftime_shows">halftime musician data</a> for all 52 Super Bowls through 2018.</p>


```R
# Load packages
library(tidyverse)

# Load the CSV data
super_bowls  <-  read_csv("datasets/super_bowls.csv")
tv  <-  read_csv("datasets/tv.csv")
halftime_musicians  <-  read_csv("datasets/halftime_musicians.csv")

# Display the first six rows of each tibble
head(super_bowls)
head(tv)
head(halftime_musicians)
```

    Parsed with column specification:
    cols(
      date = col_date(format = ""),
      super_bowl = col_double(),
      venue = col_character(),
      city = col_character(),
      state = col_character(),
      attendance = col_double(),
      team_winner = col_character(),
      winning_pts = col_double(),
      qb_winner_1 = col_character(),
      qb_winner_2 = col_character(),
      coach_winner = col_character(),
      team_loser = col_character(),
      losing_pts = col_double(),
      qb_loser_1 = col_character(),
      qb_loser_2 = col_character(),
      coach_loser = col_character(),
      combined_pts = col_double(),
      difference_pts = col_double()
    )
    Parsed with column specification:
    cols(
      super_bowl = col_double(),
      network = col_character(),
      avg_us_viewers = col_double(),
      total_us_viewers = col_double(),
      rating_household = col_double(),
      share_household = col_double(),
      rating_18_49 = col_double(),
      share_18_49 = col_double(),
      ad_cost = col_double()
    )
    Parsed with column specification:
    cols(
      super_bowl = col_double(),
      musician = col_character(),
      num_songs = col_double()
    )



<table>
<thead><tr><th scope=col>date</th><th scope=col>super_bowl</th><th scope=col>venue</th><th scope=col>city</th><th scope=col>state</th><th scope=col>attendance</th><th scope=col>team_winner</th><th scope=col>winning_pts</th><th scope=col>qb_winner_1</th><th scope=col>qb_winner_2</th><th scope=col>coach_winner</th><th scope=col>team_loser</th><th scope=col>losing_pts</th><th scope=col>qb_loser_1</th><th scope=col>qb_loser_2</th><th scope=col>coach_loser</th><th scope=col>combined_pts</th><th scope=col>difference_pts</th></tr></thead>
<tbody>
	<tr><td>2018-02-04                   </td><td>52                           </td><td>U.S. Bank Stadium            </td><td>Minneapolis                  </td><td>Minnesota                    </td><td>67612                        </td><td>Philadelphia Eagles          </td><td>41                           </td><td>Nick Foles                   </td><td>NA                           </td><td>Doug Pederson                </td><td>New England Patriots         </td><td>33                           </td><td>Tom Brady                    </td><td>NA                           </td><td>Bill Belichick               </td><td>74                           </td><td> 8                           </td></tr>
	<tr><td>2017-02-05                   </td><td>51                           </td><td>NRG Stadium                  </td><td>Houston                      </td><td>Texas                        </td><td>70807                        </td><td>New England Patriots         </td><td>34                           </td><td>Tom Brady                    </td><td>NA                           </td><td>Bill Belichick               </td><td>Atlanta Falcons              </td><td>28                           </td><td>Matt Ryan                    </td><td>NA                           </td><td>Dan Quinn                    </td><td>62                           </td><td> 6                           </td></tr>
	<tr><td>2016-02-07                   </td><td>50                           </td><td>Levi's Stadium               </td><td>Santa Clara                  </td><td>California                   </td><td>71088                        </td><td>Denver Broncos               </td><td>24                           </td><td>Peyton Manning               </td><td>NA                           </td><td>Gary Kubiak                  </td><td>Carolina Panthers            </td><td>10                           </td><td>Cam Newton                   </td><td>NA                           </td><td>Ron Rivera                   </td><td>34                           </td><td>14                           </td></tr>
	<tr><td>2015-02-01                   </td><td>49                           </td><td>University of Phoenix Stadium</td><td>Glendale                     </td><td>Arizona                      </td><td>70288                        </td><td>New England Patriots         </td><td>28                           </td><td>Tom Brady                    </td><td>NA                           </td><td>Bill Belichick               </td><td>Seattle Seahawks             </td><td>24                           </td><td>Russell Wilson               </td><td>NA                           </td><td>Pete Carroll                 </td><td>52                           </td><td> 4                           </td></tr>
	<tr><td>2014-02-02                   </td><td>48                           </td><td>MetLife Stadium              </td><td>East Rutherford              </td><td>New Jersey                   </td><td>82529                        </td><td>Seattle Seahawks             </td><td>43                           </td><td>Russell Wilson               </td><td>NA                           </td><td>Pete Carroll                 </td><td>Denver Broncos               </td><td> 8                           </td><td>Peyton Manning               </td><td>NA                           </td><td>John Fox                     </td><td>51                           </td><td>35                           </td></tr>
	<tr><td>2013-02-03                   </td><td>47                           </td><td>Mercedes-Benz Superdome      </td><td>New Orleans                  </td><td>Louisiana                    </td><td>71024                        </td><td>Baltimore Ravens             </td><td>34                           </td><td>Joe Flacco                   </td><td>NA                           </td><td>John Harbaugh                </td><td>San Francisco 49ers          </td><td>31                           </td><td>Colin Kaepernick             </td><td>NA                           </td><td>Jim Harbaugh                 </td><td>65                           </td><td> 3                           </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>super_bowl</th><th scope=col>network</th><th scope=col>avg_us_viewers</th><th scope=col>total_us_viewers</th><th scope=col>rating_household</th><th scope=col>share_household</th><th scope=col>rating_18_49</th><th scope=col>share_18_49</th><th scope=col>ad_cost</th></tr></thead>
<tbody>
	<tr><td>52       </td><td>NBC      </td><td>103390000</td><td>       NA</td><td>43.1     </td><td>68       </td><td>33.4     </td><td>78       </td><td>5000000  </td></tr>
	<tr><td>51       </td><td>Fox      </td><td>111319000</td><td>172000000</td><td>45.3     </td><td>73       </td><td>37.1     </td><td>79       </td><td>5000000  </td></tr>
	<tr><td>50       </td><td>CBS      </td><td>111864000</td><td>167000000</td><td>46.6     </td><td>72       </td><td>37.7     </td><td>79       </td><td>5000000  </td></tr>
	<tr><td>49       </td><td>NBC      </td><td>114442000</td><td>168000000</td><td>47.5     </td><td>71       </td><td>39.1     </td><td>79       </td><td>4500000  </td></tr>
	<tr><td>48       </td><td>Fox      </td><td>112191000</td><td>167000000</td><td>46.7     </td><td>69       </td><td>39.3     </td><td>77       </td><td>4000000  </td></tr>
	<tr><td>47       </td><td>CBS      </td><td>108693000</td><td>164100000</td><td>46.3     </td><td>69       </td><td>39.7     </td><td>77       </td><td>4000000  </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>super_bowl</th><th scope=col>musician</th><th scope=col>num_songs</th></tr></thead>
<tbody>
	<tr><td>52                                   </td><td>Justin Timberlake                    </td><td>11                                   </td></tr>
	<tr><td>52                                   </td><td>University of Minnesota Marching Band</td><td> 1                                   </td></tr>
	<tr><td>51                                   </td><td>Lady Gaga                            </td><td> 7                                   </td></tr>
	<tr><td>50                                   </td><td>Coldplay                             </td><td> 6                                   </td></tr>
	<tr><td>50                                                                                 </td><td><span style=white-space:pre-wrap>Beyonc&lt;U+00E9&gt;                       </span></td><td> 3                                                                                 </td></tr>
	<tr><td>50                                   </td><td>Bruno Mars                           </td><td> 3                                   </td></tr>
</tbody>
</table>




```R
# These packages need to be loaded in the first @tests cell. 
library(testthat) 
library(IRkernel.testthat)

soln_super_bowls  <-  read_csv("datasets/super_bowls.csv")
soln_tv = read_csv("datasets/tv.csv")
soln_halftime_musicians = read_csv("datasets/halftime_musicians.csv")

run_tests({
    test_that("packages are loaded", {
        expect_true("tidyverse" %in% .packages(), info = "Did you load the tidyverse package?")
      })
    test_that("The .csv were read in correctly", {
        expect_is(super_bowls, "tbl_df", info = "Did you read in super_bowls.csv with read_csv?")
        expect_equal(super_bowls, soln_super_bowls, 
                     info = "super_bowls contains the wrong values. Did you load the correct .csv file?")

        expect_is(tv, "tbl_df", info = "Did you read in tv.csv with read_csv?")
        expect_equal(tv, soln_tv, 
                     info = "tv contains the wrong values. Did you load the correct .csv file?")

        expect_is(halftime_musicians, "tbl_df", info = "Did you read in halftime_musicians.csv with read_csv?")
        expect_equal(halftime_musicians, soln_halftime_musicians, 
                     info = "halftime_musicians contains the wrong values. Did you load the correct .csv file?")
    })
})
```

    Parsed with column specification:
    cols(
      date = col_date(format = ""),
      super_bowl = col_double(),
      venue = col_character(),
      city = col_character(),
      state = col_character(),
      attendance = col_double(),
      team_winner = col_character(),
      winning_pts = col_double(),
      qb_winner_1 = col_character(),
      qb_winner_2 = col_character(),
      coach_winner = col_character(),
      team_loser = col_character(),
      losing_pts = col_double(),
      qb_loser_1 = col_character(),
      qb_loser_2 = col_character(),
      coach_loser = col_character(),
      combined_pts = col_double(),
      difference_pts = col_double()
    )
    Parsed with column specification:
    cols(
      super_bowl = col_double(),
      network = col_character(),
      avg_us_viewers = col_double(),
      total_us_viewers = col_double(),
      rating_household = col_double(),
      share_household = col_double(),
      rating_18_49 = col_double(),
      share_18_49 = col_double(),
      ad_cost = col_double()
    )
    Parsed with column specification:
    cols(
      super_bowl = col_double(),
      musician = col_character(),
      num_songs = col_double()
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
        current_start_time: 15.142 0.271 660.917 0.005 0
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


## 2. Taking note of dataset issues
<p>From the quick look at the Super Bowl game data, we can see that the dataset appears whole except for missing values in the backup quarterback columns (<code>qb_winner_2</code> and <code>qb_loser_2</code>), which make sense given most starting QBs in the Super Bowl (<code>qb_winner_1</code> and <code>qb_loser_1</code>) play the entire game.</p>
<p>From the visual inspection of TV and halftime musicians data, there is only one missing value displayed, but I've got a hunch there are more. The first Super Bowl was played on January 15, 1967, and I'm guessing some data (e.g., the number of songs performed) probably weren't tracked reliably over time. Wikipedia is great but not perfect.</p>
<p>Looking at a summary of the datasets shows us that there are multiple columns with null values.</p>


```R
# Summary of the TV data
summary(tv)

# Summary of the halftime musician data 
summary(halftime_musicians)
```


       super_bowl      network          avg_us_viewers      total_us_viewers   
     Min.   : 1.00   Length:53          Min.   : 24430000   Min.   : 51180000  
     1st Qu.:13.00   Class :character   1st Qu.: 73852000   1st Qu.:142900000  
     Median :26.00   Mode  :character   Median : 85240000   Median :153400000  
     Mean   :26.02                      Mean   : 80709585   Mean   :148872000  
     3rd Qu.:39.00                      3rd Qu.: 92570000   3rd Qu.:165550000  
     Max.   :52.00                      Max.   :114442000   Max.   :172000000  
                                                            NA's   :38         
     rating_household share_household  rating_18_49    share_18_49   
     Min.   :18.5     Min.   :36.00   Min.   :33.40   Min.   :77.00  
     1st Qu.:41.3     1st Qu.:63.00   1st Qu.:36.90   1st Qu.:77.25  
     Median :43.3     Median :67.00   Median :37.90   Median :78.50  
     Mean   :42.7     Mean   :66.38   Mean   :38.01   Mean   :78.17  
     3rd Qu.:46.0     3rd Qu.:71.00   3rd Qu.:39.50   3rd Qu.:79.00  
     Max.   :49.1     Max.   :78.00   Max.   :41.20   Max.   :79.00  
                                      NA's   :38      NA's   :47     
        ad_cost       
     Min.   :  37500  
     1st Qu.: 185000  
     Median : 850000  
     Mean   :1456712  
     3rd Qu.:2385365  
     Max.   :5000000  
                      



       super_bowl      musician           num_songs     
     Min.   : 1.00   Length:134         Min.   : 1.000  
     1st Qu.:17.25   Class :character   1st Qu.: 1.000  
     Median :31.50   Mode  :character   Median : 2.000  
     Mean   :29.09                      Mean   : 2.955  
     3rd Qu.:41.00                      3rd Qu.: 3.250  
     Max.   :52.00                      Max.   :11.000  
                                        NA's   :46      



```R
run_tests({
    test_that("the sky is blue", {
        expect_true("blue sky" == "blue sky", 
                    info = "Not testing anything.")
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
        current_start_time: 15.18 0.275 660.958 0.005 0
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


## 3. Combined points distribution
<p>In the TV data, the following columns have a lot of missing values:</p>
<ul>
<li><code>total_us_viewers</code> (amount of U.S. viewers who watched at least some part of the broadcast)</li>
<li><code>rating_18_49</code> (average % of U.S. adults 18-49 who live in a household with a TV that were watching for the entire broadcast)</li>
<li><code>share_18_49</code> (average % of U.S. adults 18-49 who live in a household with a TV <em>in use</em> that were watching for the entire broadcast)</li>
</ul>
<p>In halftime musician data, there are missing numbers of songs performed (<code>num_songs</code>) for about a third of the musicians.</p>
<p>There are a lot of potential reasons for missing values. Were the data ever tracked? Would the research effort to fill in the gaps be worth it? Maybe. Watching every Super Bowl halftime show to get song counts could be pretty fun. But we don't have time to do that now -- the Big Game is less than a week away! Let's take note of where the datasets are not perfect and start uncovering some insights.</p>
<p>We'll start by visualizing the distribution of combined points for each Super Bowl. Let's also find the Super Bowls with the highest and lowest scores.</p>


```R
# Reduce the size of the plots
options(repr.plot.width = 5, repr.plot.height = 4)

# Plot a histogram of combined points
ggplot(super_bowls, aes(x = combined_pts)) +
 geom_histogram(binwidth = 5) +
 labs(x = "Combined Points", y = "Number of Super Bowls")

# Display the highest- and lowest-scoring Super Bowls
super_bowls  %>% 
 filter(combined_pts > 70 | combined_pts < 25)
```




<table>
<thead><tr><th scope=col>date</th><th scope=col>super_bowl</th><th scope=col>venue</th><th scope=col>city</th><th scope=col>state</th><th scope=col>attendance</th><th scope=col>team_winner</th><th scope=col>winning_pts</th><th scope=col>qb_winner_1</th><th scope=col>qb_winner_2</th><th scope=col>coach_winner</th><th scope=col>team_loser</th><th scope=col>losing_pts</th><th scope=col>qb_loser_1</th><th scope=col>qb_loser_2</th><th scope=col>coach_loser</th><th scope=col>combined_pts</th><th scope=col>difference_pts</th></tr></thead>
<tbody>
	<tr><td>2018-02-04          </td><td>52                  </td><td>U.S. Bank Stadium   </td><td>Minneapolis         </td><td>Minnesota           </td><td>67612               </td><td>Philadelphia Eagles </td><td>41                  </td><td>Nick Foles          </td><td>NA                  </td><td>Doug Pederson       </td><td>New England Patriots</td><td>33                  </td><td>Tom Brady           </td><td>NA                  </td><td>Bill Belichick      </td><td>74                  </td><td> 8                  </td></tr>
	<tr><td>1995-01-29          </td><td>29                  </td><td>Joe Robbie Stadium  </td><td>Miami Gardens       </td><td>Florida             </td><td>74107               </td><td>San Francisco 49ers </td><td>49                  </td><td>Steve Young         </td><td>NA                  </td><td>George Seifert      </td><td>San Diego Chargers  </td><td>26                  </td><td>Stan Humphreys      </td><td>NA                  </td><td>Bobby Ross          </td><td>75                  </td><td>23                  </td></tr>
	<tr><td>1975-01-12          </td><td> 9                  </td><td>Tulane Stadium      </td><td>New Orleans         </td><td>Louisiana           </td><td>80997               </td><td>Pittsburgh Steelers </td><td>16                  </td><td>Terry Bradshaw      </td><td>NA                  </td><td>Chuck Noll          </td><td>Minnesota Vikings   </td><td> 6                  </td><td>Fran Tarkenton      </td><td>NA                  </td><td>Bud Grant           </td><td>22                  </td><td>10                  </td></tr>
	<tr><td>1973-01-14          </td><td> 7                  </td><td>Memorial Coliseum   </td><td>Los Angeles         </td><td>California          </td><td>90182               </td><td>Miami Dolphins      </td><td>14                  </td><td>Bob Griese          </td><td>NA                  </td><td>Don Shula           </td><td>Washington Redskins </td><td> 7                  </td><td>Bill Kilmer         </td><td>NA                  </td><td>George Allen        </td><td>21                  </td><td> 7                  </td></tr>
	<tr><td>1969-01-12          </td><td> 3                  </td><td>Orange Bowl         </td><td>Miami               </td><td>Florida             </td><td>75389               </td><td>New York Jets       </td><td>16                  </td><td>Joe Namath          </td><td>NA                  </td><td>Weeb Ewbank         </td><td>Baltimore Colts     </td><td> 7                  </td><td>Earl Morrall        </td><td>Johnny Unitas       </td><td>Don Shula           </td><td>23                  </td><td> 9                  </td></tr>
</tbody>
</table>




![png](output_7_2.png)



```R
stud_plot <- last_plot()
soln_plot  <- ggplot(soln_super_bowls, aes(combined_pts)) +
 geom_histogram(binwidth = 5) + 
 labs(x = "Combined Points", y = "Number of Super Bowls")

run_tests({
    test_that("the plot was created correctly", {
        expect_equal(stud_plot, soln_plot, 
                     info = "The historgram of combined points was not created correctly. \nCheck that combined_pts is the aesthetic and the binwidth = 5.")
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
        current_start_time: 15.389 0.275 661.166 0.005 0
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


## 4. Point difference distribution
<p>Most of the combined scores are between 40 and 50 points, with the extremes being roughly equal distance away in opposite directions. At the highest combined scores of 74 and 75, are two games featuring dominant quarterback performances. One happened last year - Super Bowl LII when Tom Brady's Patriots lost to Nick Foles' underdog Eagles 33 to 41, for a combined score of 74.</p>
<p>On the other end of the spectrum, we have Super Bowl III and VII, which featured tough defenses that dominated the games. We also have Super Bowl IX in New Orleans in 1975, whose 16-6 score can be attributed to inclement weather. Overnight rain made the field slick, and it was cold (46 °F / 8 °C), making it hard for the Steelers and Vikings to do much offensively. This was the second-coldest Super Bowl ever and the last to be played in inclement weather for over 30 years. The NFL realized people like points, I guess.</p>
<p>Now let's take a look at the point difference between teams in each Super Bowl.</p>


```R
# Reduce the size of the plots
options(repr.plot.width = 5, repr.plot.height = 4)

# Plot a histogram of point differences
ggplot(super_bowls, aes(x = difference_pts)) +
 geom_histogram(binwidth = 2) +
 labs(x = "Point Difference", y = "Number of Super Bowls")

# Display the closest game and largest blow out
super_bowls  %>% 
 filter(difference_pts == min(difference_pts) | difference_pts == max(difference_pts))
```




<table>
<thead><tr><th scope=col>date</th><th scope=col>super_bowl</th><th scope=col>venue</th><th scope=col>city</th><th scope=col>state</th><th scope=col>attendance</th><th scope=col>team_winner</th><th scope=col>winning_pts</th><th scope=col>qb_winner_1</th><th scope=col>qb_winner_2</th><th scope=col>coach_winner</th><th scope=col>team_loser</th><th scope=col>losing_pts</th><th scope=col>qb_loser_1</th><th scope=col>qb_loser_2</th><th scope=col>coach_loser</th><th scope=col>combined_pts</th><th scope=col>difference_pts</th></tr></thead>
<tbody>
	<tr><td>1991-01-27         </td><td>25                 </td><td>Tampa Stadium      </td><td>Tampa              </td><td>Florida            </td><td>73813              </td><td>New York Giants    </td><td>20                 </td><td>Jeff Hostetler     </td><td>NA                 </td><td>Bill Parcells      </td><td>Buffalo Bills      </td><td>19                 </td><td>Jim Kelly          </td><td>NA                 </td><td>Marv Levy          </td><td>39                 </td><td> 1                 </td></tr>
	<tr><td>1990-01-28         </td><td>24                 </td><td>Louisiana Superdome</td><td>New Orleans        </td><td>Louisiana          </td><td>72919              </td><td>San Francisco 49ers</td><td>55                 </td><td>Joe Montana        </td><td>NA                 </td><td>George Seifert     </td><td>Denver Broncos     </td><td>10                 </td><td>John Elway         </td><td>NA                 </td><td>Dan Reeves         </td><td>65                 </td><td>45                 </td></tr>
</tbody>
</table>




![png](output_10_2.png)



```R
stud_plot <- last_plot()
soln_plot  <- ggplot(soln_super_bowls, aes(difference_pts)) +
 geom_histogram(binwidth = 2) +
 labs(x = "Point Difference", y = "Number of Super Bowls")

run_tests({
    test_that("the plot was created correctly", {
        expect_equal(stud_plot, soln_plot, 
                     info = "The historgram of point differences was not created correctly.\nCheck that difference_pts is the aesthetic and binwidth is correctly set.")
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
        current_start_time: 15.647 0.275 661.423 0.005 0
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


## 5. Do blowouts translate to lost viewers?
<p>The vast majority of Super Bowls are close games. Makes sense. Both teams are the best in their conference if they've made it this far. The closest game ever was the Buffalo Bills' 1-point loss to the New York Giants in 1991, which is best remembered for Scott Norwood's last-second missed field goal attempt that went <em><a href="https://www.youtube.com/watch?v=RPFZCGgjDSg">wide right</a></em>, kicking off four Bills Super Bowl losses in a row. Poor Scott. The biggest point spread so far is 45 points (!) when Hall of Famer, Joe Montana, led the San Francisco 49ers to victory in 1990, one year before the closest game ever.</p>
<p>I remember watching the Seahawks crush the Broncos by 35 points (43-8) in 2014, which sucked to watch in my opinion. The game was never really close. I'm pretty sure we changed the channel at the end of the third quarter. Let's combine the game data and TV data to see if this is a universal phenomenon. Do large point differences translate to lost viewers? We can plot <a href="https://en.wikipedia.org/wiki/Nielsen_ratings">household share</a> <em>(average percentage of U.S. households with a TV in use that were watching for the entire broadcast)</em> vs. point difference to find out.</p>


```R
# Filter out Super Bowl I and join the game data and TV data
games_tv <- tv  %>% 
 filter(super_bowl > 1)  %>% 
 inner_join(super_bowls, by = "super_bowl")

# Create a scatter plot with a linear regression model
ggplot(games_tv, aes(x=difference_pts, y = share_household)) +
 geom_point() +
 geom_smooth(method = "lm") +
 labs(x = "Point Difference", y = "Viewership (household share)")
```




![png](output_13_1.png)



```R
stud_plot <- last_plot()

soln_games_tv <- soln_tv  %>% 
 filter(super_bowl != 1)  %>% 
 inner_join(soln_super_bowls, by = "super_bowl")

soln_plot  <- ggplot(soln_games_tv, aes(difference_pts, share_household)) +
 geom_point() +
 geom_smooth(method = "lm") +
 labs(x = "Point Difference", y = "Viewership (household share)")

run_tests({
    test_that("games_tv was created correctly", {
        expect_equal(games_tv, soln_games_tv, 
                     info = "games_tv was not created correctly. \nCheck that you use "!=" to remove SB one, and joined to super_bowls.")
    })
    test_that("the plot was created correctly", {
        expect_equal(stud_plot, soln_plot, 
                     info = "The scatterplot is not correct.\nCheck the x and y aesthetics and that you used method = 'lm' in geom_smooth().")
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
        current_start_time: 15.913 0.275 661.689 0.005 0
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


## 6. Viewership and the ad industry over time
<p>The downward sloping regression line and the 95% confidence interval for that regression <em>suggest</em> that bailing on the game if it is a blowout is common. Though it matches our intuition, we must take it with a grain of salt because the linear relationship in the data is weak due to our small sample size of 52 games.</p>
<p>Regardless of the score, I bet most people stick it out for the halftime show, which is good news for the TV networks and advertisers. A 30-second spot costs a pretty <a href="https://www.businessinsider.com/super-bowl-commercials-cost-more-than-eagles-quarterback-earns-2018-1">\$5 million</a> now, but has it always been that much? And how has the number of viewers and household ratings trended alongside advertisement cost? We can find out using line plots that share a "Super Bowl" x-axis.</p>


```R
# Convert the data format for plotting
games_tv_plot  <- games_tv %>% 
    gather(key = "category", value = "value", avg_us_viewers, rating_household, ad_cost)  %>% 
    mutate(cat_name = case_when(category == "avg_us_viewers" ~ "Average number of US viewers",
                                category == "rating_household" ~ "Household rating",
                                category == "ad_cost" ~ "Advertisement cost (USD)",
                                TRUE ~ as.character(category)))

# Plot the data
ggplot(games_tv_plot, aes(x=super_bowl, y=value)) +
 geom_line() +
 facet_wrap(~ cat_name, scales = "free", nrow = 3) + 
 labs(x = "Super Bowl", y = "") +
 theme_minimal()
```




![png](output_16_1.png)



```R
stud_plot <- last_plot()

soln_games_tv_plot  <- soln_games_tv %>% 
    gather(key = "category", value = "value", avg_us_viewers, rating_household, ad_cost)  %>% 
    mutate(cat_name = case_when(category == "avg_us_viewers" ~ "Average number of US viewers",
                                category == "rating_household" ~ "Household rating",
                                category == "ad_cost" ~ "Advertisement cost (USD)",
                                TRUE ~ as.character(category)))

soln_plot <- ggplot(soln_games_tv_plot, aes(super_bowl, value)) +
 geom_line() +
 facet_wrap(~ cat_name, scales = "free", nrow = 3) + 
 labs(x = "Super Bowl", y = "") +
 theme_minimal()

run_tests({
    test_that("wide_games_tv was created correctly", {
        expect_equal(games_tv_plot, soln_games_tv_plot, 
                     info = "wide_games_tv was not created correctly. \nYou need to gather the three columns you are going to plot.")
        })
    test_that("the plot was created correctly", {
        expect_equal(stud_plot, soln_plot, 
                     info = "The faceted line plot is not correct.\nCheck the x and y aesthetics and the theme.")
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
        current_start_time: 16.398 0.275 662.174 0.005 0
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


## 7. Halftime shows weren't always this great
<p>We can see that the number of viewers increased before advertisement costs did. Maybe the networks weren't very data savvy and were slow to react? Makes sense since DataCamp didn't exist back then.</p>
<p>Another hypothesis: maybe halftime shows weren't as entertaining in the earlier years? The modern spectacle that is the Super Bowl has a lot to do with of big halftime acts. I went down a YouTube rabbit hole, and it turns out that older halftime shows were not quite the spectacle they are today. Some examples:</p>
<ul>
<li><a href="https://youtu.be/6wMXHxWO4ns?t=263">Super Bowl XXVI</a> in 1992: A Frosty The Snowman rap performed by children.</li>
<li><a href="https://www.youtube.com/watch?v=PKQTL1PYSag">Super Bowl XXIII</a> in 1989: An Elvis impersonator who did magic tricks and didn't even sing one Elvis song.</li>
<li><a href="https://youtu.be/oSXMNbK2e98?t=436">Super Bowl XXI</a> in 1987: Tap dancing ponies. Okay, that was pretty awesome actually.</li>
</ul>
<p>It turns out that Michael Jackson's Super Bowl XXVII performance, one of the most watched events in American TV history, was when the NFL realized that the having big-name halftime acts brought in more viewers. Let's look at the halftime acts before Michael Jackson brought the NFL and entertainment industry together.</p>


```R
# Filter and diplay halftime musicians before and including Super Bowl XXVII
( pre_MJ  <- halftime_musicians  %>% 
 filter(super_bowl <= 27) )
```


<table>
<thead><tr><th scope=col>super_bowl</th><th scope=col>musician</th><th scope=col>num_songs</th></tr></thead>
<tbody>
	<tr><td>27                                                              </td><td>Michael Jackson                                                 </td><td> 5                                                              </td></tr>
	<tr><td>26                                                              </td><td>Gloria Estefan                                                  </td><td> 2                                                              </td></tr>
	<tr><td>26                                                              </td><td>University of Minnesota Marching Band                           </td><td>NA                                                              </td></tr>
	<tr><td>25                                                              </td><td>New Kids on the Block                                           </td><td> 2                                                              </td></tr>
	<tr><td>24                                                              </td><td>Pete Fountain                                                   </td><td> 1                                                              </td></tr>
	<tr><td>24                                                              </td><td>Doug Kershaw                                                    </td><td> 1                                                              </td></tr>
	<tr><td>24                                                              </td><td>Irma Thomas                                                     </td><td> 1                                                              </td></tr>
	<tr><td>24                                                              </td><td>Pride of Nicholls Marching Band                                 </td><td>NA                                                              </td></tr>
	<tr><td>24                                                              </td><td>The Human Jukebox                                               </td><td>NA                                                              </td></tr>
	<tr><td>24                                                              </td><td>Pride of Acadiana                                               </td><td>NA                                                              </td></tr>
	<tr><td>23                                                              </td><td>Elvis Presto                                                    </td><td> 7                                                              </td></tr>
	<tr><td>22                                                              </td><td>Chubby Checker                                                  </td><td> 2                                                              </td></tr>
	<tr><td>22                                                              </td><td>San Diego State University Marching Aztecs                      </td><td>NA                                                              </td></tr>
	<tr><td>22                                                              </td><td>Spirit of Troy                                                  </td><td>NA                                                              </td></tr>
	<tr><td>21                                                              </td><td>Grambling State University Tiger Marching Band                  </td><td> 8                                                              </td></tr>
	<tr><td>21                                                              </td><td>Spirit of Troy                                                  </td><td> 8                                                              </td></tr>
	<tr><td>20                                                              </td><td>Up with People                                                  </td><td>NA                                                              </td></tr>
	<tr><td>19                                                              </td><td>Tops In Blue                                                    </td><td>NA                                                              </td></tr>
	<tr><td>18                                                              </td><td>The University of Florida Fightin' Gator Marching Band          </td><td> 7                                                              </td></tr>
	<tr><td>18                                                              </td><td>The Florida State University Marching Chiefs                    </td><td> 7                                                              </td></tr>
	<tr><td>17                                                              </td><td>Los Angeles Unified School District All City Honor Marching Band</td><td>NA                                                              </td></tr>
	<tr><td>16                                                              </td><td>Up with People                                                  </td><td>NA                                                              </td></tr>
	<tr><td>15                                                              </td><td>The Human Jukebox                                               </td><td>NA                                                              </td></tr>
	<tr><td>15                                                              </td><td>Helen O'Connell                                                 </td><td>NA                                                              </td></tr>
	<tr><td>14                                                              </td><td>Up with People                                                  </td><td>NA                                                              </td></tr>
	<tr><td>14                                                              </td><td>Grambling State University Tiger Marching Band                  </td><td>NA                                                              </td></tr>
	<tr><td>13                                                              </td><td>Ken Hamilton                                                    </td><td>NA                                                              </td></tr>
	<tr><td>13                                                              </td><td>Gramacks                                                        </td><td>NA                                                              </td></tr>
	<tr><td>12                                                              </td><td>Tyler Junior College Apache Band                                </td><td>NA                                                              </td></tr>
	<tr><td>12                                                              </td><td>Pete Fountain                                                   </td><td>NA                                                              </td></tr>
	<tr><td>12                                                              </td><td>Al Hirt                                                         </td><td>NA                                                              </td></tr>
	<tr><td>11                                                              </td><td>Los Angeles Unified School District All City Honor Marching Band</td><td>NA                                                              </td></tr>
	<tr><td>10                                                              </td><td>Up with People                                                  </td><td>NA                                                              </td></tr>
	<tr><td> 9                                                              </td><td>Mercer Ellington                                                </td><td>NA                                                              </td></tr>
	<tr><td> 9                                                              </td><td>Grambling State University Tiger Marching Band                  </td><td>NA                                                              </td></tr>
	<tr><td> 8                                                              </td><td>University of Texas Longhorn Band                               </td><td>NA                                                              </td></tr>
	<tr><td> 8                                                              </td><td>Judy Mallett                                                    </td><td>NA                                                              </td></tr>
	<tr><td> 7                                                              </td><td>University of Michigan Marching Band                            </td><td>NA                                                              </td></tr>
	<tr><td> 7                                                              </td><td>Woody Herman                                                    </td><td>NA                                                              </td></tr>
	<tr><td> 7                                                              </td><td>Andy Williams                                                   </td><td>NA                                                              </td></tr>
	<tr><td> 6                                                              </td><td>Ella Fitzgerald                                                 </td><td>NA                                                              </td></tr>
	<tr><td> 6                                                              </td><td>Carol Channing                                                  </td><td>NA                                                              </td></tr>
	<tr><td> 6                                                              </td><td>Al Hirt                                                         </td><td>NA                                                              </td></tr>
	<tr><td> 6                                                              </td><td>United States Air Force Academy Cadet Chorale                   </td><td>NA                                                              </td></tr>
	<tr><td> 5                                                              </td><td>Southeast Missouri State Marching Band                          </td><td>NA                                                              </td></tr>
	<tr><td> 4                                                              </td><td>Marguerite Piazza                                               </td><td>NA                                                              </td></tr>
	<tr><td> 4                                                              </td><td>Doc Severinsen                                                  </td><td>NA                                                              </td></tr>
	<tr><td> 4                                                              </td><td>Al Hirt                                                         </td><td>NA                                                              </td></tr>
	<tr><td> 4                                                              </td><td>The Human Jukebox                                               </td><td>NA                                                              </td></tr>
	<tr><td> 3                                                                                                          </td><td><span style=white-space:pre-wrap>Florida A&amp;M University Marching 100 Band                        </span></td><td>NA                                                                                                          </td></tr>
	<tr><td> 2                                                              </td><td>Grambling State University Tiger Marching Band                  </td><td>NA                                                              </td></tr>
	<tr><td> 1                                                              </td><td>University of Arizona Symphonic Marching Band                   </td><td>NA                                                              </td></tr>
	<tr><td> 1                                                              </td><td>Grambling State University Tiger Marching Band                  </td><td>NA                                                              </td></tr>
	<tr><td> 1                                                              </td><td>Al Hirt                                                         </td><td>NA                                                              </td></tr>
</tbody>
</table>




```R
soln_pre_MJ  <- soln_halftime_musicians  %>% 
 filter(super_bowl <= 27) 

run_tests({
    test_that("pre_MJ created correctly", {
        expect_equal(pre_MJ, soln_pre_MJ, 
                     info = "pre_MJ was not created correctly. \nCheck that you filtered for super_bowl <= 27.")
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
        current_start_time: 16.511 0.275 662.285 0.005 0
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


## 8. Who has the most halftime show appearances?
<p>Now that's a lot of marching bands! There was also the American jazz clarinetist, Pete Fountain, and Miss Texas 1973 played the violin. Nothing against those performers - they are just simply not <a href="https://www.youtube.com/watch?v=suIg9kTGBVI">Beyoncé</a>. To be fair, no one is.</p>
<p>Let's find all the musicians who performed at the Super Bowl more than once and count their performances.</p>


```R
# Display the musicians who performed more than once
halftime_musicians  %>% 
    count(musician, sort = TRUE)  %>% 
    filter(n > 1) 
    
```


<table>
<thead><tr><th scope=col>musician</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>Grambling State University Tiger Marching Band                  </td><td>6                                                               </td></tr>
	<tr><td>Al Hirt                                                         </td><td>4                                                               </td></tr>
	<tr><td>Up with People                                                  </td><td>4                                                               </td></tr>
	<tr><td>The Human Jukebox                                               </td><td>3                                                               </td></tr>
	<tr><td><span style=white-space:pre-wrap>Beyonc&lt;U+00E9&gt;                                                  </span></td><td>2                                                                                                             </td></tr>
	<tr><td>Bruno Mars                                                      </td><td>2                                                               </td></tr>
	<tr><td><span style=white-space:pre-wrap>Florida A&amp;M University Marching 100 Band                        </span></td><td>2                                                                                                           </td></tr>
	<tr><td>Gloria Estefan                                                  </td><td>2                                                               </td></tr>
	<tr><td>Justin Timberlake                                               </td><td>2                                                               </td></tr>
	<tr><td>Los Angeles Unified School District All City Honor Marching Band</td><td>2                                                               </td></tr>
	<tr><td>Nelly                                                           </td><td>2                                                               </td></tr>
	<tr><td>Pete Fountain                                                   </td><td>2                                                               </td></tr>
	<tr><td>Spirit of Troy                                                  </td><td>2                                                               </td></tr>
	<tr><td>University of Minnesota Marching Band                           </td><td>2                                                               </td></tr>
</tbody>
</table>




```R
out <- .Last.value

soln_test  <- soln_halftime_musicians  %>% 
    count(musician)  %>% 
    filter(n > 1) 
    

run_tests({
    test_that("You found the musicians with more than 1 appearance", {
        expect_equal(out, soln_test, 
                     info = "The display is not correct. \nCheck that you filtered for musicians who appeared more than once, and arranged the counts in descending order.")
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
        current_start_time: 16.552 0.279 662.33 0.005 0
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


## 9. Who performed the most songs in a halftime show?
<p>The world-famous <a href="https://www.youtube.com/watch?v=RL_3oqpHiDg">Grambling State University Tiger Marching Band</a> takes the crown with six appearances. Beyoncé, Justin Timberlake, Nelly, and Bruno Mars are the only post-Y2K musicians with multiple appearances (two each).</p>
<p>Now let's look at the number of songs performed in a halftime show. From our previous inspections, the <code>num_songs</code> column has a lot of missing values:</p>
<ul>
<li>A lot of the marching bands don't have <code>num_songs</code> entries.</li>
<li>For non-marching bands, there is a lot of missing data before Super Bowl XX.</li>
</ul>
<p>Let's filter out marching bands by using a string match for "Marching" and "Spirit" (a common naming convention for marching bands is "Spirit of [something]"). We'll only keep data from Super Bowls XX and later to address the missing data issue, and <em>then</em> let's see who performed the most number of songs.</p>


```R
# Remove marching bands and data before Super Bowl XX
musicians_songs  <- halftime_musicians  %>% 
    filter(!str_detect(musician, "Marching"),
           !str_detect(musician, "Spirit"),
          super_bowl > 20)

# Plot a histogram of the number of songs per performance
ggplot(musicians_songs, aes(x = num_songs)) + 
    geom_histogram(binwidth = 1) +
    labs(x = "Number of songs per halftime show", y = "Number of musicians")

# Display the musicians with more than four songs per show
musicians_songs  %>% 
    filter(num_songs > 4)  %>% 
    arrange(desc(num_songs))
```

    Warning message:
    "Removed 2 rows containing non-finite values (stat_bin)."




<table>
<thead><tr><th scope=col>super_bowl</th><th scope=col>musician</th><th scope=col>num_songs</th></tr></thead>
<tbody>
	<tr><td>52                 </td><td>Justin Timberlake  </td><td>11                 </td></tr>
	<tr><td>30                 </td><td>Diana Ross         </td><td>10                 </td></tr>
	<tr><td>49                 </td><td>Katy Perry         </td><td> 8                 </td></tr>
	<tr><td>51                 </td><td>Lady Gaga          </td><td> 7                 </td></tr>
	<tr><td>47                                                               </td><td><span style=white-space:pre-wrap>Beyonc&lt;U+00E9&gt;     </span></td><td> 7                                                               </td></tr>
	<tr><td>41                 </td><td>Prince             </td><td> 7                 </td></tr>
	<tr><td>23                 </td><td>Elvis Presto       </td><td> 7                 </td></tr>
	<tr><td>50                 </td><td>Coldplay           </td><td> 6                 </td></tr>
	<tr><td>48                 </td><td>Bruno Mars         </td><td> 6                 </td></tr>
	<tr><td>45                 </td><td>The Black Eyed Peas</td><td> 6                 </td></tr>
	<tr><td>46                 </td><td>Madonna            </td><td> 5                 </td></tr>
	<tr><td>44                 </td><td>The Who            </td><td> 5                 </td></tr>
	<tr><td>27                 </td><td>Michael Jackson    </td><td> 5                 </td></tr>
</tbody>
</table>




![png](output_25_3.png)



```R
stud_plot  <-  last_plot()

soln_musicians_songs  <-soln_halftime_musicians  %>% 
    filter(!str_detect(musician, "Marching"),
           !str_detect(musician, "Spirit"),
          super_bowl > 20)

soln_plot <- ggplot(soln_musicians_songs, aes(num_songs)) + 
    geom_histogram(binwidth = 1) +
    labs(x = "Number of songs per halftime show", y = "Number of musicians")

run_tests({
    test_that("musicians_songs is correct", {
        expect_equal(musicians_songs, soln_musicians_songs, 
                     info = "musicians_songs is not correct. \nCheck the filtering.")
    })
    test_that("the histogram is correct", {
        expect_equal(stud_plot, soln_plot, info = "The plot is not correct. Did you use num_songs as the asethetic with a binwidth = 1?")
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
        current_start_time: 16.775 0.279 662.553 0.005 0
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


## 10. Conclusion
<p>Most non-band musicians do 1 to 3 songs per halftime show. It's important to note that the duration of the halftime show is fixed (roughly 12 minutes) so songs per performance is more a measure of how many hit songs you have (cram as many hit songs in as you can!). Timberlake went off in 2018 with 11 songs! Wow! Diana Ross comes in second with a ten song medley in 1996.</p>
<p>In this notebook, we loaded, cleaned, and explored Super Bowl game, television, and halftime show data. We visualized the distributions of combined points, point differences, and halftime show performances using histograms. We used line plots to see how advertisement cost increases lagged behind viewership increases. And, we discovered that blowouts appear to lead to a drop in viewership.</p>
<p>This year's Big Game will be here before you know it. Who do you think will win Super Bowl LIII?</p>


```R
# 2018-2019 conference champions
patriots <-  "New England Patriots"
rams  <- "Los Angeles Rams"

# Who will win Super Bowl LII?
super_bowl_LII_winner  <-  patriots
paste("The winner of Super Bowl LII will be the", super_bowl_LII_winner)
```


'The winner of Super Bowl LII will be the New England Patriots'



```R
run_tests({
    test_that("You found a magical unicorn!", {
        expect_is(patriots, "character")
        expect_is(rams, "character")
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
        current_start_time: 16.853 0.279 662.63 0.005 0
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

