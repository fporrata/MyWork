
# Introduction to data analysis using machine learning 

## 02. Clustering with K-Means

In this notebook, we will look at the popular K-Means clustering algorithm, using the fruit database. The chief advantage of K-Means is that it's quick and robust, but its chief disadvantage is that you need to decide how many clusters there are beforehand ... except there's a way around that, the silhouette coefficient, which we'll see at the end of this notebook.

#### 1. import libraries and datafile #


```python
import pandas as pd
import numpy as np
from sklearn import cluster
import matplotlib.pyplot as plt
%matplotlib inline
from scipy import stats

df = pd.read_csv('fruit.csv')
# Since this is unsupervised classification, we'll drop the labels
df = df.drop(['fruit_id', 'fruit_name'], axis=1)
df.sort(['sweetness', 'acidity', 'weight', 'elongatedness'], inplace=True)
df.reset_index(drop=True, inplace=True)
df.tail(10)
```




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>color_id</th>
      <th>color_name</th>
      <th>elongatedness</th>
      <th>weight</th>
      <th>sweetness</th>
      <th>acidity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>169</th>
      <td> 4</td>
      <td> orange</td>
      <td> 0.08</td>
      <td> 144</td>
      <td> 3.58</td>
      <td> 1290</td>
    </tr>
    <tr>
      <th>170</th>
      <td> 5</td>
      <td>    red</td>
      <td> 0.11</td>
      <td> 182</td>
      <td> 3.58</td>
      <td> 1295</td>
    </tr>
    <tr>
      <th>171</th>
      <td> 4</td>
      <td> orange</td>
      <td> 0.11</td>
      <td> 144</td>
      <td> 3.59</td>
      <td> 1035</td>
    </tr>
    <tr>
      <th>172</th>
      <td> 4</td>
      <td> orange</td>
      <td> 0.09</td>
      <td> 143</td>
      <td> 3.63</td>
      <td> 1015</td>
    </tr>
    <tr>
      <th>173</th>
      <td> 6</td>
      <td> yellow</td>
      <td> 0.47</td>
      <td> 123</td>
      <td> 3.64</td>
      <td>  380</td>
    </tr>
    <tr>
      <th>174</th>
      <td> 6</td>
      <td> yellow</td>
      <td> 0.56</td>
      <td> 126</td>
      <td> 3.69</td>
      <td>  465</td>
    </tr>
    <tr>
      <th>175</th>
      <td> 5</td>
      <td>    red</td>
      <td> 0.11</td>
      <td> 189</td>
      <td> 3.71</td>
      <td>  780</td>
    </tr>
    <tr>
      <th>176</th>
      <td> 4</td>
      <td> orange</td>
      <td> 0.19</td>
      <td> 144</td>
      <td> 3.82</td>
      <td>  845</td>
    </tr>
    <tr>
      <th>177</th>
      <td> 5</td>
      <td>    red</td>
      <td> 0.09</td>
      <td> 191</td>
      <td> 3.92</td>
      <td> 1065</td>
    </tr>
    <tr>
      <th>178</th>
      <td> 2</td>
      <td>  brown</td>
      <td> 0.15</td>
      <td> 152</td>
      <td> 4.00</td>
      <td> 1035</td>
    </tr>
  </tbody>
</table>
</div>



#### 2. Explore and normalize two numeric features #

Since it's rather difficult to visualize more than two dimensions, we'll just use two of the five numeric features, ``acidity`` and ``sweetness``, which we saw exhibited some clustering in the first notebook


```python
columns = ['acidity', 'sweetness']
df[columns].describe()
```




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>acidity</th>
      <th>sweetness</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>  179.000000</td>
      <td> 179.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>  745.849162</td>
      <td>   2.606034</td>
    </tr>
    <tr>
      <th>std</th>
      <td>  314.332206</td>
      <td>   0.712020</td>
    </tr>
    <tr>
      <th>min</th>
      <td>  278.000000</td>
      <td>   1.270000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>  501.000000</td>
      <td>   1.925000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>  672.000000</td>
      <td>   2.780000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>  985.000000</td>
      <td>   3.170000</td>
    </tr>
    <tr>
      <th>max</th>
      <td> 1680.000000</td>
      <td>   4.000000</td>
    </tr>
  </tbody>
</table>
</div>



For many parametric algorithms, it's important to standardize (a.k.a. normalize) the data so that every feature has a mean of zero and a standard deviation of one.


```python
col1 = columns[0]
col2 = columns[1]
plt.scatter(df[col1], df[col2], s=44, c='#808080', alpha=0.5)
plt.xlim(df[col1].min(), df[col1].max())
plt.ylim(df[col2].min(), df[col2].max())
plt.title('before standardization')
plt.xlabel(col1)
plt.ylabel(col2)
plt.show()
```


![png](output_6_0.png)



```python
col1 = 'acidity_normal'
col2 = 'sweetness_normal'
df['sweetness_normal'] = (df.sweetness - df.sweetness.mean()) / df.sweetness.std()
df['acidity_normal'] = (df.acidity - df.acidity.mean()) / df.acidity.std()
plt.scatter(df[col1], df[col2], s=44, c='#808080', alpha=0.5)
plt.xlim(df[col1].min(), df[col1].max())
plt.ylim(df[col2].min(), df[col2].max())
plt.title('after standardization')
plt.xlabel(col1)
plt.ylabel(col2)
plt.show()
```


![png](output_7_0.png)


Make a numpy array of the (x, y) values of the above ``sweetness_normal`` and ``acidity_normal`` features


```python
data = np.array([list(df[col1]), list(df[col2])]).T # a 179 x 2 array of instances x features
data.shape
```




    (179, 2)



#### 3. Showing the steps of k-means centroid convergence #


```python
k = 3 #number of clusters

start= np.array([[ 1 , 0], [ 2, -1], [ 2, -2] ]) # starting points for the clusters

steps = ['Set initial centroids',
         '1A: assign clusters by proximity',
         '1B: move centroids to mid-cluster',
         '2A: re-assign clusters by proximity',
         '2B: move centroids to mid-cluster',
         '3A: re-assign clusters by proximity',
         '3B: move centroids to mid-cluster',
         'Final centroids and clusters']

centroids = []

for i, stepname in enumerate(steps):

    num_iterations = [1, 2, 2, 3, 3, 4, 4, 100][i]
    kmeans = cluster.KMeans(n_clusters=k, max_iter=num_iterations, init=start, n_init=1)
    kmeans.fit(data)
    labels = kmeans.labels_
    centroids.append(kmeans.cluster_centers_)
    
    plt.xlabel(col1)
    plt.ylabel(col2)
    plt.title(stepname)

    if i == 0:
        #plot every point in grey
        plt.plot(data[:,0],data[:,1],'o',markerfacecolor='#808080')
        for j in range(k):
            lines = plt.plot(centroids[i][j,0],centroids[i][j,1],'kx')
        # make the centroid x's bigger
            plt.setp(lines,ms=15.0)
            plt.setp(lines,mew=2.0)
    else: 
        # plot every label in a different color
        for j in range(k):
            subset = data[np.where(labels==j)]
            plt.plot(subset[:,0],subset[:,1],'o')
            # plot the centroids
            if i in [1,3,5]:
                # from previous step
                lines = plt.plot(centroids[i-1][j,0],centroids[i-1][j,1],'kx')
            else:
                lines = plt.plot(centroids[i][j,0],centroids[i][j,1],'kx')
            # make the centroid x's bigger
            plt.setp(lines,ms=15.0)
            plt.setp(lines,mew=2.0)

    plt.show()
    
```


![png](output_11_0.png)



![png](output_11_1.png)



![png](output_11_2.png)



![png](output_11_3.png)



![png](output_11_4.png)



![png](output_11_5.png)



![png](output_11_6.png)



![png](output_11_7.png)


#### 4. Evaluate the reproducibility of k-means clustering this dataset #

Since the final K-Means clusters can be dependent on the initial centroid positions chosen (usually randomly), let's run the algorithm 100 times and find out how often instances are assigned to different clusters. (Ironically, with K-Means clustering, the most inconsistent results can occur in datasets that exhibit the best clustering. This should not be an issue with out data, but it's best to be sure.)

First we make a 179x100 numpy array to hold the cluster assignments ('labels'): 0, 1 or 2 (since we have predetermined there are three clusters).


```python
for i in range(100):
    kmeans = cluster.KMeans(n_clusters=3, max_iter=100, init='random', n_init=1)
    kmeans.fit(data)
    labels = np.array(kmeans.labels_)
    if i==0:
        all_labels = labels
    else:
        all_labels = np.vstack((all_labels, labels))
```

Since the numbers of the clusters (0, 1 or 2) are not consistent from run to run, we will choose three datapoints that are representative of the clusters. Going through the data, I chose points 10, 144 and 160 in the lower left, upper left, and upper right, respectively.


```python
plt.scatter(df[col1], df[col2], s=7, c='#808080', alpha=0.5)
plt.scatter(data[10,0], data[10,1], s=72, c='#dddd22')
plt.scatter(data[144,0], data[144,1], s=66, c='#dddd22')
plt.scatter(data[160,0], data[160,1], s=66, c='#dddd22')
plt.xlim(df[col1].min(), df[col1].max())
plt.ylim(df[col2].min(), df[col2].max())
plt.title('chosen characteristic cluster points')
plt.xlabel(col1)
plt.ylabel(col2)
plt.show()
```


![png](output_15_0.png)


Go through each repetition and assign each point to the cluster that each of the above three points represents, then find any points whose cluster assignment has a nonzero standard deviation.


```python
regularized_labels = np.zeros(all_labels.shape, dtype=np.int8)
disagreements = []

for i in range(all_labels.shape[0]):
    cluster0 = all_labels[i, 10]
    cluster1 = all_labels[i, 144]
    cluster2 = all_labels[i, 160]
    for j in range(all_labels.shape[1]):
        if all_labels[i,j] == cluster1:
            regularized_labels[i,j] = 1
        elif all_labels[i,j] == cluster2:
            regularized_labels[i,j] = 2
        
for i in range(regularized_labels.shape[1]):
    disagreements.append(regularized_labels[:,i].std()) # standard deviations
```

Visualize all the points that are ever assigned to two different clusters.


```python
plt.scatter(df[col1], df[col2], s=12, c='#808080', alpha=0.5)
for i in range(len(disagreements)):
    if disagreements[i] > 0:
        plt.scatter(data[i,0], data[i,1], s=72, c='#dd22dd')
plt.xlim(df[col1].min(), df[col1].max())
plt.ylim(df[col2].min(), df[col2].max())
plt.title('points in different clusters after 100 runs')
plt.xlabel(col1)
plt.ylabel(col2)
plt.show()
```


![png](output_19_0.png)


#### 5. Cluster with different values of k #

What does the clustering look like with 2, 3, 4 or 5 clusters?


```python
# comparison of different values of k
def compare_kmeans(k):
    
    kmeans = cluster.KMeans(n_clusters=k)
    kmeans.fit(data)

    labels = kmeans.labels_
    centroids = kmeans.cluster_centers_

    plt.xlabel(col1)
    plt.ylabel(col2)
    plt.title('k-Means for k = ' + str(k))

    for i in range(k):
        subset = data[np.where(labels==i)]
        plt.plot(subset[:,0],subset[:,1],'o')
        # plot the centroids
        lines = plt.plot(centroids[i,0],centroids[i,1],'kx')
        # make the centroid x's bigger
        plt.setp(lines,ms=15.0)
        plt.setp(lines,mew=2.0)
    plt.show()
    
compare_kmeans(2)
compare_kmeans(3)
compare_kmeans(4)
compare_kmeans(5)
```


![png](output_21_0.png)



![png](output_21_1.png)



![png](output_21_2.png)



![png](output_21_3.png)


#### Find the maximum silhouette coefficient #

The silhouette coefficient compares inter- and intra-cluster distances to find the value of k that best separates the points into clusters.


```python
from sklearn.metrics import silhouette_score

def kmeans_silhouette(k):
    kmeans = cluster.KMeans(n_clusters=k)
    kmeans.fit(data)
    labels = kmeans.labels_
    score = silhouette_score(data, labels)
    return score

silhouettes = []
for i in range(2,10):
    silhouettes.append(kmeans_silhouette(i))

plt.plot(range(2,10), silhouettes, 'ro-', lw=2)
plt.title('Silhouette coefficient plot')
plt.xlabel('Number of clusters')
plt.ylabel('Silhouette coefficient')
plt.ylim(0, 0.6)
plt.xlim(1,10)
```




    (1, 10)




![png](output_23_1.png)

