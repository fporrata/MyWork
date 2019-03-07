
## 1. Survey of BMI and physical activity
<p>We've all taken a survey at some point, but do you ever wonder what happens to your answers? Surveys are given to a carefully selected sample of people with the goal of generalizing the results to a much larger population.</p>
<p>The <a href="https://www.cdc.gov/nchs/nhanes/index.htm">National Health and Nutrition Examination Survey (NHANES)</a> data is a complex survey of tens of thousands of people designed to assess the health and nutritional status of adults and children in the United States. The NHANES data includes many measurements related to overall health, physical activity, diet, psychological health, socioeconomic factors and more.</p>
<p>Depending on the sampling design, each person has a sampling weight that quantifies how many people in the larger population their data is meant to represent. In this notebook, we'll apply survey methods that use sampling weights to estimate and model relationships between measurements.</p>
<p>We are going to focus on a common health indicator, Body Mass Index (<a href="https://en.wikipedia.org/wiki/Body_mass_index">BMI</a> kg/m<sup>2</sup>), and how it is related to physical activity. We'll visualize the data and use survey-weighted regression to test for associations.</p>



```R
# Load the NHANES and dplyr packages
library(dplyr)
library(NHANES)

# Load the NHANESraw data
data("NHANESraw")

# Take a glimpse at the contents
glimpse(NHANESraw)
```

    Observations: 20,293
    Variables: 78
    $ ID               <int> 51624, 51625, 51626, 51627, 51628, 51629, 51630, 5...
    $ SurveyYr         <fct> 2009_10, 2009_10, 2009_10, 2009_10, 2009_10, 2009_...
    $ Gender           <fct> male, male, male, male, female, male, female, fema...
    $ Age              <int> 34, 4, 16, 10, 60, 26, 49, 1, 10, 80, 10, 80, 4, 3...
    $ AgeMonths        <int> 409, 49, 202, 131, 722, 313, 596, 12, 124, NA, 121...
    $ Race1            <fct> White, Other, Black, Black, Black, Mexican, White,...
    $ Race3            <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ Education        <fct> High School, NA, NA, NA, High School, 9 - 11th Gra...
    $ MaritalStatus    <fct> Married, NA, NA, NA, Widowed, Married, LivePartner...
    $ HHIncome         <fct> 25000-34999, 20000-24999, 45000-54999, 20000-24999...
    $ HHIncomeMid      <int> 30000, 22500, 50000, 22500, 12500, 30000, 40000, 4...
    $ Poverty          <dbl> 1.36, 1.07, 2.27, 0.81, 0.69, 1.01, 1.91, 1.36, 2....
    $ HomeRooms        <int> 6, 9, 5, 6, 6, 4, 5, 5, 7, 4, 5, 5, 7, NA, 6, 6, 5...
    $ HomeOwn          <fct> Own, Own, Own, Rent, Rent, Rent, Rent, Rent, Own, ...
    $ Work             <fct> NotWorking, NA, NotWorking, NA, NotWorking, Workin...
    $ Weight           <dbl> 87.4, 17.0, 72.3, 39.8, 116.8, 97.6, 86.7, 9.4, 26...
    $ Length           <dbl> NA, NA, NA, NA, NA, NA, NA, 75.7, NA, NA, NA, NA, ...
    $ HeadCirc         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ Height           <dbl> 164.7, 105.4, 181.3, 147.8, 166.0, 173.0, 168.4, N...
    $ BMI              <dbl> 32.22, 15.30, 22.00, 18.22, 42.39, 32.61, 30.57, N...
    $ BMICatUnder20yrs <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ BMI_WHO          <fct> 30.0_plus, 12.0_18.5, 18.5_to_24.9, 12.0_18.5, 30....
    $ Pulse            <int> 70, NA, 68, 68, 72, 72, 86, NA, 70, 88, 84, 54, NA...
    $ BPSysAve         <int> 113, NA, 109, 93, 150, 104, 112, NA, 108, 139, 94,...
    $ BPDiaAve         <int> 85, NA, 59, 41, 68, 49, 75, NA, 53, 43, 45, 60, NA...
    $ BPSys1           <int> 114, NA, 112, 92, 154, 102, 118, NA, 106, 142, 94,...
    $ BPDia1           <int> 88, NA, 62, 36, 70, 50, 82, NA, 60, 62, 38, 62, NA...
    $ BPSys2           <int> 114, NA, 114, 94, 150, 104, 108, NA, 106, 140, 92,...
    $ BPDia2           <int> 88, NA, 60, 44, 68, 48, 74, NA, 50, 46, 40, 62, NA...
    $ BPSys3           <int> 112, NA, 104, 92, 150, 104, 116, NA, 110, 138, 96,...
    $ BPDia3           <int> 82, NA, 58, 38, 68, 50, 76, NA, 56, 40, 50, 58, NA...
    $ Testosterone     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ DirectChol       <dbl> 1.29, NA, 1.55, 1.89, 1.16, 1.16, 1.16, NA, 1.58, ...
    $ TotChol          <dbl> 3.49, NA, 4.97, 4.16, 5.22, 4.14, 6.70, NA, 4.14, ...
    $ UrineVol1        <int> 352, NA, 281, 139, 30, 202, 77, NA, 39, 128, 109, ...
    $ UrineFlow1       <dbl> NA, NA, 0.415, 1.078, 0.476, 0.563, 0.094, NA, 0.3...
    $ UrineVol2        <int> NA, NA, NA, NA, 246, NA, NA, NA, NA, NA, NA, NA, N...
    $ UrineFlow2       <dbl> NA, NA, NA, NA, 2.51, NA, NA, NA, NA, NA, NA, NA, ...
    $ Diabetes         <fct> No, No, No, No, Yes, No, No, No, No, No, No, Yes, ...
    $ DiabetesAge      <int> NA, NA, NA, NA, 56, NA, NA, NA, NA, NA, NA, 70, NA...
    $ HealthGen        <fct> Good, NA, Vgood, NA, Fair, Good, Good, NA, NA, Exc...
    $ DaysPhysHlthBad  <int> 0, NA, 2, NA, 20, 2, 0, NA, NA, 0, NA, 0, NA, NA, ...
    $ DaysMentHlthBad  <int> 15, NA, 0, NA, 25, 14, 10, NA, NA, 0, NA, 0, NA, N...
    $ LittleInterest   <fct> Most, NA, NA, NA, Most, None, Several, NA, NA, Non...
    $ Depressed        <fct> Several, NA, NA, NA, Most, Most, Several, NA, NA, ...
    $ nPregnancies     <int> NA, NA, NA, NA, 1, NA, 2, NA, NA, NA, NA, NA, NA, ...
    $ nBabies          <int> NA, NA, NA, NA, 1, NA, 2, NA, NA, NA, NA, NA, NA, ...
    $ Age1stBaby       <int> NA, NA, NA, NA, NA, NA, 27, NA, NA, NA, NA, NA, NA...
    $ SleepHrsNight    <int> 4, NA, 8, NA, 4, 4, 8, NA, NA, 6, NA, 9, NA, 7, NA...
    $ SleepTrouble     <fct> Yes, NA, No, NA, No, No, Yes, NA, NA, No, NA, No, ...
    $ PhysActive       <fct> No, NA, Yes, NA, No, Yes, No, NA, NA, Yes, NA, No,...
    $ PhysActiveDays   <int> NA, NA, 5, NA, NA, 2, NA, NA, NA, 4, NA, NA, NA, N...
    $ TVHrsDay         <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ CompHrsDay       <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
    $ TVHrsDayChild    <int> NA, 4, NA, 1, NA, NA, NA, NA, 1, NA, 3, NA, 2, NA,...
    $ CompHrsDayChild  <int> NA, 1, NA, 1, NA, NA, NA, NA, 0, NA, 0, NA, 1, NA,...
    $ Alcohol12PlusYr  <fct> Yes, NA, NA, NA, No, Yes, Yes, NA, NA, Yes, NA, No...
    $ AlcoholDay       <int> NA, NA, NA, NA, NA, 19, 2, NA, NA, 1, NA, NA, NA, ...
    $ AlcoholYear      <int> 0, NA, NA, NA, 0, 48, 20, NA, NA, 52, NA, 0, NA, N...
    $ SmokeNow         <fct> No, NA, NA, NA, Yes, No, Yes, NA, NA, No, NA, No, ...
    $ Smoke100         <fct> Yes, NA, NA, NA, Yes, Yes, Yes, NA, NA, Yes, NA, Y...
    $ SmokeAge         <int> 18, NA, NA, NA, 16, 15, 38, NA, NA, 16, NA, 21, NA...
    $ Marijuana        <fct> Yes, NA, NA, NA, NA, Yes, Yes, NA, NA, NA, NA, NA,...
    $ AgeFirstMarij    <int> 17, NA, NA, NA, NA, 10, 18, NA, NA, NA, NA, NA, NA...
    $ RegularMarij     <fct> No, NA, NA, NA, NA, Yes, No, NA, NA, NA, NA, NA, N...
    $ AgeRegMarij      <int> NA, NA, NA, NA, NA, 12, NA, NA, NA, NA, NA, NA, NA...
    $ HardDrugs        <fct> Yes, NA, NA, NA, No, Yes, Yes, NA, NA, NA, NA, NA,...
    $ SexEver          <fct> Yes, NA, NA, NA, Yes, Yes, Yes, NA, NA, NA, NA, NA...
    $ SexAge           <int> 16, NA, NA, NA, 15, 9, 12, NA, NA, NA, NA, NA, NA,...
    $ SexNumPartnLife  <int> 8, NA, NA, NA, 4, 10, 10, NA, NA, NA, NA, NA, NA, ...
    $ SexNumPartYear   <int> 1, NA, NA, NA, NA, 1, 1, NA, NA, NA, NA, NA, NA, N...
    $ SameSex          <fct> No, NA, NA, NA, No, No, Yes, NA, NA, NA, NA, NA, N...
    $ SexOrientation   <fct> Heterosexual, NA, NA, NA, NA, Heterosexual, Hetero...
    $ WTINT2YR         <dbl> 80100.544, 53901.104, 13953.078, 11664.899, 20090....
    $ WTMEC2YR         <dbl> 81528.772, 56995.035, 14509.279, 12041.635, 21000....
    $ SDMVPSU          <int> 1, 2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1,...
    $ SDMVSTRA         <int> 83, 79, 84, 86, 75, 88, 85, 86, 88, 77, 86, 79, 84...
    $ PregnantNow      <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...

## 2. Visualize survey weight and strata variables
<p>We see from <code>glimpse()</code> that the <code>NHANESraw</code> data has many health measurement variables. It also contains a sampling weight variable <code>WTMEC2YR</code>, a strata variable <code>SDMVSTRA</code>, and a primary sampling unit (PSU) variable, <code>SDMVPSU</code>, that accounts for design effects of clustering. These PSUs are nested within strata.</p>
<p>Since <code>NHANESraw</code> data spans 4 years (2009&ndash;2012) and the sampling weights are based on 2 years of data, we first need to create a weight variable that scales the sample across the full 4 years. We will divide the 2-year weight in half so that in total, the weights sum to the total US population.</p>
<p>The NHANES data has oversampled some geographic regions and specific minority groups. By examining the distribution of sampling weights for each race, we can see that Whites are undersampled and have higher weights while oversampled Black, Mexican, Hispanic people have lower weights since each sampled person in these minority groups represents fewer US people.</p>


```R
# Load the ggplot2 package
library(ggplot2)

# Use mutate to create a 4-year weight variable and call it WTMEC4YR
NHANESraw <- NHANESraw %>% mutate(WTMEC4YR = WTMEC2YR/2)

# Calculate the sum of this weight variable
NHANESraw %>% summarize(sum(WTMEC4YR))

# Plot the sample weights using boxplots, with Race1 on the x-axis
ggplot(NHANESraw, aes(x = Race1, y = WTMEC4YR)) + geom_boxplot()
```


<table>
<thead><tr><th scope=col>sum(WTMEC4YR)</th></tr></thead>
<tbody>
	<tr><td>304267200</td></tr>
</tbody>
</table>


![png](output_4_2.png)



## 3. Specify the survey design
<p>We will now use the <code>survey</code> package to specify the complex survey design that we will use in later analyses. We know the strata, cluster (PSU), and weight variables for our data. We also know that the clusters (PSUs) are nested within strata.</p>


```R
# Load the survey package
library(survey)

# Specify the survey design
nhanes_design <- svydesign(
    data = NHANESraw,
    strata = ~SDMVSTRA,
    id = ~SDMVPSU,
    nest = TRUE,
    weights = ~WTMEC4YR)

summary(nhanes_design)
```


    Stratified 1 - level Cluster Sampling design (with replacement)
    With (62) clusters.
    svydesign(data = NHANESraw, strata = ~SDMVSTRA, id = ~SDMVPSU, 
        nest = TRUE, weights = ~WTMEC4YR)
    Probabilities:
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    8.986e-06 5.664e-05 1.054e-04       Inf 1.721e-04       Inf 
    Stratum Sizes: 
                75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91
    obs        803 785 823 829 696 751 696 724 713 683 592 946 598 647 251 862 998
    design.PSU   2   2   2   2   2   2   2   2   2   2   2   3   2   2   2   3   3
    actual.PSU   2   2   2   2   2   2   2   2   2   2   2   3   2   2   2   3   3
                92  93  94  95  96  97  98  99 100 101 102 103
    obs        875 602 688 722 676 608 708 682 700 715 624 296
    design.PSU   3   2   2   2   2   2   2   2   2   2   2   2
    actual.PSU   3   2   2   2   2   2   2   2   2   2   2   2
    Data variables:
     [1] "ID"               "SurveyYr"         "Gender"           "Age"             
     [5] "AgeMonths"        "Race1"            "Race3"            "Education"       
     [9] "MaritalStatus"    "HHIncome"         "HHIncomeMid"      "Poverty"         
    [13] "HomeRooms"        "HomeOwn"          "Work"             "Weight"          
    [17] "Length"           "HeadCirc"         "Height"           "BMI"             
    [21] "BMICatUnder20yrs" "BMI_WHO"          "Pulse"            "BPSysAve"        
    [25] "BPDiaAve"         "BPSys1"           "BPDia1"           "BPSys2"          
    [29] "BPDia2"           "BPSys3"           "BPDia3"           "Testosterone"    
    [33] "DirectChol"       "TotChol"          "UrineVol1"        "UrineFlow1"      
    [37] "UrineVol2"        "UrineFlow2"       "Diabetes"         "DiabetesAge"     
    [41] "HealthGen"        "DaysPhysHlthBad"  "DaysMentHlthBad"  "LittleInterest"  
    [45] "Depressed"        "nPregnancies"     "nBabies"          "Age1stBaby"      
    [49] "SleepHrsNight"    "SleepTrouble"     "PhysActive"       "PhysActiveDays"  
    [53] "TVHrsDay"         "CompHrsDay"       "TVHrsDayChild"    "CompHrsDayChild" 
    [57] "Alcohol12PlusYr"  "AlcoholDay"       "AlcoholYear"      "SmokeNow"        
    [61] "Smoke100"         "SmokeAge"         "Marijuana"        "AgeFirstMarij"   
    [65] "RegularMarij"     "AgeRegMarij"      "HardDrugs"        "SexEver"         
    [69] "SexAge"           "SexNumPartnLife"  "SexNumPartYear"   "SameSex"         
    [73] "SexOrientation"   "WTINT2YR"         "WTMEC2YR"         "SDMVPSU"         
    [77] "SDMVSTRA"         "PregnantNow"      "WTMEC4YR"        


## 4. Subset the data
<p>Analysis of survey data requires careful consideration of the sampling design and weights at every step. Something as simple as filtering the data becomes complicated when weights are involved. </p>
<p>When we wish to examine a subset of the data (i.e. the subpopulation of adult Hispanics with diabetes, or pregnant women), we must explicitly specify this in the design. We cannot simply remove that subset of the data through filtering the raw data because the survey weights will no longer be correct and will not add up to the full US population.</p>
<p>BMI categories are different for children and young adults younger than 20 so we will subset the data to only analyze adults of at least 20 years of age.</p>


```R
# Select adults of Age >= 20 with subset
nhanes_adult <- subset(nhanes_design, Age >= 20)

# Print a summary of this subset
summary(nhanes_adult)

# Compare the number of observations in the full data to the adult data
nrow(nhanes_design)
nrow(nhanes_adult)
```


    Stratified 1 - level Cluster Sampling design (with replacement)
    With (62) clusters.
    subset(nhanes_design, Age >= 20)
    Probabilities:
         Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    8.986e-06 4.303e-05 8.107e-05       Inf 1.240e-04       Inf 
    Stratum Sizes: 
                75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91
    obs        471 490 526 500 410 464 447 400 411 395 357 512 327 355 153 509 560
    design.PSU   2   2   2   2   2   2   2   2   2   2   2   3   2   2   2   3   3
    actual.PSU   2   2   2   2   2   2   2   2   2   2   2   3   2   2   2   3   3
                92  93  94  95  96  97  98  99 100 101 102 103
    obs        483 376 368 454 362 315 414 409 377 460 308 165
    design.PSU   3   2   2   2   2   2   2   2   2   2   2   2
    actual.PSU   3   2   2   2   2   2   2   2   2   2   2   2
    Data variables:
     [1] "ID"               "SurveyYr"         "Gender"           "Age"             
     [5] "AgeMonths"        "Race1"            "Race3"            "Education"       
     [9] "MaritalStatus"    "HHIncome"         "HHIncomeMid"      "Poverty"         
    [13] "HomeRooms"        "HomeOwn"          "Work"             "Weight"          
    [17] "Length"           "HeadCirc"         "Height"           "BMI"             
    [21] "BMICatUnder20yrs" "BMI_WHO"          "Pulse"            "BPSysAve"        
    [25] "BPDiaAve"         "BPSys1"           "BPDia1"           "BPSys2"          
    [29] "BPDia2"           "BPSys3"           "BPDia3"           "Testosterone"    
    [33] "DirectChol"       "TotChol"          "UrineVol1"        "UrineFlow1"      
    [37] "UrineVol2"        "UrineFlow2"       "Diabetes"         "DiabetesAge"     
    [41] "HealthGen"        "DaysPhysHlthBad"  "DaysMentHlthBad"  "LittleInterest"  
    [45] "Depressed"        "nPregnancies"     "nBabies"          "Age1stBaby"      
    [49] "SleepHrsNight"    "SleepTrouble"     "PhysActive"       "PhysActiveDays"  
    [53] "TVHrsDay"         "CompHrsDay"       "TVHrsDayChild"    "CompHrsDayChild" 
    [57] "Alcohol12PlusYr"  "AlcoholDay"       "AlcoholYear"      "SmokeNow"        
    [61] "Smoke100"         "SmokeAge"         "Marijuana"        "AgeFirstMarij"   
    [65] "RegularMarij"     "AgeRegMarij"      "HardDrugs"        "SexEver"         
    [69] "SexAge"           "SexNumPartnLife"  "SexNumPartYear"   "SameSex"         
    [73] "SexOrientation"   "WTINT2YR"         "WTMEC2YR"         "SDMVPSU"         
    [77] "SDMVSTRA"         "PregnantNow"      "WTMEC4YR"        



20293



11778


## 5. Visualizing BMI
<p>We let <code>svydesign()</code> do its magic, but how does this help us learn about the full US population? With survey methods, we can use the sampling weights to estimate the true distributions of measurements within the entire population. This works for many statistics such as means, proportions, and standard deviations.</p>
<p>We'll use survey methods to estimate average BMI in the US adult population and also to draw a weighted histogram of the distribution.</p>


```R
# Calculate the mean BMI in NHANESraw
bmi_mean_raw <- NHANESraw %>% 
    filter(Age >= 20) %>%
    summarize(mean(BMI, na.rm=TRUE))
bmi_mean_raw

# Calculate the survey-weighted mean BMI of US adults
bmi_mean <- svymean(~BMI, design = nhanes_adult, na.rm = TRUE)
bmi_mean

# Draw a weighted histogram of BMI in the US population
NHANESraw %>% 
  filter(Age >= 20) %>%
    ggplot(mapping = aes(x = BMI, weight = WTMEC4YR)) + 
    geom_histogram()+
    geom_vline(xintercept = coef(bmi_mean), color="red")
```


<table>
<thead><tr><th scope=col>mean(BMI, na.rm = TRUE)</th></tr></thead>
<tbody>
	<tr><td>28.98217</td></tr>
</tbody>
</table>




          mean     SE
    BMI 28.734 0.1235


    `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
    Warning message:
    "Removed 547 rows containing non-finite values (stat_bin)."




![png](output_13_4.png)


## 6. Is BMI lower in physically active people?
<p>The distribution of BMI looks to be about what we might expect with most people under 40 kg/m<sup>2</sup> and a slight positive skewness because a few people have much higher BMI. Now to the question of interest: does the distribution of BMI differ between people who are physically active versus those who are not physically active? We can visually compare BMI with a boxplot as well as formally test for a difference in mean BMI. </p>


```R
# Load the broom library
library(broom)

# Make a boxplot of BMI stratified by physically active status
NHANESraw %>% 
  filter(Age>=20) %>%
  ggplot(aes(x = PhysActive, y = BMI,, weight = WTMEC4YR)) + geom_boxplot()

# Conduct a t-test comparing mean BMI between physically active status
survey_ttest <- svyttest(BMI~PhysActive, design = nhanes_adult)

# Use broom to show the tidy results
tidy(survey_ttest)
```

    Warning message:
    "Removed 547 rows containing non-finite values (stat_boxplot)."




<table>
<thead><tr><th scope=col>estimate</th><th scope=col>statistic</th><th scope=col>p.value</th><th scope=col>parameter</th><th scope=col>conf.low</th><th scope=col>conf.high</th><th scope=col>method</th><th scope=col>alternative</th></tr></thead>
<tbody>
	<tr><td>-1.846458          </td><td>-9.716503          </td><td>4.56031e-11        </td><td>32                 </td><td>-2.218916          </td><td>-1.473999          </td><td>Design-based t-test</td><td>two.sided          </td></tr>
</tbody>
</table>




![png](output_16_3.png)


## 7. Could there be confounding by smoking? (part 1)
<p>The relationship between physical activity and BMI is likely not so simple as "if you exercise you will lower your BMI." In fact, many other lifestyle or demographic variables could be confounding this relationship. One such variable could be smoking status. If someone smokes, is he or she more or less likely to be physically active? Are smokers more likely to have higher or lower BMI? We can examine these relationships in the survey data. Note that many people chose not to answer the smoking question, so we reduce our sample size when looking at this data.</p>
<p>First, let's look at the relationship between smoking and physical activity.</p>


```R
# Estimate the proportion who are physically active by current smoking status
phys_by_smoke <- svyby(~PhysActive, by = ~SmokeNow, 
                       FUN = svymean, 
                       design = nhanes_adult, 
                       keep.names = FALSE)

# Print the table
phys_by_smoke

# Plot the proportions
ggplot(data = phys_by_smoke, aes(SmokeNow, PhysActiveYes, fill = SmokeNow)) +
 geom_col() + ylab("Proportion Physically Active")
```


<table>
<thead><tr><th scope=col>SmokeNow</th><th scope=col>PhysActiveNo</th><th scope=col>PhysActiveYes</th><th scope=col>se.PhysActiveNo</th><th scope=col>se.PhysActiveYes</th></tr></thead>
<tbody>
	<tr><td>No        </td><td>0.4566990 </td><td>0.5433010 </td><td>0.01738054</td><td>0.01738054</td></tr>
	<tr><td>Yes       </td><td>0.5885421 </td><td>0.4114579 </td><td>0.01163246</td><td>0.01163246</td></tr>
</tbody>
</table>



![png](output_19_2.png)


## 8. Could there be confounding by smoking? (part 2)
<p>Now let's examine the relationship between smoking with BMI.</p>


```R
# Estimate mean BMI by current smoking status
BMI_by_smoke <- svyby(~BMI, by = ~SmokeNow, 
      FUN = svymean, 
      design = nhanes_adult, 
      na.rm = TRUE)
BMI_by_smoke

# Plot the distribution of BMI by current smoking status
NHANESraw %>% 
  filter(Age>=20, !is.na(SmokeNow)) %>% 
ggplot(mapping = aes(x = SmokeNow, y = BMI, weight = WTMEC4YR)) + 
    geom_boxplot()
```


<table>
<thead><tr><th></th><th scope=col>SmokeNow</th><th scope=col>BMI</th><th scope=col>se</th></tr></thead>
<tbody>
	<tr><th scope=row>No</th><td>No       </td><td>29.25734 </td><td>0.1915138</td></tr>
	<tr><th scope=row>Yes</th><td>Yes      </td><td>27.74873 </td><td>0.1652377</td></tr>
</tbody>
</table>



    Warning message:
    "Removed 244 rows containing non-finite values (stat_boxplot)."

![png](output_22_3.png)



## 9. Add smoking in the mix
<p>We saw that people who smoke are less likely to be physically active and have a higher BMI on average. We also saw that people who are physically active have a lower BMI on average. How do these seemingly conflicting associations work together? To get a better sense of what's going on, we can compare BMI by physical activity stratified by smoking status.</p>


```R
# Plot the distribution of BMI by smoking and physical activity status
NHANESraw %>% 
  filter(Age>=20) %>% 
ggplot(mapping = aes(x = SmokeNow, 
                         y = BMI, 
                         weight = WTMEC4YR, 
                         color = PhysActive)) + 
    geom_boxplot()

```

    Warning message:
    "Removed 547 rows containing non-finite values (stat_boxplot)."




![png](output_25_2.png)


## 10. Incorporate possible confounding in the model
<p>In the above plot, we see that people who are physically active tend to have lower BMI no matter their smoking status, and this is true even if they didn't answer the question. However, we also see that smokers have lower BMI in general. Also, looking closely we see the difference in BMI comparing physically active people to non-physically active people is slightly smaller in smokers than in non-smokers.</p>
<p>Previously, we used a simple t-test to compare mean BMI in physically active people and non-physically active people. In order to adjust for smoking status, as well as other possible confounders or predictors of BMI, we can use a linear regression model with multiple independent variables. When using survey data, we use a weighted linear regression method which is a special case of generalized linear models (GLMs).</p>


```R
# Fit a multiple regression model
mod1 <- svyglm(BMI ~ PhysActive*SmokeNow, design = nhanes_adult)

# Tidy the model results
tidy_mod1 <- tidy(mod1)
tidy_mod1

# Calculate expected mean difference in BMI for activity within non-smokers
diff_non_smoke <- tidy_mod1 %>% 
    filter(term=="PhysActiveYes") %>% 
    select(estimate)
diff_non_smoke

# Calculate expected mean difference in BMI for activity within smokers
diff_smoke <- tidy_mod1 %>% 
    filter(term %in% c("PhysActiveYes","PhysActiveYes:SmokeNowYes")) %>% 
    summarize(estimate = sum(estimate))
diff_smoke
```


<table>
<thead><tr><th scope=col>term</th><th scope=col>estimate</th><th scope=col>std.error</th><th scope=col>statistic</th><th scope=col>p.value</th></tr></thead>
<tbody>
	<tr><td>(Intercept)              </td><td>30.540997                </td><td>0.2098466                </td><td>145.539656               </td><td>2.619435e-44             </td></tr>
	<tr><td>PhysActiveYes            </td><td>-2.350701                </td><td>0.2358895                </td><td> -9.965262               </td><td>4.961177e-11             </td></tr>
	<tr><td>SmokeNowYes              </td><td>-2.238390                </td><td>0.2665632                </td><td> -8.397223               </td><td>2.262528e-09             </td></tr>
	<tr><td>PhysActiveYes:SmokeNowYes</td><td> 1.004490                </td><td>0.3435443                </td><td>  2.923903               </td><td>6.520735e-03             </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>estimate</th></tr></thead>
<tbody>
	<tr><td>-2.350701</td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>estimate</th></tr></thead>
<tbody>
	<tr><td>-1.346211</td></tr>
</tbody>
</table>


## 11. What does it all mean?
<p>We fit a linear regression model where the association of physical activity with BMI could vary by smoking status. The interaction between physical activity and smoking has a small p-value, which suggests the association does vary by smoking status. The difference between physically active and non-physically active people is larger in magnitude in the non-smoker population.</p>
<p>We should check the <a href="https://campus.datacamp.com/courses/inference-for-linear-regression/technical-conditions-in-linear-regression?ex=1">model fit and technical assumptions</a> of our regression model. Then, we can conclude that physically active people tend to have lower BMI, as do smokers. Although they have similar effect sizes, we probably wouldn't want to recommend smoking along with exercise!</p>
<p>In order to determine whether physical activity <em>causes</em> lower BMI, we would need to use causal inference methods or a randomized control study. We can adjust for other possible confounders in our regression model to determine if physical activity is still associated with BMI, but we fall short of confirming that physical activity itself can lower one's BMI.</p>


```R
# Adjust mod1 for other possible confounders
mod2 <- svyglm(BMI ~ PhysActive*SmokeNow + Race1 + Alcohol12PlusYr + Gender, 
               design = nhanes_adult)

# Tidy the output
tidy(mod2)
```


<table>
<thead><tr><th scope=col>term</th><th scope=col>estimate</th><th scope=col>std.error</th><th scope=col>statistic</th><th scope=col>p.value</th></tr></thead>
<tbody>
	<tr><td>(Intercept)              </td><td>33.2378322               </td><td>0.3162940                </td><td>105.0852370              </td><td>1.745688e-33             </td></tr>
	<tr><td>PhysActiveYes            </td><td>-2.1140302               </td><td>0.2729173                </td><td> -7.7460482              </td><td>5.559290e-08             </td></tr>
	<tr><td>SmokeNowYes              </td><td>-2.2266832               </td><td>0.3034114                </td><td> -7.3388252              </td><td>1.402940e-07             </td></tr>
	<tr><td>Race1Hispanic            </td><td>-1.4670407               </td><td>0.4200193                </td><td> -3.4927937              </td><td>1.875493e-03             </td></tr>
	<tr><td>Race1Mexican             </td><td>-0.1909654               </td><td>0.4637845                </td><td> -0.4117546              </td><td>6.841735e-01             </td></tr>
	<tr><td>Race1White               </td><td>-2.0761158               </td><td>0.3200810                </td><td> -6.4862209              </td><td>1.043842e-06             </td></tr>
	<tr><td>Race1Other               </td><td>-3.1050466               </td><td>0.6202084                </td><td> -5.0064570              </td><td>4.089394e-05             </td></tr>
	<tr><td>Alcohol12PlusYrYes       </td><td>-0.8549211               </td><td>0.3575930                </td><td> -2.3907660              </td><td>2.501002e-02             </td></tr>
	<tr><td>Gendermale               </td><td>-0.2557363               </td><td>0.2302174                </td><td> -1.1108470              </td><td>2.776397e-01             </td></tr>
	<tr><td>PhysActiveYes:SmokeNowYes</td><td> 0.7368701               </td><td>0.3874182                </td><td>  1.9020020              </td><td>6.923930e-02             </td></tr>
</tbody>
</table>


