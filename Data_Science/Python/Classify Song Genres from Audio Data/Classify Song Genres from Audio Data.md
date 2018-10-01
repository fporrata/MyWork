
## 1. Preparing our dataset
<p><em>These recommendations are so on point! How does this playlist know me so well?</em></p>
<p>Over the past few years, streaming services with huge catalogs have become the primary means through which most people listen to their favorite music. But at the same time, the sheer amount of music on offer can mean users might be a bit overwhelmed when trying to look for newer music that suits their tastes.</p>
<p>For this reason, streaming services have looked into means of categorizing music to allow for personalized recommendations. One method involves direct analysis of the raw audio information in a given song, scoring the raw data on a variety of metrics. Today, we'll be examining data compiled by a research group known as The Echo Nest. Our goal is to look through this dataset and classify songs as being either 'Hip-Hop' or 'Rock' - all without listening to a single one ourselves. In doing so, we will learn how to clean our data, do some exploratory data visualization, and use feature reduction towards the goal of feeding our data through some simple machine learning algorithms, such as decision trees and logistic regression.</p>
<p>To begin with, let's load the metadata about our tracks alongside the track metrics compiled by The Echo Nest. A song is about more than its title, artist, and number of listens. We have another dataset that has musical features of each track such as <code>danceability</code> and <code>acousticness</code> on a scale from -1 to 1. These exist in two different files, which are in different formats - CSV and JSON. While CSV is a popular file format for denoting tabular data, JSON is another common file format in which databases often return the results of a given query.</p>
<p>Let's start by creating two pandas <code>DataFrames</code> out of these files that we can merge so we have features and labels (often also referred to as <code>X</code> and <code>y</code>) for the classification later on.</p>


```python
import pandas as pd

# Read in track metadata with genre labels
tracks = pd.read_csv("datasets/fma-rock-vs-hiphop.csv")

# Read in track metrics with the features
echonest_metrics = pd.read_json("datasets/echonest-metrics.json", precise_float = True)

# Merge the relevant columns of tracks and echonest_metrics
#echo_tracks = tracks[['track_id', 'genre_top']].merge(echonest_metrics, left_on='track_id', right_on='track_id' )
echo_tracks = pd.merge(echonest_metrics, tracks[['track_id', 'genre_top']], on='track_id')
# Inspect the resultant dataframe
echo_tracks.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 4802 entries, 0 to 4801
    Data columns (total 10 columns):
    acousticness        4802 non-null float64
    danceability        4802 non-null float64
    energy              4802 non-null float64
    instrumentalness    4802 non-null float64
    liveness            4802 non-null float64
    speechiness         4802 non-null float64
    tempo               4802 non-null float64
    track_id            4802 non-null int64
    valence             4802 non-null float64
    genre_top           4802 non-null object
    dtypes: float64(8), int64(1), object(1)
    memory usage: 412.7+ KB


## 2. Pairwise relationships between continuous variables
<p>We typically want to avoid using variables that have strong correlations with each other -- hence avoiding feature redundancy -- for a few reasons:</p>
<ul>
<li>To keep the model simple and improve interpretability (with many features, we run the risk of overfitting).</li>
<li>When our datasets are very large, using fewer features can drastically speed up our computation time.</li>
</ul>
<p>To get a sense of whether there are any strongly correlated features in our data, we will use built-in functions in the <code>pandas</code> package.</p>


```python
# Create a correlation matrix
corr_metrics = echonest_metrics.corr()
corr_metrics.style.background_gradient()
```



<table id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013" > 
<thead>    <tr> 
        <th class="blank level0" ></th> 
        <th class="col_heading level0 col0" >acousticness</th> 
        <th class="col_heading level0 col1" >danceability</th> 
        <th class="col_heading level0 col2" >energy</th> 
        <th class="col_heading level0 col3" >instrumentalness</th> 
        <th class="col_heading level0 col4" >liveness</th> 
        <th class="col_heading level0 col5" >speechiness</th> 
        <th class="col_heading level0 col6" >tempo</th> 
        <th class="col_heading level0 col7" >track_id</th> 
        <th class="col_heading level0 col8" >valence</th> 
    </tr></thead> 
<tbody>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row0" class="row_heading level0 row0" >acousticness</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col0" class="data row0 col0" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col1" class="data row0 col1" >-0.189599</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col2" class="data row0 col2" >-0.477273</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col3" class="data row0 col3" >0.110033</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col4" class="data row0 col4" >0.0413193</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col5" class="data row0 col5" >0.0387845</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col6" class="data row0 col6" >-0.110701</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col7" class="data row0 col7" >-0.279829</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row0_col8" class="data row0 col8" >-0.0854362</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row1" class="row_heading level0 row1" >danceability</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col0" class="data row1 col0" >-0.189599</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col1" class="data row1 col1" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col2" class="data row1 col2" >0.0453446</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col3" class="data row1 col3" >-0.118033</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col4" class="data row1 col4" >-0.143339</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col5" class="data row1 col5" >0.171311</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col6" class="data row1 col6" >-0.0943519</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col7" class="data row1 col7" >0.102056</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row1_col8" class="data row1 col8" >0.428515</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row2" class="row_heading level0 row2" >energy</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col0" class="data row2 col0" >-0.477273</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col1" class="data row2 col1" >0.0453446</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col2" class="data row2 col2" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col3" class="data row2 col3" >-0.00241179</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col4" class="data row2 col4" >0.0457524</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col5" class="data row2 col5" >-0.00864488</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col6" class="data row2 col6" >0.227324</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col7" class="data row2 col7" >0.121991</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row2_col8" class="data row2 col8" >0.219384</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row3" class="row_heading level0 row3" >instrumentalness</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col0" class="data row3 col0" >0.110033</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col1" class="data row3 col1" >-0.118033</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col2" class="data row3 col2" >-0.00241179</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col3" class="data row3 col3" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col4" class="data row3 col4" >-0.0585932</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col5" class="data row3 col5" >-0.216689</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col6" class="data row3 col6" >0.0230032</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col7" class="data row3 col7" >-0.283206</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row3_col8" class="data row3 col8" >-0.1452</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row4" class="row_heading level0 row4" >liveness</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col0" class="data row4 col0" >0.0413193</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col1" class="data row4 col1" >-0.143339</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col2" class="data row4 col2" >0.0457524</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col3" class="data row4 col3" >-0.0585932</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col4" class="data row4 col4" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col5" class="data row4 col5" >0.0731041</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col6" class="data row4 col6" >-0.00756641</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col7" class="data row4 col7" >-0.00405934</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row4_col8" class="data row4 col8" >-0.0178859</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row5" class="row_heading level0 row5" >speechiness</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col0" class="data row5 col0" >0.0387845</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col1" class="data row5 col1" >0.171311</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col2" class="data row5 col2" >-0.00864488</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col3" class="data row5 col3" >-0.216689</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col4" class="data row5 col4" >0.0731041</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col5" class="data row5 col5" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col6" class="data row5 col6" >0.0321876</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col7" class="data row5 col7" >-0.0750767</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row5_col8" class="data row5 col8" >0.0947941</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row6" class="row_heading level0 row6" >tempo</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col0" class="data row6 col0" >-0.110701</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col1" class="data row6 col1" >-0.0943519</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col2" class="data row6 col2" >0.227324</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col3" class="data row6 col3" >0.0230032</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col4" class="data row6 col4" >-0.00756641</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col5" class="data row6 col5" >0.0321876</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col6" class="data row6 col6" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col7" class="data row6 col7" >0.004313</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row6_col8" class="data row6 col8" >0.129911</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row7" class="row_heading level0 row7" >track_id</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col0" class="data row7 col0" >-0.279829</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col1" class="data row7 col1" >0.102056</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col2" class="data row7 col2" >0.121991</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col3" class="data row7 col3" >-0.283206</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col4" class="data row7 col4" >-0.00405934</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col5" class="data row7 col5" >-0.0750767</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col6" class="data row7 col6" >0.004313</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col7" class="data row7 col7" >1</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row7_col8" class="data row7 col8" >0.0202007</td> 
    </tr>    <tr> 
        <th id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013level0_row8" class="row_heading level0 row8" >valence</th> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col0" class="data row8 col0" >-0.0854362</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col1" class="data row8 col1" >0.428515</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col2" class="data row8 col2" >0.219384</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col3" class="data row8 col3" >-0.1452</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col4" class="data row8 col4" >-0.0178859</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col5" class="data row8 col5" >0.0947941</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col6" class="data row8 col6" >0.129911</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col7" class="data row8 col7" >0.0202007</td> 
        <td id="T_c8e8e022_c5c8_11e8_9e76_0242ac110013row8_col8" class="data row8 col8" >1</td> 
    </tr></tbody> 
</table> 


## 3. Normalizing the feature data
<p>As mentioned earlier, it can be particularly useful to simplify our models and use as few features as necessary to achieve the best result. Since we didn't find any particular strong correlations between our features, we can instead use a common approach to reduce the number of features called <strong>principal component analysis (PCA)</strong>. </p>
<p>It is possible that the variance between genres can be explained by just a few features in the dataset. PCA rotates the data along the axis of highest variance, thus allowing us to determine the relative contribution of each feature of our data towards the variance between classes. </p>
<p>However, since PCA uses the absolute variance of a feature to rotate the data, a feature with a broader range of values will overpower and bias the algorithm relative to the other features. To avoid this, we must first normalize our data. There are a few methods to do this, but a common way is through <em>standardization</em>, such that all features have a mean = 0 and standard deviation = 1 (the resultant is a z-score).</p>


```python
# Define our features 
features = echo_tracks.drop(['track_id', 'genre_top'], axis = 1)

# Define our labels
labels = echo_tracks['genre_top']

# Import the StandardScaler
from sklearn.preprocessing import StandardScaler

# Scale the features and set the values to a new variable
scaler = StandardScaler()
scaled_train_features = scaler.fit_transform(features)

```

## 4. Principal Component Analysis on our scaled data
<p>Now that we have preprocessed our data, we are ready to use PCA to determine by how much we can reduce the dimensionality of our data. We can use <strong>scree-plots</strong> and <strong>cumulative explained ratio plots</strong> to find the number of components to use in further analyses.</p>
<p>Scree-plots display the number of components against the variance explained by each component, sorted in descending order of variance. Scree-plots help us get a better sense of which components explain a sufficient amount of variance in our data. When using scree plots, an 'elbow' (a steep drop from one data point to the next) in the plot is typically used to decide on an appropriate cutoff.</p>


```python
# This is just to make plots appear in the notebook
%matplotlib inline

# Import our plotting module, and PCA class
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA

# Get our explained variance ratios from PCA using all features
pca = PCA()
pca.fit(scaled_train_features)
exp_variance = pca.explained_variance_ratio_

# plot the explained variance using a barplot 
fig, ax = plt.subplots()
ax.bar(range(pca.n_components_), height = exp_variance)
ax.set_xlabel('Principal Component #')


```


![png](output_10_1.png)


## 5. Further visualization of PCA
<p>Unfortunately, there does not appear to be a clear elbow in this scree plot, which means it is not straightforward to find the number of intrinsic dimensions using this method. </p>
<p>But all is not lost! Instead, we can also look at the <strong>cumulative explained variance plot</strong> to determine how many features are required to explain, say, about 90% of the variance (cutoffs are somewhat arbitrary here, and usually decided upon by 'rules of thumb'). Once we determine the appropriate number of components, we can perform PCA with that many components, ideally reducing the dimensionality of our data.</p>


```python
# Import numpy
import numpy as np

# Calculate the cumulative explained variance
cum_exp_variance = np.cumsum(exp_variance)

# Plot the cumulative explained variance and draw a dashed line at 0.90.
fig, ax = plt.subplots()
ax.plot(cum_exp_variance)
ax.axhline(y=0.9, linestyle='--')
n_components = 6

# Perform PCA with the chosen number of components and project data onto components
pca = PCA(n_components, random_state=10)
pca.fit(scaled_train_features)
pca_projection = pca.transform(scaled_train_features)
```


![png](output_13_0.png)


## 6. Train a decision tree to classify genre
<p>Now we can use the lower dimensional PCA projection of the data to classify songs into genres. To do that, we first need to split our dataset into 'train' and 'test' subsets, where the 'train' subset will be used to train our model while the 'test' dataset allows for model performance validation.</p>
<p>Here, we will be using a simple algorithm known as a decision tree. Decision trees are rule-based classifiers that take in features and follow a 'tree structure' of binary decisions to ultimately classify a data point into one of two or more categories. In addition to being easy to both use and interpret, decision trees allow us to visualize the 'logic flowchart' that the model generates from the training data.</p>
<p>Here is an example of a decision tree that demonstrates the process by which an input image (in this case, of a shape) might be classified based on the number of sides it has and whether it is rotated.</p>

![png](0.PNG)


```python
# Import train_test_split function and Decision tree classifier
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
# Split our data
train_features, test_features, train_labels, test_labels = train_test_split(pca_projection, labels,random_state=10)

# Train our decision tree
tree = DecisionTreeClassifier(random_state=10)
tree.fit(train_features,train_labels)

# Predict the labels for the test data
pred_labels_tree = tree.predict(test_features )
```

## 7. Compare our decision tree to a logistic regression
<p>Although our tree's performance is decent, it's a bad idea to immediately assume that it's therefore the perfect tool for this job -- there's always the possibility of other models that will perform even better! It's always a worthwhile idea to at least test a few other algorithms and find the one that's best for our data.</p>
<p>Sometimes simplest is best, and so we will start by applying <strong>logistic regression</strong>. Logistic regression makes use of what's called the logistic function to calculate the odds that a given data point belongs to a given class. Once we have both models, we can compare them on a few performance metrics, such as false positive and false negative rate (or how many points are inaccurately classified). </p>


```python
# Import LogisticRegression
from sklearn.linear_model import LogisticRegression

# Train our logistic regression and predict labels for the test set
logreg =  LogisticRegression(random_state = 10) 
logreg.fit(train_features,train_labels)
pred_labels_logit = logreg.predict(test_features)

# Create the classification report for both models
from sklearn.metrics import classification_report
class_rep_tree = classification_report(test_labels, pred_labels_tree)
class_rep_log = classification_report(test_labels, pred_labels_logit)

print("Decision Tree: \n", class_rep_tree)
print("Logistic Regression: \n", class_rep_log)


```

    Decision Tree: 
                  precision    recall  f1-score   support
    
        Hip-Hop       0.66      0.66      0.66       229
           Rock       0.92      0.92      0.92       972
    
    avg / total       0.87      0.87      0.87      1201
    
    Logistic Regression: 
                  precision    recall  f1-score   support
    
        Hip-Hop       0.75      0.57      0.65       229
           Rock       0.90      0.95      0.93       972
    
    avg / total       0.87      0.88      0.87      1201
    


## 8. Balance our data for greater performance
<p>Both our models do similarly well, boasting an average precision of 87% each. However, looking at our classification report, we can see that rock songs are fairly well classified, but hip-hop songs are disproportionately misclassified as rock songs. </p>
<p>Why might this be the case? Well, just by looking at the number of data points we have for each class, we see that we have far more data points for the rock classification than for hip-hop, potentially skewing our model's ability to distinguish between classes. This also tells us that most of our model's accuracy is driven by its ability to classify just rock songs, which is less than ideal.</p>
<p>To account for this, we can weight the value of a correct classification in each class inversely to the occurrence of data points for each class. Since a correct classification for "Rock" is not more important than a correct classification for "Hip-Hop" (and vice versa), we only need to account for differences in <em>sample size</em> of our data points when weighting our classes here, and not relative importance of each class. </p>


```python
# Subset only the hip-hop tracks, and then only the rock tracks
hop_only = echo_tracks.loc[echo_tracks['genre_top'] == 'Hip-Hop']
rock_only = echo_tracks.loc[echo_tracks['genre_top']  == 'Rock']

# sample the rocks songs to be the same number as there are hip-hop songs
rock_only = rock_only.sample(n = len(hop_only),  random_state = 10)

# concatenate the dataframes rock_only and hop_only
rock_hop_bal = pd.concat([rock_only, hop_only] )

# The features, labels, and pca projection are created for the balanced dataframe
features = rock_hop_bal.drop(['genre_top', 'track_id'], axis=1) 
labels = rock_hop_bal['genre_top']
pca_projection = pca.fit_transform(scaler.fit_transform(features))

# Redefine the train and test set with the pca_projection from the balanced data
train_features, test_features, train_labels, test_labels = train_test_split(pca_projection, labels, random_state=10)


```

## 9. Does balancing our dataset improve model bias?
<p>We've now balanced our dataset, but in doing so, we've removed a lot of data points that might have been crucial to training our models. Let's test to see if balancing our data improves model bias towards the "Rock" classification while retaining overall classification performance. </p>
<p>Note that we have already reduced the size of our dataset and will go forward without applying any dimensionality reduction. In practice, we would consider dimensionality reduction more rigorously when dealing with vastly large datasets and when computation times become prohibitively large.</p>


```python
# Train our decision tree on the balanced data
tree = DecisionTreeClassifier(random_state = 10)
tree.fit(train_features,train_labels)
pred_labels_tree = tree.predict(test_features )

# Train our logistic regression on the balanced data
logreg =  LogisticRegression(random_state = 10) 
logreg.fit(train_features,train_labels)
pred_labels_logit = logreg.predict(test_features)

# Compare the models
print("Decision Tree: \n", classification_report(test_labels, pred_labels_tree))
print("Logistic Regression: \n", classification_report(test_labels, pred_labels_logit))
```

    Decision Tree: 
                  precision    recall  f1-score   support
    
        Hip-Hop       0.77      0.77      0.77       230
           Rock       0.76      0.76      0.76       225
    
    avg / total       0.76      0.76      0.76       455
    
    Logistic Regression: 
                  precision    recall  f1-score   support
    
        Hip-Hop       0.82      0.83      0.82       230
           Rock       0.82      0.81      0.82       225
    
    avg / total       0.82      0.82      0.82       455
    


## 10. Using cross-validation to evaluate our models
<p>Success! Balancing our data has removed bias towards the more prevalent class. To get a good sense of how well our models are actually performing, we can apply what's called <strong>cross-validation</strong> (CV). This step allows us to compare models in a more rigorous fashion.</p>
<p>Since the way our data is split into train and test sets can impact model performance, CV attempts to split the data multiple ways and test the model on each of the splits. Although there are many different CV methods, all with their own advantages and disadvantages, we will use what's known as <strong>K-fold</strong> CV here. K-fold first splits the data into K different, equally sized subsets. Then, it iteratively uses each subset as a test set while using the remainder of the data as train sets. Finally, we can then aggregate the results from each fold for a final model performance score.</p>


```python
from sklearn.model_selection import KFold, cross_val_score

# Set up our K-fold cross-validation
kf = KFold(n_splits = 10,  random_state = 10, shuffle=False)

tree = DecisionTreeClassifier(random_state=10)
logreg = LogisticRegression(random_state=10)

# Train our models using KFold cv
tree_score = cross_val_score(tree,pca_projection ,labels, cv=kf)
logit_score = cross_val_score(logreg, pca_projection ,labels, cv=kf)


# Print the mean of each array of scores
print("Decision Tree:", np.mean(tree_score), "Logistic Regression:", np.mean(logit_score))


```

    Decision Tree: 0.7241758241758242 Logistic Regression: 0.7752747252747252


