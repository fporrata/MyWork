
## 1. Athletics needs a new breed of scouts and managers
<p>Athletics goes back to the original Olympics. Since then, little has changed. Athletes compete as individuals, seeking to throw the farthest, jump the farthest (or highest) and run the fastest. But people like cheering for teams, waving banners and yelling like mad during matches, wearing their favorite player's jerseys and staying loyal to their side through thick and thin.  </p>
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_177/img/NAL_Shield_Blue.png" alt=""></p>
<p>What if athletics was a team sport? It could potentially be more interesting and would give us a new set of sports analytics to discuss. We might even reduce the incentives to do unsavory things in the pursuit of <em>altius</em>, <em>fortius</em> and <em>citius</em>.</p>
<p>This dataset contains results from American athletes in the horizontal jumps (triple jump and long jump) and throws (shot put, discus, javelin, hammer and weight). Let's read that in and examine women's javelin.</p>


```R
# Load the tidyverse package
library(tidyverse)

# Import the full dataset
data <- read_csv("datasets/athletics.csv")

unique(data$Event)

# Select the results of interest: women's javelin
javelin <- data %>% filter(Event =='Javelin' & Male_Female == 'Female') %>% select(-c(Male_Female, Event))
 
# Give yourself a snapshot of your data 
head(javelin)
summary(javelin)
```

    Parsed with column specification:
    cols(
      Event = col_character(),
      Male_Female = col_character(),
      EventID = col_integer(),
      Athlete = col_character(),
      Flight1 = col_double(),
      Flight2 = col_double(),
      Flight3 = col_double(),
      Flight4 = col_double(),
      Flight5 = col_double(),
      Flight6 = col_double()
    )



<ol class=list-inline>
	<li>'Shot Put'</li>
	<li>'Weight'</li>
	<li>'Javelin'</li>
	<li>'Discus'</li>
	<li>'Hammer'</li>
</ol>




<table>
<thead><tr><th scope=col>EventID</th><th scope=col>Athlete</th><th scope=col>Flight1</th><th scope=col>Flight2</th><th scope=col>Flight3</th><th scope=col>Flight4</th><th scope=col>Flight5</th><th scope=col>Flight6</th></tr></thead>
<tbody>
	<tr><td>8                 </td><td>Brittany Borman   </td><td>54.02             </td><td>51.21             </td><td>57.31             </td><td>52.57             </td><td>56.97             </td><td>60.91             </td></tr>
	<tr><td>8                 </td><td>Ariana Ince       </td><td>48.97             </td><td>54.85             </td><td>53.58             </td><td>55.13             </td><td>55.27             </td><td>56.66             </td></tr>
	<tr><td>8                 </td><td>Kara Patterson    </td><td>50.14             </td><td>52.10             </td><td> 0.00             </td><td>50.82             </td><td>55.88             </td><td>54.62             </td></tr>
	<tr><td>8                 </td><td>Kimberley Hamilton</td><td>47.96             </td><td> 0.00             </td><td>50.93             </td><td>54.13             </td><td>55.15             </td><td>53.34             </td></tr>
	<tr><td>8                 </td><td>Laura Loht        </td><td>44.40             </td><td>53.78             </td><td>50.56             </td><td>54.15             </td><td> 0.00             </td><td>49.02             </td></tr>
	<tr><td>8                 </td><td>Brianna Bain      </td><td>49.31             </td><td> 0.00             </td><td>51.32             </td><td> 0.00             </td><td>48.64             </td><td>53.05             </td></tr>
</tbody>
</table>




        EventID         Athlete             Flight1         Flight2     
     Min.   :   8.0   Length:178         Min.   : 0.00   Min.   : 0.00  
     1st Qu.: 178.0   Class :character   1st Qu.:41.53   1st Qu.:40.23  
     Median : 511.0   Mode  :character   Median :48.85   Median :48.85  
     Mean   : 796.8                      Mean   :40.80   Mean   :39.87  
     3rd Qu.:1703.0                      3rd Qu.:53.20   3rd Qu.:53.07  
     Max.   :1859.0                      Max.   :64.94   Max.   :61.38  
        Flight3         Flight4         Flight5         Flight6     
     Min.   : 0.00   Min.   : 0.00   Min.   : 0.00   Min.   : 0.00  
     1st Qu.: 0.00   1st Qu.:40.57   1st Qu.: 0.00   1st Qu.: 0.00  
     Median :47.34   Median :49.30   Median :48.01   Median :46.80  
     Mean   :34.22   Mean   :39.37   Mean   :32.97   Mean   :34.82  
     3rd Qu.:52.08   3rd Qu.:52.10   3rd Qu.:51.44   3rd Qu.:52.44  
     Max.   :62.42   Max.   :61.56   Max.   :60.84   Max.   :64.45  



```R
# These packages need to be loaded in the first `@tests` cell. 
library(testthat) 
library(IRkernel.testthat)

correct_data <- read_csv("datasets/athletics.csv")
    correct_javelin <- correct_data %>%
        filter(Male_Female == "Female" & Event == "Javelin") %>%
        select(-Male_Female, -Event)

run_tests({
    test_that("data is correct", {
        expect_equivalent(correct_data, data, 
            info = "datasets/athletics.csv should be read in using read_csv")
    })
    test_that("javelin is correct", {
        expect_equivalent(correct_javelin, javelin, 
            info = "javelin should be female javelin results only, and don't forget to remove the Male_Female and Event columns.")
    })
})
```

    Parsed with column specification:
    cols(
      Event = col_character(),
      Male_Female = col_character(),
      EventID = col_integer(),
      Athlete = col_character(),
      Flight1 = col_double(),
      Flight2 = col_double(),
      Flight3 = col_double(),
      Flight4 = col_double(),
      Flight5 = col_double(),
      Flight6 = col_double()
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
        current_start_time: 13.874 0.371 3076.649 0.003 0.003
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


## 2. Managers love tidy data
<p>This view shows each athlete’s results at individual track meets. Athletes have six throws, but in these meets only one – their longest – actually matters. If all we wanted to do was talk regular track and field, we would have a very easy task: create a new column taking the max of each row, arrange the data frame by that column in descending order and we’d be done.</p>
<p>But our managers need to do and know much more than that! This is a sport of strategy, where every throw matters. Managers need a deeper analysis to choose their teams, craft their plan and make decisions on match-day.</p>
<p>We first need to make this standard “wide” view tidy data. We’re not completely done with the wide view, but the tidy data will allow us to compute our summary statistics. </p>


```R
# Assign the tidy data to javelin_long
javelin_long <- javelin %>% gather(Flight, Distance, -EventID, -Athlete)

# Make Flight a numeric
javelin_long$Flight <- as.numeric(str_replace(javelin_long$Flight, "Flight", ""))

# Examine the first 6 rows
head(javelin_long)
```


<table>
<thead><tr><th scope=col>EventID</th><th scope=col>Athlete</th><th scope=col>Flight</th><th scope=col>Distance</th></tr></thead>
<tbody>
	<tr><td>8                 </td><td>Brittany Borman   </td><td>1                 </td><td>54.02             </td></tr>
	<tr><td>8                 </td><td>Ariana Ince       </td><td>1                 </td><td>48.97             </td></tr>
	<tr><td>8                 </td><td>Kara Patterson    </td><td>1                 </td><td>50.14             </td></tr>
	<tr><td>8                 </td><td>Kimberley Hamilton</td><td>1                 </td><td>47.96             </td></tr>
	<tr><td>8                 </td><td>Laura Loht        </td><td>1                 </td><td>44.40             </td></tr>
	<tr><td>8                 </td><td>Brianna Bain      </td><td>1                 </td><td>49.31             </td></tr>
</tbody>
</table>




```R
correct_javelin_long <- javelin %>%
     gather(Flight1:Flight6, key = "Flight", value="Distance")

correct_javelin_long$Flight = as.numeric(gsub("Flight", "", correct_javelin_long$Flight))

correct_javelin_wide_full <- javelin %>%
    mutate(early = Flight1+Flight2+Flight3, late = Flight4+Flight5+Flight6, diff = late - early)

run_tests({
    test_that("javelin_long is correct", {
        expect_equivalent(correct_javelin_long, javelin_long, 
            info = "Check your gather statement - you want the six `Flight` columns with `Flight` and `Distance` as 
your key:value pair")
    })
    test_that("Flight values are numeric", {
        expect_that(javelin_long$Flight, is_a("numeric"),
        info = "Use `gsub` to remove the word `Flight from each entry in the new `Flight` column, then
convert the values to numeric.")
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
        current_start_time: 13.921 0.371 3076.695 0.003 0.003
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


## 3. Every throw matters
<p>A throw is a foul if the athlete commits a technical violation during the throw. In javelin, the most common foul is stepping over the release line. Traditionally, the throw is scored as an “F” and it has no further significance. Athletes can also choose to pass on a throw – scored as a “P” – if they are content with their earlier throws and want to “save themselves” for later.</p>
<p>Remember when we said every throw matters? Here, the goal is not for each player to have one great throw. All their throws in each event are summed together, and the team with the highest total distance wins the point. Fouls are scored as 0 and passing, well, your manager and teammates would not be pleased.</p>
<p>Here, we examine which athletes cover the most distance in each of their matches, along with two ways to talk about their consistency.</p>


```R
javelin_totals <- javelin_long %>% filter(Distance > 0) %>%
group_by(Athlete, EventID) %>%
summarize(TotalDistance = sum(Distance), StandardDev = round(sd(Distance), 3), Success = n())
 
javelin_totals[10:20,]


```


<table>
<thead><tr><th scope=col>Athlete</th><th scope=col>EventID</th><th scope=col>TotalDistance</th><th scope=col>StandardDev</th><th scope=col>Success</th></tr></thead>
<tbody>
	<tr><td>Allison Updike</td><td> 681          </td><td>146.85        </td><td>3.844         </td><td>3             </td></tr>
	<tr><td>Alyssa Olin   </td><td>1740          </td><td>195.41        </td><td>2.075         </td><td>4             </td></tr>
	<tr><td>Alyssa Olin   </td><td>1859          </td><td>210.08        </td><td>0.971         </td><td>4             </td></tr>
	<tr><td>Ariana Ince   </td><td>   8          </td><td>324.46        </td><td>2.688         </td><td>6             </td></tr>
	<tr><td>Ariana Ince   </td><td> 238          </td><td>276.39        </td><td>3.076         </td><td>5             </td></tr>
	<tr><td>Ariana Ince   </td><td> 498          </td><td>255.40        </td><td>0.933         </td><td>5             </td></tr>
	<tr><td>Ariana Ince   </td><td> 511          </td><td>332.87        </td><td>2.775         </td><td>6             </td></tr>
	<tr><td>Ariana Ince   </td><td> 747          </td><td>229.75        </td><td>0.724         </td><td>4             </td></tr>
	<tr><td>Ariana Ince   </td><td> 815          </td><td>270.23        </td><td>2.538         </td><td>5             </td></tr>
	<tr><td>Ariana Ince   </td><td>1566          </td><td>225.14        </td><td>2.544         </td><td>4             </td></tr>
	<tr><td>Ariana Ince   </td><td>1575          </td><td>230.57        </td><td>1.517         </td><td>4             </td></tr>
</tbody>
</table>




```R
correct_javelin_totals <- javelin_long %>%
     filter(Distance > 0) %>%
     group_by(Athlete, EventID) %>% 
     summarize(TotalDistance = sum(Distance), StandardDev = round(sd(Distance),3), Success = n())

run_tests({
    test_that("javelin_long contains correct athletes and results", {
        expect_equivalent(javelin_totals$Athlete, correct_javelin_totals$Athlete, 
        info = "Did you filter by `Distance` so you only have results greater than zero?")
    })
    
    test_that("summarize values are correct", {
        expect_true(all(c("TotalDistance", "StandardDev", "Success") %in% names(javelin_totals)) &
                    all(javelin_totals$StandardDev %in% correct_javelin_totals$StandardDev),
            info = "Did you correctly define `TotalDistance`, `StandardDev` and `Success` in a `summarize` statement?
    Be sure to wrap your `sd()` function in `round()` and round to 3 places for `StandardDev`.")
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
        current_start_time: 13.967 0.371 3076.741 0.003 0.003
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


## 4. Find the clutch performers
<p>In many traditional track meets, after the first three throws the leaders in the field are whittled down to the top eight (sometimes more, sometimes less) athletes. Like the meet overall, this is solely based on their best throw of those first three. </p>
<p>We give the choice to the managers. Of the three athletes who start each event, the manager chooses the two who will continue on for the last three throws. The manager will need to know which players tend to come alive – or at least maintain their form – in the late stages of a match. They also need to know if a player’s first three throws are consistent with their playing history. Otherwise, they could make a poor decision about who stays in based only on the sample unfolding in front of them.</p>
<p>For now, let’s examine just our top-line stat – total distance covered – for differences between early and late stages of the match.</p>


```R
javelin <- javelin %>% mutate(early = Flight1 + Flight2 + Flight3,
                              late = Flight4 + Flight5 + Flight6,
                               diff = late - early)


# Examine the last ten rows
tail(javelin, 10)
```


<table>
<thead><tr><th scope=col>EventID</th><th scope=col>Athlete</th><th scope=col>Flight1</th><th scope=col>Flight2</th><th scope=col>Flight3</th><th scope=col>Flight4</th><th scope=col>Flight5</th><th scope=col>Flight6</th><th scope=col>early</th><th scope=col>late</th><th scope=col>diff</th></tr></thead>
<tbody>
	<tr><td>1773                  </td><td>Melissa Fraser        </td><td>47.62                 </td><td>48.68                 </td><td>47.52                 </td><td> 0.00                 </td><td> 0.00                 </td><td>45.61                 </td><td>143.82                </td><td> 45.61                </td><td> -98.21               </td></tr>
	<tr><td>1773                  </td><td>Kaelyn Carlson-Shipley</td><td>43.39                 </td><td>44.90                 </td><td>40.00                 </td><td>43.17                 </td><td>40.29                 </td><td>40.58                 </td><td>128.29                </td><td>124.04                </td><td>  -4.25               </td></tr>
	<tr><td>1859                  </td><td>Kara Winger           </td><td>56.89                 </td><td>52.93                 </td><td>55.48                 </td><td>54.45                 </td><td>57.59                 </td><td>62.88                 </td><td>165.30                </td><td>174.92                </td><td>   9.62               </td></tr>
	<tr><td>1859                  </td><td>Avione Allgood        </td><td>56.54                 </td><td> 0.00                 </td><td>54.39                 </td><td>51.61                 </td><td>54.32                 </td><td> 0.00                 </td><td>110.93                </td><td>105.93                </td><td>  -5.00               </td></tr>
	<tr><td>1859                  </td><td>Ariana Ince           </td><td>51.93                 </td><td>53.46                 </td><td>52.45                 </td><td>55.97                 </td><td>55.18                 </td><td> 0.00                 </td><td>157.84                </td><td>111.15                </td><td> -46.69               </td></tr>
	<tr><td>1859                  </td><td>Bethany Drake         </td><td>49.88                 </td><td>51.02                 </td><td>54.20                 </td><td> 0.00                 </td><td>50.59                 </td><td> 0.00                 </td><td>155.10                </td><td> 50.59                </td><td>-104.51               </td></tr>
	<tr><td>1859                  </td><td>Alyssa Olin           </td><td> 0.00                 </td><td>53.74                 </td><td>52.08                 </td><td>51.48                 </td><td> 0.00                 </td><td>52.78                 </td><td>105.82                </td><td>104.26                </td><td>  -1.56               </td></tr>
	<tr><td>1859                  </td><td>Dominique Ouellette   </td><td>49.60                 </td><td>44.22                 </td><td>50.60                 </td><td>51.26                 </td><td>49.25                 </td><td>53.17                 </td><td>144.42                </td><td>153.68                </td><td>   9.26               </td></tr>
	<tr><td>1859                  </td><td>Kristen Clark         </td><td>47.18                 </td><td>50.93                 </td><td> 0.00                 </td><td>48.17                 </td><td>49.27                 </td><td>49.61                 </td><td> 98.11                </td><td>147.05                </td><td>  48.94               </td></tr>
	<tr><td>1859                  </td><td>Rebekah Wales         </td><td>48.83                 </td><td> 0.00                 </td><td>50.38                 </td><td>48.23                 </td><td> 0.00                 </td><td>46.65                 </td><td> 99.21                </td><td> 94.88                </td><td>  -4.33               </td></tr>
</tbody>
</table>




```R
last_value <- .Last.value 

run_tests({
    test_that("diff column is properly created and defined", {
    expect_equal(javelin[-5], correct_javelin_wide_full[-5],
        info = "Make sure `early` is the sum of the first three flights, `late` is the sum of the latter three flights, and 
   `diff` is `early` subtracted from `late`.")
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
        current_start_time: 14.004 0.371 3076.777 0.003 0.003
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


## 5. Pull the pieces together for a new look at the athletes
<p>The aggregate stats are in two data frame. By joining the two together, we can take our first rough look at how the athletes compare.</p>


```R
javelin_totals <- javelin %>% left_join(javelin_totals, by = c("EventID", "Athlete")) %>%
                  select(Athlete, TotalDistance, StandardDev, Success, diff)

# Examine the first ten rows
head(javelin_totals, 10)
```


<table>
<thead><tr><th scope=col>Athlete</th><th scope=col>TotalDistance</th><th scope=col>StandardDev</th><th scope=col>Success</th><th scope=col>diff</th></tr></thead>
<tbody>
	<tr><td>Brittany Borman   </td><td>332.99            </td><td>3.574             </td><td>6                 </td><td>   7.91           </td></tr>
	<tr><td>Ariana Ince       </td><td>324.46            </td><td>2.688             </td><td>6                 </td><td>   9.66           </td></tr>
	<tr><td>Kara Patterson    </td><td>263.56            </td><td>2.462             </td><td>5                 </td><td>  59.08           </td></tr>
	<tr><td>Kimberley Hamilton</td><td>261.51            </td><td>2.884             </td><td>5                 </td><td>  63.73           </td></tr>
	<tr><td>Laura Loht        </td><td>251.91            </td><td>3.982             </td><td>5                 </td><td> -45.57           </td></tr>
	<tr><td>Brianna Bain      </td><td>202.32            </td><td>2.002             </td><td>4                 </td><td>   1.06           </td></tr>
	<tr><td>Paige Blackburn   </td><td>152.73            </td><td>2.085             </td><td>3                 </td><td> -55.13           </td></tr>
	<tr><td>Heather Bergmann  </td><td>283.43            </td><td>2.278             </td><td>6                 </td><td>   2.41           </td></tr>
	<tr><td>Kara Patterson    </td><td>360.74            </td><td>2.119             </td><td>6                 </td><td>   2.98           </td></tr>
	<tr><td>Brittany Borman   </td><td>237.56            </td><td>2.313             </td><td>4                 </td><td>-116.52           </td></tr>
</tbody>
</table>




```R
correct_javelin_totals <- correct_javelin_totals %>%
    left_join(javelin, by=c("EventID", "Athlete")) %>%
    select(1, 3:5, 14)

run_tests({
    
    test_that("Correct columns are in the new data frame",{
        expect_true(all(c("Athlete", "TotalDistance", "StandardDev", "Success", "diff") %in% names(javelin_totals)),
                   info = "Double check the columns you selected after performing the left join.")
    })
    
    test_that("Athletes and events are grouped correctly", {
    expect_equivalent(javelin_totals, correct_javelin_totals, 
        info = "Remember to start with `javelin_totals`, then `left_join` by `EventID` and `Athlete`")
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
        current_start_time: 14.046 0.371 3076.818 0.003 0.003
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


## 6. Normalize the data to compare across stats
<p>The four summary statistics - total distance, standard deviation, number of successful throws and our measure of early vs. late - are on different scales and measure very different things. Managers need to be able to compare these to each other and then weigh them based on what is most important to their vision and strategy for the team. A simple normalization will allow for these comparisons.</p>


```R
norm <- function(result) {
    (result - min(result)) / (max(result) - min(result))
}
aggstats <- c("TotalDistance", "StandardDev", "Success", "diff")
javelin_norm <- javelin_totals %>%
 ungroup() %>%
mutate_at(aggstats, norm) %>% group_by(Athlete) %>%
summarize_all(mean) 
head(javelin_norm)
```


<table>
<thead><tr><th scope=col>Athlete</th><th scope=col>TotalDistance</th><th scope=col>StandardDev</th><th scope=col>Success</th><th scope=col>diff</th></tr></thead>
<tbody>
	<tr><td>Abigail Gomez          </td><td>0.4459534              </td><td>0.2678973              </td><td>0.4500000              </td><td>0.3828542              </td></tr>
	<tr><td>Abigail Gomez Hernandez</td><td>0.2439924              </td><td>0.1146165              </td><td>0.2500000              </td><td>0.7195185              </td></tr>
	<tr><td>Alicia DeShasier       </td><td>0.7529941              </td><td>0.3267327              </td><td>0.8333333              </td><td>0.6870598              </td></tr>
	<tr><td>Allison Updike         </td><td>0.2831123              </td><td>0.6392012              </td><td>0.2500000              </td><td>0.3203585              </td></tr>
	<tr><td>Alyssa Olin            </td><td>0.4688902              </td><td>0.2497063              </td><td>0.5000000              </td><td>0.3089929              </td></tr>
	<tr><td>Ariana Ince            </td><td>0.6602443              </td><td>0.3419779              </td><td>0.6923077              </td><td>0.4460812              </td></tr>
</tbody>
</table>




```R
correct_javelin_norm <- correct_javelin_totals %>%
 ungroup() %>%
 mutate_at(aggstats, norm) %>%
 group_by(Athlete) %>%
 summarize_all(mean)

run_tests({
    test_that("norm is properly defined as a function", {
        expect_that(norm, is_a("function"), info="Take a look at how you defined the function `norm.`")
    })
    test_that("data is correctly normalized", {
    expect_equivalent(correct_javelin_norm, javelin_norm, 
        info = "Use `mutate_at` to compute the function `norm` over the `aggstats` vector. Then check to make sure
you grouped by `Athlete` and took the mean across all columns.")
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
        current_start_time: 14.093 0.371 3076.865 0.003 0.003
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


## 7. What matters most when building your squad?
<p>Managers have to decide what kind of players they want on their team - who matches their vision, who has the skills they need to play their style of athletics and - ultimately - who will deliver the wins. A risk-averse manager will want players who rarely foul. The steely-eyed manager will want the players who can deliver the win with their final throws. </p>
<p>Like any other sport (or profession), rarely will any one player be equally strong in all areas. Managers have to make trade-offs in selecting their teams. Our first batch of managers have the added disadvantage of selecting players based on data from a related but distinct sport. Our data comes from traditional track and field meets, where the motivations and goals are much different than our own. </p>
<p>This is why managers make the big money and get sacked when results go south.</p>


```R
weights <- c(3, 2, 4, 1)
javelin_team <- javelin_norm %>%
                mutate(TotalScore = TotalDistance * weights[1] + StandardDev * weights[2]+  Success * weights[3] + diff * weights[4])  %>% 
                arrange(desc(TotalScore)) %>% select(Athlete, TotalScore) %>% top_n(5)

javelin_team
```

    Selecting by TotalScore



<table>
<thead><tr><th scope=col>Athlete</th><th scope=col>TotalScore</th></tr></thead>
<tbody>
	<tr><td>Madalaine Stulce     </td><td>8.108372             </td></tr>
	<tr><td>Dominique Ouellette  </td><td>7.862795             </td></tr>
	<tr><td>Heather Bergmann     </td><td>7.496688             </td></tr>
	<tr><td>Diana Sammai Martinez</td><td>7.356566             </td></tr>
	<tr><td>Rebecka Anderson     </td><td>7.205920             </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("weights sum to 10", {
    expect_equal(sum(weights), 10, 
        info = "Uh oh! Do your weights add up to 10?")
    })

    test_that("players are arranged in descending order",{
        expect_true(javelin_team$TotalScore[1] > javelin_team$TotalScore[5], 
         info = "Make sure you `arrange` the data frame in descending order to get the 5 best players!")
    })
    
    test_that("student selects top 5 athletes", {
    expect_equal(nrow(javelin_team), 5, 
        info = "Check your slice call to take only the top 5 players.")
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
        current_start_time: 14.13 0.371 3076.901 0.003 0.003
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


## 8. Get to know your players
<p>The data has spoken! Now we have our five javelin throwers but we still don’t really know them. The <code>javelin_totals</code> data frame has the data that went into the decision process, so we will pull that up. This gives us an idea of what they each bring to the team. </p>
<p>We can also take a look at how they compare to the pool of athletes we started from by taking the mean and maximum of each statistic.</p>


```R
team_stats <- javelin_totals %>% 
              filter(Athlete %in% c("Madalaine Stulce", "Dominique Ouellette" , "Heather Bergmann", "Diana Sammai Martinez", "Rebecka Anderson"))%>% 
              group_by(Athlete) %>%
              summarize_all(mean)


pool_stats <- data.frame(do.call('cbind', sapply(javelin_totals, function(x) if(is.numeric(x)) c(max(x), mean(x)))))
pool_stats$MaxAve <- c("Maximum", "Average")
pool_stats <- pool_stats %>%
    gather(key="Statistic", value="Aggregate", -MaxAve)
                                                 
# Examine team stats
team_stats
    
  
```


<table>
<thead><tr><th scope=col>Athlete</th><th scope=col>TotalDistance</th><th scope=col>StandardDev</th><th scope=col>Success</th><th scope=col>diff</th></tr></thead>
<tbody>
	<tr><td>Diana Sammai Martinez</td><td>262.000              </td><td>2.3750               </td><td>6                    </td><td>11.880               </td></tr>
	<tr><td>Dominique Ouellette  </td><td>298.655              </td><td>2.9105               </td><td>6                    </td><td> 2.875               </td></tr>
	<tr><td>Heather Bergmann     </td><td>283.430              </td><td>2.2780               </td><td>6                    </td><td> 2.410               </td></tr>
	<tr><td>Madalaine Stulce     </td><td>274.760              </td><td>4.4720               </td><td>6                    </td><td>-6.420               </td></tr>
	<tr><td>Rebecka Anderson     </td><td>259.150              </td><td>2.0690               </td><td>6                    </td><td> 7.370               </td></tr>
</tbody>
</table>




```R
correct_team_stats <- correct_javelin_totals %>% 
 filter(Athlete %in% javelin_team$Athlete) %>% 
 summarize_all(mean) 

run_tests({
    test_that("correct athletes are selected", {
    expect_equivalent(correct_team_stats, team_stats, 
        info = "Did you filter the `javelin_totals` data frame for those athletes who are `%in%` your team?")
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
        current_start_time: 14.178 0.371 3076.949 0.003 0.003
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


## 9. Make your case to the front office
<p>The manager knows what she wants out of the team and has the data to support her choices, but she still needs to defend her decisions to the team owners. They do write the checks, after all. </p>
<p>The owners are busy people. Many of them work other jobs and own other companies. They trust their managers, so as long the manager can give them an easy-to-digest visual presentation of why they should sign these five athletes out of all the others, they will approve.</p>
<p>A series of plots showing how each athlete compares to the maximum and the average of each statistic will be enough for them.</p>


```R
p <- team_stats %>% gather(Statistic, Aggregate, -Athlete) %>%
     ggplot(aes(x = Athlete, y = Aggregate, fill = Athlete)) +
     geom_bar(stat="identity") +
  facet_wrap(~Statistic, 2, 2, scales="free_y") +
  geom_hline(data=pool_stats, aes(yintercept=Aggregate, group=Statistic, color=MaxAve), size=1) +
  labs(title="Team Porrata: Women's Javelin", color="Athlete pool maximum / average") +
  scale_fill_hue(l=70) +
  scale_color_hue(l=20) +
  theme_minimal() +
  theme(axis.text.x=element_blank(), axis.title.x=element_blank(), axis.title.y=element_blank())
  
p
```




![png](output_25_1.png)



```R
last <- last_plot()
facet_class <- class(last_plot()$facet)

run_tests({
     test_that("The plot is faceted into 2 x 2 grid", {
    expect_true(! "FacetNull" %in% facet_class, 
        info = "Use `facet_wrap` to create a 2 x 2 grid based on `Statistic.`")
    })
    
    test_that("correct columns are plotted", {
    mappings <- str_replace(as.character(last$mapping), "~", "")
    expect_true(all(c("Athlete", "Aggregate") %in% mappings), 
        info = "Check your key:value pair in the gather statement and then your aesthetics in the 
        ggplot statement. You should have `Athlete` for two aesthetics and `Aggregate` - your 'value' for the other.")
    })
    
    test_that("plot is a bar graph", {
    expect_true( "GeomBar" %in% class(last$layers[[1]]$geom), 
        info = "Did you include a `geom_bar` to create a bar plot?")
    })

# Reason for deleting: it seems that the task won't be validated unless nrow and ncol are specified whish isn't necessary in practice
#     test_that("Plots are displayed in two rows", {
#     expect_true(p$facet$params$ncol == 2 & p$facet$params$nrow == 2, 
#         info = "Use `nrow` and `ncol` in `facet_wrap` to create a 2x2 display of your plots.")
#     })
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
        current_start_time: 14.804 0.371 3077.574 0.003 0.003
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


## 10. Time to throw down
<p>Before the athletics season opens, the manager will perform similar analyses for the other throws, the jumps, and running events. Then you'll game out different permutations of your team and your opponent to come up with the best lineup and make the best decisions on match day. For now, since it's what we know best and we're almost out of time, let's simulate a simple javelin match. </p>
<p>The winner is the team that throws the highest combined distance: six throws from each of your three players against six throws from each of the opponent's three players.</p>


```R
home <- c(2,3,5)
away <- sample(1:nrow(javelin_totals), 3, replace=FALSE)

HomeTeam <- round(sum(team_stats$TotalDistance[home]),2)
AwayTeam <- round(sum(javelin_totals$TotalDistance[away]),2)

print(paste0("Javelin match, Final Score: ", HomeTeam, " - ", AwayTeam))
ifelse(HomeTeam > AwayTeam, print("Win!"), print("Sometimes you just have to take the L."))
```

    [1] "Javelin match, Final Score: 841.23 - 572.8"
    [1] "Win!"



'Win!'



```R
run_tests({
     test_that("digits within range are chosen for home", {
         expect_equal(sum(home > 5), 0, info="Make sure you place three digits between 1 and 5 in `home`.")
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
        current_start_time: 14.845 0.371 3077.614 0.003 0.003
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

