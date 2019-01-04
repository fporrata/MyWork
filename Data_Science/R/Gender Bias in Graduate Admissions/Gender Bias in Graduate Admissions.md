
## 1. Welcome to Berkeley
<p>It's 1973, and – as one of the top-ranked universities in the United States – Berkeley has attracted thousands of applicants to its graduate school. But how many made the cut?</p>
<p>We will start off by loading the <code>UCBAdmissions</code> dataset, which is included in base R. This shows the number of students – male and female – who were admitted or rejected from the six largest departments at Berkeley. Since the dataset takes the unwieldly form of a three-dimensional array, we will convert it to tidy format using the <code>tidy</code> function from the <code>tidytext</code> package. Then we will be ready to start doing some analysis.</p>
<p><img src="https://s3.amazonaws.com/assets.datacamp.com/production/project_567/img/Berkeley.jpg" alt="Berkeley Campus" title="Berkeley Campus"></p>
<p><em>Source: <a href="https://www.flickr.com/photos/brainchildvn/">brainchildvn</a> on Flickr</em></p>


```R
# Load UCBAdmissions dataset
data(UCBAdmissions)

# Print dataset to console
print(UCBAdmissions)

# Load broom package
library(broom)

# Convert UCBAdmissions to tidy format
ucb_tidy <- tidy(UCBAdmissions)

# Print tidy dataset to console
print(ucb_tidy)
```

    , , Dept = A
    
              Gender
    Admit      Male Female
      Admitted  512     89
      Rejected  313     19
    
    , , Dept = B
    
              Gender
    Admit      Male Female
      Admitted  353     17
      Rejected  207      8
    
    , , Dept = C
    
              Gender
    Admit      Male Female
      Admitted  120    202
      Rejected  205    391
    
    , , Dept = D
    
              Gender
    Admit      Male Female
      Admitted  138    131
      Rejected  279    244
    
    , , Dept = E
    
              Gender
    Admit      Male Female
      Admitted   53     94
      Rejected  138    299
    
    , , Dept = F
    
              Gender
    Admit      Male Female
      Admitted   22     24
      Rejected  351    317
    
    # A tibble: 24 x 4
       Admit    Gender Dept      n
       <chr>    <chr>  <chr> <dbl>
     1 Admitted Male   A       512
     2 Rejected Male   A       313
     3 Admitted Female A        89
     4 Rejected Female A        19
     5 Admitted Male   B       353
     6 Rejected Male   B       207
     7 Admitted Female B        17
     8 Rejected Female B         8
     9 Admitted Male   C       120
    10 Rejected Male   C       205
    # ... with 14 more rows



```R
library(testthat)
library(IRkernel.testthat)

soln_ucb_tidy <- tidy(UCBAdmissions)

run_tests({
    
    test_that("packages are loaded", {
        
        expect_true("broom" %in% .packages(), info = "Did you load the `broom` package?")
    
    })
    
    test_that("data is loaded and formatted correctly", {
        
        expect_true(exists("UCBAdmissions"),
                     info = "Did you load in the `UCBAdmissions` dataset with the `data()` function?")
        expect_identical(ucb_tidy, soln_ucb_tidy, info = "Did you tidy `UCBAdmissions` with the `tidy()` function?")

        
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
        current_start_time: 18.881 0.328 1303.035 0.005 0
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


## 2. Acceptance rate for men and women
<p>The data is more readable now that it is in tidy format, but – since it is split by department and displays raw counts – it is difficult for us to infer any kind of gender bias. To do that, we need to aggregate over department and ask ourselves, overall, what <em>proportion</em> of men and women were accepted into Berkeley in 1973.</p>
<p>Here we make use of the <code>dplyr</code> package for all of our data manipulation tasks. We aggregate over department using the <code>group_by</code> function to get the total number of men and women who were accepted into or rejected from Berkeley that year, as well as the proportion accepted in each case. That will leave us in a better place to understand any accusations of gender bias.</p>


```R
# Load the dplyr library
library(dplyr)

# Aggregate over department
ucb_tidy_aggregated <- ucb_tidy %>% 
  group_by(Admit, Gender) %>% 
  summarize(n = sum(n)) %>% 
  ungroup() %>% 
  group_by(Gender) %>% 
  mutate(prop = n / sum(n)) %>% 
  filter(Admit == "Admitted")

# Print aggregated dataset
print(ucb_tidy_aggregated)
```

    # A tibble: 2 x 4
    # Groups:   Gender [2]
      Admit    Gender     n  prop
      <chr>    <chr>  <dbl> <dbl>
    1 Admitted Female   557 0.304
    2 Admitted Male    1198 0.445



```R
soln_ucb_tidy_aggregated <- soln_ucb_tidy %>% 
  group_by(Admit, Gender) %>% 
  summarize(n = sum(n)) %>% 
  ungroup() %>% 
  group_by(Gender) %>% 
  mutate(prop = n / sum(n)) %>% 
  filter(Admit == "Admitted")

run_tests({
    test_that("packages are loaded", {
        expect_true("dplyr" %in% .packages(), info = "Did you load the `dplyr` package?")
    })
    
    test_that("data is prepared correctly", {
        expect_false("Dept" %in% colnames(ucb_tidy_aggregated), info = "Did you group by `Admit` and `Gender`?")
        expect_equal(soln_ucb_tidy_aggregated$n, ucb_tidy_aggregated$n, info = "Did you sum over `n` in the `summarize` function?")
        expect_equal(soln_ucb_tidy_aggregated$prop, ucb_tidy_aggregated$prop, info = "Did you calculate `prop` by dividing `n` by its sum?")
        expect_false("Rejected" %in% ucb_tidy_aggregated$Admit, info = "Did you filter for `Admitted` students only?")
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
        current_start_time: 18.944 0.328 1303.098 0.005 0
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


## 3. Visualizing the discrepancy
<p>From the previous task, we can see that <strong>44.5% of male applicants</strong> were accepted into Berkeley, as opposed to <strong>30.4% of female applicants</strong>. Now we can start to see the problem. Did Berkeley's graduate admissions department really discriminate against women that year?</p>
<p>Before we consider alternative explanations, let's visualize the discrepancy through a simple bar chart using <code>ggplot2</code>. This won't add much to our understanding of the problem right now, but it will act as a useful reference point later on.</p>
<p>For clarity, we will format acceptance rate as a percentage using the <code>percent</code> function from the <code>scales</code> package.</p>


```R
# Load the ggplot2 and scales packages
library(ggplot2)
library(scales)

# Prepare the bar plot
gg_bar <- ucb_tidy_aggregated %>% 
    ggplot(aes(x = Gender, y = prop, fill = Gender)) +
    geom_col() +
    geom_text(aes(label = percent(prop)), vjust = -1) +
    labs(title = "Acceptance rate of male and female applicants",
         subtitle = "University of California, Berkeley (1973)",
         y = "Acceptance rate") +
    scale_y_continuous(labels = scales::percent, limits = c(0,0.5)) +
    guides(fill = FALSE)

# Print the bar plot
print(gg_bar)
```


![png](output_7_0.png)



```R
soln_gg_bar <- soln_ucb_tidy_aggregated %>% 
    ggplot(aes(x = Gender, y = prop, fill = Gender)) +
    geom_col() +
    geom_text(aes(label = percent(prop)), vjust = -1) +
    labs(title = "Acceptance rate of male and female applicants",
         subtitle = "University of California, Berkeley (1973)",
         y = "Acceptance rate") +
    scale_y_continuous(labels = percent, limits = c(0, 0.5)) +
    guides(fill = FALSE)

run_tests({
    
    test_that("packages are loaded", {
        
        expect_true("ggplot2" %in% .packages(), info = "Did you load the `ggplot2` package?")
        expect_true("scales" %in% .packages(), info = "Did you load the `scales` package?")
        
    })
    
    test_that("the mappings are correct", {
        
        expect_identical(deparse(soln_gg_bar$mapping$x), deparse(gg_bar$mapping$x),
            info = 'The `x` aesthetic is incorrect. Did you map it to `Gender`?')
        expect_identical(deparse(soln_gg_bar$mapping$y), deparse(gg_bar$mapping$y),
            info = 'The `y` aesthetic is incorrect. Did you map it to `prop`?')
        expect_identical(deparse(soln_gg_bar$mapping$fill), deparse(gg_bar$mapping$fill),
            info = 'The `fill` aesthetic is incorrect. Did you map it to `Gender`?')
        
    })
    
    test_that("the parameters of geom_text() are correct", {
        
        expect_equal(soln_gg_bar$labels$label, gg_bar$labels$label,
                     info = "The `label` for `geom_text()` is incorrect. Did you set it to percent(prop)?")
        
        expect_identical(soln_gg_bar$layers[[2]]$aes_params$vjust, gg_bar$layers[[2]]$aes_params$vjust,
            info = 'The value of `vjust` is incorrect. Did you set it to `-1`?')
        
    })
    
    test_that("the parameters of scale_y_continuous() are correct", {
        
        expect_identical(ggplot_build(soln_gg_bar)$layout$panel_params[[1]][[9]], ggplot_build(gg_bar)$layout$panel_params[[1]][[9]],
                        info = "The labels for the y axis are incorrect. Did you set them to `percent` in `scale_y_continuous()`?")
        
        expect_identical(ggplot_build(soln_gg_bar)$layout$panel_params[[1]][[8]], ggplot_build(gg_bar)$layout$panel_params[[1]][[8]],
                        info = "The `limits` for `scale_y_continuous()` are incorrect. Did you set them to c(0, 0.5)?")
        
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
        current_start_time: 19.193 0.328 1303.346 0.005 0
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


## 4. Acceptance rate by department
<p>The bar plot confirms what we already knew – a higher proportion of men were accepted than women. But what happens when we separate the graph out by department?</p>
<p>Now we can return to our <code>ucb_tidy</code> dataset. After calculating the proportion of acceptances/rejections, we will plot a separate chart for each department using the <code>facet_wrap()</code> function in <code>ggplot2</code>. This will give us an idea of how acceptance rates differ by department, as well as by gender.</p>


```R
# Calculate acceptance/rejection rate
ucb_by_dept <- ucb_tidy %>% 
    group_by(Gender, Dept) %>% 
    mutate(prop = n / sum(n)) %>% 
    filter(Admit == "Admitted")

# Print the dataset
print(ucb_by_dept)

# Prepare the bar plot for each department
gg_bar_faceted <- ucb_by_dept %>% 
  ggplot(aes(Gender, prop, fill = Gender)) +
  geom_col() +
  geom_text(aes(label = percent(prop)), vjust = -1) +
  labs(title = "Acceptance rate of male and female applicants",
       subtitle = "University of California, Berkeley (1973)",
       y = "Acceptance rate") +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
  facet_wrap(~Dept) +
  guides(fill = FALSE)

# Print the bar plot for each department
print(gg_bar_faceted)
```

    # A tibble: 12 x 5
    # Groups:   Gender, Dept [12]
       Admit    Gender Dept      n   prop
       <chr>    <chr>  <chr> <dbl>  <dbl>
     1 Admitted Male   A       512 0.621 
     2 Admitted Female A        89 0.824 
     3 Admitted Male   B       353 0.630 
     4 Admitted Female B        17 0.68  
     5 Admitted Male   C       120 0.369 
     6 Admitted Female C       202 0.341 
     7 Admitted Male   D       138 0.331 
     8 Admitted Female D       131 0.349 
     9 Admitted Male   E        53 0.277 
    10 Admitted Female E        94 0.239 
    11 Admitted Male   F        22 0.0590
    12 Admitted Female F        24 0.0704



![png](output_10_1.png)



```R
soln_ucb_by_dept <- soln_ucb_tidy %>% 
    group_by(Gender, Dept) %>% 
    mutate(prop = n / sum(n)) %>% 
    filter(Admit == "Admitted")

soln_gg_bar_faceted <- soln_ucb_by_dept %>% 
  ggplot(aes(Gender, prop, fill = Gender)) +
  geom_col() +
  geom_text(aes(label = percent(prop)), vjust = -1) +
  labs(title = "Acceptance rate of male and female applicants",
       subtitle = "University of California, Berkeley (1973)",
       y = "Acceptance rate") +
  scale_y_continuous(labels = scales::percent, limits = c(0, 1)) +
  facet_wrap(~Dept) +
  guides(fill = FALSE)

run_tests({
    
    test_that("data is correctly prepared", {
        
        expect_equal(group_vars(soln_ucb_by_dept), group_vars(ucb_by_dept), info = "Did you group by `Gender` and `Dept`?")
        expect_equal(soln_ucb_by_dept$prop, ucb_by_dept$prop, info = "Did you calculate `prop` as `n / sum(n)`?")
        expect_false("Rejected" %in% ucb_by_dept$Admit, info = "Did you filter for `Admitted` students only?")
        
    })
    
    test_that("plot is correctly prepared", {
        
        expect_identical(soln_gg_bar_faceted$facet$params$facets, gg_bar_faceted$facet$params$facets,
                        info = "Did you facet by department? Remember to use a one-sided formula: `~Dept`.")
        expect_identical(soln_gg_bar_faceted$guides, gg_bar_faceted$guides,
                         info = "Did you remove the legend? Remember to set `fill = FALSE`.")
        
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
        current_start_time: 19.931 0.328 1304.083 0.005 0
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


## 5. Alternative explanations
<p>Now that we have separated out our analysis by department, the interpretation has changed rather dramatically. Although men were indeed more likely to be admitted into Departments C and E, women were more likely to be admitted into all other departments. So what's really going on here?</p>
<p>If you turn your attention to the first two plots, you can see that Department A and B were quite easy to get into. However, relatively few women applied to these departments – only 108 women applied to Department A, as opposed to 825 men!</p>
<p>At this stage, we can hypothesise that the effect of gender on acceptance is null when you control for department. We can test that hypothesis using <strong>binary logistic regression</strong>, but first we need to de-aggregate the dataset so that each row represents one student. That should leave us with 4,526 rows – one row for each student who applied to Berkeley that year.</p>


```R
# Define function that repeats each row in each column n times
multiply_rows <- function(column, n) {
  rep(column, n)
}

# Create new de-aggregated data frame using the multiply_rows function
ucb_full <- data.frame(Admit = multiply_rows(ucb_tidy$Admit, ucb_tidy$n),
                      Gender = multiply_rows(ucb_tidy$Gender, ucb_tidy$n),
                      Dept = multiply_rows(ucb_tidy$Dept, ucb_tidy$n))

# Check the number of rows equals the number of students
nrow(ucb_full)
```


4526



```R
sln_multiply_rows <- function(column, n) {
  rep(column, n)
}

sln_ucb_full <- data.frame(Admit = sln_multiply_rows(soln_ucb_tidy$Admit, soln_ucb_tidy$n),
                      Gender = sln_multiply_rows(soln_ucb_tidy$Gender, soln_ucb_tidy$n),
                      Dept = sln_multiply_rows(soln_ucb_tidy$Dept, soln_ucb_tidy$n))

run_tests({
    
    test_that("function is correct", {
        
        expect_identical(args(sln_multiply_rows), args(multiply_rows),
                         info = "Did you define the function correctly? It should have two arguments: `column` and `n`.")
        
        expect_equal(body(sln_multiply_rows), body(multiply_rows),
                        info = "The function body is incorrect. `rep()` should have two arguments: `column` and `n`.")
        
    })
    
    test_that("ucb_full is correct", {
        
        expect_true("Admit" %in% colnames(ucb_full),
                   info = "Did you apply `multiply_rows` to `ucb_tidy$Admit` when creating `ucb_full`?")
        
        expect_true("Gender" %in% colnames(ucb_full),
                   info = "Did you apply `multiply_rows` to `ucb_tidy$Gender` when creating `ucb_full`?")
        
        expect_true("Dept" %in% colnames(ucb_full),
                   info = "Did you apply `multiply_rows` to `ucb_tidy$Dept` when creating `ucb_full`?")
        
    })
    
    test_that("number of rows is correct", {
        expect_equal(nrow(sln_ucb_full), nrow(ucb_full),
                    info = "The number of rows is incorrect. Did you apply `multiply_rows` to `Admit`, `Gender` and `Dept` with `n` as the second argument?")
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
        current_start_time: 19.977 0.332 1304.132 0.005 0
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


## 6. Binary logistic regression: part i
<p>The data is now in the right format for us to do some hypothesis testing. Great! But first let's try to predict admittance using gender alone. We will use the built-in <code>glm()</code> function to fit a generalised linear model, making sure to set <code>family = "binomial"</code> because the outcome variable is binary (<code>Admitted</code> or <code>Rejected</code>).</p>
<p>By default, <code>Admit</code> is coded such that <code>Admitted</code> is level 1 and <code>Rejected</code> is level 2 (because of their alphabetical order). Since <code>glm()</code> will assume that level 2 represents 'success', we will reverse the coding of <code>Admit</code> so we are predicting the probability of admittance rather than rejection.</p>
<p>To change the coding of a variable, you can use the <code>fct_relevel()</code> function from the <code>forcats</code> package.</p>


```R
# Load the forcats library
library(forcats)

# Reverse the coding of the Admit variable
ucb_full$Admit <- fct_relevel(ucb_full$Admit,  "Rejected", "Admitted")

# Run the regression
glm_gender <- glm(Admit ~ Gender, data = ucb_full, family = "binomial")

# Summarize the results
summary(glm_gender)
```


    
    Call:
    glm(formula = Admit ~ Gender, family = "binomial", data = ucb_full)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -1.0855  -1.0855  -0.8506   1.2722   1.5442  
    
    Coefficients:
                Estimate Std. Error z value Pr(>|z|)    
    (Intercept) -0.83049    0.05077 -16.357   <2e-16 ***
    GenderMale   0.61035    0.06389   9.553   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 6044.3  on 4525  degrees of freedom
    Residual deviance: 5950.9  on 4524  degrees of freedom
    AIC: 5954.9
    
    Number of Fisher Scoring iterations: 4




```R
sln_ucb_full$Admit <- fct_relevel(sln_ucb_full$Admit, "Rejected", "Admitted")

sln_glm_gender <- glm(Admit ~ Gender, data = sln_ucb_full, family = "binomial")

run_tests({
    
    test_that("packages are loaded", {
        expect_true("forcats" %in% .packages(), info = "Did you load the `forcats` package?")
        
    })
    
    test_that("factor levels are reversed", {
        
        expect_equal(levels(as.factor(sln_ucb_full$Admit)), levels(as.factor(ucb_full$Admit)),
                     info = "Did you reverse the coding of the `Admit` variable using `fct_rev()`?")
        
    })
    
    test_that("the regression is prepared correctly", {
        
        expect_equal(sln_glm_gender$family[[1]], glm_gender$family[[1]],
                    info = "Did you set `family` equal to `binomial`?")
        expect_equal(sln_glm_gender$xlevels[[1]], glm_gender$xlevels[[1]],
                    info = "Did you set `Gender` as the only predictor variable?")
        
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
        current_start_time: 20.057 0.332 1304.212 0.005 0
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


## 7. Binary logistic regression: part ii
<p>Sure enough, when you predict the probability of admission as a function of gender alone, the effect is statistically significant (p &lt; 0.01). Specifically, you are <code>exp(0.61035) = 1.84</code> times more likely to be admitted if you are a man. However, what happens if we control for department?</p>


```R
# Run the regression, including Dept as an explanatory variable
glm_genderdept <- glm(Admit ~ Gender + Dept, data = ucb_full, family = "binomial")

# Summarize the results
summary(glm_genderdept)
```


    
    Call:
    glm(formula = Admit ~ Gender + Dept, family = "binomial", data = ucb_full)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -1.4773  -0.9306  -0.3741   0.9588   2.3613  
    
    Coefficients:
                Estimate Std. Error z value Pr(>|z|)    
    (Intercept)  0.68192    0.09911   6.880 5.97e-12 ***
    GenderMale  -0.09987    0.08085  -1.235    0.217    
    DeptB       -0.04340    0.10984  -0.395    0.693    
    DeptC       -1.26260    0.10663 -11.841  < 2e-16 ***
    DeptD       -1.29461    0.10582 -12.234  < 2e-16 ***
    DeptE       -1.73931    0.12611 -13.792  < 2e-16 ***
    DeptF       -3.30648    0.16998 -19.452  < 2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 6044.3  on 4525  degrees of freedom
    Residual deviance: 5187.5  on 4519  degrees of freedom
    AIC: 5201.5
    
    Number of Fisher Scoring iterations: 5




```R
sln_glm_genderdept <- glm(Admit ~ Gender + Dept, data = sln_ucb_full, family = "binomial")

run_tests({
    
    test_that("the regression is prepared correctly", {
        expect_true(glm_genderdept$family[[1]] == "binomial", info = "Did you set the `family` argument equal to `binomial`?")
        expect_equal(sln_glm_genderdept$xlevels, glm_genderdept$xlevels, info = "Did you set `Gender` and `Dept` as the predictor variables?")
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
        current_start_time: 20.135 0.336 1304.293 0.005 0
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


## 8. Behold Simpson's paradox
<p>Finally, we can see Simpson's paradox at play – when you control for the effect of department on the probability of admission, the effect of gender disappears. In fact, it even reverses, suggesting that – controlling for department – you were actually more likely to be admitted as a woman! However, this effect is not statistically significant (p &gt; 0.05), so we conclude that there was not a campus-wide bias against applicants of either gender in 1973.</p>
<p>That said, individual departments often handle their own admissions processes, so it is plausible that bias exists in one department but not another. Let's take a look at Department A, where 82.4% of women were admitted but only 62.1% of men. Is the difference statistically significant?</p>


```R
# Filter for Department A
dept_a <- ucb_full %>% filter(Dept == "A")

# Run the regression
glm_gender_depta <- glm(Admit ~ Gender , data = dept_a, family = "binomial")

# Summarize the results
summary(glm_gender_depta)
```


    
    Call:
    glm(formula = Admit ~ Gender, family = "binomial", data = dept_a)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -1.8642  -1.3922   0.9768   0.9768   0.9768  
    
    Coefficients:
                Estimate Std. Error z value Pr(>|z|)    
    (Intercept)   1.5442     0.2527   6.110 9.94e-10 ***
    GenderMale   -1.0521     0.2627  -4.005 6.21e-05 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 1214.7  on 932  degrees of freedom
    Residual deviance: 1195.7  on 931  degrees of freedom
    AIC: 1199.7
    
    Number of Fisher Scoring iterations: 4




```R
sln_dept_a <- sln_ucb_full[sln_ucb_full$Dept == "A",]
sln_glm_gender_depta <- glm(Admit ~ Gender, data = sln_dept_a, family = "binomial")

run_tests({
    
    test_that("the data is properly filtered", {
        expect_true(exists("dept_a"), info = "Did you create a new data frame called `dept_a`?")
        expect_equal(sln_dept_a$Dept, dept_a$Dept, info = "Did you filter for Department A only?")
    })
    
    test_that("the regression is prepared correctly", {
        expect_true(glm_gender_depta$family[[1]] == "binomial", info = "Did you set the `family` argument equal to `binomial`?")
        expect_equal(sln_glm_gender_depta$xlevels, glm_gender_depta$xlevels, info = "Did you set `Gender` as the only predictor variable?")
        expect_equal(sln_glm_gender_depta$data, glm_gender_depta$data, info = "Did you remember to use `dept_a` instead of `ucb_full`?")
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
        current_start_time: 20.198 0.336 1304.355 0.005 0
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


## 9. Bias or discrimination?
<p>Well then! If we take Department A in isolation, we find there is a statistically significant bias in favour of women. So does that mean that the department discriminated against men?</p>
<p>Not necessarily. After all, the bias might exist simply because the female applicants to Department A were better qualified that year. In their article dealing with this issue, Bickel, Hammel &amp; O'Connell (1975) define discrimination as "the exercise of decision influenced by the sex of the applicant when that is immaterial to the qualifications for entry". Since we do not have any data on the respective qualifications of the candidates, we cannot say whether any gender bias in their admissions process amounted to discrimination.</p>
<p>Although now more than 40 years old, the Berkeley problem is a useful reminder about the dangers of aggregation and omitted variable bias, especially in relation to matters of such legal and ethical importance as discrimination. Where bias does exist – as it does in the case of Department A – it is always worth considering whether there are any other factors that could explain the discrepancy.</p>


```R
# Define bias
bias <- "a pattern of association between a particular decision and a particular sex of applicant, of sufficient strength to make us confident that it is unlikely to be the result of chance alone"

# Define discrimination
discrimination <- "the exercise of decision influenced by the sex of the applicant when that is immaterial to the qualifications for entry"

# Is bias equal to discrimination?
bias != discrimination
```


TRUE



```R
sln_bias <- "a pattern of association between a particular decision and a particular sex of applicant, of sufficient strength to make us confident that it is unlikely to be the result of chance alone"
sln_discrimination <- "the exercise of decision influenced by the sex of the applicant when that is immaterial to the qualifications for entry"

run_tests({

    test_that("bias and discrimination are defined correctly", {
        
        expect_true(agrep(bias, sln_bias) == 1,
                     info = "Did you find the correct definition of bias? It should begin as 'a pattern of association...'.")
        
        expect_true(agrep(discrimination, sln_discrimination) == 1,
                     info = "Did you find the correct definition of discrimination? It should begin as 'the exercise of decision...'.")
        
        expect_true(bias != discrimination,
                    info = "Did you define bias and discrimination differently?")
        
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
        current_start_time: 20.238 0.336 1304.395 0.005 0
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

