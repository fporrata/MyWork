
## 1. Introduction
<p>Version control repositories like CVS, Subversion or Git can be a real gold mine for software developers. They contain every change to the source code including the date (the "when"), the responsible developer (the "who"), as well as little message that describes the intention (the "what") of a change.</p>
<p><a href="https://commons.wikimedia.org/wiki/File:Tux.svg">
<img style="float: right;margin:5px 20px 5px 1px" width="150px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_111/img/tux.png" alt="Tux - the Linux mascot">
</a></p>
<p>In this notebook, we will analyze the evolution of a very famous open-source project &ndash; the Linux kernel. The Linux kernel is the heart of some Linux distributions like Debian, Ubuntu or CentOS. </p>
<p>We get some first insights into the work of the development efforts by </p>
<ul>
<li>identifying the TOP 10 contributors and</li>
<li>visualizing the commits over the years.</li>
</ul>
<p>Linus Torvalds, the (spoiler alert!) main contributor to the Linux kernel (and also the creator of Git), created a <a href="https://github.com/torvalds/linux/">mirror of the Linux repository on GitHub</a>. It contains the complete history of kernel development for the last 13 years.</p>
<p>For our analysis, we will use a Git log file with the following content:</p>


```python
# Printing the content of git_log_excerpt.csv
read_data = ""
with open('datasets/git_log_excerpt.csv') as f:
         read_data = f.read()
f.closed
print(read_data)

```

    1502382966#Linus Torvalds
    1501368308#Max Gurtovoy
    1501625560#James Smart
    1501625559#James Smart
    1500568442#Martin Wilck
    1502273719#Xin Long
    1502278684#Nikolay Borisov
    1502238384#Girish Moodalbail
    1502228709#Florian Fainelli
    1502223836#Jon Paul Maloy



```python
%%nose

def test_listing_of_file_contents():
    
    # FIXME1: if student executes cell more than once, variable _i2 is then not defined. Solution?
    
    #PATH = "datasets/git_log_excerpt.csv"
    # hard coded cell number: maybe a little bit fragile
    #cell_input_from_sample_code = _i2
    #assert PATH in cell_input_from_sample_code, \
    #"The file %s should be read in." % PATH
    
    # FIXME2: can't access the sample code cell's output here because of the use of 'print'
    
    # test currently deactivated: too hard to create a table test case
    assert True
```






    1/1 tests passed




## 2. Reading in the dataset
<p>The dataset was created by using the command <code>git log --encoding=latin-1 --pretty="%at#%aN"</code>. The <code>latin-1</code> encoded text output was saved in a header-less csv file. In this file, each row is a commit entry with the following information:</p>
<ul>
<li><code>timestamp</code>: the time of the commit as a UNIX timestamp in seconds since 1970-01-01 00:00:00 (Git log placeholder "<code>%at</code>")</li>
<li><code>author</code>: the name of the author that performed the commit (Git log placeholder "<code>%aN</code>")</li>
</ul>
<p>The columns are separated by the number sign <code>#</code>. The complete dataset is in the <code>datasets/</code> directory. It is a <code>gz</code>-compressed csv file named <code>git_log.gz</code>.</p>


```python
# Loading in the pandas module
import pandas as pd

# Reading in the log file
git_log = pd.read_csv("datasets/git_log.gz", names=['timestamp','author'], sep="#",encoding = 'latin-1', header=None)

# Printing out the first 5 rows
git_log.head()




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
      <th>timestamp</th>
      <th>author</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1502826583</td>
      <td>Linus Torvalds</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1501749089</td>
      <td>Adrian Hunter</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1501749088</td>
      <td>Adrian Hunter</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1501882480</td>
      <td>Kees Cook</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1497271395</td>
      <td>Rob Clark</td>
    </tr>
  </tbody>
</table>
</div>




```python
%%nose


def test_is_pandas_loaded_as_pd():
    
    try:
        pd # throws NameError
        pd.DataFrame # throws AttributeError
    except NameError:
        assert False, "Module pandas not loaded as pd."
    except AttributeError:
        assert False, "Variable pd is used as short name for another module."
    
    
def test_is_git_log_data_frame_existing():
    
    try:
        # checks implicitly if git_log by catching the NameError exception
        assert isinstance(git_log, pd.DataFrame), "git_log isn't a DataFrame."
              
    except NameError as e:
        assert False, "Variable git_log doesn't exist."


def test_has_git_log_correct_columns():
    
    expected = ['timestamp', 'author']
    assert all(git_log.columns.get_values() == expected), \
        "Expected columns are %s" % expected
        

def test_is_logfile_content_read_in_correctly():
    
    correct_git_log = pd.read_csv(
        'datasets/git_log.gz',
        sep='#',
        encoding='latin-1',
        header=None,
        names=['timestamp', 'author'])
    
    assert correct_git_log.equals(git_log), \
        "The content of datasets/git_log.gz wasn't correctly read into git_log. Check the parameters of read_csv."
```






    4/4 tests passed




## 3. Getting an overview
<p>The dataset contains the information about every single code contribution (a "commit") to the Linux kernel over the last 13 years. We'll first take a look at the number of authors and their commits to the repository.</p>


```python
# calculating number of commits
number_of_commits = git_log['timestamp'].count()

# calculating number of authors
number_of_authors = len(git_log['author'].dropna().unique())


# printing out the results
print("%s authors committed %s code changes." % (number_of_authors, number_of_commits))
```

    17385 authors committed 699071 code changes.



```python
%%nose

def test_basic_statistics():
    assert number_of_commits == len(git_log), \
    "The number of commits should be right."
    assert number_of_authors == len(git_log['author'].dropna().unique()), \
    "The number of authors should be right."
```






    1/1 tests passed




## 4. Finding the TOP 10 contributors
<p>There are some very important people that changed the Linux kernel very often. To see if there are any bottlenecks, we take a look at the TOP 10 authors with the most commits.</p>


```python
# Identifying the top 10 authors
top_10_authors = git_log['author'].value_counts().head(10)

# Listing contents of 'top_10_authors'
top_10_authors
```




    Linus Torvalds           23361
    David S. Miller           9106
    Mark Brown                6802
    Takashi Iwai              6209
    Al Viro                   6006
    H Hartley Sweeten         5938
    Ingo Molnar               5344
    Mauro Carvalho Chehab     5204
    Arnd Bergmann             4890
    Greg Kroah-Hartman        4580
    Name: author, dtype: int64




```python
%%nose


def test_is_series_or_data_frame():
    
    assert isinstance(top_10_authors, pd.Series) or isinstance(top_10_authors, pd.DataFrame), \
    "top_10_authors isn't a Series or DataFrame, but of type %s." % type(top_10_authors)

    
def test_is_result_structurally_alright():
    
    top10 = top_10_authors.squeeze()
    # after a squeeze(), the DataFrame with one Series should be converted to a Series
    assert isinstance(top10, pd.Series), \
    "top_10_authors should only contain the data for authors and the number of commits."
    

def test_is_right_number_of_entries():
    
    expected_number_of_entries = 10
    assert len(top_10_authors.squeeze()) is expected_number_of_entries, \
    "The number of TOP 10 entries should be %r. Be sure to store the result into the 'top_10_authors' variable." % expected_number_of_entries 
    
    
def test_is_expected_top_author():
    
    expected_top_author = "Linus Torvalds"
    assert top_10_authors.squeeze().index[0] == expected_top_author, \
    "The number one contributor should be %s." % expected_top_author
    
    
def test_is_expected_top_commits():    
    expected_top_commits = 23361
    assert top_10_authors.squeeze()[0] == expected_top_commits, \
    "The number of the most commits should be %r." % expected_top_commits
```






    5/5 tests passed




## 5. Wrangling the data
<p>For our analysis, we want to visualize the contributions over time. For this, we use the information in the <code>timestamp</code> column to create a time series-based column.</p>


```python
# converting the timestamp column
git_log['timestamp'] = pd.to_datetime(git_log['timestamp'], unit='s')

# summarizing the converted timestamp column
git_log['timestamp'].describe()
```




    count                  699071
    unique                 668448
    top       2008-09-04 05:30:19
    freq                       99
    first     1970-01-01 00:00:01
    last      2037-04-25 08:08:26
    Name: timestamp, dtype: object




```python
%%nose

def test_timestamps():
    
    START_DATE = '1970-01-01 00:00:01'
    assert START_DATE in str(git_log['timestamp'].min()), \
    'The first timestamp should be %s.' % START_DATE
    
    END_DATE = '2037-04-25 08:08:26'
    assert END_DATE in str(git_log['timestamp'].max()), \
    'The last timestamp should be %s.' % END_DATE
```






    1/1 tests passed




## 6. Treating wrong timestamps
<p>As we can see from the results above, some contributors had their operating system's time incorrectly set when they committed to the repository. We'll clean up the <code>timestamp</code> column by dropping the rows with the incorrect timestamps.</p>


```python
first_Torvalds_commit = git_log.loc[git_log['author'] == 'Linus Torvalds', 'timestamp'].sort_values().head(1)

# determining the first real commit timestamp
first_commit_timestamp = first_Torvalds_commit.iloc[0]

# determining the last sensible commit timestamp
last_commit_timestamp = pd.to_datetime('today')

# filtering out wrong timestamps
corrected_log = git_log.loc[(git_log['timestamp'] >= first_commit_timestamp) & (git_log['timestamp'] <= last_commit_timestamp)]

# summarizing the corrected timestamp column
corrected_log['timestamp'].describe()
```




    count                  698569
    unique                 667977
    top       2008-09-04 05:30:19
    freq                       99
    first     2005-04-16 22:20:36
    last      2017-10-03 12:57:00
    Name: timestamp, dtype: object




```python
%%nose

def test_corrected_timestamps():
    
    FIRST_REAL_COMMIT = '2005-04-16 22:20:36'
    assert FIRST_REAL_COMMIT in str(corrected_log['timestamp'].min()), \
    'The first real commit timestamp should be %s.' % FIRST_REAL_COMMIT
    
    LAST_REAL_COMMIT = '2017-10-03 12:57:00'
    assert LAST_REAL_COMMIT in str(corrected_log['timestamp'].max()), \
    'The last real commit timestamp should be %s.' % LAST_REAL_COMMIT
```






    1/1 tests passed




## 7. Grouping commits per year
<p>To find out how the development activity has increased over time, we'll group the commits by year and count them up.</p>


```python
# Counting the no. commits per year
commits_per_year = corrected_log.groupby(
    pd.Grouper(
        key='timestamp', 
        freq='AS'
        )
    ).count()

# Listing the first rows
commits_per_year.head()
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
      <th>author</th>
    </tr>
    <tr>
      <th>timestamp</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2005-01-01</th>
      <td>16229</td>
    </tr>
    <tr>
      <th>2006-01-01</th>
      <td>29255</td>
    </tr>
    <tr>
      <th>2007-01-01</th>
      <td>33759</td>
    </tr>
    <tr>
      <th>2008-01-01</th>
      <td>48847</td>
    </tr>
    <tr>
      <th>2009-01-01</th>
      <td>52572</td>
    </tr>
  </tbody>
</table>
</div>




```python
%%nose

def test_number_of_commits_per_year():
    
    YEARS = 13
    assert len(commits_per_year) == YEARS, \
    'Number of years should be %s.' % YEARS
    
    
def test_new_beginning_of_git_log():
    
    START = '2005-01-01 00:00:00'
    assert START in str(commits_per_year.index[0]), \
    'DataFrame should start at %s' % START
```






    2/2 tests passed




## 8. Visualizing the history of Linux
<p>Finally, we'll make a plot out of these counts to better see how the development effort on Linux has increased over the the last few years. </p>


```python
# Setting up plotting in Jupyter notebooks
%matplotlib inline

# plot the data
ax = commits_per_year.plot(kind ='line', title = 'Commits per year', legend = False)
ax.set_xlabel("Year")
ax.set_ylabel("Commits")
```




    <matplotlib.text.Text at 0x7f911fbf0ba8>




![png](output_22_1.png)



```python
%%nose

def test_call_to_plot():
    
    # FIXME: Different results local and on build server.
    # - local (expected): AssertionError: Plot type should be a bar chart.
    # - build server: NameError: name '_i20' is not defined
    # deactivating tests
    
    #assert "kind='bar'" in _i20, "Plot type should be a bar chart."
    
    # test currently deactivated: too hard to create a table test case
    assert True
```






    1/1 tests passed




## 9.  Conclusion
<p>Thanks to the solid foundation and caretaking of Linux Torvalds, many other developers are now able to contribute to the Linux kernel as well. There is no decrease of development activity at sight!</p>


```python
# calculating or setting the year with the most commits to Linux
year_with_most_commits = 2016 
```


```python
%%nose

def test_year_with_most_commits():
    assert str(year_with_most_commits).endswith("16") , \
        "Write the year with the most commits as 20??, but with ?? replaced."
```






    1/1 tests passed



