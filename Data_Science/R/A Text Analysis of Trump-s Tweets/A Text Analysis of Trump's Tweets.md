
## 1. The tweets
<p>I don’t usually post about politics (I’m not particularly savvy about polling, which is where data science has had the <a href="http://fivethirtyeight.com/">most substantial impact on politics</a>), but I saw a hypothesis about Donald Trump’s Twitter account that simply begged to be investigated with data: </p>

![png](tweet.png)

<p>When Trump wishes the Olympic team good luck, he’s tweeting from his iPhone. When he’s insulting a rival, he’s usually tweeting from an Android. Is this an artifact showing which tweets are Trump’s own and which are by some handler in the campaign?</p>
<p>Others have <a href="http://www.cnet.com/news/trumps-tweets-android-for-nasty-iphone-for-nice/">explored Trump’s timeline</a> and noticed this tends to hold up. And Trump himself <a href="http://www.theverge.com/2015/10/5/9453935/donald-trump-twitter-strategy">did indeed tweet from a Samsung Galaxy</a> until <a href="https://www.recode.net/2017/5/27/15705090/president-donald-trump-twitter-android-iphone-ios-samsung-galaxy-security-hacking">March 2017</a>. But how could we examine it quantitatively? During the development of the <a href="http://github.com/juliasilge/tidytext">tidytext R package</a>, I was writing about writing about text mining and sentiment analysis, and this is an excellent opportunity to apply it again.</p>
<p>My analysis, shown below, concludes that <strong>the Android and iPhone tweets are clearly from different people</strong>. Tweets from these two devices are posted during different times of day, and the use of hashtags, links, and retweets are distinctive. What’s more, we can see that <strong>the Android tweets are angrier and more negative</strong>, while the iPhone tweets tend to be benign announcements and pictures. Overall I’d agree with <a href="https://twitter.com/tvaziri/">@tvaziri</a>’s analysis. We can tell the difference between the campaign’s tweets (iPhone) and Trump’s own (Android). Let's see how.</p>
<p>First, let's load the content of Donald Trump’s timeline. Our dataset is from <a href="http://www.trumptwitterarchive.com/">The Trump Twitter Archive</a> by Brendan Brown, which contains all 35,000+ tweets from the <a href="https://twitter.com/realDonaldTrump/">@realDonaldTrump</a> Twitter account from 2009 (the year Trump sent his <a href="https://www.businessinsider.de/donald-trump-first-tweet-2017-5">first tweet</a>) through 2018. We'll filter it for the election period only, June 1st, 2015 through November 8th, 2016.</p>


```R
# Load the libraries
library(tidyverse)
library(lubridate)

# Read in the data
tweets <- read_csv("datasets/trump_tweets.csv", guess_max = 36000) %>%
  filter(created_at >= "2015-06-01" , created_at <= "2016-11-08")

# Inspect the first six rows
head(tweets)
```

<table>
<thead><tr><th scope=col>source</th><th scope=col>id_str</th><th scope=col>text</th><th scope=col>created_at</th><th scope=col>retweet_count</th><th scope=col>in_reply_to_user_id_str</th><th scope=col>favorite_count</th><th scope=col>is_retweet</th></tr></thead>
<tbody>
	<tr><td>Twitter for Android                                                                                                                         </td><td>6.827032e+17                                                                                                                                </td><td>I would like to wish everyone A HAPPY AND HEALTHY NEW YEAR. WE MUST ALL WORK TOGETHER TO, FINALLY, MAKE AMERICA SAFE AGAIN AND GREAT AGAIN! </td><td>2015-12-31 23:21:49                                                                                                                         </td><td>6776                                                                                                                                        </td><td>NA                                                                                                                                          </td><td>16495                                                                                                                                       </td><td>FALSE                                                                                                                                       </td></tr>
	<tr><td>Twitter for Android                                                                                                                         </td><td>6.827007e+17                                                                                                                                </td><td>Do you believe that The State Department, on NEW YEAR'S EVE, just released more of Hillary's e-mails. They just want it all to end. BAD!    </td><td>2015-12-31 23:11:35                                                                                                                         </td><td>2755                                                                                                                                        </td><td>NA                                                                                                                                          </td><td> 6824                                                                                                                                       </td><td>FALSE                                                                                                                                       </td></tr>
	<tr><td>Twitter for iPhone                                                                                                                                                                      </td><td>6.826351e+17                                                                                                                                                                            </td><td><span style=white-space:pre-wrap>THANK YOU ILLINOIS! Let's not forget to get family &amp;amp; friends- out to VOTE IN 2016! https://t.co/lg5kMbNLYK https://t.co/dtMAsIq4cf      </span></td><td>2015-12-31 18:51:12                                                                                                                                                                     </td><td>2468                                                                                                                                                                                    </td><td>NA                                                                                                                                                                                      </td><td> 6047                                                                                                                                                                                   </td><td>FALSE                                                                                                                                                                                   </td></tr>
	<tr><td>Twitter for iPhone                                                                                                                          </td><td>6.826053e+17                                                                                                                                </td><td>HAPPY BIRTHDAY to my son, @DonaldJTrumpJr! Very proud of you! #TBT https://t.co/ULerCEOCGX https://t.co/nbxPVdarJM                          </td><td>2015-12-31 16:52:38                                                                                                                         </td><td>2080                                                                                                                                        </td><td>NA                                                                                                                                          </td><td> 8416                                                                                                                                       </td><td>FALSE                                                                                                                                       </td></tr>
	<tr><td>Twitter for Android                                                                                                                         </td><td>6.825788e+17                                                                                                                                </td><td>I would feel sorry for @JebBush and how badly he is doing with his campaign other than for the fact he took millions of $'s of hit ads on me</td><td>2015-12-31 15:07:18                                                                                                                         </td><td>1875                                                                                                                                        </td><td>NA                                                                                                                                          </td><td> 5780                                                                                                                                       </td><td>FALSE                                                                                                                                       </td></tr>
	<tr><td>Twitter for iPhone                                                                                                                          </td><td>6.825446e+17                                                                                                                                </td><td>#MakeAmericaGreatAgain #Trump2016 https://t.co/IEIXos0wh9                                                                                   </td><td>2015-12-31 12:51:35                                                                                                                         </td><td>2285                                                                                                                                        </td><td>NA                                                                                                                                          </td><td> 5729                                                                                                                                       </td><td>FALSE                                                                                                                                       </td></tr>
</tbody>
</table>



## 2. Clean those tweets
<p>We'll clean the data by extracting the source application. We’re only looking at the iPhone and Android tweets. A much smaller number of tweets are from the web client or iPad.</p>
<p>Overall, the cleaned data should include 2281 tweets from an iPhone device and 4236 tweets from an Android device.</p>


```R
# Count the nubmer of tweets by source
tweets %>% count(source)

# Clean the tweets
cleaned_tweets <- tweets %>%
 select(id_str, source, text, created_at) %>%
  filter(source %in% c("Twitter for iPhone", "Twitter for Android")) %>%
  extract(source, "source", "(\\w+)$")

# Inspect the first six rows
head(cleaned_tweets)
```


<table>
<thead><tr><th scope=col>source</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>Facebook               </td><td>   2                   </td></tr>
	<tr><td>Instagram              </td><td>  47                   </td></tr>
	<tr><td>Media Studio           </td><td>   1                   </td></tr>
	<tr><td>Mobile Web (M5)        </td><td>   1                   </td></tr>
	<tr><td>Periscope              </td><td>   7                   </td></tr>
	<tr><td>TweetDeck              </td><td>   2                   </td></tr>
	<tr><td>Twitter Ads            </td><td>  63                   </td></tr>
	<tr><td>Twitter Mirror for iPad</td><td>   1                   </td></tr>
	<tr><td>Twitter QandA          </td><td>  10                   </td></tr>
	<tr><td>Twitter Web Client     </td><td>1301                   </td></tr>
	<tr><td>Twitter for Android    </td><td>4240                   </td></tr>
	<tr><td>Twitter for BlackBerry </td><td>  45                   </td></tr>
	<tr><td>Twitter for iPad       </td><td>  22                   </td></tr>
	<tr><td>Twitter for iPhone     </td><td>2275                   </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>id_str</th><th scope=col>source</th><th scope=col>text</th><th scope=col>created_at</th></tr></thead>
<tbody>
	<tr><td>6.827032e+17                                                                                                                                </td><td>Android                                                                                                                                     </td><td>I would like to wish everyone A HAPPY AND HEALTHY NEW YEAR. WE MUST ALL WORK TOGETHER TO, FINALLY, MAKE AMERICA SAFE AGAIN AND GREAT AGAIN! </td><td>2015-12-31 23:21:49                                                                                                                         </td></tr>
	<tr><td>6.827007e+17                                                                                                                                </td><td>Android                                                                                                                                     </td><td>Do you believe that The State Department, on NEW YEAR'S EVE, just released more of Hillary's e-mails. They just want it all to end. BAD!    </td><td>2015-12-31 23:11:35                                                                                                                         </td></tr>
	<tr><td>6.826351e+17                                                                                                                                                                            </td><td>iPhone                                                                                                                                                                                  </td><td><span style=white-space:pre-wrap>THANK YOU ILLINOIS! Let's not forget to get family &amp;amp; friends- out to VOTE IN 2016! https://t.co/lg5kMbNLYK https://t.co/dtMAsIq4cf      </span></td><td>2015-12-31 18:51:12                                                                                                                                                                     </td></tr>
	<tr><td>6.826053e+17                                                                                                                                </td><td>iPhone                                                                                                                                      </td><td>HAPPY BIRTHDAY to my son, @DonaldJTrumpJr! Very proud of you! #TBT https://t.co/ULerCEOCGX https://t.co/nbxPVdarJM                          </td><td>2015-12-31 16:52:38                                                                                                                         </td></tr>
	<tr><td>6.825788e+17                                                                                                                                </td><td>Android                                                                                                                                     </td><td>I would feel sorry for @JebBush and how badly he is doing with his campaign other than for the fact he took millions of $'s of hit ads on me</td><td>2015-12-31 15:07:18                                                                                                                         </td></tr>
	<tr><td>6.825446e+17                                                                                                                                </td><td>iPhone                                                                                                                                      </td><td>#MakeAmericaGreatAgain #Trump2016 https://t.co/IEIXos0wh9                                                                                   </td><td>2015-12-31 12:51:35                                                                                                                         </td></tr>
</tbody>
</table>



## 3. Is "time" the giveaway?
<p>Most people are creatures of habit, and we would expect their tweet times to be a type of ‘signature’. We can certainly spot the difference here. Most tweets from the Android are in the early morning or later in the evening, while tweets from the iPhone occur more often in the afternoon.</p>


```R
# Load the scales package
library(scales)

#  Plot the percentage of tweets by hour of the day for each device
cleaned_tweets %>%
  count(source, hour = hour(with_tz(created_at, "EST"))) %>%
  mutate(percent = n/sum(n)) %>%
  ggplot(aes(hour, percent, col = source)) +
  geom_line() + 
  scale_y_continuous(labels = percent_format()) +
  labs(x = "Hour of day (EST)", y = "% of tweets", color = "")
```

![png](output_7_1.png)

## 4. The quote tweet is dead
<p>Another place we can spot a difference is in Trump’s anachronistic behavior of “manually retweeting” people by copy-pasting their tweets, then surrounding them with quotation marks. These are known as <a href="https://www.theringer.com/tech/2018/5/2/17311616/twitter-retweet-quote-endorsement-function-trolls">quote tweets</a>.</p>

![png](tweet_quotes.png)

<p>Almost all the quote tweets are posted from the Android.</p>
<p>After this plot, we’ll filter out the quote tweets in the remaining <strong>by-word</strong> analyses because they contain text from followers that may not be representative of Trump’s tweets.</p>


```R
#  Plot the number of tweets with and without quotes by device
cleaned_tweets %>%
  count(source,
        quoted = ifelse(str_detect(text, '^"'), "Quoted", "Not quoted")) %>%
  ggplot(aes(source, n, fill = quoted)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "", y = "Number of tweets", fill = "") +
  ggtitle('Whether tweets start with a quotation mark (")')
```
![png](output_10_1.png)


## 5. Links and pictures
<p>Another place we see a difference between the iPhone and Android tweets is in the sharing of links or pictures.</p>
<p>It turns out that tweets from the iPhone were <strong>way more likely to contain either a picture or a link</strong>. This also makes sense with our narrative: iPhone (presumably run by the campaign) tends to write “announcement” tweets about events, like this:</p>

![png](tweet_windham.png)

<p>While Android (Trump himself) tends to write picture-less tweets like:</p>

![png](tweet_media.png)


```R
#  Count the number of tweets with and without picture/links by device
tweet_picture_counts <- cleaned_tweets %>%
  filter(!str_detect(text, '^"')) %>%
  count(source,
        picture = ifelse(str_detect(text, "t.co"),
                         "Picture/link", "No picture/link"))

# Make a bar plot 
ggplot(tweet_picture_counts, aes(source, n, fill = picture)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "", y = "Number of tweets", fill = "")
```

![png](output_13_1.png)


## 6. Comparison of words
<p>Now that we’re sure there is a difference between these two platforms, what can we say about the difference in the <em>content</em> of the tweets? We’ll use the <a href="https://cran.r-project.org/web/packages/tidytext">tidytext package</a> that <a href="http://juliasilge.com/">Julia Silge</a> and I developed.</p>
<p>We start by dividing lines of text into individual words using <code>unnest_tokens()</code> (see <a href="https://cran.r-project.org/web/packages/tidytext/vignettes/tidytext.html">this vignette</a> for more), and by removing some common “stopwords”.</p>


```R
# Load the tidytext package
library(tidytext)

# Create a regex pattern
reg <- "([^A-Za-z\\d#@']|'(?![A-Za-z\\d#@]))"

# Unnest the text strings into a data frame of words
tweet_words <- cleaned_tweets %>%
  filter(!str_detect(text, '^"')) %>%
  mutate(text = str_replace_all(text, "https://t.co/[A-Za-z\\d]+|&amp;", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = reg) %>%
  filter(!word %in% stop_words$word,
         str_detect(word, "[a-z]"))

# Inspect the first six rows of tweet_words
head(tweet_words)
```


<table>
<thead><tr><th scope=col>id_str</th><th scope=col>source</th><th scope=col>created_at</th><th scope=col>word</th></tr></thead>
<tbody>
	<tr><td>6.053187e+17       </td><td>Android            </td><td>2015-06-01 10:23:13</td><td>@foxandfriends     </td></tr>
	<tr><td>6.053187e+17       </td><td>Android            </td><td>2015-06-01 10:23:13</td><td>enjoy              </td></tr>
	<tr><td>6.066705e+17       </td><td>Android            </td><td>2015-06-05 03:55:04</td><td>worst              </td></tr>
	<tr><td>6.066705e+17       </td><td>Android            </td><td>2015-06-05 03:55:04</td><td>boring             </td></tr>
	<tr><td>6.066705e+17       </td><td>Android            </td><td>2015-06-05 03:55:04</td><td>political          </td></tr>
	<tr><td>6.066705e+17       </td><td>Android            </td><td>2015-06-05 03:55:04</td><td>pundits            </td></tr>
</tbody>
</table>

## 7. Most common words
<p>What are the most common words @realDonaldTrump tweets? This plot should look familiar to anyone who has seen the feed.</p>


```R
# Plot the most common words from @realDonaldTrump tweets
tweet_words %>%
  count(word, sort = TRUE) %>%
  head(n = 20) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = "identity") +
  ylab("Occurrences") +
 coord_flip()
```
![png](output_19_1.png)


## 8. Common words: Android vs. iPhone (i)
<p>Now let’s consider which words are most common from the Android relative to the iPhone, and vice versa. We’ll use the simple measure of log odds ratio <strong>for each word</strong>, calculated as:</p>

![png](log.PNG)

<p><br></p>
<p>We'll only be looking at words that occur at least five times in both platforms. There will be some instances with fewer than five uses in either the Android or the iPhone, but never one with fewer than five total. If there is one occurrence of a word in the Android, you'll know that there are at least four occurrences in the iPhone for the same word.</p>
<p><br></p>
<p>The “+1”, called <a href="https://en.wikipedia.org/wiki/Additive_smoothing">Laplace smoothing</a>, are to avoid dividing by zero and to put <a href="http://varianceexplained.org/r/empirical_bayes_baseball/">more trust in common words</a>.</p>


```R
# Create the log odds ratio of each word
android_iphone_ratios <- tweet_words %>%
  count(word, source) %>%
  group_by(word)  %>% 
  filter(sum(n) >= 5) %>%
  spread(source, n, fill = 0) %>%
  ungroup() %>%
  mutate_if(is.numeric, funs((. + 1) / sum(. + 1))) %>%
  mutate(logratio = log2(Android / iPhone)) %>%
  arrange(desc(logratio))

# Inspect the first six rows
head(android_iphone_ratios)
```


<table>
<thead><tr><th scope=col>word</th><th scope=col>Android</th><th scope=col>iPhone</th><th scope=col>logratio</th></tr></thead>
<tbody>
	<tr><td>mails       </td><td>0.0016695703</td><td>7.984669e-05</td><td>4.386100    </td></tr>
	<tr><td>poor        </td><td>0.0010162602</td><td>7.984669e-05</td><td>3.669893    </td></tr>
	<tr><td>poorly      </td><td>0.0009436702</td><td>7.984669e-05</td><td>3.562978    </td></tr>
	<tr><td>bosses      </td><td>0.0008710801</td><td>7.984669e-05</td><td>3.447501    </td></tr>
	<tr><td>turnberry   </td><td>0.0008710801</td><td>7.984669e-05</td><td>3.447501    </td></tr>
	<tr><td>angry       </td><td>0.0007984901</td><td>7.984669e-05</td><td>3.321970    </td></tr>
</tbody>
</table>


## 9. Common words: Android vs. iPhone (ii)
<p>Now that we've calculated the log odds ratio of each word, we'll plot the 15 words with the greatest log odds ratio for the Android and the iPhone.</p>
<p>With the way we've set up the log odds ratio, positive values are assigned to words from the Android, and negative values are assigned to the iPhone. </p>


```R
# Plot the log odds ratio for each word by device
android_iphone_ratios %>%
  group_by(logratio > 0) %>%
  top_n(15, abs(logratio)) %>%
  ungroup() %>%
  mutate(word = reorder(word, logratio)) %>%
  ggplot(aes(word, logratio, fill = logratio < 0)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  ylab("Android / iPhone log ratio") +
  scale_fill_manual(name = "", labels = c("Android", "iPhone"),
                    values = c("red", "lightblue"))
```
![png](output_25_1.png)

## 10. Adding sentiments
<p>What do we know so far? </p>
<ul>
<li><p><strong>Most hashtags come from the iPhone.</strong> Indeed, almost no tweets from Trump's Android contained hashtags, with some rare exceptions like <a href="https://twitter.com/realDonaldTrump/status/753960134422900736">this one</a>. (This is true only because we filtered out the quoted "retweets," as Trump does sometimes quote tweets <a href="https://twitter.com/realDonaldTrump/status/731805331425218560">like this</a> that contain hashtags).</p></li>
<li><p><strong>Words like "join" and times like "7 pm", came only from the iPhone.</strong> The iPhone is responsible for event announcements like <a href="https://twitter.com/realDonaldTrump/status/743522630230228993">this one</a> ("Join me in Houston, Texas tomorrow night at 7 pm!")</p></li>
<li><p><strong>Emotionally charged words, like "poorly," "angry," and "stupid" were more common on Android.</strong> This supports the original hypothesis that this is the "angrier" or more hyperbolic account.</p></li>
</ul>
<p>Since we’ve observed a difference in word use between the Android and iPhone tweets, let's see if there's a difference in sentiment. We’ll work with the NRC Word-Emotion Association lexicon, available from the tidytext package, which associates words with ten sentiments: positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust.</p>


```R
# Create a sentiment data frame from the NRC lexicon
nrc <- sentiments %>%
  filter(lexicon == "nrc") %>%
  select(word, sentiment)

# Join the NRC lexicon to the 
android_iphone_sentiment <- android_iphone_ratios %>%
  inner_join(nrc, by = "word") %>%
  filter(!sentiment %in% c("positive", "negative")) %>%
  mutate(sentiment = reorder(sentiment, -logratio),
         word = reorder(word, -logratio)) %>%
  group_by(sentiment) %>%
  top_n(10, abs(logratio)) %>%
  ungroup()

# Inspect the first six rows
head(android_iphone_sentiment)
```


<table>
<thead><tr><th scope=col>word</th><th scope=col>Android</th><th scope=col>iPhone</th><th scope=col>logratio</th><th scope=col>sentiment</th></tr></thead>
<tbody>
	<tr><td>angry       </td><td>0.0007984901</td><td>7.984669e-05</td><td>3.321970    </td><td>anger       </td></tr>
	<tr><td>angry       </td><td>0.0007984901</td><td>7.984669e-05</td><td>3.321970    </td><td>disgust     </td></tr>
	<tr><td>defend      </td><td>0.0007259001</td><td>7.984669e-05</td><td>3.184466    </td><td>fear        </td></tr>
	<tr><td>enthusiasm  </td><td>0.0006533101</td><td>7.984669e-05</td><td>3.032463    </td><td>anticipation</td></tr>
	<tr><td>enthusiasm  </td><td>0.0006533101</td><td>7.984669e-05</td><td>3.032463    </td><td>joy         </td></tr>
	<tr><td>enthusiasm  </td><td>0.0006533101</td><td>7.984669e-05</td><td>3.032463    </td><td>surprise    </td></tr>
</tbody>
</table>




## 11. Android vs. iPhone sentiments
<p>Now we'll take a look at the sentiments of the common words from both devices. We'll see that a lot of words annotated as negative sentiments (with a few exceptions like “crime” and “terrorist”) are more common in Trump’s Android tweets than the campaign’s iPhone tweets.</p>


```R
# Plot the log odds ratio of words by device in groups sentiments
ggplot(android_iphone_sentiment, aes(word, logratio, fill = logratio < 0)) +
  facet_wrap(~sentiment, scales = "free", nrow = 2) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "", y = "Android / iPhone log ratio") +
  scale_fill_manual(name = "", labels = c("Android", "iPhone"),
                    values = c("red", "lightblue"))
```

![png](output_31_1.png)



## 12. Conclusion: The ghost in the political machine
<p>There's a difference in style and sentiment between Trump's tweets from the Android and the iPhone. We know Trump used the Android until March 2017, but who was tweeting from the iPhone on Trump's behalf? I was fascinated by a <a href="http://www.newyorker.com/magazine/2016/07/25/donald-trumps-ghostwriter-tells-all">New Yorker article</a> about Tony Schwartz, Trump’s ghostwriter for <em>The Art of the Deal</em>. Of particular interest was how Schwartz imitated Trump’s voice and philosophy:</p>
<blockquote>
  <p><em>In his journal, Schwartz describes the process of trying to make Trump’s voice palatable in the book. It was kind of “a trick,” he writes, to mimic Trump’s blunt, staccato, no-apologies delivery while making him seem almost boyishly appealing…. Looking back at the text now, Schwartz says, “I created a character far more winning than Trump is.”</em></p>
</blockquote>
<p>A lot has been written about Trump’s mental state. But I’d rather get inside the head of the anonymous staffer whose job is to imitate Trump’s unique cadence (“Very sad!”) or put a positive spin on it, to millions of his followers. Are they a true believer, or just a cog in a political machine, mixing whatever mainstream appeal they can into the <a href="https://twitter.com/realDonaldTrump">@realDonaldTrump</a> concoction? Like Tony Schwartz, will they one day regret their involvement?</p>


```R
anonymous_iPhone_tweeter <- "Cog"
```

