
## 1. Import and explore data
<p><em>Warning: the dataset in this project contains explicit language.</em></p>

![jpg(southpark.png)

<p><a href="https://en.m.wikipedia.org/wiki/South_Park">South Park</a> is a satiric American TV show. It is an adult show mainly because of its coarse language. I know every episode pretty well, but I wanted to see if I can dig up something more using text analysis.</p>
<p>That's what we will focus on. We will see how the sentiments and the popularity of episodes evolve over time. We will examine the <strong>swear words</strong> and their ratio across episodes. We will also answer some questions about the show. Do you think that naughtier episodes tend to be more popular? Is Eric Cartman, the main face of the show, really the naughtiest character? We will have answers to these and more questions soon enough.</p>
<p>We will be using two datasets. One that contains every line spoken in all the 287 episodes (first 21 seasons) of the show and another that contains mean episode ratings from <a href="https://www.imdb.com/title/tt0121955">IMDB</a>. We will be joining, summarizing and visualizing until we've answered all our questions.</p>
<p>Our best friends will be the <strong>tidyverse</strong>, <strong>tidytext</strong>, and <strong>ggplot2</strong> packages. Let's not waste any more time and get to it. We'll start slowly by loading all necessary libraries and both of the datasets.</p>


```R
# Load libraries
library(tidyverse)
library(tidytext)
library(SnowballC)
library(sweary)
library(broom)

# Load datasets
sp_lines <- read_csv("datasets/sp_lines.csv")
sp_ratings <- read_csv("datasets/sp_ratings.csv")

# Take a look at the last few observations
tail(sp_lines)
tail(sp_ratings)
```

<table>
<thead><tr><th scope=col>character</th><th scope=col>text</th><th scope=col>episode_name</th><th scope=col>season_number</th><th scope=col>episode_number</th></tr></thead>
<tbody>
	<tr><td>officer bright                                          </td><td>he broke free                                           </td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
	<tr><td>jimbo                                                   </td><td>the president is on the loose again                     </td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
	<tr><td>officer bright                                          </td><td>he'll be even more desperate now it's going to get worse</td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
	<tr><td>stan                                                    </td><td>we can't destroy him can we                             </td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
	<tr><td>randy                                                   </td><td>i don't know i guess it's up to the whites              </td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
	<tr><td>end of splatty tomato                                   </td><td>end of splatty tomato                                   </td><td>Splatty Tomato                                          </td><td>21                                                      </td><td>10                                                      </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>season_number</th><th scope=col>episode_number</th><th scope=col>rating</th><th scope=col>votes</th><th scope=col>episode_order</th></tr></thead>
<tbody>
	<tr><td>21  </td><td> 5  </td><td>7.4 </td><td>1091</td><td>282 </td></tr>
	<tr><td>21  </td><td> 6  </td><td>7.3 </td><td> 964</td><td>283 </td></tr>
	<tr><td>21  </td><td> 7  </td><td>7.4 </td><td>1008</td><td>284 </td></tr>
	<tr><td>21  </td><td> 8  </td><td>7.2 </td><td> 833</td><td>285 </td></tr>
	<tr><td>21  </td><td> 9  </td><td>7.9 </td><td> 896</td><td>286 </td></tr>
	<tr><td>21  </td><td>10  </td><td>7.1 </td><td> 906</td><td>287 </td></tr>
</tbody>
</table>




## 2. Sentiments, swear words, and stemming
<p>Now that we have the raw data prepared, we will do some modifications. We'll utilize the combined powers of tidyverse and tidytext and make one great dataset that we will work with from now on.</p>
<p>We will join the dataset together. But most importantly, we will unnest the lines so <strong>every row of our data frame becomes a word</strong>. It will make our analysis and future visualizations very easy. We will also get rid of stop words (a, the, and, ...) and assign a sentiment score based on the <a href="http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010">AFINN lexicon</a>.</p>
<p>Our new dataset will have some great new columns that will tell us a lot more about the show!</p>


```R
# Join lines with episode ratings
sp <- inner_join(sp_lines, sp_ratings, by = c("season_number" = "season_number", "episode_number" = "episode_number"))
# Load english swear words
en_swear_words <- sweary::get_swearwords("en") %>%
    mutate(stem = wordStem(word))

# and add a swear_word logical column.
sp_words <- sp %>%
    # Unnest lines to words
    unnest_tokens(word, text) %>%
    # leave out stop words
    anti_join(stop_words) %>%
    # Add sentiment score
    left_join(get_sentiments("afinn")) %>%
    # Add word stem column
    mutate(word_stem = wordStem(word),
    # Add swear word logical column
          swear_word = word %in% en_swear_words$word  | word_stem %in% en_swear_words$stem)

tail(sp_words)


```
<table>
<thead><tr><th scope=col>character</th><th scope=col>episode_name</th><th scope=col>season_number</th><th scope=col>episode_number</th><th scope=col>rating</th><th scope=col>votes</th><th scope=col>episode_order</th><th scope=col>word</th><th scope=col>score</th><th scope=col>word_stem</th><th scope=col>swear_word</th></tr></thead>
<tbody>
	<tr><td>officer bright       </td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>worse                </td><td>-3                   </td><td>wors                 </td><td>FALSE                </td></tr>
	<tr><td>stan                 </td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>destroy              </td><td>-3                   </td><td>destroi              </td><td>FALSE                </td></tr>
	<tr><td>randy                </td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>guess                </td><td>NA                   </td><td>guess                </td><td>FALSE                </td></tr>
	<tr><td>randy                </td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>whites               </td><td>NA                   </td><td>white                </td><td>FALSE                </td></tr>
	<tr><td>end of splatty tomato</td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>splatty              </td><td>NA                   </td><td>splatti              </td><td>FALSE                </td></tr>
	<tr><td>end of splatty tomato</td><td>Splatty Tomato       </td><td>21                   </td><td>10                   </td><td>7.1                  </td><td>906                  </td><td>287                  </td><td>tomato               </td><td>NA                   </td><td>tomato               </td><td>FALSE                </td></tr>
</tbody>
</table>





## 3. Summarize data by episode
<p>Now that the dataset is prepared, we can finally start analyzing it. Let's see what we can say about each of the episodes. I can't wait to see the different swear word ratios. What's the naughtiest one?</p>


```R
# Summarize data by episode
by_episode <- sp_words %>%
    # Group by episode name, rating, and episode order
    group_by(episode_name, rating, episode_order) %>%
    # Create a swear word ratio and episode sentiment score
    summarize(
        swear_word_ratio = sum(swear_word) / n() ,
        sentiment_score = mean(score, na.rm = TRUE)) %>%
    arrange(episode_order)

# Take a look at by_episode structure
tail(by_episode)

# What is the naughtiest episode?
( naughtiest <- by_episode[which.max(by_episode$swear_word_ratio), ] )
```


<table>
<thead><tr><th scope=col>episode_name</th><th scope=col>rating</th><th scope=col>episode_order</th><th scope=col>swear_word_ratio</th><th scope=col>sentiment_score</th></tr></thead>
<tbody>
	<tr><td>Hummels &amp; Heroin </td><td>7.4                  </td><td>282                  </td><td>0.021396396          </td><td>-0.7567568           </td></tr>
	<tr><td>Sons A Witches   </td><td>7.3              </td><td>283              </td><td>0.009221311      </td><td>-0.4285714       </td></tr>
	<tr><td>Doubling Down    </td><td>7.4              </td><td>284              </td><td>0.025583982      </td><td>-0.7413793       </td></tr>
	<tr><td>Moss Piglets     </td><td>7.2              </td><td>285              </td><td>0.029464286      </td><td>-0.1145833       </td></tr>
	<tr><td>SUPER HARD PCness</td><td>7.9              </td><td>286              </td><td>0.013993541      </td><td>-0.2562500       </td></tr>
	<tr><td>Splatty Tomato   </td><td>7.1              </td><td>287              </td><td>0.019659240      </td><td>-0.5375000       </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>episode_name</th><th scope=col>rating</th><th scope=col>episode_order</th><th scope=col>swear_word_ratio</th><th scope=col>sentiment_score</th></tr></thead>
<tbody>
	<tr><td>It Hits the Fan</td><td>8.5            </td><td>66             </td><td>0.1341557      </td><td>-1.978667      </td></tr>
</tbody>
</table>

## 4. South Park overall sentiment
<p><strong>It Hits the Fan</strong> – more than <strong>13%</strong> of swear words? Now that's a naughty episode! They say a swear word roughly <strong>every 8 seconds</strong> throughout the whole episode!</p>
<p>It also has a mean sentiment score of <strong>-2</strong>. That is pretty low on a scale from -5 (very negative) to +5 (very positive). <a href="https://en.wikipedia.org/wiki/Sentiment_analysis">Sentiment analysis</a> helps us decide what is the attitude of the document we aim to analyze. We are using a numeric scale, but there are other options. Some dictionaries can even classify words to say if it expresses <em>happiness</em>, <em>surprise</em>, <em>anger</em>, etc.</p>
<p>We can roughly get the idea of the episode atmosphere thanks to the sentiment score. Let's compare all the episodes together and plot the sentiment evolution.</p>


```R
# Set a minimal theme for all future plots
theme_set(theme_gray())

# Plot sentiment score for each episode
ggplot(by_episode, aes(episode_order, sentiment_score)) +
    # Add a column geom
    geom_col() +
    # Add a smooth geom
    geom_smooth()
```

![png](output_10_2.png)


## 5. South Park episode popularity
<p>The trend in the previous plot showed us that the sentiment changes over time. We can also see that most of the episodes have a <strong>negative</strong> mean sentiment score.</p>
<p>Let's now take a look at IMDB ratings. They tell us everything we need to analyze episode popularity. There's nothing better than a nice plot to see if the show is becoming more or less popular over time.</p>


```R
# Plot episode ratings
ggplot(by_episode, aes(episode_order, rating)) +
    # Add a point geom
    geom_point() +
    # Add a smooth geom
    geom_smooth() +
    # Create a red, dashed, vertical line for episode 100
    geom_vline(xintercept = 100, color="red", linetype = "dashed")
```

![png](output_13_2.png)



## 6. Are naughty episodes more popular?
<p>South Park creators made a joke in the episode called <a href="https://en.wikipedia.org/wiki/Cancelled_(South_Park)">Cancelled</a> that a show shouldn't go past a 100 episodes. We saw that the popularity keeps dropping since then. But it's still a great show, trust me.</p>
<p>Let's take a look at something even more interesting though. I always wondered whether naughtier episodes are actually more popular. We have already prepared swear word ratio and episode rating in our <code>by_episode</code> data frame.</p>
<p><strong>Let's plot it then!</strong></p>


```R
# Plot swear word ratio over episode rating
ggplot(by_episode, aes(rating, swear_word_ratio)) +
    # Add a transparent point geom
    geom_point(alpha = 0.6, size = 3) +
    # Add a smooth geom
    geom_smooth() +
    # Display y-axis using percents
    scale_y_continuous(labels = scales::percent) +
    scale_x_continuous(breaks = seq(6, 10, 0.5)) +
    labs(
        x = "IMDB rating",
        y = "Episode swear word ratio"
)
```

   
![png](output_16_2.png)



## 7. Comparing profanity of two characters
<p>Right now, we will create a function that will help us decide which of the two characters is naughtier. We will need a <strong>2x2 matrix</strong> for a couple to compare them. The first column has to be the <strong>number of swear words</strong> and the second the <strong>total number of words</strong>. Let's take a look at the following table. Those are real numbers for <em>Cartman</em> and <em>Butters</em>.</p>
<table>
<thead>
<tr>
<th></th>
<th>swear</th>
<th>total</th>
</tr>
</thead>
<tbody>
<tr>
<td>Cartman</td>
<td>1318</td>
<td>49434</td>
</tr>
<tr>
<td>Butters</td>
<td>100</td>
<td>11512</td>
</tr>
</tbody>
</table>
<p>The final step will be to apply a statistical test. Because we are comparing proportions, we can use a base R function made exactly for this purpose. Meet <a href="https://www.rdocumentation.org/packages/stats/versions/3.5.1/topics/prop.test">prop.test</a>.</p>


```R
compare_profanity <- function(char1, char2, words) {
    char_1 <- filter(words, character == char1)
    # Filter words for the second character
    char_2 <- filter(words, character == char2)
    char_1_summary <- summarise(char_1, swear = sum(swear_word), total = n())
    # Summarize words for the second character
    char_2_summary <- summarise(char_2, swear = sum(swear_word), total = n())
    char_both_summary <- bind_rows(char_1_summary, char_2_summary)
    # Run a proportion test
    result <- prop.test(as.matrix(char_both_summary), correct = FALSE)
    # Tidy and return the result
    return(tidy(result) %>% bind_cols(character = char1))
}
```

## 8. Is Eric Cartman the naughtiest character?
<p>Anyone who knows the show might suspect that <strong>Eric Cartman</strong> is the naughtiest character. This is what I think too. We will know for sure very soon. I picked the top speaking characters for our analysis. These will be the most relevant to compare with Cartman. They are stored in the <code>characters</code> vector.</p>
<p>We will now use <code>map_df()</code> from <code>purrr</code> to easily compare profanity of Cartman with every character in our vector. Our function <code>compare_profanity()</code> always returns a data frame thanks to the <code>tidy()</code> function from <code>broom</code>.</p>
<p>The best way to answer the question is to create a nice plot again.</p>


```R
# Most speaking characters of the show
characters <- c("butters", "cartman", "kenny", "kyle", "randy", "stan", "gerald", "mr. garrison",
                "mr. mackey", "wendy", "chef", "jimbo", "jimmy", "sharon", "sheila", "stephen")
# Map compare_profanity to all characters agains cartman
prop_result <- map_df(characters, compare_profanity, "cartman", sp_words)

# Plot estimate1 confidence intervals of all characters
ggplot(prop_result, aes(x = reorder(character, -estimate1), estimate1)) +
    # Add an errorbar geom and color it by p.value threshold
    geom_errorbar(aes(ymin = conf.low, ymax = conf.high, color = p.value < 0.05), show.legend = FALSE) +
    geom_hline(yintercept = 0, col = "red", linetype = "dashed") +
    theme(axis.text.x = element_text(angle = 60, hjust = 1))
```

![png](output_22_1.png)


## 9. Let's answer some questions
<p>We included Eric Cartman in our <code>characters</code> vector so that we can easily compare him with the others. There are three main things that we should take into account when evaluating the above plot:</p>
<ol>
<li><strong>Spread of the error bar:</strong> the wider, the less words are spoken.</li>
<li><strong>Color of the error bar:</strong> blue is statistically significant result (p-value &lt; 0.05).</li>
<li><strong>Position of the error bar:</strong> prop.test estimate suggesting who is naughtier.</li>
</ol>
<p>Are we able to say if <strong>naughty episodes are more popular?</strong> And what about Eric Cartman, is he really the <strong>naughtiest character in South Park?</strong> And if not, <strong>who is it?</strong></p>


```R
# Are naughty episodes more popular? TRUE/FALSE
naughty_episodes_more_popular <- FALSE
# Is Eric Cartman the naughtiest character? TRUE/FALSE
eric_cartman_naughtiest <- FALSE
# If he is, assign an empty string, otherwise write his name
who_is_naughtiest <- "kenny"
```
