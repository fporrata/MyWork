
## 1. Darwin's bibliography

<img src="CharlesDarwin.jpg" alt="drawing" width="200"/>

<p>Charles Darwin is one of the few universal figures of science. His most renowned work is without a doubt his "<em>On the Origin of Species</em>" published in 1859 which introduced the concept of natural selection. But Darwin wrote many other books on a wide range of topics, including geology, plants or his personal life. In this notebook, we will automatically detect how closely related his books are to each other.</p>
<p>To this purpose, we will develop the bases of <strong>a content-based book recommendation system</strong>, which will determine which books are close to each other based on how similar the discussed topics are. The methods we will use are commonly used in text- or documents-heavy industries such as legal, tech or customer support to perform some common task such as text classification or handling search engine queries.</p>
<p>Let's take a look at the books we'll use in our recommendation system.</p>


```python
# Import library
import glob

# The books files are contained in this folder
folder = "datasets/"

# List all the .txt files and sort them alphabetically
files = glob.glob(folder + '*.txt')
files.sort()
files


```




    ['datasets/Autobiography.txt',
     'datasets/CoralReefs.txt',
     'datasets/DescentofMan.txt',
     'datasets/DifferentFormsofFlowers.txt',
     'datasets/EffectsCrossSelfFertilization.txt',
     'datasets/ExpressionofEmotionManAnimals.txt',
     'datasets/FormationVegetableMould.txt',
     'datasets/FoundationsOriginofSpecies.txt',
     'datasets/GeologicalObservationsSouthAmerica.txt',
     'datasets/InsectivorousPlants.txt',
     'datasets/LifeandLettersVol1.txt',
     'datasets/LifeandLettersVol2.txt',
     'datasets/MonographCirripedia.txt',
     'datasets/MonographCirripediaVol2.txt',
     'datasets/MovementClimbingPlants.txt',
     'datasets/OriginofSpecies.txt',
     'datasets/PowerMovementPlants.txt',
     'datasets/VariationPlantsAnimalsDomestication.txt',
     'datasets/VolcanicIslands.txt',
     'datasets/VoyageBeagle.txt']


## 2. Load the contents of each book into Python
<p>As a first step, we need to load the content of these books into Python and do some basic pre-processing to facilitate the downstream analyses. We call such a collection of texts <strong>a corpus</strong>. We will also store the titles for these books for future reference and print their respective length to get a gauge for their contents.</p>


```python
# Import libraries
import re, os

# Initialize the object that will contain the texts and titles
txts = []
titles = []

for n in files:
    # Open each file
    f = open(n, encoding = 'utf-8-sig')
    # Remove all non-alpha-numeric characters
    pattern = re.compile('^[\w-]+$')
    fclean = pattern.sub('',f.read())
    
    # Store the texts and titles of the books in two separate lists
    txts.append(fclean) 
    titles.append(os.path.basename(n).replace('.txt', ''))

# Print the length, in characters, of each book
[len(t) for t in txts]
```




    [126535,
     515199,
     1853959,
     637442,
     953361,
     646127,
     352125,
     557591,
     825187,
     933920,
     1082757,
     1054634,
     815756,
     1815025,
     314447,
     945712,
     1133642,
     1139290,
     352425,
     1188353]


## 3. Find "On the Origin of Species"
<p>For the next parts of this analysis, we will often check the results returned by our method for a given book. For consistency, we will refer to Darwin's most famous book: "<em>On the Origin of Species</em>." Let's find to which index this book is associated.</p>


```python
# Browse the list containing all the titles
for i in range(len(titles)):
    # Store the index if the title is "OriginofSpecies"
    if (titles[i] == "OriginofSpecies"):
        ori = i

# Print the stored index
ori
```
    15


## 4. Tokenize the corpus
<p>As a next step, we need to transform the corpus into a format that is easier to deal with for the downstream analyses. We will tokenize our corpus, i.e., transform each text into a list of the individual words (called tokens) it is made of. To check the output of our process, we will print the first 20 tokens of "<em>On the Origin of Species</em>".</p>


```python
# Define a list of stop words
stoplist = set('for a of the and to in to be which some is at that we i who whom show via may my our might as well'.split())

# Convert the text to lower case 
txts_lower_case = [t.lower() for t in txts]

# Transform the text into tokens 
txts_split = [t.split() for t in txts_lower_case]

# Remove tokens which are part of the list of stop words
texts = [[word for word in txt if word not in list(stoplist)] for txt in txts_split]
#texts = [not w in list(stoplist) for w in txts_split]

# Print the first 20 tokens for the "On the Origin of Species" book
texts[ori][1:20]


```




    ['origin',
     'species.',
     '*',
     '*',
     '*',
     '*',
     '*',
     '"but',
     'with',
     'regard',
     'material',
     'world,',
     'can',
     'least',
     'go',
     'so',
     'far',
     'this--we',
     'can']


## 5. Stemming of the tokenized corpus
<p>If you have read <em>On the Origin of Species</em>, you will have noticed that Charles Darwin can use different words to refer to a similar concept. For example, the concept of selection can be described by words such as <em>selection</em>, <em>selective</em>, <em>select</em> or <em>selects</em>. This will dilute the weight given to this concept in the book and potentially bias the results of the analysis.</p>
<p>To solve this issue, it is a common practice to use a <strong>stemming process</strong>, which will group together the inflected forms of a word so they can be analysed as a single item: <strong>the stem</strong>. In our <em>On the Origin of Species</em> example, the words related to the concept of selection would be gathered under the <em>select</em> stem.</p>
<p>As we are analysing 20 full books, the stemming algorithm can take several minutes to run and, in order to make the process faster, we will directly load the final results from a pickle file and review the method used to generate it.</p>


```python
import pickle

# Load the stemmed tokens list from the pregenerated pickle file
texts_stem = pickle.load(open(r"datasets/texts_stem.p", "rb"))

# Print the 20 first stemmed tokens from the "On the Origin of Species" book
texts_stem[ori][1:20]
```




    ['origin',
     'speci',
     'but',
     'with',
     'regard',
     'materi',
     'world',
     'can',
     'least',
     'go',
     'so',
     'far',
     'thi',
     'can',
     'perceiv',
     'event',
     'are',
     'brought',
     'about']


## 6. Building a bag-of-words model
<p>Now that we have transformed the texts into stemmed tokens, we need to build models that will be useable by downstream algorithms.</p>
<p>First, we need to will create a universe of all words contained in our corpus of Charles Darwin's books, which we call <em>a dictionary</em>. Then, using the stemmed tokens and the dictionary, we will create <strong>bag-of-words models</strong> (BoW) of each of our texts. The BoW models will represent our books as a list of all uniques tokens they contain associated with their respective number of occurrences. </p>
<p>To better understand the structure of such a model, we will print the five first elements of one of the "<em>On the Origin of Species</em>" BoW model.</p>


```python
# Load the functions allowing to create and use dictionaries
from gensim import corpora

# Create a dictionary from the stemmed tokens
dictionary = corpora.Dictionary(texts_stem)

# Create a bag-of-words model for each book, using the previously generated dictionary
bows = [dictionary.doc2bow(txt) for txt in txts_split]

# Print the first five elements of the On the Origin of species' BoW model
bows[ori][1:5]




```




    [(23, 1), (27, 1), (63, 2), (65, 1)]


## 7. The most common words of a given book
<p>The results returned by the bag-of-words model is certainly easy to use for a computer but hard to interpret for a human. It is not straightforward to understand which stemmed tokens are present in a given book from Charles Darwin, and how many occurrences we can find.</p>
<p>In order to better understand how the model has been generated and visualize its content, we will transform it into a DataFrame and display the 10 most common stems for the book "<em>On the Origin of Species</em>".</p>


```python
# Import pandas to create and manipulate DataFrames
import pandas as pd

# Convert the BoW model for "On the Origin of Species" into a DataFrame
df_bow_origin = pd.DataFrame(bows[ori])

# Add the column names to the DataFrame
df_bow_origin.columns = ['index', 'occurrences']

# Add a column containing the token corresponding to the dictionary index
df_bow_origin["token"] = [dictionary[index] for index in df_bow_origin.index]

# Sort the DataFrame by descending number of occurrences and print the first 10 values
df_bow_origin.sort_values(by=['occurrences'], ascending = False).head(10)



```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>index</th>
      <th>occurrences</th>
      <th>token</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1176</th>
      <td>4479</td>
      <td>7681</td>
      <td>heart</td>
    </tr>
    <tr>
      <th>1341</th>
      <td>6005</td>
      <td>4380</td>
      <td>interbr</td>
    </tr>
    <tr>
      <th>2027</th>
      <td>24478</td>
      <td>3600</td>
      <td>rejoic</td>
    </tr>
    <tr>
      <th>380</th>
      <td>1168</td>
      <td>1749</td>
      <td>brush</td>
    </tr>
    <tr>
      <th>77</th>
      <td>286</td>
      <td>1630</td>
      <td>8500</td>
    </tr>
    <tr>
      <th>580</th>
      <td>1736</td>
      <td>1486</td>
      <td>conway</td>
    </tr>
    <tr>
      <th>127</th>
      <td>393</td>
      <td>1350</td>
      <td>advis</td>
    </tr>
    <tr>
      <th>584</th>
      <td>1747</td>
      <td>1173</td>
      <td>corps</td>
    </tr>
    <tr>
      <th>330</th>
      <td>1043</td>
      <td>1131</td>
      <td>bleed</td>
    </tr>
    <tr>
      <th>52</th>
      <td>218</td>
      <td>1114</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>

## 8. Build a tf-idf model
<p>If it wasn't for the presence of the stem "<em>speci</em>", we would have a hard time to guess this BoW model comes from the <em>On the Origin of Species</em> book. The most recurring words are, apart from few exceptions, very common and unlikely to carry any information peculiar to the given book. We need to use an additional step in order to determine which tokens are the most specific to a book.</p>
<p>To do so, we will use a <strong>tf-idf model</strong> (term frequency–inverse document frequency). This model defines the importance of each word depending on how frequent it is in this text and how infrequent it is in all the other documents. As a result, a high tf-idf score for a word will indicate that this word is specific to this text.</p>
<p>After computing those scores, we will print the 10 words most specific to the "<em>On the Origin of Species</em>" book (i.e., the 10 words with the highest tf-idf score).</p>


```python
# Load the gensim functions that will allow us to generate tf-idf models
from gensim.models import TfidfModel

# Generate the tf-idf model
model = TfidfModel(bows)

# Print the model for "On the Origin of Species"
model[bows[ori]]
```




    [(0, 0.0010623348867173012),
     (23, 0.004619413661598463),
     (27, 0.0030139521361860224),
     (63, 0.009238827323196926),
     (65, 0.001450328426833015),
     (75, 0.004025618979311572),
     (78, 0.012139484176862957),
     (84, 0.0017981510141551168),
     (91, 0.004499848502582165),
     (95, 0.002575290552478557),
     (97, 0.005150581104957114),
     (99, 0.020966709215717527),
     (111, 0.010623348867173012),
     (115, 0.0038788716823142254),
     (118, 0.042488194619020356),
     (123, 0.04619413661598463),
     (130, 0.01310923945119178),
     (137, 0.03233589563118924),
     (138, 0.00413746312780184),
     (140, 0.00258591445487615),
     (144, 0.015102768269457228),
     (157, 0.0037181721035105544),
     (165, 0.02012809489655786),
     (172, 0.03937367439759394),
     (173, 0.018590860517552772),
     (176, 0.008533517701091295),
        ...]


## 9. The results of the tf-idf model
<p>Once again, the format of those results is hard to interpret for a human. Therefore, we will transform it into a more readable version and display the 10 most specific words for the "<em>On the Origin of Species</em>" book.</p>


```python
# Convert the tf-idf model for "On the Origin of Species" into a DataFrame
df_tfidf = pd.DataFrame(model[bows[ori]])

# Name the columns of the DataFrame id and score
df_tfidf.columns = ['id', 'score']

# Add the tokens corresponding to the numerical indices for better readability
df_tfidf["token"] = [dictionary[index] for index in df_tfidf.id]

# Sort the DataFrame by descending tf-idf score and print the first 10 rows.
df_tfidf.sort_values(by=['score'], ascending = False).head(10)
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>score</th>
      <th>token</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>254</th>
      <td>1092</td>
      <td>0.296386</td>
      <td>glacial</td>
    </tr>
    <tr>
      <th>203</th>
      <td>917</td>
      <td>0.200873</td>
      <td>extinct</td>
    </tr>
    <tr>
      <th>1420</th>
      <td>11955</td>
      <td>0.191284</td>
      <td>wax</td>
    </tr>
    <tr>
      <th>1571</th>
      <td>16224</td>
      <td>0.179948</td>
      <td>silurian</td>
    </tr>
    <tr>
      <th>436</th>
      <td>1878</td>
      <td>0.171795</td>
      <td>pollen</td>
    </tr>
    <tr>
      <th>82</th>
      <td>369</td>
      <td>0.164239</td>
      <td>breed</td>
    </tr>
    <tr>
      <th>1446</th>
      <td>12472</td>
      <td>0.139778</td>
      <td>flora</td>
    </tr>
    <tr>
      <th>1636</th>
      <td>20890</td>
      <td>0.135925</td>
      <td>melipona</td>
    </tr>
    <tr>
      <th>181</th>
      <td>822</td>
      <td>0.133963</td>
      <td>embryo</td>
    </tr>
    <tr>
      <th>1293</th>
      <td>10108</td>
      <td>0.121395</td>
      <td>pigeon</td>
    </tr>
  </tbody>
</table>
</div>


## 10. Compute distance between texts
<p>The results of the tf-idf algorithm now return stemmed tokens which are specific to each book. We can, for example, see that topics such as selection, breeding or domestication are defining "<em>On the Origin of Species</em>" (and yes, in this book, Charles Darwin talks quite a lot about pigeons too). Now that we have a model associating tokens to how specific they are to each book, we can measure how related to books are between each other.</p>
<p>To this purpose, we will use a measure of similarity called <strong>cosine similarity</strong> and we will visualize the results as a distance matrix, i.e., a matrix showing all pairwise distances between Darwin's books.</p>


```python
# Load the library allowing similarity computations
from gensim import similarities

# Compute the similarity matrix (pairwise distance between all texts)
sims = similarities.MatrixSimilarity(model[bows])

# Transform the resulting list into a dataframe
sim_df = pd.DataFrame(list(sims))

# Add the titles of the books as columns and index of the dataframe
sim_df.columns = titles

# Print the resulting matrix
sim_df

```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Autobiography</th>
      <th>CoralReefs</th>
      <th>DescentofMan</th>
      <th>DifferentFormsofFlowers</th>
      <th>EffectsCrossSelfFertilization</th>
      <th>ExpressionofEmotionManAnimals</th>
      <th>FormationVegetableMould</th>
      <th>FoundationsOriginofSpecies</th>
      <th>GeologicalObservationsSouthAmerica</th>
      <th>InsectivorousPlants</th>
      <th>LifeandLettersVol1</th>
      <th>LifeandLettersVol2</th>
      <th>MonographCirripedia</th>
      <th>MonographCirripediaVol2</th>
      <th>MovementClimbingPlants</th>
      <th>OriginofSpecies</th>
      <th>PowerMovementPlants</th>
      <th>VariationPlantsAnimalsDomestication</th>
      <th>VolcanicIslands</th>
      <th>VoyageBeagle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.000000</td>
      <td>0.025451</td>
      <td>0.090304</td>
      <td>0.046261</td>
      <td>0.021180</td>
      <td>0.100203</td>
      <td>0.042420</td>
      <td>0.118626</td>
      <td>0.038058</td>
      <td>0.020544</td>
      <td>0.339267</td>
      <td>0.233771</td>
      <td>0.004573</td>
      <td>0.008187</td>
      <td>0.007992</td>
      <td>0.113236</td>
      <td>0.010052</td>
      <td>0.055785</td>
      <td>0.052752</td>
      <td>0.156566</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.025451</td>
      <td>1.000000</td>
      <td>0.010950</td>
      <td>0.006036</td>
      <td>0.003758</td>
      <td>0.008870</td>
      <td>0.023547</td>
      <td>0.041456</td>
      <td>0.050971</td>
      <td>0.005987</td>
      <td>0.027165</td>
      <td>0.013818</td>
      <td>0.006525</td>
      <td>0.008878</td>
      <td>0.002669</td>
      <td>0.037073</td>
      <td>0.004451</td>
      <td>0.015390</td>
      <td>0.056380</td>
      <td>0.161937</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.090304</td>
      <td>0.010950</td>
      <td>1.000000</td>
      <td>0.055337</td>
      <td>0.024749</td>
      <td>0.200441</td>
      <td>0.026394</td>
      <td>0.157973</td>
      <td>0.014364</td>
      <td>0.011489</td>
      <td>0.046925</td>
      <td>0.047856</td>
      <td>0.049996</td>
      <td>0.027745</td>
      <td>0.008667</td>
      <td>0.237937</td>
      <td>0.010315</td>
      <td>0.212504</td>
      <td>0.015086</td>
      <td>0.122905</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.046261</td>
      <td>0.006036</td>
      <td>0.055337</td>
      <td>1.000000</td>
      <td>0.304642</td>
      <td>0.011003</td>
      <td>0.025398</td>
      <td>0.058794</td>
      <td>0.012971</td>
      <td>0.027665</td>
      <td>0.010945</td>
      <td>0.031059</td>
      <td>0.008347</td>
      <td>0.007852</td>
      <td>0.039354</td>
      <td>0.192194</td>
      <td>0.029957</td>
      <td>0.082392</td>
      <td>0.013976</td>
      <td>0.019275</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.021180</td>
      <td>0.003758</td>
      <td>0.024749</td>
      <td>0.304642</td>
      <td>1.000000</td>
      <td>0.008067</td>
      <td>0.050609</td>
      <td>0.038762</td>
      <td>0.007815</td>
      <td>0.027763</td>
      <td>0.006952</td>
      <td>0.013521</td>
      <td>0.003425</td>
      <td>0.004660</td>
      <td>0.038817</td>
      <td>0.102055</td>
      <td>0.101039</td>
      <td>0.049614</td>
      <td>0.007038</td>
      <td>0.025778</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.100203</td>
      <td>0.008870</td>
      <td>0.200441</td>
      <td>0.011003</td>
      <td>0.008067</td>
      <td>1.000000</td>
      <td>0.028496</td>
      <td>0.084503</td>
      <td>0.011811</td>
      <td>0.024792</td>
      <td>0.061393</td>
      <td>0.041388</td>
      <td>0.011114</td>
      <td>0.016440</td>
      <td>0.011469</td>
      <td>0.084302</td>
      <td>0.018689</td>
      <td>0.092685</td>
      <td>0.014944</td>
      <td>0.109110</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.042420</td>
      <td>0.023547</td>
      <td>0.026394</td>
      <td>0.025398</td>
      <td>0.050609</td>
      <td>0.028496</td>
      <td>1.000000</td>
      <td>0.036072</td>
      <td>0.063964</td>
      <td>0.066118</td>
      <td>0.020017</td>
      <td>0.012417</td>
      <td>0.018055</td>
      <td>0.017659</td>
      <td>0.021286</td>
      <td>0.069607</td>
      <td>0.051806</td>
      <td>0.029571</td>
      <td>0.053170</td>
      <td>0.094223</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.118626</td>
      <td>0.041456</td>
      <td>0.157973</td>
      <td>0.058794</td>
      <td>0.038762</td>
      <td>0.084503</td>
      <td>0.036072</td>
      <td>1.000000</td>
      <td>0.067212</td>
      <td>0.026674</td>
      <td>0.089769</td>
      <td>0.068693</td>
      <td>0.014785</td>
      <td>0.016605</td>
      <td>0.013134</td>
      <td>0.406380</td>
      <td>0.022062</td>
      <td>0.272508</td>
      <td>0.050530</td>
      <td>0.171394</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.038058</td>
      <td>0.050971</td>
      <td>0.014364</td>
      <td>0.012971</td>
      <td>0.007815</td>
      <td>0.011811</td>
      <td>0.063964</td>
      <td>0.067212</td>
      <td>1.000000</td>
      <td>0.015839</td>
      <td>0.030663</td>
      <td>0.016112</td>
      <td>0.009296</td>
      <td>0.013801</td>
      <td>0.006960</td>
      <td>0.081047</td>
      <td>0.009430</td>
      <td>0.021966</td>
      <td>0.273759</td>
      <td>0.290871</td>
    </tr>
    <tr>
      <th>9</th>
      <td>0.020544</td>
      <td>0.005987</td>
      <td>0.011489</td>
      <td>0.027665</td>
      <td>0.027763</td>
      <td>0.024792</td>
      <td>0.066118</td>
      <td>0.026674</td>
      <td>0.015839</td>
      <td>1.000000</td>
      <td>0.007961</td>
      <td>0.016592</td>
      <td>0.017685</td>
      <td>0.018836</td>
      <td>0.046066</td>
      <td>0.025875</td>
      <td>0.107746</td>
      <td>0.019151</td>
      <td>0.017712</td>
      <td>0.038466</td>
    </tr>
    <tr>
      <th>10</th>
      <td>0.339267</td>
      <td>0.027165</td>
      <td>0.046925</td>
      <td>0.010945</td>
      <td>0.006952</td>
      <td>0.061393</td>
      <td>0.020017</td>
      <td>0.089769</td>
      <td>0.030663</td>
      <td>0.007961</td>
      <td>1.000000</td>
      <td>0.953910</td>
      <td>0.003300</td>
      <td>0.015032</td>
      <td>0.006680</td>
      <td>0.075467</td>
      <td>0.010400</td>
      <td>0.036384</td>
      <td>0.035527</td>
      <td>0.138434</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.233771</td>
      <td>0.013818</td>
      <td>0.047856</td>
      <td>0.031059</td>
      <td>0.013521</td>
      <td>0.041388</td>
      <td>0.012417</td>
      <td>0.068693</td>
      <td>0.016112</td>
      <td>0.016592</td>
      <td>0.953910</td>
      <td>1.000000</td>
      <td>0.003281</td>
      <td>0.013999</td>
      <td>0.009592</td>
      <td>0.058652</td>
      <td>0.008609</td>
      <td>0.026244</td>
      <td>0.023944</td>
      <td>0.083000</td>
    </tr>
    <tr>
      <th>12</th>
      <td>0.004573</td>
      <td>0.006525</td>
      <td>0.049996</td>
      <td>0.008347</td>
      <td>0.003425</td>
      <td>0.011114</td>
      <td>0.018055</td>
      <td>0.014785</td>
      <td>0.009296</td>
      <td>0.017685</td>
      <td>0.003300</td>
      <td>0.003281</td>
      <td>1.000000</td>
      <td>0.484633</td>
      <td>0.007194</td>
      <td>0.024247</td>
      <td>0.014391</td>
      <td>0.029749</td>
      <td>0.013417</td>
      <td>0.013286</td>
    </tr>
    <tr>
      <th>13</th>
      <td>0.008187</td>
      <td>0.008878</td>
      <td>0.027745</td>
      <td>0.007852</td>
      <td>0.004660</td>
      <td>0.016440</td>
      <td>0.017659</td>
      <td>0.016605</td>
      <td>0.013801</td>
      <td>0.018836</td>
      <td>0.015032</td>
      <td>0.013999</td>
      <td>0.484633</td>
      <td>1.000000</td>
      <td>0.010489</td>
      <td>0.026954</td>
      <td>0.015223</td>
      <td>0.031983</td>
      <td>0.014877</td>
      <td>0.020030</td>
    </tr>
    <tr>
      <th>14</th>
      <td>0.007992</td>
      <td>0.002669</td>
      <td>0.008667</td>
      <td>0.039354</td>
      <td>0.038817</td>
      <td>0.011469</td>
      <td>0.021286</td>
      <td>0.013134</td>
      <td>0.006960</td>
      <td>0.046066</td>
      <td>0.006680</td>
      <td>0.009592</td>
      <td>0.007194</td>
      <td>0.010489</td>
      <td>1.000000</td>
      <td>0.016152</td>
      <td>0.095672</td>
      <td>0.013789</td>
      <td>0.007445</td>
      <td>0.023717</td>
    </tr>
    <tr>
      <th>15</th>
      <td>0.113236</td>
      <td>0.037073</td>
      <td>0.237937</td>
      <td>0.192194</td>
      <td>0.102055</td>
      <td>0.084302</td>
      <td>0.069607</td>
      <td>0.406380</td>
      <td>0.081047</td>
      <td>0.025875</td>
      <td>0.075467</td>
      <td>0.058652</td>
      <td>0.024247</td>
      <td>0.026954</td>
      <td>0.016152</td>
      <td>1.000000</td>
      <td>0.023954</td>
      <td>0.318713</td>
      <td>0.060506</td>
      <td>0.181492</td>
    </tr>
    <tr>
      <th>16</th>
      <td>0.010052</td>
      <td>0.004451</td>
      <td>0.010315</td>
      <td>0.029957</td>
      <td>0.101039</td>
      <td>0.018689</td>
      <td>0.051806</td>
      <td>0.022062</td>
      <td>0.009430</td>
      <td>0.107746</td>
      <td>0.010400</td>
      <td>0.008609</td>
      <td>0.014391</td>
      <td>0.015223</td>
      <td>0.095672</td>
      <td>0.023954</td>
      <td>1.000000</td>
      <td>0.019244</td>
      <td>0.008945</td>
      <td>0.048913</td>
    </tr>
    <tr>
      <th>17</th>
      <td>0.055785</td>
      <td>0.015390</td>
      <td>0.212504</td>
      <td>0.082392</td>
      <td>0.049614</td>
      <td>0.092685</td>
      <td>0.029571</td>
      <td>0.272508</td>
      <td>0.021966</td>
      <td>0.019151</td>
      <td>0.036384</td>
      <td>0.026244</td>
      <td>0.029749</td>
      <td>0.031983</td>
      <td>0.013789</td>
      <td>0.318713</td>
      <td>0.019244</td>
      <td>1.000000</td>
      <td>0.025918</td>
      <td>0.147054</td>
    </tr>
    <tr>
      <th>18</th>
      <td>0.052752</td>
      <td>0.056380</td>
      <td>0.015086</td>
      <td>0.013976</td>
      <td>0.007038</td>
      <td>0.014944</td>
      <td>0.053170</td>
      <td>0.050530</td>
      <td>0.273759</td>
      <td>0.017712</td>
      <td>0.035527</td>
      <td>0.023944</td>
      <td>0.013417</td>
      <td>0.014877</td>
      <td>0.007445</td>
      <td>0.060506</td>
      <td>0.008945</td>
      <td>0.025918</td>
      <td>1.000000</td>
      <td>0.146669</td>
    </tr>
    <tr>
      <th>19</th>
      <td>0.156566</td>
      <td>0.161937</td>
      <td>0.122905</td>
      <td>0.019275</td>
      <td>0.025778</td>
      <td>0.109110</td>
      <td>0.094223</td>
      <td>0.171394</td>
      <td>0.290871</td>
      <td>0.038466</td>
      <td>0.138434</td>
      <td>0.083000</td>
      <td>0.013286</td>
      <td>0.020030</td>
      <td>0.023717</td>
      <td>0.181492</td>
      <td>0.048913</td>
      <td>0.147054</td>
      <td>0.146669</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>


## 11. The book most similar to "On the Origin of Species"
<p>We now have a matrix containing all the similarity measures between any pair of books from Charles Darwin! We can now use this matrix to quickly extract the information we need, i.e., the distance between one book and one or several others. </p>
<p>As a first step, we will display which books are the most similar to "<em>On the Origin of Species</em>," more specifically we will produce a bar chart showing all books ranked by how similar they are to Darwin's landmark work.</p>


```python
# This is needed to display plots in a notebook
%matplotlib inline

# Import libraries
import matplotlib.pyplot as plt

# Select the column corresponding to "On the Origin of Species" and 
v = sim_df['OriginofSpecies']

titles_labels = []
ax = v.sort_values().plot.barh()

# Modify the axes labels and plot title for a better readability
plt.title("Similarity of Books to On the Origin of Species")
plt.xlabel("Similarity")
plt.ylabel("Book Title")
locs, labels = plt.yticks()

#for label in ax.yaxis.get_ticklabels():
for label in labels:
    titles_labels.append(titles[int(label.get_text())])
plt.yticks(locs, titles_labels)
plt.show()
```


![png](output_31_0.png)


## 12. Which books have similar content?
<p>This turns out to be extremely useful if we want to determine a given book's most similar work. For example, we have just seen that if you enjoyed "<em>On the Origin of Species</em>," you can read books discussing similar concepts such as "<em>The Variation of Animals and Plants under Domestication</em>" or "<em>The Descent of Man, and Selection in Relation to Sex</em>." If you are familiar with Darwin's work, these suggestions will likely seem natural to you. Indeed, <em>On the Origin of Species</em> has a whole chapter about domestication and <em>The Descent of Man, and Selection in Relation to Sex</em> applies the theory of natural selection to human evolution. Hence, the results make sense.</p>
<p>However, we now want to have a better understanding of the big picture and see how Darwin's books are generally related to each other (in terms of topics discussed). To this purpose, we will represent the whole similarity matrix as a dendrogram, which is a standard tool to display such data. <strong>This last approach will display all the information about book similarities at once.</strong> For example, we can find a book's closest relative but, also, we can visualize which groups of books have similar topics (e.g., the cluster about Charles Darwin personal life with his autobiography and letters). If you are familiar with Darwin's bibliography, the results should not surprise you too much, which indicates the method gives good results. Otherwise, next time you read one of the author's book, you will know which other books to read next in order to learn more about the topics it addressed.</p>


```python
# Import libraries
from scipy.cluster import hierarchy

# Compute the clusters from the similarity matrix,
# using the Ward variance minimization algorithm
Z = hierarchy.linkage(sim_df, 'ward')

# Display this result as a horizontal dendrogram

R = hierarchy.dendrogram(Z, leaf_font_size=8, labels=sim_df.index , orientation="left")
temp = {R["leaves"][i]: titles[i] for i in sim_df.index }
def llf(xx):
    return temp[xx]
dend = hierarchy.dendrogram(Z, leaf_font_size=8, leaf_label_func=llf , orientation="left")
dend
```




    {'color_list': ['g',
      'r',
      'c',
      'c',
      'c',
      'c',
      'c',
      'm',
      'm',
      'm',
      'y',
      'y',
      'y',
      'y',
      'y',
      'b',
      'b',
      'b',
      'b'],
     'dcoord': [[0.0, 0.14421741985454192, 0.14421741985454192, 0.0],
      [0.0, 0.7294507722346358, 0.7294507722346358, 0.0],
      [0.0, 0.8585928739427128, 0.8585928739427128, 0.0],
      [0.0, 1.0614754009136729, 1.0614754009136729, 0.8585928739427128],
      [0.0, 1.1517983171163997, 1.1517983171163997, 0.0],
      [0.0, 1.3964654740310107, 1.3964654740310107, 1.1517983171163997],
      [1.0614754009136729,
       1.5771665997675328,
       1.5771665997675328,
       1.3964654740310107],
      [0.0, 1.037709763592402, 1.037709763592402, 0.0],
      [0.0, 1.196901469573153, 1.196901469573153, 1.037709763592402],
      [0.0, 1.4213624470164252, 1.4213624470164252, 1.196901469573153],
      [0.0, 0.9921630402822105, 0.9921630402822105, 0.0],
      [0.0, 1.2652162973565597, 1.2652162973565597, 0.0],
      [0.0, 1.3338112351434654, 1.3338112351434654, 1.2652162973565597],
      [0.0, 1.3825318027851081, 1.3825318027851081, 1.3338112351434654],
      [0.9921630402822105,
       1.6529154439199383,
       1.6529154439199383,
       1.3825318027851081],
      [1.4213624470164252,
       1.903658132870821,
       1.903658132870821,
       1.6529154439199383],
      [1.5771665997675328,
       2.030463873830914,
       2.030463873830914,
       1.903658132870821],
      [0.7294507722346358,
       2.1121676898365274,
       2.1121676898365274,
       2.030463873830914],
      [0.14421741985454192,
       2.5937597393262215,
       2.5937597393262215,
       2.1121676898365274]],
     'icoord': [[5.0, 5.0, 15.0, 15.0],
      [25.0, 25.0, 35.0, 35.0],
      [55.0, 55.0, 65.0, 65.0],
      [45.0, 45.0, 60.0, 60.0],
      [85.0, 85.0, 95.0, 95.0],
      [75.0, 75.0, 90.0, 90.0],
      [52.5, 52.5, 82.5, 82.5],
      [125.0, 125.0, 135.0, 135.0],
      [115.0, 115.0, 130.0, 130.0],
      [105.0, 105.0, 122.5, 122.5],
      [145.0, 145.0, 155.0, 155.0],
      [185.0, 185.0, 195.0, 195.0],
      [175.0, 175.0, 190.0, 190.0],
      [165.0, 165.0, 182.5, 182.5],
      [150.0, 150.0, 173.75, 173.75],
      [113.75, 113.75, 161.875, 161.875],
      [67.5, 67.5, 137.8125, 137.8125],
      [30.0, 30.0, 102.65625, 102.65625],
      [10.0, 10.0, 66.328125, 66.328125]],
     'ivl': ['Autobiography',
      'CoralReefs',
      'DescentofMan',
      'DifferentFormsofFlowers',
      'EffectsCrossSelfFertilization',
      'ExpressionofEmotionManAnimals',
      'FormationVegetableMould',
      'FoundationsOriginofSpecies',
      'GeologicalObservationsSouthAmerica',
      'InsectivorousPlants',
      'LifeandLettersVol1',
      'LifeandLettersVol2',
      'MonographCirripedia',
      'MonographCirripediaVol2',
      'MovementClimbingPlants',
      'OriginofSpecies',
      'PowerMovementPlants',
      'VariationPlantsAnimalsDomestication',
      'VolcanicIslands',
      'VoyageBeagle'],
     'leaves': [10,
      11,
      12,
      13,
      17,
      7,
      15,
      0,
      2,
      5,
      1,
      19,
      8,
      18,
      3,
      4,
      6,
      14,
      9,
      16]}




![png](output_34_1.png)


