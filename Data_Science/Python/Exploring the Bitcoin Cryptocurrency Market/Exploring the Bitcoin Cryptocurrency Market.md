
## 1. Bitcoin. Cryptocurrencies. So hot right now.
<p>Since the <a href="https://newfronttest.bitcoin.com/bitcoin.pdf">launch of Bitcoin in 2008</a>, hundreds of similar projects based on the blockchain technology have emerged. We call these cryptocurrencies (also coins or cryptos in the Internet slang). Some are extremely valuable nowadays, and others may have the potential to become extremely valuable in the future<sup>1</sup>. In fact, the 6th of December of 2017 Bitcoin has a <a href="https://en.wikipedia.org/wiki/Market_capitalization">market capitalization</a> above $200 billion. </p>
<p><center>

![png](0.PNG)

<em>The astonishing increase of Bitcoin market capitalization in 2017.</em></center></p>
<p>As a first task, we will load the current data from the <a href="https://api.coinmarketcap.com">coinmarketcap API</a> and display it in the output.</p>


```python
# Importing pandas
import pandas as pd

# Importing matplotlib and setting aesthetics for plotting later.
import matplotlib.pyplot as plt
%matplotlib inline
%config InlineBackend.figure_format = 'svg' 
plt.style.use('fivethirtyeight')

# Reading in current data from coinmarketcap.com
current = pd.read_json("https://api.coinmarketcap.com/v1/ticker/")

# Printing out the first few lines
current.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>24h_volume_usd</th>
      <th>available_supply</th>
      <th>id</th>
      <th>last_updated</th>
      <th>market_cap_usd</th>
      <th>max_supply</th>
      <th>name</th>
      <th>percent_change_1h</th>
      <th>percent_change_24h</th>
      <th>percent_change_7d</th>
      <th>price_btc</th>
      <th>price_usd</th>
      <th>rank</th>
      <th>symbol</th>
      <th>total_supply</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>5.314156e+09</td>
      <td>17282012</td>
      <td>bitcoin</td>
      <td>1537630463</td>
      <td>115130819323</td>
      <td>2.100000e+07</td>
      <td>Bitcoin</td>
      <td>-0.40</td>
      <td>-0.84</td>
      <td>1.87</td>
      <td>1.000000</td>
      <td>6661.887477</td>
      <td>1</td>
      <td>BTC</td>
      <td>17282012</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2.499645e+09</td>
      <td>102118237</td>
      <td>ethereum</td>
      <td>1537630478</td>
      <td>24264540947</td>
      <td>NaN</td>
      <td>Ethereum</td>
      <td>-0.56</td>
      <td>4.07</td>
      <td>7.16</td>
      <td>0.035676</td>
      <td>237.612219</td>
      <td>2</td>
      <td>ETH</td>
      <td>102118237</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3.544177e+09</td>
      <td>39809069106</td>
      <td>ripple</td>
      <td>1537630442</td>
      <td>22094853866</td>
      <td>1.000000e+11</td>
      <td>XRP</td>
      <td>-2.61</td>
      <td>-10.17</td>
      <td>96.96</td>
      <td>0.000083</td>
      <td>0.555021</td>
      <td>3</td>
      <td>XRP</td>
      <td>99991841593</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4.925154e+08</td>
      <td>17362488</td>
      <td>bitcoin-cash</td>
      <td>1537630469</td>
      <td>8210125867</td>
      <td>2.100000e+07</td>
      <td>Bitcoin Cash</td>
      <td>-0.90</td>
      <td>-2.10</td>
      <td>4.17</td>
      <td>0.070999</td>
      <td>472.865761</td>
      <td>4</td>
      <td>BCH</td>
      <td>17362488</td>
    </tr>
    <tr>
      <th>4</th>
      <td>8.538329e+08</td>
      <td>906245118</td>
      <td>eos</td>
      <td>1537630473</td>
      <td>5291128228</td>
      <td>NaN</td>
      <td>EOS</td>
      <td>-0.75</td>
      <td>0.45</td>
      <td>7.47</td>
      <td>0.000877</td>
      <td>5.838518</td>
      <td>5</td>
      <td>EOS</td>
      <td>1006245120</td>
    </tr>
  </tbody>
</table>
</div>

## 2. Full dataset, filtering, and reproducibility
<p>The previous API call returns only the first 100 coins, and we want to explore as many coins as possible. Moreover, we can't produce reproducible analysis with live online data. To solve these problems, we will load a CSV we conveniently saved on the 6th of December of 2017 using the API call <code>https://api.coinmarketcap.com/v1/ticker/?limit=0</code> named <code>datasets/coinmarketcap_06122017.csv</code>. </p>


```python
# Reading datasets/coinmarketcap_06122017.csv into pandas
dec6 = pd.read_csv("datasets/coinmarketcap_06122017.csv")

# Selecting the 'id' and the 'market_cap_usd' columns
market_cap_raw = dec6[['id','market_cap_usd']]

# Counting the number of values
market_cap_raw.count()


```
    id                1326
    market_cap_usd    1031
    dtype: int64

## 3. Discard the cryptocurrencies without a market capitalization
<p>Why do the <code>count()</code> for <code>id</code> and <code>market_cap_usd</code> differ above? It is because some cryptocurrencies listed in coinmarketcap.com have no known market capitalization, this is represented by <code>NaN</code> in the data, and <code>NaN</code>s are not counted by <code>count()</code>. These cryptocurrencies are of little interest to us in this analysis, so they are safe to remove.</p>


```python
# Filtering out rows without a market capitalization
cap = market_cap_raw.query('market_cap_usd > 0')
#same code: cap = market_cap_raw[ market_cap_raw['market_cap_usd'] > 0 ] 

# Counting the number of values again
cap.count()
```
    id                1031
    market_cap_usd    1031
    dtype: int64

## 4. How big is Bitcoin compared with the rest of the cryptocurrencies?
<p>At the time of writing, Bitcoin is under serious competition from other projects, but it is still dominant in market capitalization. Let's plot the market capitalization for the top 10 coins as a barplot to better visualize this.</p>


```python
#Declaring these now for later use in the plots
TOP_CAP_TITLE = 'Top 10 market capitalization'
TOP_CAP_YLABEL = '% of total cap'

# Selecting the first 10 rows and setting the index
cap10 = dec6[:10].set_index('id')

# Calculating market_cap_perc
cap10 = cap10.assign(market_cap_perc = lambda x: round((x.market_cap_usd/cap.market_cap_usd.sum()) * 100, 2))
print(cap10.head())
# Plotting the barplot with the title defined above 
ax = cap10.plot.bar(x='name', y='market_cap_perc', title = TOP_CAP_TITLE)

# Annotating the y axis with the label defined above
ax.set_ylabel(TOP_CAP_YLABEL)
plt.show()
```

                  Unnamed: 0  24h_volume_usd  available_supply  last_updated  \
    id                                                                         
    bitcoin                0    9.007640e+09      1.672352e+07    1512549554   
    ethereum               1    1.551330e+09      9.616537e+07    1512549553   
    bitcoin-cash           2    1.111350e+09      1.684044e+07    1512549578   
    iota                   3    2.936090e+09      2.779530e+09    1512549571   
    ripple                 4    2.315050e+08      3.873915e+10    1512549541   
    
                  market_cap_usd    max_supply          name  percent_change_1h  \
    id                                                                            
    bitcoin         2.130493e+11  2.100000e+07       Bitcoin               0.12   
    ethereum        4.352945e+10           NaN      Ethereum              -0.18   
    bitcoin-cash    2.529585e+10  2.100000e+07  Bitcoin Cash               1.65   
    iota            1.475225e+10  2.779530e+09          IOTA              -2.38   
    ripple          9.365343e+09  1.000000e+11        Ripple               0.56   
    
                  percent_change_24h  percent_change_7d  price_btc     price_usd  \
    id                                                                             
    bitcoin                     7.33              17.45   1.000000  12739.500000   
    ethereum                   -3.93              -7.33   0.036177    452.652000   
    bitcoin-cash               -5.51              -4.75   0.120050   1502.090000   
    iota                       83.35             255.82   0.000424      5.307460   
    ripple                     -3.70             -14.79   0.000019      0.241754   
    
                  rank symbol  total_supply  market_cap_perc  
    id                                                        
    bitcoin          1    BTC  1.672352e+07            56.92  
    ethereum         2    ETH  9.616537e+07            11.63  
    bitcoin-cash     3    BCH  1.684044e+07             6.76  
    iota             4  MIOTA  2.779530e+09             3.94  
    ripple           5    XRP  9.999309e+10             2.50  



![svg](output_10_1.svg)


## 5. Making the plot easier to read and more informative
<p>While the plot above is informative enough, it can be improved. Bitcoin is too big, and the other coins are hard to distinguish because of this. Instead of the percentage, let's use a log<sup>10</sup> scale of the "raw" capitalization. Plus, let's use color to group similar coins and make the plot more informative<sup>1</sup>. </p>
<p>For the colors rationale: bitcoin-cash and bitcoin-gold are forks of the bitcoin <a href="https://en.wikipedia.org/wiki/Blockchain">blockchain</a><sup>2</sup>. Ethereum and Cardano both offer Turing Complete <a href="https://en.wikipedia.org/wiki/Smart_contract">smart contracts</a>. Iota and Ripple are not minable. Dash, Litecoin, and Monero get their own color.</p>
<p><sup>1</sup> <em>This coloring is a simplification. There are more differences and similarities that are not being represented here.</em></p>
<p><sup>2</sup> <em>The bitcoin forks are actually <strong>very</strong> different, but it is out of scope to talk about them here. Please see the warning above and do your own research.</em></p>


```python
# Colors for the bar plot
COLORS = ['orange', 'green', 'orange', 'cyan', 'cyan', 'blue', 'silver', 'orange', 'red', 'green']

# Plotting market_cap_usd as before but adding the colors and scaling the y-axis  
ax = cap10.plot.bar(x='name', y='market_cap_usd', title = TOP_CAP_TITLE, color = COLORS)
ax.set_yscale('log')

# Annotating the y axis with 'USD'
ax.set_ylabel('USD')
ax.set_xlabel('')
# Final touch! Removing the xlabel as it is not very informative

plt.show()
```


![svg](output_13_0.svg)

## 6. What is going on?! Volatility in cryptocurrencies
<p>The cryptocurrencies market has been spectacularly volatile since the first exchange opened. This notebook didn't start with a big, bold warning for nothing. Let's explore this volatility a bit more! We will begin by selecting and plotting the 24 hours and 7 days percentage change, which we already have available.</p>


```python
# Selecting the id, percent_change_24h and percent_change_7d columns
volatility = dec6[['id','percent_change_24h','percent_change_7d']]

# Setting the index to 'id' and dropping all NaN rows
volatility = volatility.set_index('id').dropna()

# Sorting the DataFrame by percent_change_24h in ascending order
volatility = volatility.sort_values(by=['percent_change_24h'])

# Checking the first few rows
volatility.head()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>percent_change_24h</th>
      <th>percent_change_7d</th>
    </tr>
    <tr>
      <th>id</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>flappycoin</th>
      <td>-95.85</td>
      <td>-96.61</td>
    </tr>
    <tr>
      <th>credence-coin</th>
      <td>-94.22</td>
      <td>-95.31</td>
    </tr>
    <tr>
      <th>coupecoin</th>
      <td>-93.93</td>
      <td>-61.24</td>
    </tr>
    <tr>
      <th>tyrocoin</th>
      <td>-79.02</td>
      <td>-87.43</td>
    </tr>
    <tr>
      <th>petrodollar</th>
      <td>-76.55</td>
      <td>542.96</td>
    </tr>
  </tbody>
</table>
</div>

## 7. Well, we can already see that things are *a bit* crazy
<p>It seems you can lose a lot of money quickly on cryptocurrencies. Let's plot the top 10 biggest gainers and top 10 losers in market capitalization.</p>


```python
#Defining a function with 2 parameters, the series to plot and the title
def top10_subplot(volatility_series, title):
    # Making the subplot and the figure for two side by side plots
    fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(10, 6))
    
    # Plotting with pandas the barchart for the top 10 losers
    ax = volatility_series[:10].plot.bar(x='name', y='', color='darkred',ax=axes[0])
    # Setting the figure's main title to the text passed as parameter
    fig.suptitle(title)
    
    # Setting the ylabel to '% change'
    ax.set_ylabel('% change')
    
    # Same as above, but for the top 10 winners
    ax = volatility_series[-10:].plot.bar(x='name', y='', color='darkblue',ax=axes[1])
    
    # Returning this for good practice, might use later
    return fig, ax

DTITLE = "24 hours top losers and winners"

# Calling the function above with the 24 hours period series and title DTITLE  
fig, ax = top10_subplot(volatility.percent_change_24h, DTITLE)
```


![svg](output_19_0.svg)

## 8. Ok, those are... interesting. Let's check the weekly Series too.
<p>800% daily increase?! Why are we doing this tutorial and not buying random coins?<sup>1</sup></p>
<p>After calming down, let's reuse the function defined above to see what is going weekly instead of daily.</p>
<p><em><sup>1</sup> Please take a moment to understand the implications of the red plots on how much value some cryptocurrencies lose in such short periods of time</em></p>


```python
# Sorting in ascending order
volatility7d = volatility.sort_values(by=['percent_change_7d'])

WTITLE = "Weekly top losers and winners"

# Calling the top10_subplot function
fig, ax = top10_subplot(volatility7d.percent_change_7d, WTITLE)
```


![svg](output_22_0.svg)

## 9. How small is small?
<p>The names of the cryptocurrencies above are quite unknown, and there is a considerable fluctuation between the 1 and 7 days percentage changes. As with stocks, and many other financial products, the smaller the capitalization, the bigger the risk and reward. Smaller cryptocurrencies are less stable projects in general, and therefore even riskier investments than the bigger ones<sup>1</sup>. Let's classify our dataset based on Investopedia's capitalization <a href="https://www.investopedia.com/video/play/large-cap/">definitions</a> for company stocks. </p>
<p><sup>1</sup> <em>Cryptocurrencies are a new asset class, so they are not directly comparable to stocks. Furthermore, there are no limits set in stone for what a "small" or "large" stock is. Finally, some investors argue that bitcoin is similar to gold, this would make them more comparable to a <a href="https://www.investopedia.com/terms/c/commodity.asp">commodity</a> instead.</em></p>


```python
# Selecting everything bigger than 10 billion 
largecaps = cap.query('market_cap_usd > 10000000000')

# Printing out largecaps
print(largecaps)
```

                 id  market_cap_usd
    0       bitcoin    2.130493e+11
    1      ethereum    4.352945e+10
    2  bitcoin-cash    2.529585e+10
    3          iota    1.475225e+10


## 10. Most coins are tiny
<p>Note that many coins are not comparable to large companies in market cap, so let's divert from the original Investopedia definition by merging categories.</p>
<p><em>This is all for now. Thanks for completing this project!</em></p>


```python
# Making a nice function for counting different marketcaps from the
# "cap" DataFrame. Returns an int.
# INSTRUCTORS NOTE: Since you made it to the end, consider it a gift :D
def capcount(query_string):
    return cap.query(query_string).count().id

# Labels for the plot
LABELS = ["biggish", "micro", "nano"]

# Using capcount count the biggish cryptos
biggish = capcount('market_cap_usd >= 300000000')

# Same as above for micro ...
micro = capcount('market_cap_usd >= 50000000 & market_cap_usd < 300000000')


# ... and for nano
nano =  capcount('market_cap_usd < 50000000')

# Making a list with the 3 counts
values = [biggish, micro, nano]


# Plotting them with matplotlib 
plt.bar(x = LABELS, height= values)
plt.title('Currency count per market cap')
plt.xlabel('cap definition')
plt.ylabel('count')


plt.show
```

![svg](output_28_1.svg)


