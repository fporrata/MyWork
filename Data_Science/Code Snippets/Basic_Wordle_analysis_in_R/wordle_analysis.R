Here is a basic analysis to determine which would be the best word to start a Wordle challenge. Here is the Wordle site: https://www.powerlanguage.co.uk/wordle/

This analysis is in response to a comment Margaret left on what would be the best words to use for the challenges.

QUESTION:

Find the best word or words to start a Wordle challenge.

DATA  ACQUISITION AND WRANGLING:

Found a website that has supposedly all the 5 letters words in English.  It has many more options but for Wordle is just 5 letters. The site is: https://www.bestwordlist.com/.

There are aroun 12.4K 5 letter words.  I copied them in a file and used Notepad++ to move all the words to a column. (Had to use regex to change a space to "\r\n"). 

I also use MS Access to add commas in between the letters of the words..  At the end I created the text file you see down in the code.


# CODE: ----------------------------------------------------

library(tidyverse)

# Load wordle data frame
wordle <- read.csv("Words_with_commas.txt", header = FALSE, sep = "," )

#change column names
names(wordle) <- c("Position 1", "Position 2", "Position 3", "Position 4", "Position 5")
head(wordle)

#Use table to get letter counts.  Note the use of tick marks for the column names.  
#It is not recommended to have spaces in the names but it was easier when plotting the names.

table(wordle$`Position 1`)
table(wordle$`Position 2`)
table(wordle$`Position 3`)
table(wordle$`Position 4`)
table(wordle$`Position 5`)

#Use ggplot2 to plot some basic graphs

ggplot(wordle, aes(x = `Position 1`)) + geom_bar()
ggplot(wordle, aes(x = `Position 2`)) + geom_bar()
ggplot(wordle, aes(x = `Position 3`)) + geom_bar()
ggplot(wordle, aes(x = `Position 4`)) + geom_bar()
ggplot(wordle, aes(x = `Position 5`)) + geom_bar()
# END OF CODE ---------------------------------------------------------------

RESULTS:

Table command outputs:

>table(wordle$`Position 1`)

   A    B    C    D    E    F    G    H    I    J    K    L    M    N 
 715  871  888  650  288  575  608  477  157  191  353  551  666  317 
   O    P    Q    R    S    T    U    V    W    X    Y    Z 
 257  821   76  610 1521  787  178  231  402   15  175   98 


> table(wordle$`Position 2`)

   A    B    C    D    E    F    G    H    I    J    K    L    M    N 
2158   79  173   83 1572   23   73  525 1334    9   92  677  175  334 
   O    P    Q    R    S    T    U    V    W    X    Y    Z 
2008  229   14  908   89  232 1137   52  158   53  263   28 


> table(wordle$`Position 3`)

   A    B    C    D    E    F    G    H    I    J    K    L    M    N 
1206  315  373  373  847  168  351  107 1018   42  253  820  497  933 
   O    P    Q    R    S    T    U    V    W    X    Y    Z 
 960  343   10 1158  510  599  642  226  265  124  202  136 


> table(wordle$`Position 4`)

   A    B    C    D    E    F    G    H    I    J    K    L    M    N 
1027  227  389  451 2257  225  409  224  833   26  484  756  391  758 
   O    P    Q    R    S    T    U    V    W    X    Y    Z 
 658  406    1  695  502  878  379  148  126   11   98  119 


> table(wordle$`Position 5`)

   A    B    C    D    E    F    G    H    I    J    K    L    M    N 
 632   55  124  807 1477   80  135  349  253    2  244  465  179  512 
   O    P    Q    R    S    T    U    V    W    X    Y    Z 
 365  146    3  656 3805  710   63    4   62   65 1254   31 

Attached are some ggplot graphs in a Word document

RESULT:

The best letter(s) per position are:

1 - S by a big margin

2 - A and O are the best choices but E or U too.  Looks like selecting a vowel is a good choice for the second position.  Check the graph.

3 - A or R

4 - E by far the best choice

5 - S by far the best choice

In the list od supposedly valid words I found SARIS but not sure if wordle enforces valid words so I would start with SARES.  
Again, this is just playing around with the data and doing a half-baked analysis.

Continuing with the analysis to show you the power of R and learning it can be fun (not just work stuff), you can use it to make even better guesses 
when playing Wordle.  Learning the dplyr functions is very important.  dplyr is included with the tidyverse package.

Here are the steps:

1 - You enter SARES as your first option and found that by luck you matched the A in position 2 and the S in position 5.  The other letters did not match.  
You can use R to help make better guesses.  Here is something you can do:

#CODE--------------------------------------------

library(tidyverse)

#Load data
wordle <- read.csv("Words_with_commas.txt", header = FALSE, sep = ",", )
names(wordle) <- c("Position 1", "Position 2", "Position 3", "Position 4", "Position 5")
head(wordle)

#create subset of data by filtering

wordle_subset <- wordle %>%
  filter(`Position 1` != "S", 
         `Position 2` == "A", 
         `Position 3` != "R", 
         `Position 4` != "E",
         `Position 5` == "S")

count(wordle_subset)
head(wordle_subset)
tail(wordle_subset)

#Find most probable combinations of letters

wordle_subset %>%
  select(`Position 1`, `Position 2`) %>%
  group_by(`Position 1`, `Position 2`) %>%
  summarize(counts = n()) %>%
  arrange(desc(counts)) 

wordle_subset %>%
  select(`Position 4`, `Position 5`) %>%
  group_by(`Position 4`, `Position 5`) %>%
  summarize(counts = n()) %>%
  arrange(desc(counts)) 

# END OF CODE ------------------------------------------------


First filter the data.  You can get a subset of only the words that have A in position 2 and the S in position 5  and do not have the other letters 
in the corresponding positions by filtering.  

> count(wordle_subset)
    n
1 455

There are 455 words out of the 12.4k that matched the criteria.

I looked at the head and tail to make sure the data looks correct.

> head(wordle_subset)
  Position 1 Position 2 Position 3 Position 4 Position 5
1          B          A          A          L          S
2          B          A          B          A          S
3          B          A          B          U          S
4          B          A          C          H          S
5          B          A          C          K          S
6          B          A          E          L          S
> tail(wordle_subset)
    Position 1 Position 2 Position 3 Position 4 Position 5
450          Y          A          U          P          S
451          Y          A          W          L          S
452          Y          A          W          N          S
453          Y          A          W          P          S
454          Z          A          C          K          S
455          Z          A          T          I          S

Then the next step would be to get the most probable combination of letters.  Here you can do many things.  
I just checked the Position 1 and 2 combination and the Position 4 and 5 combinations.

> wordle_subset %>%
+   select(`Position 1`, `Position 2`) %>%
+   group_by(`Position 1`, `Position 2`) %>%
+   summarize(counts = n()) %>%
+   arrange(desc(counts)) 
`summarise()` has grouped output by 'Position 1'. You can override using the `.groups` argument.
# A tibble: 22 × 3
# Groups:   Position 1 [22]
   `Position 1` `Position 2` counts
   <chr>        <chr>         <int>
 1 T            A                40
 2 B            A                39
 3 M            A                39
 4 H            A                34
 5 C            A                33
 6 W            A                33
 7 R            A                32
 8 P            A                28
 9 G            A                27
10 K            A                26
# … with 12 more rows
> 
> 
> wordle_subset %>%
+   select(`Position 4`, `Position 5`) %>%
+   group_by(`Position 4`, `Position 5`) %>%
+   summarize(counts = n()) %>%
+   arrange(desc(counts)) 
`summarise()` has grouped output by 'Position 4'. You can override using the `.groups` argument.
# A tibble: 18 × 3
# Groups:   Position 4 [18]
   `Position 4` `Position 5` counts
   <chr>        <chr>         <int>
 1 A            S                57
 2 T            S                52
 3 K            S                50
 4 I            S                41
 5 L            S                38
 6 D            S                27
 7 U            S                26
 8 N            S                25
 9 P            S                22
10 O            S                21
11 F            S                20
12 R            S                19
13 G            S                18
14 H            S                16
15 M            S                13
16 B            S                 5
17 C            S                 4
18 S            S                 1
> 

RESULT

The best letter to try in Position 1 would be T but the counts are too close so leave it to chance.

The best letter for Position 4 would be A.  At least you know from the result NOT to use as your first choice S in Position 4.

You can continue a similar analysis if you are lucky enough to match more letters of the word.

