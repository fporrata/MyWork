
## 1. Backscatter - remote sensing in the ocean
<p><img align="right" width="400" height="1000" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_547/img/4167340394_cc0b979fac_b_crop.jpg"> </p>
<p>Reflections. No, I’m not talking about contemplating your existence within the Tidyverse or understanding
what that spline did to your data. I’m talking about echoes. Specifically, sound echoes called “backscatter”. Marine scientists use backscatter to understand the distribution of organisms in the ocean.</p>
<p>In this analysis, we are going to wrangle active acoustic data and plot the mean volume backscatter associated with fish with swim-bladders in relation to bathymetry (depth of the sea floor).</p>
<p>For many marine ecologists, the goal of using active acoustic technologies is to extract biologically relevant quantities from backscatter. What are “biologically relevant quantities,” you ask? Great question! These are data that help us answer the <em>who</em>, <em>what</em>, <em>why</em>, <em>where</em>, <em>when</em>, and <em>how</em> in ecology.</p>
<p>Since World War II, the use of echosounders has allowed scientists to locate and visualize distributions of fish and zooplankton. Echosounders produce sound signals (pings) at specific frequencies and durations that are transmitted into the ocean. When these signals encounter something with a different density than the surrounding water, the signal is reflected back in the direction it came from. Thus, “backscatter”. Backscatter is recorded by the echosounder and useful information is calculated from the received signal, including the position of the source of the scattering (<em>“where”?</em>) and the intensity of the backscatter in decibels (dB) (broadly speaking, the <em>“who/what”?</em>). Active acoustic technologies are a unique remote sensing tool that allows scientists to take an acoustic “snap-shot” of a 3-dimensional environment.   </p>
<p>These acoustic data were collected from a research vessel that crossed the shelf break in the Mid-Atlantic Bight (<a href="https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.ngdc.mgg.wcd:HB1103_EK60">NOAA cruise HB1103</a>) and were preprocessed using the proprietary software, <a href="https://www.echoview.com/">Echoview</a>. </p>


```R
# Load the libraries
library(tidyverse)
library(lubridate)
library(geosphere)
library(gridExtra)

# Read in the depth data
bottom <- read_csv("datasets/bottom_line.csv", col_types = cols(Ping_date = col_date(format = "%m/%d/%Y")))

# Inspect the first six rows
head(bottom)
```


<table>
<thead><tr><th scope=col>Ping_date</th><th scope=col>Ping_time</th><th scope=col>Ping_milliseconds</th><th scope=col>Latitude</th><th scope=col>Longitude</th><th scope=col>Position_status</th><th scope=col>Depth</th><th scope=col>Line_status</th><th scope=col>Ping_status</th><th scope=col>Altitude</th></tr></thead>
<tbody>
	<tr><td>2011-06-18</td><td>09:53:37  </td><td>725       </td><td>999.00000 </td><td>999.00000 </td><td>4         </td><td>68.60377  </td><td>1         </td><td>0         </td><td>-9.9e+37  </td></tr>
	<tr><td>2011-06-18</td><td>09:53:42  </td><td>741       </td><td> 38.29771 </td><td>-74.00185 </td><td>3         </td><td>68.60024  </td><td>1         </td><td>0         </td><td> 0.0e+00  </td></tr>
	<tr><td>2011-06-18</td><td>09:58:47  </td><td>866       </td><td> 38.29429 </td><td>-73.99677 </td><td>1         </td><td>68.78515  </td><td>1         </td><td>0         </td><td> 0.0e+00  </td></tr>
	<tr><td>2011-06-18</td><td>09:58:52  </td><td>866       </td><td> 38.29424 </td><td>-73.99666 </td><td>1         </td><td>68.77859  </td><td>1         </td><td>0         </td><td> 0.0e+00  </td></tr>
	<tr><td>2011-06-18</td><td>09:58:57  </td><td>866       </td><td> 38.29418 </td><td>-73.99653 </td><td>1         </td><td>68.37986  </td><td>1         </td><td>0         </td><td> 0.0e+00  </td></tr>
	<tr><td>2011-06-18</td><td>09:59:02  </td><td>866       </td><td> 38.29411 </td><td>-73.99641 </td><td>1         </td><td>68.37986  </td><td>1         </td><td>0         </td><td> 0.0e+00  </td></tr>
</tbody>
</table>




```R
# These packages need to be loaded in the first @tests cell. 
library(testthat) 
library(IRkernel.testthat)

soln_bottom <- read_csv("datasets/bottom_line.csv", col_types = cols(Ping_date = col_date(format = "%m/%d/%Y")))

run_tests({
    test_that("packages are loaded", {
        expect_true("tidyverse" %in% .packages(), info = "Did you load the tidyverse package?")
        expect_true("lubridate" %in% .packages(), info = "Did you load the lubridate package?")
        expect_true("geosphere" %in% .packages(), info = "Did you load the geosphere package?")
        expect_true("gridExtra" %in% .packages(), info = "Did you load the gridExtra package?")
    })
    
    test_that("bottom data loaded correctly", {
        expect_is(bottom, "tbl_df", info = "Did you read in bottom_line with read_csv?")
        expect_equal(bottom, soln_bottom, info = "bottom contains the wrong values. Did you import the correct .csv file?")
        expect_identical(as.character(bottom$Ping_date[1]), "2011-06-18", info = "Did you use the correct format in col_date()?" )
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
        current_start_time: 24.439 0.381 3406.164 0.005 0
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


## 2. What is the "shelf break"?
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_547/img/map_trkln.png" alt="map_trkln"></p>
<p>The red line in the map above is the ship's track across the shelf break in the Mid-Atlantic Bight. But what is the "shelf break"? The shelf break is the submerged edge of the continental shelf and it is characterized by a steep increase in slope gradients. It’s “The Big Drop-off”. In most marine ecosystems the shelf break is also a highly dynamic and productive area that provides a wide range of habitat for many marine species. The smallest phytoplankton to the largest marine mammals, sharks, seabirds, tunas, and sea turtles - they all utilize this area at some point in their life cycles. And, we’re going to play with some active acoustic data from this amazing region!</p>
<p>But first, let's clean up the bathymetry (depth) data and get it ready for plotting.</p>


```R
# Clean the bottom data
bottom_clean <- bottom %>%
  filter(Position_status == 1) %>% 
  select(Ping_date, Ping_time, Latitude, Longitude, Depth) %>%
  mutate(DT = ymd_hms(paste(Ping_date, Ping_time)),
       dist = c(0,distHaversine(cbind(Longitude[-n()], Latitude[-n()]),
                                cbind(Longitude[ -1], Latitude[ -1]))),                         
       distalong = cumsum(dist),
       t_diff = c(NA, difftime(DT[ -1], DT[-n()], units = "secs")),
       m_per_sec = dist/t_diff)
  
# Inspect the first six rows
head(bottom_clean)
```


<table>
<thead><tr><th scope=col>Ping_date</th><th scope=col>Ping_time</th><th scope=col>Latitude</th><th scope=col>Longitude</th><th scope=col>Depth</th><th scope=col>DT</th><th scope=col>dist</th><th scope=col>distalong</th><th scope=col>t_diff</th><th scope=col>m_per_sec</th></tr></thead>
<tbody>
	<tr><td>2011-06-18         </td><td>09:58:47           </td><td>38.29429           </td><td>-73.99677          </td><td>68.78515           </td><td>2011-06-18 09:58:47</td><td> 0.00000           </td><td> 0.00000           </td><td>NA                 </td><td>      NA           </td></tr>
	<tr><td>2011-06-18         </td><td>09:58:52           </td><td>38.29424           </td><td>-73.99666          </td><td>68.77859           </td><td>2011-06-18 09:58:52</td><td>11.47956           </td><td>11.47956           </td><td> 5                 </td><td>2.295913           </td></tr>
	<tr><td>2011-06-18         </td><td>09:58:57           </td><td>38.29418           </td><td>-73.99653          </td><td>68.37986           </td><td>2011-06-18 09:58:57</td><td>12.77948           </td><td>24.25904           </td><td> 5                 </td><td>2.555895           </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:02           </td><td>38.29411           </td><td>-73.99641          </td><td>68.37986           </td><td>2011-06-18 09:59:02</td><td>13.24406           </td><td>37.50310           </td><td> 5                 </td><td>2.648813           </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:07           </td><td>38.29404           </td><td>-73.99627          </td><td>68.37986           </td><td>2011-06-18 09:59:07</td><td>14.17050           </td><td>51.67360           </td><td> 5                 </td><td>2.834099           </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:12           </td><td>38.29396           </td><td>-73.99612          </td><td>68.38039           </td><td>2011-06-18 09:59:12</td><td>15.34577           </td><td>67.01937           </td><td> 5                 </td><td>3.069153           </td></tr>
</tbody>
</table>




```R
soln_bottom_clean <- bottom %>%
  filter(Position_status == 1)  %>%
  select(Ping_date, Ping_time, Latitude, Longitude, Depth) %>%
  mutate(DT = ymd_hms(paste(Ping_date, Ping_time)),                      
         dist = c(0,distHaversine(cbind(Longitude[-n()], Latitude[-n()]),
                                  cbind(Longitude[ -1], Latitude[ -1]))),                         
         distalong = cumsum(dist),                                         
         t_diff = c(NA, difftime(DT[ -1], DT[-n()], units = "secs")),      
         m_per_sec = dist/t_diff)                                          


run_tests({
    test_that("correct columns were selected", {
        expect_identical(colnames(soln_bottom_clean), colnames(bottom_clean), 
                info = "Did you select the correct columns? Is there a typo?")
    })
    
    test_that("m_per_sec is calculated correctly", {
        expect_identical(round(bottom_clean$m_per_sec[3], 6), 2.555895, info = "Did you divide `dist` by  `t_diff`?")   
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
        current_start_time: 24.548 0.381 3406.274 0.005 0
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


## 3. Where ever you go, there you are
<p>Now that we have removed the bad data points and calculated the cumulative distance the ship traveled, let's plot the data to see if our calculation makes sense. A horizontal view of the ship's track will show us if the ship deviated from the track line or if there were any breaks in the data. A plot of the depth of the sea floor along the track line will show us the position of the shelf break. In a spatial analysis of the track line data, we would normally work in the packages <code>sp</code> and <code>sf</code>, but that's a topic all its own. For now, we'll do a couple track line plots with the latitude, longitude, depth, and distance along the track line.</p>


```R
# Plot a horizontal view of the ship's track line
p_LonLat <- ggplot(bottom_clean, aes(x = Longitude, y = Latitude)) + geom_point()

# View the plot
p_LonLat

# Plot the depth of the sea floor along the track line
p_bthy <- ggplot(bottom_clean, aes(x = distalong, y = Depth)) + geom_point(size = 0.5) + scale_y_reverse() + labs(x = "Distance along trackline (m)", y = "Depth (m)")

# View the plot
p_bthy
```






![png](output_7_2.png)



![png](output_7_3.png)



```R
stud_LonLat <- p_LonLat
stud_bthy <- p_bthy

soln_LonLat <- ggplot(bottom_clean, aes(Longitude, Latitude)) +
                  geom_point()

soln_bthy <- ggplot(bottom_clean, aes(distalong, Depth)) +
                  geom_point(size = 0.5) +
                  scale_y_reverse() +
                  labs(x = "Distance along trackline (m)", y = "Depth (m)")

run_tests({
    test_that("plots are drawn correctly", {
        expect_s3_class(stud_LonLat, "ggplot") 
        expect_identical(stud_LonLat$data, soln_LonLat$data, info = 'The plot data is incorrect. Did you use `bottom_clean`?')
        expect_s3_class(stud_bthy, "ggplot") 
        expect_identical(stud_bthy$data, soln_bthy$data, info = 'The plot data is incorrect. Did you use `bottom_clean`?')
        })
    
    test_that("plots use correct x and y", {    
        expect_identical(deparse(stud_LonLat$mapping$x),deparse(soln_LonLat$mapping$x),
            info = 'The `x` aesthetic in p_LonLat is incorrect. Did you map it to `Longitude`?')      
        expect_identical(deparse(stud_bthy$mapping$x),deparse(soln_bthy$mapping$x),
            info = 'The `x` aesthetic in p_bthy is incorrect. Did you map it to `Longitude`?')  
        expect_identical(deparse(stud_LonLat$mapping$y),deparse(soln_LonLat$mapping$y),
            info = 'The `y` aesthetic in p_LonLat is incorrect. Did you map it to `Latitude`?')      
        expect_identical(deparse(stud_bthy$mapping$x),deparse(soln_bthy$mapping$x),
            info = 'The `y` aesthetic in p_bthy is incorrect. Did you map it to `Latitude`?')  
    })
    
    test_that("correct geoms were used", {
        expect_identical(class(stud_LonLat$layers[[1]]$geom)[1],class(soln_LonLat$layers[[1]]$geom)[1],
            info = 'There is no point layer in p_LonLat. Did you call `geom_point()`?')
        expect_identical(class(stud_bthy$layers[[1]]$geom)[1],class(soln_bthy$layers[[1]]$geom)[1],
            info = 'There is no point layer in p_bthy. Did you call `geom_point()`?')
        })
    
     test_that("the correct size parameter was used", {
        expect_identical(stud_bthy$layers[[1]]$aes_params$size, soln_bthy$layers[[1]]$aes_params$size,
            info = 'The size of the points in p_bthy is incorrect. Did you set `size` to `0.5`?')
         })
    
    test_that("y axis was reversed", {
        expect_lt(ggplot_build(p_bthy)$layout$panel_scales_y[[1]]$range$range[1], 0,
                 label = "Did you reverse the y-axis? See the documentation link in the instructions.")
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
        current_start_time: 25.16 0.382 3406.887 0.005 0
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


## 4. What's the difference?
<p>It looks like the straight track line isn't so straight. Actually, this happens quite often with data collected in this area. There is a lot of fishing gear in the shelf break region of the Mid-Atlantic Bight and sometimes the ship must divert from the track line to avoid it. It is also possible that the GPS signal was lost for a few minutes. Let's find out what the difference is between the straight-line length of the track line (start point to endpoint) and the cumulative distance the ship traveled.</p>
<p>Calculating the difference between the cumulative meters traveled and the straight-line distance of the track line is a common task - a perfect time to create a function to use on other track line data files!</p>


```R
# Create a function to calculate the difference between the cumulative distance the ship traveled 
# and the start and end points of the track line.
distance_diff <- function(bottom_data){
  cumulative_dist <- last(bottom_data$distalong)
  start <- cbind(first(bottom_data$Longitude), first(bottom_data$Latitude))
  end <- cbind(last(bottom_data$Longitude), last(bottom_data$Latitude))
  straight_line_dist <-  distHaversine(start, end)
  return(round(cumulative_dist - straight_line_dist, 1))
}

# Run the `distance_diff` on `bottom_clean`
distance_diff(bottom_clean)
```


513.3



```R
soln_distance_diff <- function(bottom_data){
  cumulative_dist <- last(bottom_data$distalong)
  start <- cbind(first(bottom_data$Longitude), first(bottom_data$Latitude))
  end <- cbind(last(bottom_data$Longitude), last(bottom_data$Latitude))
  straight_line_dist <-  distHaversine(start, end)
  return(round(cumulative_dist - straight_line_dist, 1))
}

dd <- soln_distance_diff(bottom_clean)

run_tests({
    test_that("distance_diff() works on the bottom_clean", {
        expect_is(distance_diff, "function")
        expect_s3_class(bottom_clean, "data.frame")    
        expect_equal(dd, distance_diff(bottom_clean),
            info = "`distance_diff()` does not produce the correct result. 
                    Make sure to use `first()` to get the `start` values and `last()` to get the `end` values." )
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
        current_start_time: 25.228 0.382 3406.955 0.005 0
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


## 5. Here fishy, fishy, fishy...
<p>In the grand scheme of track line diversions, a 513-meter difference isn't too bad. This difference could play a larger or small role in the data analysis depending on the ecological question being asked. For now, we'll keep it in mind as we load, clean, and plot out the acoustic data.</p>
<p>Volume backscatter is the summation of all the returned echoes within the sampling volume. It's a measure of the relative density of organisms. In this case, because we preprocessed the data in <a href="https://www.echoview.com/">Echoview</a> to look for fish-like scattering, our final plot of the volume backscatter data, <code>Sv_mean</code>, will give us an indication of how fish are distributed along the track line.</p>


```R
# Read in the acoustic data
acoustic <- read_csv("datasets/acoustic_LgSBF.csv")

# Glimpse the data
glimpse(acoustic)

# Remove bad positional data
acoustic_clean <- acoustic %>%
  filter(Lon_M != 999)

# Plot a horizontal view of the ship's track line from the acoustic data
ggplot(acoustic_clean, aes(x = Lon_M, y = Lat_M)) + geom_point() 


```

    Parsed with column specification:
    cols(
      .default = col_integer(),
      Sv_mean = col_double(),
      NASC = col_double(),
      Sv_max = col_double(),
      Sv_min = col_double(),
      Sv_noise = col_double(),
      Height_mean = col_double(),
      Depth_mean = col_double(),
      Dist_S = col_double(),
      Dist_E = col_double(),
      Dist_M = col_double(),
      VL_start = col_double(),
      VL_end = col_double(),
      VL_mid = col_double(),
      Time_S = col_time(format = ""),
      Time_E = col_time(format = ""),
      Time_M = col_time(format = ""),
      Lat_S = col_double(),
      Lon_S = col_double(),
      Lat_E = col_double(),
      Lon_E = col_double()
      # ... with 18 more columns
    )
    See spec(...) for full column specifications.


    Observations: 726
    Variables: 78
    $ Process_ID                           <int> 20216, 20216, 20216, 20216, 20...
    $ Interval                             <int> 1, 4, 5, 6, 7, 8, 9, 10, 11, 1...
    $ Layer                                <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    $ Sv_mean                              <dbl> -67.80649, -67.97805, -67.6505...
    $ NASC                                 <dbl> 210.7003, 365.6001, 429.4046, ...
    $ Sv_max                               <dbl> -56.94744, -53.93325, -54.5139...
    $ Sv_min                               <dbl> -77.73801, -88.67275, -87.3610...
    $ Sv_noise                             <dbl> -968.8756, -967.8684, -967.643...
    $ NASC_noise                           <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Height_mean                          <dbl> 29.50000, 53.25000, 58.00000, ...
    $ Depth_mean                           <dbl> 39.50000, 39.04617, 39.00000, ...
    $ Good_samples                         <int> 59, 639, 522, 464, 464, 406, 4...
    $ Layer_depth_min                      <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Layer_depth_max                      <int> 250, 250, 250, 250, 250, 250, ...
    $ Ping_S                               <int> 0, 2, 14, 23, 31, 39, 46, 54, ...
    $ Ping_E                               <int> 1, 13, 22, 30, 38, 45, 53, 60,...
    $ Ping_M                               <int> 0, 7, 18, 26, 34, 42, 49, 57, ...
    $ Dist_S                               <dbl> 0.0000, 609.2889, 804.8728, 10...
    $ Dist_E                               <dbl> 14.25999, 783.86859, 985.75568...
    $ Dist_M                               <dbl> 0.0000, 676.6425, 891.7338, 10...
    $ VL_start                             <dbl> 0.0000, 600.4773, 785.7129, 98...
    $ VL_end                               <dbl> 12.3158, 767.8645, 962.5547, 1...
    $ VL_mid                               <dbl> 0.0000, 664.4884, 869.5859, 10...
    $ Date_S                               <int> 20110618, 20110618, 20110618, ...
    $ Time_S                               <time> 09:53:37, 09:58:47, 09:59:47,...
    $ Date_E                               <int> 20110618, 20110618, 20110618, ...
    $ Time_E                               <time> 09:53:42, 09:59:42, 10:00:27,...
    $ Date_M                               <int> 20110618, 20110618, 20110618, ...
    $ Time_M                               <time> 09:53:37, 09:59:12, 10:00:07,...
    $ Lat_S                                <dbl> 999.00000, 38.29429, 38.29343,...
    $ Lon_S                                <dbl> 999.00000, -73.99677, -73.9948...
    $ Lat_E                                <dbl> 38.29771, 38.29351, 38.29271, ...
    $ Lon_E                                <dbl> -74.00185, -73.99506, -73.9930...
    $ Lat_M                                <dbl> 999.00000, 38.29396, 38.29309,...
    $ Lon_M                                <dbl> 999.00000, -73.99612, -73.9939...
    $ Exclude_below_line_depth_mean        <dbl> 68.60201, 68.43658, 68.25401, ...
    $ Alpha                                <dbl> 0.007856, 0.007856, 0.007856, ...
    $ Gain_constant                        <int> -9999, -9999, -9999, -9999, -9...
    $ Noise_Sv_1m                          <int> -999, -999, -999, -999, -999, ...
    $ Minimum_Sv_threshold_applied         <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    $ Minimum_integration_threshold        <int> -90, -90, -90, -90, -90, -90, ...
    $ Maximum_Sv_threshold_applied         <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Maximum_integration_threshold        <int> 99, 99, 99, 99, 99, 99, 99, 99...
    $ Exclude_above_line_applied           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    $ Exclude_above_line_depth_mean        <int> 10, 10, 10, 10, 10, 10, 10, 10...
    $ Exclude_below_line_applied           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    $ Bottom_offset                        <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Standard_deviation                   <dbl> 3.51318e-07, 3.67224e-07, 3.45...
    $ Skewness                             <dbl> 3.675343, 6.287088, 5.815767, ...
    $ Kurtosis                             <dbl> 14.920100, 50.453991, 45.17382...
    $ ABC                                  <dbl> 4.88847e-06, 8.48232e-06, 9.96...
    $ ABC_noise                            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Area_Backscatter_Strength            <dbl> -53.10827, -50.71486, -50.0162...
    $ Thickness_mean                       <dbl> 29.50000, 53.25000, 58.00000, ...
    $ Range_mean                           <dbl> 33.50000, 33.04617, 33.00000, ...
    $ Exclude_below_line_range_mean        <dbl> 62.60201, 62.43658, 62.25401, ...
    $ Exclude_above_line_range_mean        <int> 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, ...
    $ Bad_data_no_data_samples             <int> 59, 59, 0, 0, 0, 0, 0, 0, 0, 0...
    $ Beam_volume_sum                      <dbl> 693.0895, 7299.0698, 5945.3823...
    $ No_data_samples                      <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ C_good_samples                       <int> 59, 639, 522, 464, 464, 406, 4...
    $ C_bad_data_no_data_samples           <int> 59, 59, 0, 0, 0, 0, 0, 0, 0, 0...
    $ C_no_data_samples                    <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Frequency                            <int> 38, 38, 38, 38, 38, 38, 38, 38...
    $ Grid_reference_line                  <chr> "\"Surface (depth of zero)\"",...
    $ Layer_top_to_reference_line_depth    <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ Layer_top_to_reference_line_range    <int> -6, -6, -6, -6, -6, -6, -6, -6...
    $ Layer_bottom_to_reference_line_depth <int> 250, 250, 250, 250, 250, 250, ...
    $ Layer_bottom_to_reference_line_range <int> 244, 244, 244, 244, 244, 244, ...
    $ Exclude_below_line_depth_min         <dbl> 68.60024, 68.28604, 68.21009, ...
    $ Exclude_below_line_range_min         <dbl> 62.60024, 62.28604, 62.21009, ...
    $ Exclude_below_line_depth_max         <dbl> 68.60377, 68.78515, 68.28604, ...
    $ Exclude_below_line_range_max         <dbl> 62.60377, 62.78515, 62.28604, ...
    $ Samples_Below_Bottom_Exclusion       <int> 362, 2182, 1638, 1456, 1456, 1...
    $ Samples_Above_Surface_Exclusion      <int> 8, 48, 36, 32, 32, 28, 32, 28,...
    $ Samples_In_Domain                    <int> 488, 2928, 2196, 1952, 1952, 1...
    $ Bad_data_empty_water_samples         <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...
    $ C_bad_data_empty_water_samples       <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...





![png](output_13_3.png)



```R
stud_plot <- last_plot()

soln_acoustic <- read_csv("datasets/acoustic_LgSBF.csv")

soln_acoustic_clean <- soln_acoustic %>%
    filter(Lon_M != 999.0)

soln_plot <- ggplot(acoustic_clean, aes(Lon_M, Lat_M)) + 
    geom_point()


run_tests({
    test_that("acoustic data loaded correctly", {
        expect_is(acoustic, "tbl_df", info = "Did you read in 'acoustic_LgSBF.csv` with read_csv?")
        expect_equal(acoustic, soln_acoustic, info = "acoustic contains the wrong values. Did you import the correct .csv file?")
        })
    
    test_that("acoustic data were filtered correctly", {
        expect_equal(nrow(acoustic_clean), 724, info = "acoustic_clean does not have the correct number of rows.")
        }) 
    
    test_that("plot of Longitude and Latitude were plotted correctly", {   
        expect_identical(deparse(stud_plot$mapping$x),deparse(soln_plot$mapping$x),
            info = 'The `x` aesthetic is incorrect. Did you map it to `Lon_M`?')      
        expect_identical(deparse(stud_plot$mapping$y),deparse(soln_plot$mapping$y),
            info = 'The `y` aesthetic is incorrect. Did you map it to `Lat_M`?')      
    })
    
    test_that("correct geoms were used", {
        expect_identical(class(stud_plot$layers[[1]]$geom)[1],class(soln_plot$layers[[1]]$geom)[1],
            info = 'There is no point layer in p_LonLat. Did you call `geom_point()`?')
        })
})

```

    Parsed with column specification:
    cols(
      .default = col_integer(),
      Sv_mean = col_double(),
      NASC = col_double(),
      Sv_max = col_double(),
      Sv_min = col_double(),
      Sv_noise = col_double(),
      Height_mean = col_double(),
      Depth_mean = col_double(),
      Dist_S = col_double(),
      Dist_E = col_double(),
      Dist_M = col_double(),
      VL_start = col_double(),
      VL_end = col_double(),
      VL_mid = col_double(),
      Time_S = col_time(format = ""),
      Time_E = col_time(format = ""),
      Time_M = col_time(format = ""),
      Lat_S = col_double(),
      Lon_S = col_double(),
      Lat_E = col_double(),
      Lon_E = col_double()
      # ... with 18 more columns
    )
    See spec(...) for full column specifications.





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
        current_start_time: 25.633 0.385 3407.366 0.005 0
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


## 6. That's a lot of variables!
<p><strong>Wow! 726 observations of 78 variables!</strong> This is the full data export from Echoview, but remember, we’re only interested in the volume backscatter data, <code>Sv_mean</code>, and the few other variables needed to plot the data. </p>
<p>These backscatter data were integrated into grid cells that are 200 meters along the ship’s path, <code>Interval</code>, by 250 meters deep, <code>Layer</code>, making a coordinate system referenced to the ship’s path and depth. We are going to explore the first depth layer. </p>


```R
# Create a list of variables to keep
vars_keep <- c("Interval", "Layer", "Sv_mean", "Frequency", 
               "Date_M", "Time_S", "Time_E", "Lat_M", "Lon_M")

# Select and filter the data 
Sv_sbf_layer1 <- acoustic_clean %>%
    select(one_of(vars_keep)) %>% 
    rename(intvr_along = Interval) %>%
    filter(Layer == 1)  %>% 
    mutate(DT_S = ymd_hms(paste(ymd(Date_M), Time_S)),
         DT_E = ymd_hms(paste(ymd(Date_M), Time_E)))  %>% 
    arrange(DT_S) 

# Glimpse the cleaned acoustic data
glimpse(Sv_sbf_layer1)
```

    Observations: 362
    Variables: 11
    $ intvr_along <int> 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1...
    $ Layer       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ Sv_mean     <dbl> -67.97805, -67.65053, -66.65866, -68.24425, -69.02423, ...
    $ Frequency   <int> 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38,...
    $ Date_M      <int> 20110618, 20110618, 20110618, 20110618, 20110618, 20110...
    $ Time_S      <time> 09:58:47, 09:59:47, 10:00:32, 10:01:12, 10:01:52, 10:0...
    $ Time_E      <time> 09:59:42, 10:00:27, 10:01:07, 10:01:47, 10:02:22, 10:0...
    $ Lat_M       <dbl> 38.29396, 38.29309, 38.29230, 38.29147, 38.29067, 38.29...
    $ Lon_M       <dbl> -73.99612, -73.99397, -73.99202, -73.98992, -73.98776, ...
    $ DT_S        <dttm> 2011-06-18 09:58:47, 2011-06-18 09:59:47, 2011-06-18 1...
    $ DT_E        <dttm> 2011-06-18 09:59:42, 2011-06-18 10:00:27, 2011-06-18 1...



```R
soln_vars_keep <- c("Interval", "Layer", "Sv_mean", "Frequency", 
               "Date_M", "Time_S", "Time_E", "Lat_M", "Lon_M")
 
soln_Sv_sbf_layer1 <- acoustic_clean %>%
    select(one_of(soln_vars_keep)) %>% 
    rename(intvr_along = Interval) %>%
    filter(Layer == "1")  %>% 
    mutate(DT_S = ymd_hms(paste(ymd(Date_M), Time_S)),
           DT_E = ymd_hms(paste(ymd(Date_M), Time_E)))  %>% 
    arrange(DT_S) 

run_tests({
    test_that("the columns and filter are correct", {
        expect_identical(colnames(soln_Sv_sbf_layer1), colnames(Sv_sbf_layer1), 
                info = "Did you select and rename the columns correctly? Is there a typo?")
        expect_true(all(Sv_sbf_layer1$Layer) == 1, info = "The `Layer` column is not correct. Did you filter for `Layer == 1`?")
    })
    test_that("datetimes were correctly created", {
        expect_identical(soln_Sv_sbf_layer1$DT_S, Sv_sbf_layer1$DT_S, info = "Something isn't correct with DT_S. Did you use `ymd_hms()`?")
        expect_identical(soln_Sv_sbf_layer1$DT_E, Sv_sbf_layer1$DT_E, info = "Something isn't correct with DT_S. Did you use `ymd_hms()`?")
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
        current_start_time: 25.76 0.385 3407.493 0.005 0
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


## 7. A little more wrangling
<p>Great! All this is coming together nicely. In <code>bottom_clean</code> we have depth, distance along the track line, and timestamps. We now also have an almost clean acoustic dataset, <code>Sv_sbf_layer1</code>, with timestamps but no distance along the track line, and no depth information (we'll get to that in a minute). Also, <a href="https://www.echoview.com/">Echoview</a> uses -999.0 to indicate NAs. We need to fix that or our plot will look a little wonky. </p>


```R
# More data wrangling...
Sv_sbf <- Sv_sbf_layer1 %>% 
  mutate(dist_M = c(0, distHaversine(cbind(Lon_M[-n()], Lat_M[-n()]),       
                          cbind(Lon_M[  -1], Lat_M[  -1]))),
       distalong = cumsum(dist_M)) %>%
  na_if(-999.0) %>% 
  mutate(intvr = interval(DT_S, DT_E))

# Glimpse the data
glimpse(Sv_sbf)
```

    Observations: 362
    Variables: 14
    $ intvr_along <int> 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1...
    $ Layer       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ Sv_mean     <dbl> -67.97805, -67.65053, -66.65866, -68.24425, -69.02423, ...
    $ Frequency   <int> 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38,...
    $ Date_M      <int> 20110618, 20110618, 20110618, 20110618, 20110618, 20110...
    $ Time_S      <time> 09:58:47, 09:59:47, 10:00:32, 10:01:12, 10:01:52, 10:0...
    $ Time_E      <time> 09:59:42, 10:00:27, 10:01:07, 10:01:47, 10:02:22, 10:0...
    $ Lat_M       <dbl> 38.29396, 38.29309, 38.29230, 38.29147, 38.29067, 38.29...
    $ Lon_M       <dbl> -73.99612, -73.99397, -73.99202, -73.98992, -73.98776, ...
    $ DT_S        <dttm> 2011-06-18 09:58:47, 2011-06-18 09:59:47, 2011-06-18 1...
    $ DT_E        <dttm> 2011-06-18 09:59:42, 2011-06-18 10:00:27, 2011-06-18 1...
    $ dist_M      <dbl> 0.0000, 211.7871, 192.3324, 204.8778, 209.1278, 183.363...
    $ distalong   <dbl> 0.0000, 211.7871, 404.1196, 608.9974, 818.1252, 1001.48...
    $ intvr       <S4: Interval> 2011-06-18 09:58:47 UTC--2011-06-18 09:59:42 U...



```R
soln_Sv_sbf <- Sv_sbf_layer1 %>% 
    mutate(dist_M = c(0, distHaversine(cbind(Lon_M[-n()], Lat_M[-n()]),       
                                       cbind(Lon_M[  -1], Lat_M[  -1]))),
           distalong = cumsum(dist_M)) %>%
    na_if(-999) %>% 
    mutate(intvr = interval(DT_S, DT_E))

run_tests({
    test_that("all columns are correctly named", {
        expect_equal(colnames(Sv_sbf), colnames(soln_Sv_sbf), info = "Did you use `mutate` to create `dist_M`, `distalong`, and `intvr`?")
    })
    test_that("all -999 changed to NA", {
        expect_equal(sum(Sv_sbf$Sv_mean == -999), 0, info = "Did you use `na_if` to replace all -999 with 'NA'?")
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
        current_start_time: 25.928 0.385 3407.66 0.005 0
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


## 8. Can't go spatial? Go temporal
<p>There is no depth information in the acoustic file. Well, that's not exactly true. One of those 76 variables was a mean depth, but it was an average of an average and it was not as accurate as the depth data we have in <code>bottom_clean</code>. </p>
<p>You might have also noticed that the two data sets have different spatial resolutions. How can we pull the depth data out of <code>bottom_clean</code> and join it with the acoustic data? There are a few different spatial ways to do this, but because we are not working in the spatial packages, we'll write our own function to determine which data points from <code>bottom_clean</code> fall within each along-track <code>Interval</code> by checking to see if the <code>bottom_clean</code> timestamp is <em>within</em> the temporal interval we just created.</p>


```R
# Name the function
getIntervalby_time <- function(bottom_data){
  res <- Sv_sbf$intvr_along[bottom_data %within% Sv_sbf$intvr] 
  if(length(res)==0) return(NA)         # dealing with NAs
  return(res)
}

# Map the track line interval value to the bottom_clean data
bottom_clean_int <- bottom_clean  %>% 
    mutate(trackline_intvr = map_dbl(DT, getIntervalby_time))

# Inpsect the first 15 rows
head(bottom_clean_int, 15)
```


<table>
<thead><tr><th scope=col>Ping_date</th><th scope=col>Ping_time</th><th scope=col>Latitude</th><th scope=col>Longitude</th><th scope=col>Depth</th><th scope=col>DT</th><th scope=col>dist</th><th scope=col>distalong</th><th scope=col>t_diff</th><th scope=col>m_per_sec</th><th scope=col>trackline_intvr</th></tr></thead>
<tbody>
	<tr><td>2011-06-18         </td><td>09:58:47           </td><td>38.29429           </td><td>-73.99677          </td><td>68.78515           </td><td>2011-06-18 09:58:47</td><td> 0.00000           </td><td>  0.00000          </td><td>NA                 </td><td>      NA           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:58:52           </td><td>38.29424           </td><td>-73.99666          </td><td>68.77859           </td><td>2011-06-18 09:58:52</td><td>11.47956           </td><td> 11.47956          </td><td> 5                 </td><td>2.295913           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:58:57           </td><td>38.29418           </td><td>-73.99653          </td><td>68.37986           </td><td>2011-06-18 09:58:57</td><td>12.77948           </td><td> 24.25904          </td><td> 5                 </td><td>2.555895           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:02           </td><td>38.29411           </td><td>-73.99641          </td><td>68.37986           </td><td>2011-06-18 09:59:02</td><td>13.24406           </td><td> 37.50310          </td><td> 5                 </td><td>2.648813           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:07           </td><td>38.29404           </td><td>-73.99627          </td><td>68.37986           </td><td>2011-06-18 09:59:07</td><td>14.17050           </td><td> 51.67360          </td><td> 5                 </td><td>2.834099           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:12           </td><td>38.29396           </td><td>-73.99612          </td><td>68.38039           </td><td>2011-06-18 09:59:12</td><td>15.34577           </td><td> 67.01937          </td><td> 5                 </td><td>3.069153           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:17           </td><td>38.29390           </td><td>-73.99597          </td><td>68.38039           </td><td>2011-06-18 09:59:17</td><td>15.09648           </td><td> 82.11585          </td><td> 5                 </td><td>3.019296           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:22           </td><td>38.29383           </td><td>-73.99582          </td><td>68.37777           </td><td>2011-06-18 09:59:22</td><td>15.72843           </td><td> 97.84428          </td><td> 5                 </td><td>3.145686           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:27           </td><td>38.29375           </td><td>-73.99564          </td><td>68.37777           </td><td>2011-06-18 09:59:27</td><td>18.05774           </td><td>115.90203          </td><td> 5                 </td><td>3.611549           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:32           </td><td>38.29368           </td><td>-73.99545          </td><td>68.44719           </td><td>2011-06-18 09:59:32</td><td>18.00171           </td><td>133.90374          </td><td> 5                 </td><td>3.600343           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:37           </td><td>38.29360           </td><td>-73.99526          </td><td>68.28604           </td><td>2011-06-18 09:59:37</td><td>19.01490           </td><td>152.91864          </td><td> 5                 </td><td>3.802980           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:42           </td><td>38.29351           </td><td>-73.99506          </td><td>68.28604           </td><td>2011-06-18 09:59:42</td><td>19.74884           </td><td>172.66748          </td><td> 5                 </td><td>3.949768           </td><td>4                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:47           </td><td>38.29343           </td><td>-73.99486          </td><td>68.28604           </td><td>2011-06-18 09:59:47</td><td>20.02998           </td><td>192.69746          </td><td> 5                 </td><td>4.005996           </td><td>5                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:52           </td><td>38.29335           </td><td>-73.99464          </td><td>68.26205           </td><td>2011-06-18 09:59:52</td><td>20.51630           </td><td>213.21376          </td><td> 5                 </td><td>4.103261           </td><td>5                  </td></tr>
	<tr><td>2011-06-18         </td><td>09:59:57           </td><td>38.29328           </td><td>-73.99442          </td><td>68.26305           </td><td>2011-06-18 09:59:57</td><td>21.04787           </td><td>234.26163          </td><td> 5                 </td><td>4.209573           </td><td>5                  </td></tr>
</tbody>
</table>




```R
soln_get_Interval_by_time <- function(bottom_data){
  res <- Sv_sbf$intvr_along[bottom_data %within% Sv_sbf$intvr]
  if(length(res)==0) return(NA)         # dealing with NAs
  return(res)
}
 
# Map the track line interval value to the bottom_clean data
soln_bottom_clean_int <- bottom_clean  %>% 
    mutate(trackline_intvr = map_dbl(DT, get_Interval_by_time))

run_tests({
    test_that("the answer is correct", {
    expect_equal(bottom_clean_int, soln_bottom_clean_int, 
        info = "bottom_clean is not correct. Did you use `map_dbl()`?")
    })
    # You can have more than one test
})
```


    Error in mutate_impl(.data, dots): Evaluation error: object 'get_Interval_by_time' not found.
    Traceback:


    1. bottom_clean %>% mutate(trackline_intvr = map_dbl(DT, get_Interval_by_time))

    2. withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))

    3. eval(quote(`_fseq`(`_lhs`)), env, env)

    4. eval(quote(`_fseq`(`_lhs`)), env, env)

    5. `_fseq`(`_lhs`)

    6. freduce(value, `_function_list`)

    7. withVisible(function_list[[k]](value))

    8. function_list[[k]](value)

    9. mutate(., trackline_intvr = map_dbl(DT, get_Interval_by_time))

    10. mutate.tbl_df(., trackline_intvr = map_dbl(DT, get_Interval_by_time))

    11. mutate_impl(.data, dots)


## 9. Depth of an Interval
<p>Now that we have the spatial <code>Interval</code> value assigned to each data point in <code>bottom_clean</code> we can group by the interval value and calculate the mean depth for each along-track Interval.</p>


```R
# Group `bottom_clean` and calculate the mean depth
bottom_intervals <- bottom_clean_int %>% 
  group_by(trackline_intvr) %>% 
  summarize(depth_mean = mean(Depth)) %>% 
  ungroup()

# Inspect the first 6 rows of `bottom_intervals`
head(bottom_intervals, 6)
```


<table>
<thead><tr><th scope=col>trackline_intvr</th><th scope=col>depth_mean</th></tr></thead>
<tbody>
	<tr><td>4       </td><td>68.43658</td></tr>
	<tr><td>5       </td><td>68.25401</td></tr>
	<tr><td>6       </td><td>68.22956</td></tr>
	<tr><td>7       </td><td>68.10563</td></tr>
	<tr><td>8       </td><td>68.14753</td></tr>
	<tr><td>9       </td><td>67.74444</td></tr>
</tbody>
</table>




```R
soln_bottom_intervals <- bottom_clean_int %>%
    group_by(trackline_intvr) %>%
    summarize(depth_mean = mean(Depth)) %>%
    ungroup()

run_tests({
    test_that("the answer is correct", {
    expect_equal(bottom_intervals, soln_bottom_intervals, 
        info = "The data frame is not correct. ")
    })
   
})
```

## 10. Acoustic data, meet Depth data
<p>We're almost ready to plot <code>Sv_mean</code> in relation to the bathymetry (depth) and find out where the fishes are along the track line. But first, the two datasets need to be joined. Unfortunately, at the time of writing, the temporal intervals created in <code>lubridate</code> do not play well with joins. We'll have to remove them for the join to work. Also, remember that we're only looking at the first depth layer (0 to 250 m). Because we do not want to insinuate that we're plotting data integrated over the entire water column, we will replace depths greater than 250 m with 250.</p>


```R
# Join the bottom intervals data to the acoustic data
data_sbf_full <- Sv_sbf %>%
  select(-intvr ) %>%
  left_join(bottom_intervals, by = c("intvr_along" = "trackline_intvr")) %>% 
  mutate(depth_plot = ifelse(depth_mean >= 250 , 250 , depth_mean))

# Glimpse the data 
glimpse(data_sbf_full)
```

    Observations: 362
    Variables: 15
    $ intvr_along <dbl> 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1...
    $ Layer       <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ Sv_mean     <dbl> -67.97805, -67.65053, -66.65866, -68.24425, -69.02423, ...
    $ Frequency   <int> 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38,...
    $ Date_M      <int> 20110618, 20110618, 20110618, 20110618, 20110618, 20110...
    $ Time_S      <time> 09:58:47, 09:59:47, 10:00:32, 10:01:12, 10:01:52, 10:0...
    $ Time_E      <time> 09:59:42, 10:00:27, 10:01:07, 10:01:47, 10:02:22, 10:0...
    $ Lat_M       <dbl> 38.29396, 38.29309, 38.29230, 38.29147, 38.29067, 38.29...
    $ Lon_M       <dbl> -73.99612, -73.99397, -73.99202, -73.98992, -73.98776, ...
    $ DT_S        <dttm> 2011-06-18 09:58:47, 2011-06-18 09:59:47, 2011-06-18 1...
    $ DT_E        <dttm> 2011-06-18 09:59:42, 2011-06-18 10:00:27, 2011-06-18 1...
    $ dist_M      <dbl> 0.0000, 211.7871, 192.3324, 204.8778, 209.1278, 183.363...
    $ distalong   <dbl> 0.0000, 211.7871, 404.1196, 608.9974, 818.1252, 1001.48...
    $ depth_mean  <dbl> 68.43658, 68.25401, 68.22956, 68.10563, 68.14753, 67.74...
    $ depth_plot  <dbl> 68.43658, 68.25401, 68.22956, 68.10563, 68.14753, 67.74...



```R
soln_data_sbf_full <- Sv_sbf %>%
  select(-intvr) %>%
  left_join(bottom_intervals, by = c("intvr_along" = "trackline_intvr")) %>% 
  mutate(depth_plot = ifelse(depth_mean >= 250, 250, depth_mean))

run_tests({
    test_that("the correct column was removed", {
    expect_equal(colnames(data_sbf_full), colnames(soln_data_sbf_full), 
        info = "The column names are incorrect. Did you remove `intvr` and create `depth_plot`?")
        })
    test_that("depth greater than 250 was reset to 250", {
        expect_equal(max(data_sbf_full$depth_plot), 250, 
                     info = "The maximum plot depth is not 250 m. Check the `ifelse()` statement.")
        })     
})
    
#Sv_sbf:
#intvr_along Layer Sv_mean Frequency Date_M Time_S Time_E Lat_M Lon_M DT_S DT_E dist_M distalong intvr
    
#bottom_interval:
#trackline_intvr dpth_mean
```

## 11. Putting it all together
<p>Woohoo! This has been a lot of data wrangling, but we're almost done. It's time to plot out the mean volume backscatter in relation to the bathymetry (depth) along the track line. Because our y-axes are on two different scales, we'll create two plots and use a function from <code>gridExtra</code> to put them in one figure.</p>


```R
# Top panel - assign the Sv plot
Sv_mean_plot <- ggplot(data_sbf_full, aes(x = distalong, y = Sv_mean)) +
  geom_line() +
  labs(y=expression(mean~volume~backscatter~S[v]~(dB))) +
  theme(axis.title.x=element_blank())

# Bottom panel - assign the bathymetry plot
bthy <- ggplot(data_sbf_full, aes(x = distalong, y = depth_plot)) +
  geom_line(size = 0.5) +
  scale_y_reverse() +
  labs(x = "Distance along trackline (m)", y = "Depth (m)")

# Display the two panels in one figure
grid.arrange(Sv_mean_plot, bthy)
```


![png](output_31_0.png)



```R
stud_Sv <- Sv_mean_plot
stud_bthy <- bthy

soln_Sv <- ggplot(data_sbf_full, aes(distalong, Sv_mean)) +
  geom_line() +
  labs(y=expression(mean~volume~backscatter~S[v]~(dB))) +
  theme(axis.title.x=element_blank())

soln_bthy <-ggplot(data_sbf_full, aes(distalong, depth_plot)) +
  geom_line(size = 0.5) +
  scale_y_reverse() +
  labs(x = "Distance along trackline (m)", y = "Depth (m)")

run_tests({
    test_that("plots are drawn correctly", {
        expect_s3_class(stud_Sv, "ggplot") 
        expect_identical(stud_Sv$data, soln_Sv$data, info = 'The plot data is incorrect. Did you use `data_sbf_full`?')
        expect_s3_class(stud_bthy, "ggplot") 
        expect_identical(stud_bthy$data, soln_bthy$data, info = 'The plot data is incorrect. Did you use `data_sbf_full`?')
        })
    
    test_that("plots use correct x and y", {    
        expect_identical(deparse(stud_Sv$mapping$x),deparse(soln_Sv$mapping$x),
            info = 'The `x` aesthetic in Sv_mean_plot is incorrect. Did you map it to `distalong`?')      
        expect_identical(deparse(stud_bthy$mapping$x),deparse(soln_bthy$mapping$x),
            info = 'The `x` aesthetic in bthy is incorrect. Did you map it to `distalong`?')  
        expect_identical(deparse(stud_Sv$mapping$y),deparse(soln_Sv$mapping$y),
            info = 'The `y` aesthetic in Sv_mean_plot is incorrect. Did you map it to `Sv_mean`?')      
        expect_identical(deparse(stud_bthy$mapping$x),deparse(soln_bthy$mapping$x),
            info = 'The `y` aesthetic in bthy is incorrect. Did you map it to `depth_plot`?')  
    })
    
    test_that("correct geoms were used", {
        expect_identical(class(stud_Sv$layers[[1]]$geom)[1],class(soln_Sv$layers[[1]]$geom)[1],
            info = 'There is no line layer in p_LonLat. Did you call `geom_line()`?')
        expect_identical(class(stud_bthy$layers[[1]]$geom)[1],class(soln_bthy$layers[[1]]$geom)[1],
            info = 'There is no line layer in p_bthy. Did you call `geom_line()`?')
        })
    
     test_that("the correct size parameter was used", {
        expect_identical(stud_bthy$layers[[1]]$aes_params$size, soln_bthy$layers[[1]]$aes_params$size,
            info = 'The size of the line in bthy is incorrect. Did you set `size` to `0.5`?')
         })
    
    test_that("y axis was reversed", {
        expect_lt(ggplot_build(p_bthy)$layout$panel_scales_y[[1]]$range$range[1], 0,
                 label = "Did you reverse the y-axis? See the documentation link in the instructions.")
    })
})
   
```

## 12. So, where are the fishes?
<p>Nice looking plot!</p>
<p>If we assume all the backscatter energy is only from fishes with swim bladders, and greater backscatter indicates more fish, where are most of the fish on this track line?</p>


```R
# Where do you think the fish are along this track line?

# Options: Shelf, Shelf Break, Offshore

(where_are_the_fishes <- "Shelf")
```


'Shelf'



```R
# One or more tests of the student's code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("the answer is correct", {
    expect_true(where_are_the_fishes == "Shelf", 
        info = "The Shelf region has the most intense fish-like backscatter.")
    })
    # You can have more than one test
})
```
