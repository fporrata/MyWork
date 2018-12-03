
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




```R
# These packages need to be loaded in the first `@tests` cell. 
library(testthat) 
library(IRkernel.testthat)

# Then follows one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests(
    
    {
    test_that("The data is loaded", {   
        expect_true(exists('antibioticDT'), 
          info = 'Read the data using fread.')       
        expect_is(antibioticDT, "data.table", info = "antibioticDT is not class data.table. Did you use fread()?")
        
    }             
             )
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 3.958 0.095 423.87 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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












```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    ##!! How can I test whether the data are sorted appropriately?
    #test_that("The data are sorted", {
    #expect_true(TRUE, # A logical 
    #    info = "The student will see this info if the test fails.")
    #})
    
    
    test_that("last_adminitration_day is correct", {
    expect_true(
         identical(antibioticDT[ , shift(day_given, 1), 
  by = .(patient_id, antibiotic_type)]$V1,
                   antibioticDT$last_administration_day)
        
        , # A logical 
        info = "Hmm, there's a problem with last_administration_day. Did you sort the data and then use shift on day_given?")
    })        
    
        test_that("days_since_last_admin is correct", {
    expect_true(antibioticDT[ , identical(days_since_last_admin, day_given - last_administration_day)], # A logical 
        info = "The number of days since last administration should be the difference between the day given and the last administration day.")
    })
    test_that("antibiotic new is correct", {
    expect_true(antibioticDT[ , identical(sort(unique(antibiotic_new)), c(0, 1))], # A logical 
        info = "antibiotic_new should only be 0 or 1.")
        
    expect_true(antibioticDT[ , mean(days_since_last_admin <= 2 & !is.na(days_since_last_admin)) == mean(antibiotic_new == 0)], # A logical 
        info = "If days_since_last_admin is less than or equal to 2, antibiotic_new should be set to 0.")
        
    expect_true(antibioticDT[ , sum(is.na(antibiotic_new)) == 0], # A logical 
        info = "There shouldn't be any missing values of antibiotic_new.")
    })    
    })

```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.186 0.098 424.04 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("blood_culture data exists", {
    expect_true(
        exists("blood_cultureDT")
        , 
        info = "Read in the data.")
    expect_is(blood_cultureDT, "data.table", info = "blood_cultureDT is not class data.table. Did you use fread()?")
    })
    # You can have more than one test
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.238 0.098 424.091 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
soln_combinedDT <- merge(blood_cultureDT,
               antibioticDT, all = FALSE, by = 'patient_id')[order(patient_id, blood_culture_day, day_given, antibiotic_type)]
run_tests({
    test_that("The merge is correct.", {
        expect_equal(nrow(combinedDT), nrow(soln_combinedDT), info = "Hmm...did you set the `all=` argument to FALSE?")
        })
    test_that("The sort is correct.", {
        expect_equal(combinedDT, soln_combinedDT,       
        info = "Hmm...did you sort by patient_id, blood_culture_day, day_given, and antibiotic_type?")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.351 0.102 424.163 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 5. Determine whether each row is in-window
<p>Now that we have the drug and blood culture data combined, we can test each drug administration against each blood culture to see if it's "in window."</p>


```R
# Make a new variable called `drug_in_bcx_window`, which is 1 if the drug was given in window and zero otherwise.
combinedDT[, drug_in_bcx_window := 0]
combinedDT[ day_given - blood_culture_day <= 2 & day_given - blood_culture_day >= -2, drug_in_bcx_window := 1]

```






```R
run_tests({
    test_that("drug_in_bcx_window is correct", {
    expect_true(
        identical(
            combinedDT[ , as.numeric(
               day_given - blood_culture_day <= 2 
               & 
               day_given - blood_culture_day >= -2)],
            combinedDT$drug_in_bcx_window),
                
        info = "Did you use as.numeric? Did you use the correct window size (2, -2)?")
    })

})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.388 0.106 424.203 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
run_tests({
   # test_that("any_iv_in_bcx_window is correct", {
    #    expect_true(
     #       identical(
     #           combinedDT[ , as.numeric(any(route == 'IV' & drug_in_bcx_window == 1)),
     #                      by = .(patient_id, blood_culture_day)]$V1,
     #           unique(combinedDT[ , .(patient_id, blood_culture_day)])$any_iv_in_bcx_window),  ##!! I removed this later, hope it wasn't wrong!: ", any_iv_in_bcx_window 
     #   info = "Try using the `any` function. Group by `patient_id` and `blood_culture_day`.")})

    test_that("No bcx exist which did not have an IV drug in window.", {
        expect_true(
          combinedDT[ , all(any_iv_in_bcx_window)],
        info = "There should not be any rows blood culture days left which did not have any IV drugs in window.")})
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.443 0.106 424.242 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
run_tests({    
    #test_that("day_of_first_new_abx_in_window is correct", {
    #    expect_true(
    #       identical(
    #            combinedDT[ ,  day_given[antibiotic_new == 1 & drug_in_bcx_window == 1][1],
    #                       by = .(patient_id, blood_culture_day)]$V1,
    #            unique(combinedDT[ , .(patient_id, blood_culture_day)])$day_of_first_new_abx_in_window),
    #        info = 'Did you subset on "`antibiotic_new == 1 & drug_in_bcx_window == 1`"?')})        
    test_that("Rows removed correctly", {  
        # There are no rows with missing day_of_first_new_abx_in_window or day_given after day_of_first_new_abx_in_window             
        expect_true(
            combinedDT[ , all(!is.na(day_of_first_new_abx_in_window) & day_given >= day_of_first_new_abx_in_window)], 
            info = "Make sure there are no rows with missing day_of_first_new_abx_in_window 
              left and all rows with the day given before the first qualifying day have been removed.")
          # There are still some rows where day_given == day_of_first_new_abx_in_window
        expect_true(
            combinedDT[ , any(day_given == day_of_first_new_abx_in_window)],        
            info = "Remember not to exclude rows where day_given is equal to ay_of_first_new_abx_in_window.")})
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.512 0.106 424.28 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 8. Simplify the data
<p>The first criterion was: Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed.</p>
<p>We've pinned down the first day for possible sequences, so now we can check for sequences of four days. So now we don't need the drug type, we just need the days of administration.</p>


```R
# Create a new data.table containing only patient_id, blood_culture_day, and day_given. 
simplified_data <- combinedDT[,c('blood_culture_day', 'day_given', 'patient_id')]

# Remove duplicate rows.
simplified_data <- unique(simplified_data)
```


```R
run_tests({
    test_that("The new data table has only id, blood culture day, and abx day", {
    expect_true(
        all(sort(names(simplified_data)) == c('blood_culture_day', 'day_given', 'patient_id')),
        
        info = "The new data set should only have patient_id, blood_culture_day, and day_given.")
    })
    test_that("Duplicates have been removed", {
    expect_true(all(!duplicated(simplified_data)),  
        info = "There are still some duplicated rows! Remove them by making a new data frame with the unique function.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.569 0.106 424.313 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
run_tests({
    test_that("There are at most 4 days for each bcx day-patient combo.", {
    expect_true(first_four_days[ , .N, by = .(patient_id, blood_culture_day)][ , all(N == 4)], 
        info = "There are still some blood culture days with more than 4 rows.")
    })
    test_that("There aren't any more bcx days with less than three ", {
    expect_true(first_four_days[ , all(num_antibiotic_days >= 4)], 
        info = "There are still some blood culture days that had less than 4 abx days left in the data.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.68 0.106 424.397 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 10. Consecutive sequence
<p>Now we need to check whether each 4-day sequence qualifies by having no gaps of more than one day.</p>
<!--"Patient receives antibiotics for a sequence of 4 days, with gaps of 1 day allowed."-->


```R
# Make a new variable indicating whether the antibiotic sequence has no skips of more than one day.
first_four_days[ , four_in_seq := as.numeric(max(diff(day_given)) < 3), by = .(patient_id, blood_culture_day)]

```




```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("four_in_seq is correct", {
    expect_true(identical(unique(first_four_days[ , .(patient_id, blood_culture_day, four_in_seq)])$four_in_seq, first_four_days[ , as.numeric(max(diff(day_given)) < 3), by = .(patient_id, blood_culture_day)]$V1), 
        info = "four_in_seq is not correct. This variable should check whether the maximum of the differences in the day_given sequence is two or less.")
    })
    # You can have more than one test
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.718 0.106 424.434 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
# one or more tests of the students code. 
# The @solution should pass the tests.
# The purpose of the tests is to try to catch common errors and to 
# give the student a hint on how to resolve these errors.
run_tests({
    test_that("The only columns in suspected_infection are patient_id and infection", {
    expect_true(identical(names(suspected_infection), c('patient_id', 'infection')), 
        info = "suspected_infection should have two columns, called patient_id.")
    })
        test_that("All the patient ids are distinct.", {
    expect_true(nrow(suspected_infection[duplicated(patient_id)]) == 0, 
        info = "Remove duplicate patient ids.")
    })
})

```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.794 0.106 424.48 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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



```R
soln_file <- fread("datasets/all_patients.csv")
soln_merge <- merge(soln_file, suspected_infection, by = "patient_id", all = TRUE)
soln_merge[is.na(infection) , infection := 0]
soln_ans <- soln_merge[ , 100*mean(infection == 1)]

run_tests({
    test_that("The data are correctly loaded. ",{   
        expect_is(all_patientsDT, "data.table", info = "all_patientsDT is not class data.table. Did you use fread()?")
        })
    test_that("The merge is correct.", {
        expect_equal(nrow(all_patientsDT), nrow(soln_merge), info = "Hmm...did you set the `all=` argument to TRUE?")
        })
    test_that("Percent of patients meeting criteria is correct.", {
        expect_equal(ans, soln_ans,       
        info = "The calculation to find the percentage of patients who met the criteria for presumed infection is not correct.
                Did you multiply the mean infections by 100?")
    })
})
```






    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 4.868 0.106 424.536 0.004 0.001
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 

