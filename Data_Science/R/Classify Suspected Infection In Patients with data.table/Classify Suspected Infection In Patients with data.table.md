
## 1. This patient may have sepsis
<p>Sepsis is a deadly syndrome where a patient has a severe infection that causes organ failure. The sooner septic patients are treated, the more likely they are to survive, but sepsis can be difficult to recognize. It may be possible to use hospital data to develop machine learning models that could flag patients who are likely to be septic. Before predictive algorithms can be developed, however, we need a reliable way to pick out the patients who had sepsis. One component to identify is a severe infection.</p>
<p>In this notebook, we will use hospital electronic health record (EHR) data covering a two-week period to find out which patients were suspected to have a severe infection. In other words, we will look into the hospital's records to see what happened during a patient's hospital stay, and try to figure out whether s/he had a severe infection. </p>
<p>We will do this by checking whether the doctor ordered a blood test to look for bacteria (a blood culture) and also gave the patient a series of antibiotics. We will use data documenting antibiotics administered and blood cultures drawn.</p>


```R
# Load packages
library(data.table)

# The data.table package is pre-loaded
# Read in the data
antibioticDT <- fread("datasets/antibioticDT.csv")

# Look at the first 30 rows
head(antibioticDT, 30)

```


<table>
<thead><tr><th scope=col>patient_id</th><th scope=col>day_given</th><th scope=col>antibiotic_type</th><th scope=col>route</th></tr></thead>
<tbody>
	<tr><td> 1           </td><td> 2           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 4           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 7           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td>15           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 1           </td><td>16           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td>18           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 1           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td> 8           </td><td> 2           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td> 8           </td><td> 8           </td><td>penicillin   </td><td>PO           </td></tr>
	<tr><td> 8           </td><td>12           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 9           </td><td> 8           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 9           </td><td>12           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>12           </td><td> 4           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>12           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>16           </td><td> 1           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>16           </td><td> 4           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>19           </td><td> 3           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>19           </td><td> 5           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>19           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td>19           </td><td>10           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>19           </td><td>12           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 1           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 1           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td></tr>
</tbody>
</table>

## 2. Which antibiotics are "new?"
<p>These data represent all drugs administered in a hospital over a two-week period. Each row represents one time the patient was given a drug. The variables include the patient id, the day the drug was administered, and the type of drug. For example, patient "0010" received doxycycline by mouth on the first day of her stay.</p>
<p>We are identifying patients with infection using the following very specific criteria. The basic idea is that a patient starts antibiotics within a couple of days of a blood culture, and is then given antibiotics for at least 4 days.</p>
<p><strong>Criteria for Suspected Infection</strong>*</p>
<ul>
<li>Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed.</li>
<li>The sequence must start with a “new antibiotic,” defined as an antibiotic type that hasn't been given in the past 2 days.</li>
<li>The sequence must start within 2 days of a blood culture.  </li>
<li>There must be at least one <strong>IV</strong> antibiotic within the +/-2 day window period. (An IV drug is one that is given intravenously.)</li>
</ul>
<p>Let's start with the second item, by finding which rows represent 'new' antibiotics. We will be checking whether each particular antibiotic type was given in the past 2 days. Let's visualize this task by looking at the data sorted by id, then antibiotic type, and finally, day.</p>


```R
# Sort the data by id, antibiotic type, day. 
#setorder(antibioticDT, c("patient_id", "antibiotic_type", "day_given"), c(1,1,1))
setorder(antibioticDT, patient_id, antibiotic_type, day_given)

# Print and examine the first 40 rows.
head(antibioticDT, 40)

# Use `shift` to calculate the last day the particular drug was administered.
antibioticDT[ , last_administration_day := shift(day_given), 
  by = .(patient_id, antibiotic_type)]

# Calculate the number of days it's been since the last administration.
antibioticDT[ , days_since_last_admin := day_given - last_administration_day]

# Make a new variable called `antibiotic_new` with an initial value of 1. 
antibioticDT[, antibiotic_new := 1]



# Reset this variable to 0 when it's only been 1 or 2 days since the last administration.
antibioticDT[ days_since_last_admin <= 2, antibiotic_new := 0]




```


<table>
<thead><tr><th scope=col>patient_id</th><th scope=col>day_given</th><th scope=col>antibiotic_type</th><th scope=col>route</th></tr></thead>
<tbody>
	<tr><td> 1           </td><td> 2           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 4           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td>18           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 7           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td>16           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 1           </td><td>15           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 1           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td> 8           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td> 8           </td><td> 2           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 8           </td><td> 8           </td><td>penicillin   </td><td>PO           </td></tr>
	<tr><td> 8           </td><td>12           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td> 9           </td><td> 8           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td> 9           </td><td>12           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>12           </td><td> 4           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>12           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>16           </td><td> 4           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>16           </td><td> 1           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>19           </td><td> 5           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>19           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td>19           </td><td> 3           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>19           </td><td>10           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>19           </td><td>12           </td><td>penicillin   </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 8           </td><td>amoxicillin  </td><td>IV           </td></tr>
	<tr><td>23           </td><td>10           </td><td>amoxicillin  </td><td>PO           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td>23           </td><td> 5           </td><td>ciprofloxacin</td><td>PO           </td></tr>
	<tr><td>23           </td><td>16           </td><td>ciprofloxacin</td><td>IV           </td></tr>
	<tr><td>23           </td><td> 1           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 4           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 5           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 6           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>23           </td><td> 9           </td><td>doxycycline  </td><td>PO           </td></tr>
	<tr><td>23           </td><td>10           </td><td>doxycycline  </td><td>IV           </td></tr>
	<tr><td>23           </td><td>11           </td><td>doxycycline  </td><td>PO           </td></tr>
</tbody>
</table>




## 3. Looking at the blood culture data
<p>Now let's look at blood culture data from the same two-week period in this hospital. These data are in blood_cultureDT.csv. Let's start by reading it into the workspace and having a look at a few rows. </p>
<p>Each row represents one blood culture and gives the patient's id and the day it occurred. For example, patient "0006" had a culture on the first day of his hospitalization and again on the ninth. Notice that some patients from the antibiotic data are not in this data and vice versa. (Some patients are in neither because they received neither antibiotics nor a blood culture.)</p>


```R
# Read in `blood_cultureDT.csv`.
blood_cultureDT <- fread("datasets/blood_cultureDT.csv")

# Print the first 30 rows
head(blood_cultureDT, 30)
```


<table>
<thead><tr><th scope=col>patient_id</th><th scope=col>blood_culture_day</th></tr></thead>
<tbody>
	<tr><td>  1</td><td> 3 </td></tr>
	<tr><td>  1</td><td>13 </td></tr>
	<tr><td>  8</td><td> 2 </td></tr>
	<tr><td>  8</td><td>13 </td></tr>
	<tr><td> 23</td><td> 3 </td></tr>
	<tr><td> 39</td><td>10 </td></tr>
	<tr><td> 45</td><td> 4 </td></tr>
	<tr><td> 45</td><td> 9 </td></tr>
	<tr><td> 45</td><td>11 </td></tr>
	<tr><td> 51</td><td> 3 </td></tr>
	<tr><td> 51</td><td> 6 </td></tr>
	<tr><td> 59</td><td> 2 </td></tr>
	<tr><td> 64</td><td> 1 </td></tr>
	<tr><td> 66</td><td> 9 </td></tr>
	<tr><td> 66</td><td>10 </td></tr>
	<tr><td> 69</td><td> 2 </td></tr>
	<tr><td> 69</td><td> 6 </td></tr>
	<tr><td> 69</td><td> 7 </td></tr>
	<tr><td> 69</td><td>11 </td></tr>
	<tr><td> 69</td><td>16 </td></tr>
	<tr><td> 76</td><td> 1 </td></tr>
	<tr><td> 77</td><td> 3 </td></tr>
	<tr><td> 79</td><td> 5 </td></tr>
	<tr><td> 79</td><td>11 </td></tr>
	<tr><td> 79</td><td>12 </td></tr>
	<tr><td> 80</td><td> 3 </td></tr>
	<tr><td> 80</td><td>12 </td></tr>
	<tr><td> 81</td><td> 2 </td></tr>
	<tr><td>112</td><td> 6 </td></tr>
	<tr><td>115</td><td> 2 </td></tr>
</tbody>
</table>


## 4. Combine the antibiotic data and the blood culture data
<p>To find which antibiotics were given close to a blood culture, we'll need to combine the drug administration data with the blood culture data. Let's keep only patients that are still candidates for infection, so only those in both data sets.</p>
<p>A tricky part is that some patients will have had blood cultures on several different days. For each of those days, we are going to see if there's a sequence of antibiotic days close to it. To accomplish this, in the merge we will match each blood culture to each antibiotic day.</p>
<p>After sorting the data following the merge, you should be able to see that each patient's antibiotic sequence is repeated for each blood culture day. This will allow us to look at each blood culture day and check whether it is associated with a qualifying sequence of antibiotics.</p>


```R
# Make a combined dataset by merging antibioticDT with blood_cultureDT.
combinedDT <- merge(blood_cultureDT, antibioticDT, all = FALSE, by = "patient_id")

# Sort by patient_id, blood_culture_day, day_given, and antibiotic_type.
setorder(combinedDT, patient_id, blood_culture_day, day_given, antibiotic_type)

# Print and examine the first 40 rows.
head(combinedDT, 40)
```


<table>
<thead><tr><th scope=col>patient_id</th><th scope=col>blood_culture_day</th><th scope=col>day_given</th><th scope=col>antibiotic_type</th><th scope=col>route</th><th scope=col>last_administration_day</th><th scope=col>days_since_last_admin</th><th scope=col>antibiotic_new</th></tr></thead>
<tbody>
	<tr><td> 1           </td><td> 3           </td><td> 2           </td><td>ciprofloxacin</td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td> 4           </td><td>ciprofloxacin</td><td>IV           </td><td> 2           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td><td> 4           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td> 7           </td><td>doxycycline  </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td><td> 7           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td>15           </td><td>penicillin   </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td>16           </td><td>doxycycline  </td><td>IV           </td><td> 9           </td><td> 7           </td><td>1            </td></tr>
	<tr><td> 1           </td><td> 3           </td><td>18           </td><td>ciprofloxacin</td><td>IV           </td><td> 6           </td><td>12           </td><td>1            </td></tr>
	<tr><td> 1           </td><td>13           </td><td> 2           </td><td>ciprofloxacin</td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td>13           </td><td> 4           </td><td>ciprofloxacin</td><td>IV           </td><td> 2           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td>13           </td><td> 6           </td><td>ciprofloxacin</td><td>IV           </td><td> 4           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td>13           </td><td> 7           </td><td>doxycycline  </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td>13           </td><td> 9           </td><td>doxycycline  </td><td>IV           </td><td> 7           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 1           </td><td>13           </td><td>15           </td><td>penicillin   </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 1           </td><td>13           </td><td>16           </td><td>doxycycline  </td><td>IV           </td><td> 9           </td><td> 7           </td><td>1            </td></tr>
	<tr><td> 1           </td><td>13           </td><td>18           </td><td>ciprofloxacin</td><td>IV           </td><td> 6           </td><td>12           </td><td>1            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td> 1           </td><td>doxycycline  </td><td>PO           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td> 2           </td><td>penicillin   </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td><td> 1           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td><td> 3           </td><td> 3           </td><td>1            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td> 8           </td><td>penicillin   </td><td>PO           </td><td> 2           </td><td> 6           </td><td>1            </td></tr>
	<tr><td> 8           </td><td> 2           </td><td>12           </td><td>penicillin   </td><td>IV           </td><td> 8           </td><td> 4           </td><td>1            </td></tr>
	<tr><td> 8           </td><td>13           </td><td> 1           </td><td>doxycycline  </td><td>PO           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 8           </td><td>13           </td><td> 2           </td><td>penicillin   </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td> 8           </td><td>13           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td><td> 1           </td><td> 2           </td><td>0            </td></tr>
	<tr><td> 8           </td><td>13           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td><td> 3           </td><td> 3           </td><td>1            </td></tr>
	<tr><td> 8           </td><td>13           </td><td> 8           </td><td>penicillin   </td><td>PO           </td><td> 2           </td><td> 6           </td><td>1            </td></tr>
	<tr><td> 8           </td><td>13           </td><td>12           </td><td>penicillin   </td><td>IV           </td><td> 8           </td><td> 4           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 1           </td><td>doxycycline  </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 1           </td><td>penicillin   </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 3           </td><td>amoxicillin  </td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 3           </td><td>ciprofloxacin</td><td>IV           </td><td>NA           </td><td>NA           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 3           </td><td>doxycycline  </td><td>IV           </td><td> 1           </td><td> 2           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 4           </td><td>doxycycline  </td><td>IV           </td><td> 3           </td><td> 1           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 5           </td><td>ciprofloxacin</td><td>PO           </td><td> 3           </td><td> 2           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 5           </td><td>doxycycline  </td><td>IV           </td><td> 4           </td><td> 1           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 6           </td><td>doxycycline  </td><td>IV           </td><td> 5           </td><td> 1           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 6           </td><td>doxycycline  </td><td>PO           </td><td> 6           </td><td> 0           </td><td>0            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 8           </td><td>amoxicillin  </td><td>IV           </td><td> 3           </td><td> 5           </td><td>1            </td></tr>
	<tr><td>23           </td><td> 3           </td><td> 9           </td><td>doxycycline  </td><td>PO           </td><td> 6           </td><td> 3           </td><td>1            </td></tr>
</tbody>
</table>


## 5. Determine whether each row is in-window
<p>Now that we have the drug and blood culture data combined, we can test each drug administration against each blood culture to see if it's "in window."</p>


```R
# Make a new variable called `drug_in_bcx_window`, which is 1 if the drug was given in window and zero otherwise.
combinedDT[, drug_in_bcx_window := 0]
combinedDT[ day_given - blood_culture_day <= 2 & day_given - blood_culture_day >= -2, drug_in_bcx_window := 1]

```

## 6. Check the IV requirement
<p>Now let's look at the fourth item in the criteria. </p>
<p><strong>Criteria for Suspected Infection</strong>*</p>
<ul>
<li>Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed.</li>
<li>The sequence must start with a “new antibiotic” (not given in the prior 2 days).</li>
<li>The sequence must start within +/-2 days of a blood culture.  </li>
<li>There must be at least one <strong>IV</strong> antibiotic within the +/-2 day window period. (An IV drug is one that is given intravenously, not by mouth.)</li>
</ul>


```R
# Make a new indicator of whether a given blood culture day had at least one IV drug given in window.
combinedDT[ , 
          any_iv_in_bcx_window := as.numeric(any(route == 'IV' & drug_in_bcx_window == 1)),
          by = .(patient_id, blood_culture_day)]

# Exclude rows in which the blood_culture_day does not have any IV drugs in window. 
combinedDT <- combinedDT[any_iv_in_bcx_window == 1]
```

## 7. Find the first day of possible sequences
<p>We're getting close! Let's review the criteria:</p>
<p><strong>Criteria for Suspected Infection</strong>*</p>
<ul>
<li>Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed.</li>
<li>The sequence must start with a “new antibiotic” (not given in the prior 2 days).</li>
<li>The sequence must start within +/-2 days of a blood culture.  </li>
<li>There must be at least one IV antibiotic within the +/-2 day window period.</li>
</ul>
<p>Let's assess the first criterion, starting by finding the first day of possible 4-day qualifying sequences.    </p>


```R
# Create a new variable called day_of_first_new_abx_in_window.
combinedDT[ , 
    day_of_first_new_abx_in_window := 
        day_given[antibiotic_new == 1 & drug_in_bcx_window == 1][1],
    by = .(patient_id, blood_culture_day)]

# Remove rows where the day is before this first qualifying day.
combinedDT <- combinedDT[day_given >= day_of_first_new_abx_in_window]
```


## 8. Simplify the data
<p>The first criterion was: Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed.</p>
<p>We've pinned down the first day for possible sequences, so now we can check for sequences of four days. So now we don't need the drug type, we just need the days of administration.</p>


```R
# Create a new data.table containing only patient_id, blood_culture_day, and day_given. 
simplified_data <- combinedDT[,c('blood_culture_day', 'day_given', 'patient_id')]

# Remove duplicate rows.
simplified_data <- unique(simplified_data)
```

## 9. Extract first four rows for each blood culture
<p>To check for sequences of 4 days, let's pull out the first four days (rows) for each patient-blood culture combination. Some patients will have less than four antibiotic days. Let's remove them first.</p>


```R
# Make a new variable showing the number of antibiotic days each patient-blood culture day combination had.
simplified_data[ , num_antibiotic_days := .N, by = .(patient_id, blood_culture_day)]

# Remove blood culture days with less than four antibiotic days (rows). 
simplified_data = simplified_data[num_antibiotic_days >= 4]

# Select the first four days for each blood culture.
first_four_days <- simplified_data[ , .SD[1:4], by = .(patient_id, blood_culture_day)]
```

## 10. Consecutive sequence
<p>Now we need to check whether each 4-day sequence qualifies by having no gaps of more than one day.</p>
<!--"Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed."-->


```R
# Make a new variable indicating whether the antibiotic sequence has no skips of more than one day.
first_four_days[ , four_in_seq := as.numeric(max(diff(day_given)) < 3), by = .(patient_id, blood_culture_day)]

```

## 11. Select the patients who meet criteria
<p>A patient meets the criteria if any of his/her blood cultures were accompanied by a qualifying sequence of antibiotics. Now that we've determined whether each blood culture qualifies, let's select the patients who meet the criteria.</p>


```R
# Select the rows which have `four_in_seq` equal to `1`.
suspected_infection <- first_four_days[four_in_seq == 1]

# Retain only the `patient_id` column.
suspected_infection <- suspected_infection[,'patient_id']

# Get rid of duplicates.
suspected_infection <- unique(suspected_infection)

# Make an infection indicator
suspected_infection[ , infection := 1]
```

## 12. Find the prevalence of sepsis
<p>In this notebook, we've used two EHR data sets and used this information to flag patients who were suspected to have a severe infection. We've also gotten a data.table workout!</p>
<p>Let's see what proportion of patients had serious infection in these data. </p>
<p>So far we've been looking at records of all antibiotic administrations and blood cultures occurring over a two week period at a particular hospital. However, not all patients who were hospitalized over this period are represented in combinedDT, since not all of them had antibiotics or blood cultures.</p>


```R
# Read in all_patientsDT.csv
all_patientsDT <- fread("datasets/all_patients.csv")

# Merge this with the infection flag data.
all_patientsDT <- merge(all_patientsDT, suspected_infection, by="patient_id", all = TRUE)

# Set any missing values of the infection flag to 0.
all_patientsDT[is.na(infection) , infection := 0]

# Calculate the percentage of patients who met the criteria for presumed infection.
ans <- all_patientsDT[ , 100*mean(infection == 1)]
print(ans)
```



    [1] 14.94382


