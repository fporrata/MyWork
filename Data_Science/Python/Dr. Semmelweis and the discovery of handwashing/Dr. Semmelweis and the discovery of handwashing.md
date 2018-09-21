
## 1. Meet Dr. Ignaz Semmelweis
<p><img style="float: left;margin:5px 20px 5px 1px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_20/img/ignaz_semmelweis_1860.jpeg"></p>
<!--
<img style="float: left;margin:5px 20px 5px 1px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_20/datasets/ignaz_semmelweis_1860.jpeg">
-->
<p>This is Dr. Ignaz Semmelweis, a Hungarian physician born in 1818 and active at the Vienna General Hospital. If Dr. Semmelweis looks troubled it's probably because he's thinking about <em>childbed fever</em>: A deadly disease affecting women that just have given birth. He is thinking about it because in the early 1840s at the Vienna General Hospital as many as 10% of the women giving birth die from it. He is thinking about it because he knows the cause of childbed fever: It's the contaminated hands of the doctors delivering the babies. And they won't listen to him and <em>wash their hands</em>!</p>
<p>In this notebook, we're going to reanalyze the data that made Semmelweis discover the importance of <em>handwashing</em>. Let's start by looking at the data that made Semmelweis realize that something was wrong with the procedures at Vienna General Hospital.</p>


```python
# importing modules
import pandas as pd

# Read datasets/yearly_deaths_by_clinic.csv into yearly
yearly = pd.read_csv("datasets/yearly_deaths_by_clinic.csv")

# Print out yearly
print(yearly)
```

        year  births  deaths    clinic
    0   1841    3036     237  clinic 1
    1   1842    3287     518  clinic 1
    2   1843    3060     274  clinic 1
    3   1844    3157     260  clinic 1
    4   1845    3492     241  clinic 1
    5   1846    4010     459  clinic 1
    6   1841    2442      86  clinic 2
    7   1842    2659     202  clinic 2
    8   1843    2739     164  clinic 2
    9   1844    2956      68  clinic 2
    10  1845    3241      66  clinic 2
    11  1846    3754     105  clinic 2



```python
%%nose

import pandas as pd

def test_yearly_exists():
    assert "yearly" in globals(), \
        "The variable yearly should be defined."
        
def test_yearly_correctly_loaded():
    correct_yearly = pd.read_csv("datasets/yearly_deaths_by_clinic.csv")
    try:
        pd.testing.assert_frame_equal(yearly, correct_yearly)
    except AssertionError:
        assert False, "The variable yearly should contain the data in yearly_deaths_by_clinic.csv"
        
```






    2/2 tests passed




## 2. The alarming number of deaths
<p>The table above shows the number of women giving birth at the two clinics at the Vienna General Hospital for the years 1841 to 1846. You'll notice that giving birth was very dangerous; an <em>alarming</em> number of women died as the result of childbirth, most of them from childbed fever.</p>
<p>We see this more clearly if we look at the <em>proportion of deaths</em> out of the number of women giving birth. Let's zoom in on the proportion of deaths at Clinic 1.</p>


```python
# Calculate proportion of deaths per no. births
yearly["proportion_deaths"] = (yearly["deaths"]/yearly["births"])

# Extract clinic 1 data into yearly1 and clinic 2 data into yearly2
yearly1 = yearly[yearly.clinic == "clinic 1"]
yearly2 = yearly[yearly.clinic == "clinic 2"]

# Print out yearly1
print(yearly1)
print(yearly2)
```

       year  births  deaths    clinic  proportion_deaths
    0  1841    3036     237  clinic 1           0.078063
    1  1842    3287     518  clinic 1           0.157591
    2  1843    3060     274  clinic 1           0.089542
    3  1844    3157     260  clinic 1           0.082357
    4  1845    3492     241  clinic 1           0.069015
    5  1846    4010     459  clinic 1           0.114464
        year  births  deaths    clinic  proportion_deaths
    6   1841    2442      86  clinic 2           0.035217
    7   1842    2659     202  clinic 2           0.075968
    8   1843    2739     164  clinic 2           0.059876
    9   1844    2956      68  clinic 2           0.023004
    10  1845    3241      66  clinic 2           0.020364
    11  1846    3754     105  clinic 2           0.027970



```python
%%nose

def test_proportion_deaths_exists():
    assert 'proportion_deaths' in yearly, \
        "The DataFrame yearly should have the column proportion_deaths"

def test_proportion_deaths_is_correctly_calculated():
    assert all(yearly["proportion_deaths"] == yearly["deaths"] / yearly["births"]), \
        "The column proportion_deaths should be the number of deaths divided by the number of births."
   
def test_yearly1_correct_shape():
    assert yearly1.shape == yearly[yearly["clinic"] == "clinic 1"].shape, \
        "yearly1 should contain the rows in yearly from clinic 1"

def test_yearly2_correct_shape():
    assert yearly2.shape == yearly[yearly["clinic"] == "clinic 2"].shape, \
        "yearly2 should contain the rows in yearly from clinic 2"
```






    4/4 tests passed




## 3. Death at the clinics
<p>If we now plot the proportion of deaths at both clinic 1 and clinic 2  we'll see a curious pattern...</p>


```python
# This makes plots appear in the notebook
%matplotlib inline

# Plot yearly proportion of deaths at the two clinics
ax = yearly1.plot(x="year", y="proportion_deaths",
              label="Clinic 1")
yearly2.plot(x="year", y="proportion_deaths",
         label="Clinic 2",  ax=ax)

ax.set_ylabel("Proportion deaths")
```




    <matplotlib.text.Text at 0x7fd9b5c23f98>




![png](output_7_1.png)



```python
%%nose

def test_ax_exists():
    assert 'ax' in globals(), \
        "The result of the plot method should be assigned to a variable called ax"
        
def test_plot_plots_correct_data():
    y0 = ax.get_lines()[0].get_ydata()
    y1 = ax.get_lines()[1].get_ydata()
    assert (
        (all(yearly1["proportion_deaths"] == y0) and
         all(yearly2["proportion_deaths"] == y1))
        or
        (all(yearly1["proportion_deaths"] == y1) and
         all(yearly2["proportion_deaths"] == y0))), \
        "The data from clinic 1 and clinic 2 should be plotted as two separate lines."
```






    2/2 tests passed




## 4. The handwashing begins
<p>Why is the proportion of deaths constantly so much higher in Clinic 1? Semmelweis saw the same pattern and was puzzled and distressed. The only difference between the clinics was that many medical students served at Clinic 1, while mostly midwife students served at Clinic 2. While the midwives only tended to the women giving birth, the medical students also spent time in the autopsy rooms examining corpses. </p>
<p>Semmelweis started to suspect that something on the corpses, spread from the hands of the medical students, caused childbed fever. So in a desperate attempt to stop the high mortality rates, he decreed: <em>Wash your hands!</em> This was an unorthodox and controversial request, nobody in Vienna knew about bacteria at this point in time. </p>
<p>Let's load in monthly data from Clinic 1 to see if the handwashing had any effect.</p>


```python
# Read datasets/monthly_deaths.csv into monthly
monthly = pd.read_csv("datasets/monthly_deaths.csv", parse_dates=["date"])

# Calculate proportion of deaths per no. births
monthly["proportion_deaths"] = (monthly["deaths"]/monthly["births"])

# Print out the first rows in monthly
monthly.head()
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
      <th>date</th>
      <th>births</th>
      <th>deaths</th>
      <th>proportion_deaths</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1841-01-01</td>
      <td>254</td>
      <td>37</td>
      <td>0.145669</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1841-02-01</td>
      <td>239</td>
      <td>18</td>
      <td>0.075314</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1841-03-01</td>
      <td>277</td>
      <td>12</td>
      <td>0.043321</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1841-04-01</td>
      <td>255</td>
      <td>4</td>
      <td>0.015686</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1841-05-01</td>
      <td>255</td>
      <td>2</td>
      <td>0.007843</td>
    </tr>
  </tbody>
</table>
</div>




```python
%%nose

def test_monthly_exists():
    assert "monthly" in globals(), \
        "The variable monthly should be defined."
        
def test_monthly_correctly_loaded():
    correct_monthly = pd.read_csv("datasets/monthly_deaths.csv")
    try:
        pd.testing.assert_series_equal(monthly["births"], correct_monthly["births"])
    except AssertionError:
        assert False, "The variable monthly should contain the data in monthly_deaths.csv"

def test_date_correctly_converted():
    assert monthly.date.dtype == pd.to_datetime(pd.Series("1847-06-01")).dtype, \
        "The column date should be converted using the pd.to_datetime() function"        
        
def test_proportion_deaths_is_correctly_calculated():
    assert all(monthly["proportion_deaths"] == monthly["deaths"] / monthly["births"]), \
        "The column proportion_deaths should be the number of deaths divided by the number of births."
```






    4/4 tests passed




## 5. The effect of handwashing
<p>With the data loaded we can now look at the proportion of deaths over time. In the plot below we haven't marked where obligatory handwashing started, but it reduced the proportion of deaths to such a degree that you should be able to spot it!</p>


```python
# Plot monthly proportion of deaths
ax = monthly.plot(x="date", y="proportion_deaths",
              label="Clinic 1")
ax.set_ylabel("Proportion deaths")
```




    <matplotlib.text.Text at 0x7fd9b5c35ef0>




![png](output_13_1.png)



```python
%%nose
        
def test_ax_exists():
    assert 'ax' in globals(), \
        "The result of the plot method should be assigned to a variable called ax"

def test_plot_plots_correct_data():
    y0 = ax.get_lines()[0].get_ydata()
    assert all(monthly["proportion_deaths"] == y0), \
        "The plot should show the column 'proportion_deaths' in monthly."
```






    2/2 tests passed




## 6. The effect of handwashing highlighted
<p>Starting from the summer of 1847 the proportion of deaths is drastically reduced and, yes, this was when Semmelweis made handwashing obligatory. </p>
<p>The effect of handwashing is made even more clear if we highlight this in the graph.</p>


```python
# Date when handwashing was made mandatory
import pandas as pd
handwashing_start = pd.to_datetime('1847-06-01')

# Split monthly into before and after handwashing_start
before_washing =monthly[monthly.date < handwashing_start]
after_washing = monthly[monthly.date >= handwashing_start]

# Plot monthly proportion of deaths before and after handwashing
ax = before_washing.plot(x="date", y="proportion_deaths",
              label="Before Handwashing")
after_washing.plot(x="date", y="proportion_deaths",
         label="After Handwashing",  ax=ax)

ax.set_ylabel("Proportion deaths")
```




    <matplotlib.text.Text at 0x7fd9b80eca20>




![png](output_16_1.png)



```python
%%nose

def test_before_washing_correct():
    correct_before_washing = monthly[monthly["date"] < handwashing_start]
    try:
        pd.testing.assert_frame_equal(before_washing, correct_before_washing)
    except AssertionError:
        assert False, "before_washing should contain the rows of monthly < handwashing_start" 

def test_after_washing_correct():
    correct_after_washing = monthly[monthly["date"] >= handwashing_start]
    try:
        pd.testing.assert_frame_equal(after_washing, correct_after_washing)
    except AssertionError:
        assert False, "after_washing should contain the rows of monthly >= handwashing_start" 

def test_ax_exists():
    assert 'ax' in globals(), \
        "The result of the plot method should be assigned to a variable called ax"

        
def test_plot_plots_correct_data():
    y0_len = ax.get_lines()[0].get_ydata().shape[0]
    y1_len = ax.get_lines()[1].get_ydata().shape[0]
    assert (
        (before_washing["proportion_deaths"].shape[0] == y0_len and
         after_washing["proportion_deaths"].shape[0] == y1_len)
        or
        (before_washing["proportion_deaths"].shape[0] == y0_len and
         after_washing["proportion_deaths"].shape[0] == y1_len)), \
        "The data in before_washing and after_washing should be plotted as two separate lines."
```






    4/4 tests passed




## 7. More handwashing, fewer deaths?
<p>Again, the graph shows that handwashing had a huge effect. How much did it reduce the monthly proportion of deaths on average?</p>


```python
# Difference in mean monthly proportion of deaths due to handwashing
before_proportion = before_washing["proportion_deaths"]
after_proportion = after_washing["proportion_deaths"]
mean_diff = after_proportion.mean() - before_proportion.mean()
mean_diff

```




    -0.08395660751183336




```python
%%nose
        
def test_before_proportion_exists():
    assert 'before_proportion' in globals(), \
        "before_proportion should be defined"
        
def test_after_proportion_exists():
    assert 'after_proportion' in globals(), \
        "after_proportion should be defined"
        
def test_mean_diff_exists():
    assert 'mean_diff' in globals(), \
        "mean_diff should be defined"
        
def test_before_proportion_is_a_series():
     assert hasattr(before_proportion, '__len__') and len(before_proportion) == 76, \
        "before_proportion should be 76 elements long, and not a single number."

def test_correct_mean_diff():
    correct_before_proportion = before_washing["proportion_deaths"]
    correct_after_proportion = after_washing["proportion_deaths"]
    correct_mean_diff = correct_after_proportion.mean() - correct_before_proportion.mean()
    assert mean_diff == correct_mean_diff, \
        "mean_diff should be calculated as the mean of after_proportion minus the mean of before_proportion."
```






    5/5 tests passed




## 8. A Bootstrap analysis of Semmelweis handwashing data
<p>It reduced the proportion of deaths by around 8 percentage points! From 10% on average to just 2% (which is still a high number by modern standards). </p>
<p>To get a feeling for the uncertainty around how much handwashing reduces mortalities we could look at a confidence interval (here calculated using the bootstrap method).</p>


```python
# A bootstrap analysis of the reduction of deaths due to handwashing
boot_mean_diff = []
for i in range(3000):
    boot_before = before_proportion.sample(frac=1, replace=True)
    boot_after = after_proportion.sample(frac=1, replace=True)
    boot_mean_diff.append( boot_after.mean() - boot_before.mean() )

# Calculating a 95% confidence interval from boot_mean_diff 
confidence_interval = pd.Series(boot_mean_diff).quantile([0.025, 0.975])
confidence_interval

```




    0.025   -0.101096
    0.975   -0.067355
    dtype: float64




```python
%%nose

def test_confidence_interval_exists():
    assert 'confidence_interval' in globals(), \
        "confidence_interval should be defined"

def test_boot_before_correct_length():
    assert len(boot_before) == len(before_proportion), \
        ("boot_before have {} elements and before_proportion have {}." + 
         "They should have the same number of elements."
        ).format(len(boot_before), len(before_proportion))
        
def test_confidence_interval_correct():
    assert ((0.09 < abs(confidence_interval).max() < 0.11) and
            (0.055 < abs(confidence_interval).min() < 0.075)) , \
        "confidence_interval should be calculated as the [0.025, 0.975] quantiles of boot_mean_diff."
```






    3/3 tests passed




## 9. The fate of Dr. Semmelweis
<p>So handwashing reduced the proportion of deaths by between 6.7 and 10 percentage points, according to a 95% confidence interval. All in all, it would seem that Semmelweis had solid evidence that handwashing was a simple but highly effective procedure that could save many lives.</p>
<p>The tragedy is that, despite the evidence, Semmelweis' theory — that childbed fever was caused by some "substance" (what we today know as <em>bacteria</em>) from autopsy room corpses — was ridiculed by contemporary scientists. The medical community largely rejected his discovery and in 1849 he was forced to leave the Vienna General Hospital for good.</p>
<p>One reason for this was that statistics and statistical arguments were uncommon in medical science in the 1800s. Semmelweis only published his data as long tables of raw data, but he didn't show any graphs nor confidence intervals. If he would have had access to the analysis we've just put together he might have been more successful in getting the Viennese doctors to wash their hands.</p>


```python
# The data Semmelweis collected points to that:
doctors_should_wash_their_hands = True
```


```python
%%nose

def test_doctors_should_was_their_hands():
    assert doctors_should_wash_their_hands, \
        "Semmelweis would argue that doctors_should_wash_their_hands should be True ."
```






    1/1 tests passed



