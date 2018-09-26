
(c) 2016 Enplus Advisors, Inc.


```python
import numpy as np
import pandas as pd
```


```python
dat = pd.read_csv('starmine.csv', parse_dates=['date'])
dat = dat.set_index(['date', 'symbol'], verify_integrity=True).sort_index()
dat.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>country</th>
      <th>sector</th>
      <th>sec</th>
      <th>ind</th>
      <th>size</th>
      <th>smi</th>
      <th>liq</th>
      <th>ret_0_1_m</th>
      <th>...</th>
      <th>ret_1_0_m</th>
      <th>ret_6_0_m</th>
      <th>ret_12_0_m</th>
      <th>mn_dollar_volume_20_d</th>
      <th>md_dollar_volume_120_d</th>
      <th>cap_usd</th>
      <th>cap</th>
      <th>sales</th>
      <th>net_income</th>
      <th>common_equity</th>
    </tr>
    <tr>
      <th>date</th>
      <th>symbol</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="5" valign="top">1995-01-31</th>
      <th>0223B</th>
      <td>87259410</td>
      <td>Tnp Enterprises Inc</td>
      <td>USA</td>
      <td>Utils</td>
      <td>UTL</td>
      <td>ELUTL</td>
      <td>-1.269609</td>
      <td>52.0</td>
      <td>NaN</td>
      <td>-0.019461</td>
      <td>...</td>
      <td>0.016807</td>
      <td>0.037494</td>
      <td>-0.083792</td>
      <td>158116.9</td>
      <td>312075.0</td>
      <td>1.657880e+08</td>
      <td>1.657880e+08</td>
      <td>4.742420e+08</td>
      <td>11605000.0</td>
      <td>2.136270e+08</td>
    </tr>
    <tr>
      <th>0392B</th>
      <td>44701594</td>
      <td>Huntsman Polymers Corp</td>
      <td>USA</td>
      <td>Manuf</td>
      <td>MAT</td>
      <td>CHEMS</td>
      <td>-1.906326</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>-0.034483</td>
      <td>...</td>
      <td>-0.105263</td>
      <td>0.118421</td>
      <td>2.148148</td>
      <td>1687355.0</td>
      <td>1586025.0</td>
      <td>1.141984e+08</td>
      <td>1.141984e+08</td>
      <td>4.293530e+08</td>
      <td>-25243000.0</td>
      <td>-5.137000e+06</td>
    </tr>
    <tr>
      <th>0485B</th>
      <td>05978410</td>
      <td>Banctec Inc</td>
      <td>USA</td>
      <td>HiTec</td>
      <td>TEC</td>
      <td>ITCON</td>
      <td>-1.081318</td>
      <td>11.0</td>
      <td>NaN</td>
      <td>-0.089655</td>
      <td>...</td>
      <td>-0.149425</td>
      <td>-0.086420</td>
      <td>-0.177778</td>
      <td>2398715.0</td>
      <td>1212200.0</td>
      <td>1.947350e+08</td>
      <td>1.947350e+08</td>
      <td>2.475380e+08</td>
      <td>16343000.0</td>
      <td>1.282730e+08</td>
    </tr>
    <tr>
      <th>0491B</th>
      <td>25660510</td>
      <td>Dole Food Co Inc</td>
      <td>USA</td>
      <td>NoDur</td>
      <td>CNS</td>
      <td>FDPRD</td>
      <td>0.608282</td>
      <td>26.0</td>
      <td>0.084006</td>
      <td>-0.051092</td>
      <td>...</td>
      <td>0.179348</td>
      <td>-0.028464</td>
      <td>-0.055357</td>
      <td>5373490.0</td>
      <td>2730825.0</td>
      <td>1.635040e+09</td>
      <td>1.635040e+09</td>
      <td>3.430521e+09</td>
      <td>77889000.0</td>
      <td>1.052114e+09</td>
    </tr>
    <tr>
      <th>0517B</th>
      <td>89621510</td>
      <td>Trimas Corp</td>
      <td>USA</td>
      <td>Manuf</td>
      <td>IND</td>
      <td>MACHN</td>
      <td>0.053782</td>
      <td>72.0</td>
      <td>-0.318195</td>
      <td>0.146497</td>
      <td>...</td>
      <td>-0.010561</td>
      <td>-0.142731</td>
      <td>-0.167145</td>
      <td>524532.5</td>
      <td>532500.0</td>
      <td>7.182750e+08</td>
      <td>7.182750e+08</td>
      <td>4.432300e+08</td>
      <td>38000000.0</td>
      <td>2.448500e+08</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 21 columns</p>
</div>




```python
sp5 = pd.read_csv('sp500.csv', parse_dates=['date'], index_col=['date']).sort_index()
sp5.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>open</th>
      <th>high</th>
      <th>low</th>
      <th>close</th>
      <th>volume</th>
      <th>adj_close</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1950-01-03</th>
      <td>16.66</td>
      <td>16.66</td>
      <td>16.66</td>
      <td>16.66</td>
      <td>1260000</td>
      <td>16.66</td>
    </tr>
    <tr>
      <th>1950-01-04</th>
      <td>16.85</td>
      <td>16.85</td>
      <td>16.85</td>
      <td>16.85</td>
      <td>1890000</td>
      <td>16.85</td>
    </tr>
    <tr>
      <th>1950-01-05</th>
      <td>16.93</td>
      <td>16.93</td>
      <td>16.93</td>
      <td>16.93</td>
      <td>2550000</td>
      <td>16.93</td>
    </tr>
    <tr>
      <th>1950-01-06</th>
      <td>16.98</td>
      <td>16.98</td>
      <td>16.98</td>
      <td>16.98</td>
      <td>2010000</td>
      <td>16.98</td>
    </tr>
    <tr>
      <th>1950-01-09</th>
      <td>17.08</td>
      <td>17.08</td>
      <td>17.08</td>
      <td>17.08</td>
      <td>2520000</td>
      <td>17.08</td>
    </tr>
  </tbody>
</table>
</div>



**Exercise:**

Calculate the average `smi` by sector.


```python
dat.groupby('sector')['smi'].mean()
```




    sector
    Durbl    41.495868
    Enrgy    37.072148
    HiTec    61.005006
    Hlth     51.898917
    Manuf    54.563836
    Money    52.549612
    NoDur    45.263033
    Other    45.847586
    Shops    46.668071
    Telcm    43.003344
    Utils    46.740057
    Name: smi, dtype: float64



**Exercise:**

Compute summary statistics on `smi` and `cap_usd`


```python
dat[['smi', 'cap_usd']].describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>smi</th>
      <th>cap_usd</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>19739.000000</td>
      <td>2.758300e+04</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>51.192715</td>
      <td>2.087045e+09</td>
    </tr>
    <tr>
      <th>std</th>
      <td>28.446720</td>
      <td>6.094795e+09</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>1.000200e+08</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>28.000000</td>
      <td>2.217303e+08</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>50.000000</td>
      <td>5.009156e+08</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>75.500000</td>
      <td>1.434850e+09</td>
    </tr>
    <tr>
      <th>max</th>
      <td>100.000000</td>
      <td>1.145130e+11</td>
    </tr>
  </tbody>
</table>
</div>



**Exercise:**

By month and sector, calculate the median of `size` and standard deviation of `liq`


```python
newdat = dat.reset_index().groupby(['date', 'sector'])
sector_by_month = newdat.agg({
    'size': 'median',
    'liq': 'std'
})

sector_by_month

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>size</th>
      <th>liq</th>
    </tr>
    <tr>
      <th>date</th>
      <th>sector</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="11" valign="top">1995-01-31</th>
      <th>Durbl</th>
      <td>-0.209173</td>
      <td>0.249388</td>
    </tr>
    <tr>
      <th>Enrgy</th>
      <td>-0.196118</td>
      <td>0.261843</td>
    </tr>
    <tr>
      <th>HiTec</th>
      <td>-0.616841</td>
      <td>0.216948</td>
    </tr>
    <tr>
      <th>Hlth</th>
      <td>-0.574538</td>
      <td>0.225687</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.059248</td>
      <td>0.271732</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.209731</td>
      <td>0.277742</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>0.014463</td>
      <td>0.281873</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.389198</td>
      <td>0.272468</td>
    </tr>
    <tr>
      <th>Shops</th>
      <td>-0.377426</td>
      <td>0.245019</td>
    </tr>
    <tr>
      <th>Telcm</th>
      <td>0.245578</td>
      <td>0.319236</td>
    </tr>
    <tr>
      <th>Utils</th>
      <td>0.364334</td>
      <td>0.248619</td>
    </tr>
    <tr>
      <th rowspan="11" valign="top">1995-02-28</th>
      <th>Durbl</th>
      <td>-0.104903</td>
      <td>0.250885</td>
    </tr>
    <tr>
      <th>Enrgy</th>
      <td>-0.168405</td>
      <td>0.260743</td>
    </tr>
    <tr>
      <th>HiTec</th>
      <td>-0.603860</td>
      <td>0.220062</td>
    </tr>
    <tr>
      <th>Hlth</th>
      <td>-0.603196</td>
      <td>0.229634</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.037930</td>
      <td>0.277932</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.175834</td>
      <td>0.280808</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>-0.008857</td>
      <td>0.284352</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.369152</td>
      <td>0.278322</td>
    </tr>
    <tr>
      <th>Shops</th>
      <td>-0.373304</td>
      <td>0.246268</td>
    </tr>
    <tr>
      <th>Telcm</th>
      <td>0.254605</td>
      <td>0.327027</td>
    </tr>
    <tr>
      <th>Utils</th>
      <td>0.362641</td>
      <td>0.252811</td>
    </tr>
    <tr>
      <th rowspan="8" valign="top">1995-03-31</th>
      <th>Durbl</th>
      <td>-0.180092</td>
      <td>0.240854</td>
    </tr>
    <tr>
      <th>Enrgy</th>
      <td>-0.063967</td>
      <td>0.253053</td>
    </tr>
    <tr>
      <th>HiTec</th>
      <td>-0.633887</td>
      <td>0.222146</td>
    </tr>
    <tr>
      <th>Hlth</th>
      <td>-0.613903</td>
      <td>0.211776</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.054066</td>
      <td>0.272534</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.199084</td>
      <td>0.276247</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>-0.045826</td>
      <td>0.281757</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.367154</td>
      <td>0.274186</td>
    </tr>
    <tr>
      <th>...</th>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th rowspan="8" valign="top">1995-09-30</th>
      <th>Hlth</th>
      <td>-0.591918</td>
      <td>0.210491</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.002176</td>
      <td>0.268338</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.168304</td>
      <td>0.283089</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>0.040862</td>
      <td>0.269791</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.278389</td>
      <td>0.265114</td>
    </tr>
    <tr>
      <th>Shops</th>
      <td>-0.384670</td>
      <td>0.257384</td>
    </tr>
    <tr>
      <th>Telcm</th>
      <td>0.079380</td>
      <td>0.317832</td>
    </tr>
    <tr>
      <th>Utils</th>
      <td>0.448477</td>
      <td>0.241216</td>
    </tr>
    <tr>
      <th rowspan="11" valign="top">1995-10-31</th>
      <th>Durbl</th>
      <td>-0.101982</td>
      <td>0.259077</td>
    </tr>
    <tr>
      <th>Enrgy</th>
      <td>0.005642</td>
      <td>0.210177</td>
    </tr>
    <tr>
      <th>HiTec</th>
      <td>-0.574153</td>
      <td>0.213616</td>
    </tr>
    <tr>
      <th>Hlth</th>
      <td>-0.605683</td>
      <td>0.229014</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.015455</td>
      <td>0.262092</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.150701</td>
      <td>0.285444</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>-0.017909</td>
      <td>0.276449</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.335399</td>
      <td>0.263521</td>
    </tr>
    <tr>
      <th>Shops</th>
      <td>-0.297481</td>
      <td>0.258768</td>
    </tr>
    <tr>
      <th>Telcm</th>
      <td>0.054268</td>
      <td>0.306151</td>
    </tr>
    <tr>
      <th>Utils</th>
      <td>0.439357</td>
      <td>0.242291</td>
    </tr>
    <tr>
      <th rowspan="11" valign="top">1995-11-30</th>
      <th>Durbl</th>
      <td>-0.065283</td>
      <td>0.244325</td>
    </tr>
    <tr>
      <th>Enrgy</th>
      <td>0.005791</td>
      <td>0.228582</td>
    </tr>
    <tr>
      <th>HiTec</th>
      <td>-0.568216</td>
      <td>0.216067</td>
    </tr>
    <tr>
      <th>Hlth</th>
      <td>-0.627659</td>
      <td>0.212029</td>
    </tr>
    <tr>
      <th>Manuf</th>
      <td>-0.025581</td>
      <td>0.263323</td>
    </tr>
    <tr>
      <th>Money</th>
      <td>-0.142364</td>
      <td>0.286863</td>
    </tr>
    <tr>
      <th>NoDur</th>
      <td>0.048762</td>
      <td>0.275936</td>
    </tr>
    <tr>
      <th>Other</th>
      <td>-0.282161</td>
      <td>0.268359</td>
    </tr>
    <tr>
      <th>Shops</th>
      <td>-0.292740</td>
      <td>0.252594</td>
    </tr>
    <tr>
      <th>Telcm</th>
      <td>0.136029</td>
      <td>0.310414</td>
    </tr>
    <tr>
      <th>Utils</th>
      <td>0.444181</td>
      <td>0.242624</td>
    </tr>
  </tbody>
</table>
<p>121 rows × 2 columns</p>
</div>



**Exercise:**

By month, calculate 5 quantiles (0.01, 0.25, 0.5, 0.75, 0.99) for smi, the median size, and the average liquidity. Use the default `pandas` quantile approximation algorithm.


```python
#solution 1
quantile5 = np.array([0.01, 0.25, 0.5, 0.75, 0.99])
newdat = dat.groupby(level='date')
smi_quantiles = newdat.apply(lambda x: x.smi.dropna().quantile(quantile5))
smi_quantiles


```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>smi</th>
      <th>0.01</th>
      <th>0.25</th>
      <th>0.5</th>
      <th>0.75</th>
      <th>0.99</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1995-01-31</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>51.0</td>
      <td>78.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-02-28</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>49.0</td>
      <td>78.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-03-31</th>
      <td>2.0</td>
      <td>26.0</td>
      <td>49.0</td>
      <td>73.0</td>
      <td>99.46</td>
    </tr>
    <tr>
      <th>1995-04-30</th>
      <td>2.0</td>
      <td>26.0</td>
      <td>48.0</td>
      <td>77.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-05-31</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>49.0</td>
      <td>75.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-06-30</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>51.0</td>
      <td>74.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-07-31</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>52.0</td>
      <td>78.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-08-31</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>50.0</td>
      <td>77.0</td>
      <td>99.00</td>
    </tr>
    <tr>
      <th>1995-09-30</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>50.0</td>
      <td>74.0</td>
      <td>99.00</td>
    </tr>
    <tr>
      <th>1995-10-31</th>
      <td>2.0</td>
      <td>28.0</td>
      <td>52.0</td>
      <td>78.0</td>
      <td>100.00</td>
    </tr>
    <tr>
      <th>1995-11-30</th>
      <td>2.0</td>
      <td>29.0</td>
      <td>50.0</td>
      <td>72.0</td>
      <td>99.00</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Solution 2
solution = newdat['smi'].apply(lambda x: x.quantile(quantile5))
solution
```




    date            
    1995-01-31  0.01      2.00
                0.25     28.00
                0.50     51.00
                0.75     78.00
                0.99    100.00
    1995-02-28  0.01      2.00
                0.25     28.00
                0.50     49.00
                0.75     78.00
                0.99    100.00
    1995-03-31  0.01      2.00
                0.25     26.00
                0.50     49.00
                0.75     73.00
                0.99     99.46
    1995-04-30  0.01      2.00
                0.25     26.00
                0.50     48.00
                0.75     77.00
                0.99    100.00
    1995-05-31  0.01      2.00
                0.25     28.00
                0.50     49.00
                0.75     75.00
                0.99    100.00
    1995-06-30  0.01      2.00
                0.25     28.00
                0.50     51.00
                0.75     74.00
                0.99    100.00
    1995-07-31  0.01      2.00
                0.25     28.00
                0.50     52.00
                0.75     78.00
                0.99    100.00
    1995-08-31  0.01      2.00
                0.25     28.00
                0.50     50.00
                0.75     77.00
                0.99     99.00
    1995-09-30  0.01      2.00
                0.25     28.00
                0.50     50.00
                0.75     74.00
                0.99     99.00
    1995-10-31  0.01      2.00
                0.25     28.00
                0.50     52.00
                0.75     78.00
                0.99    100.00
    1995-11-30  0.01      2.00
                0.25     29.00
                0.50     50.00
                0.75     72.00
                0.99     99.00
    Name: smi, dtype: float64


