
Create a dictionary count_letters with keys consisting of each unique letter in the sentence and values consisting of the number of times each letter is used in this sentence. Count upper case and lower case letters separately in the dictionary.


```python
import string
#add lower and upper case characters to alphabet
alphabet = string.ascii_letters

sentence = 'Jamie quickly realized that the beautiful gowns are expensive'

count_letters = {}
count_letters = dict.fromkeys(sentence, 0)
for c in sentence: count_letters[c] += 1
    
print(count_letters)    
```

    {'J': 1, 'a': 5, 'm': 1, 'i': 5, 'e': 9, ' ': 8, 'q': 1, 'u': 3, 'c': 1, 'k': 1, 'l': 3, 'y': 1, 'r': 2, 'z': 1, 'd': 1, 't': 4, 'h': 2, 'b': 1, 'f': 1, 'g': 1, 'o': 1, 'w': 1, 'n': 2, 's': 2, 'x': 1, 'p': 1, 'v': 1}
    
