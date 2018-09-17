
## 1. Candy Crush Saga
<p><a href="https://king.com/game/candycrush">Candy Crush Saga</a> is a hit mobile game developed by King (part of Activision|Blizzard) that is played by millions of people all around the world. The game is structured as a series of levels where players need to match similar candy together to (hopefully) clear the level and keep progressing on the level map. If you are one of the few that haven't played Candy Crush, here's a short demo:</p>
<p><a href="https://youtu.be/HGLGxnfs_t8"><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_139/img/candy_crush_video.jpeg" alt=""></a></p>
<p>Candy Crush has more than 3000 levels, and new ones are added every week. That is a lot of levels! And with that many levels, it's important to get <em>level difficulty</em> just right. Too easy and the game gets boring, too hard and players become frustrated and quit playing.</p>
<p>In this project, we will see how we can use data collected from players to estimate level difficulty. Let's start by loading in the packages we're going to need.</p>


```R
# This sets the size of plots to a good default.
options(repr.plot.width = 5, repr.plot.height = 4)

# Loading in packages
library(tidyverse)
```



## 2. The data set
<p>The dataset we will use contains one week of data from a sample of players who played Candy Crush back in 2014. The data is also from a single <em>episode</em>, that is, a set of 15 levels. It has the following columns:</p>
<ul>
<li><strong>player_id</strong>: a unique player id</li>
<li><strong>dt</strong>: the date</li>
<li><strong>level</strong>: the level number within the episode, from 1 to 15.</li>
<li><strong>num_attempts</strong>: number of level attempts for the player on that level and date.</li>
<li><strong>num_success</strong>: number of level attempts that resulted in a success/win for the player on that level and date.</li>
</ul>
<p>The granularity of the dataset is player, date, and level. That is, there is a row for every player, day, and level recording the total number of attempts and how many of those resulted in a win.</p>
<p>Now, let's load in the dataset and take a look at the first couple of rows. </p>


```R
# Reading in the data
data <-read_csv("datasets/candy_crush.csv")

# Printing out the first couple of rows
head(data)
```

 <table>
<thead><tr><th scope=col>player_id</th><th scope=col>dt</th><th scope=col>level</th><th scope=col>num_attempts</th><th scope=col>num_success</th></tr></thead>
<tbody>
	<tr><td>6dd5af4c7228fa353d505767143f5815</td><td>2014-01-04                      </td><td> 4                              </td><td>3                               </td><td>1                               </td></tr>
	<tr><td>c7ec97c39349ab7e4d39b4f74062ec13</td><td>2014-01-01                      </td><td> 8                              </td><td>4                               </td><td>1                               </td></tr>
	<tr><td>c7ec97c39349ab7e4d39b4f74062ec13</td><td>2014-01-05                      </td><td>12                              </td><td>6                               </td><td>0                               </td></tr>
	<tr><td>a32c5e9700ed356dc8dd5bb3230c5227</td><td>2014-01-03                      </td><td>11                              </td><td>1                               </td><td>1                               </td></tr>
	<tr><td>a32c5e9700ed356dc8dd5bb3230c5227</td><td>2014-01-07                      </td><td>15                              </td><td>6                               </td><td>0                               </td></tr>
	<tr><td>b94d403ac4edf639442f93eeffdc7d92</td><td>2014-01-01                      </td><td> 8                              </td><td>8                               </td><td>1                               </td></tr>
</tbody>
</table>


## 3. Checking the data set
<p>Now that we have loaded the dataset let's count how many players we have in the sample and how many days worth of data we have.</p>


```R
print("Number of players:")
length(unique(data$player_id))

print("Period for which we have data:")
range(data$dt)
```

    [1] "Number of players:"



6814


    [1] "Period for which we have data:"



<ol class=list-inline>
	<li><time datetime="2014-01-01">2014-01-01</time></li>
	<li><time datetime="2014-01-07">2014-01-07</time></li>
</ol>

## 4. Computing level difficulty
<p>Within each Candy Crush episode, there is a mix of easier and tougher levels. Luck and individual skill make the number of attempts required to pass a level different from player to player. The assumption is that difficult levels require more attempts on average than easier ones. That is, <em>the harder</em> a level is, <em>the lower</em> the probability to pass that level in a single attempt is.</p>
<p>A simple approach to model this probability is as a <a href="https://en.wikipedia.org/wiki/Bernoulli_process">Bernoulli process</a>; as a binary outcome (you either win or lose) characterized by a single parameter <em>p<sub>win</sub></em>: the probability of winning the level in a single attempt. This probability can be estimated for each level as:</p>
<p>![png](4.PNG)</p>
<!-- $$p_{win} = \frac{\sum wins}{\sum attempts}$$ -->
<p>For example, let's say a level has been played 10 times and 2 of those attempts ended up in a victory. Then the probability of winning in a single attempt would be <em>p<sub>win</sub></em> = 2 / 10 = 20%.</p>
<p>Now, let's compute the difficulty <em>p<sub>win</sub></em> separately for each of the 15 levels.</p>


```R
# Calculating level difficulty
difficulty <- data %>% group_by(level) %>% summarise(attempts = sum(num_attempts), wins = sum(num_success)) %>% mutate(p_win = wins/attempts)

# Printing out the level difficulty
difficulty
```


<table>
<thead><tr><th scope=col>level</th><th scope=col>attempts</th><th scope=col>wins</th><th scope=col>p_win</th></tr></thead>
<tbody>
	<tr><td> 1        </td><td> 1322     </td><td> 818      </td><td>0.61875946</td></tr>
	<tr><td> 2        </td><td> 1285     </td><td> 666      </td><td>0.51828794</td></tr>
	<tr><td> 3        </td><td> 1546     </td><td> 662      </td><td>0.42820181</td></tr>
	<tr><td> 4        </td><td> 1893     </td><td> 705      </td><td>0.37242472</td></tr>
	<tr><td> 5        </td><td> 6937     </td><td> 634      </td><td>0.09139397</td></tr>
	<tr><td> 6        </td><td> 1591     </td><td> 668      </td><td>0.41986172</td></tr>
	<tr><td> 7        </td><td> 4526     </td><td> 614      </td><td>0.13566063</td></tr>
	<tr><td> 8        </td><td>15816     </td><td> 641      </td><td>0.04052858</td></tr>
	<tr><td> 9        </td><td> 8241     </td><td> 670      </td><td>0.08130081</td></tr>
	<tr><td>10        </td><td> 3282     </td><td> 617      </td><td>0.18799512</td></tr>
	<tr><td>11        </td><td> 5575     </td><td> 603      </td><td>0.10816143</td></tr>
	<tr><td>12        </td><td> 6868     </td><td> 659      </td><td>0.09595224</td></tr>
	<tr><td>13        </td><td> 1327     </td><td> 686      </td><td>0.51695554</td></tr>
	<tr><td>14        </td><td> 2772     </td><td> 777      </td><td>0.28030303</td></tr>
	<tr><td>15        </td><td>30374     </td><td>1157      </td><td>0.03809179</td></tr>
</tbody>
</table>



## 5. Plotting difficulty profile
<p>![png](5.PNG) </p>
<p>Great! We now have the difficulty for all the 15 levels in the episode. Keep in mind that, as we measure difficulty as the probability to pass a level in a single attempt, a <em>lower</em> value (a smaller probability of winning the level) implies a <em>higher</em> level difficulty.</p>
<p>Now that we have the difficulty of the episode we should plot it. Let's plot a line graph with the levels on the X-axis and the difficulty (<em>p<sub>win</sub></em>) on the Y-axis. We call this plot the <em>difficulty profile</em> of the episode.</p>


```R
# Plotting the level difficulty profile
ggplot(difficulty, aes(x = level, y = p_win)) + geom_line() + scale_x_continuous(breaks = scales::pretty_breaks(n = 15)) + scale_y_continuous(labels = scales::percent)
```




![png](output_13_1.png)

## 6. Spotting hard levels
<p>What constitutes a <em>hard</em> level is subjective. However, to keep things simple, we could define a threshold of difficulty, say 10%, and label levels with <em>p<sub>win</sub></em> &lt; 10% as <em>hard</em>. It's relatively easy to spot these hard levels on the plot, but we can make the plot more friendly by explicitly highlighting the hard levels.</p>


```R
# Adding points and a dashed line
ggplot(difficulty, aes(x = level, y = p_win)) + geom_line() + geom_point() + geom_hline(yintercept = 0.10,linetype="dashed") + scale_x_continuous(breaks = scales::pretty_breaks(n = 15)) + scale_y_continuous(labels = scales::percent)


```




![png](output_16_1.png)


## 7. Computing uncertainty
<p>![png](7_0.PNG) </p>
<p>As Data Scientists we should always report some measure of the uncertainty of any provided numbers. Maybe tomorrow, another sample will give us slightly different values for the difficulties? Here we will simply use the <a href="https://en.wikipedia.org/wiki/Standard_error"><em>Standard error</em></a> as a measure of uncertainty:</p>
<p>![png](7_1.PNG)</p>
<!-- $$
\sigma_{error} \approx \frac{\sigma_{sample}}{\sqrt{n}}
$$ -->
<p>Here <em>n</em> is the number of datapoints and <em>σ<sub>sample</sub></em> is the sample standard deviation. For a Bernoulli process, the sample standard deviation is: </p>
<p>![png](7_2.PNG)</p>
<!-- $$
\sigma_{sample} = \sqrt{p_{win} (1 - p_{win})} 
$$ -->
<p>Therefore, we can calculate the standard error like this:</p>
<p>![png](7_3.PNG)</p>
<!-- $$
\sigma_{error} \approx \sqrt{\frac{p_{win}(1 - p_{win})}{n}}
$$ -->
<p>We already have all we need in the <code>difficulty</code> data frame! Every level has been played <em>n</em> number of times and we have their difficulty <em>p<sub>win</sub></em>. Now, let's calculate the standard error for each level.</p>


```R
# Computing the standard error of p_win for each level
difficulty <- difficulty %>% mutate(error = sqrt(p_win * (1 - p_win) / attempts) )

```

## 8. Showing uncertainty
<p>Now that we have a measure of uncertainty for each levels' difficulty estimate let's use <em>error bars</em> to show this uncertainty in the plot. We will set the length of the error bars to one standard error. The upper limit and the lower limit of each error bar should then be <em>p<sub>win</sub></em> + <em>σ<sub>error</sub></em> and <em>p<sub>win</sub></em> - <em>σ<sub>error</sub></em>, respectively.</p>


```R
# Adding standard error bars
ggplot(difficulty, aes(x = level, y = p_win)) + geom_line() + geom_point() + geom_hline(yintercept = 0.10,linetype="dashed") + scale_x_continuous(breaks = scales::pretty_breaks(n = 15)) + scale_y_continuous(labels = scales::percent) + geom_errorbar(aes(ymin = p_win - error, ymax = p_win + error))
```




![png](output_22_1.png)


## 9. A final metric
<p>It looks like our difficulty estimates are pretty precise! Using this plot, a level designer can quickly spot where the hard levels are and also see if there seems to be too many hard levels in the episode.</p>
<p>One question a level designer might ask is: "How likely is it that a player will complete the episode without losing a single time?" Let's calculate this using the estimated level difficulties!</p>


```R
# The probability of completing the episode without losing a single time
p <-  prod(difficulty$p_win)

# Printing it out
p
```


9.44714093448606e-12


## 10. Should our level designer worry?
<p>Given the probability we just calculated, should our level designer worry about that a lot of players might complete the episode in one attempt?</p>


```R
# Should our level designer worry about that a lot of 
# players will complete the episode in one attempt?
should_the_designer_worry <- FALSE
```

