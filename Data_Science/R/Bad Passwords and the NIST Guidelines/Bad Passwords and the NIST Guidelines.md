
## 1. The NIST Special Publication 800-63B
<p>If you – 50 years ago – needed to come up with a secret password you were probably part of a secret espionage organization or (more likely) you were pretending to be a spy when playing as a kid. Today, many of us are forced to come up with new passwords <em>all the time</em> when signing into sites and apps. As a password <em>inventeur</em> it is your responsibility to come up with good, hard-to-crack passwords. But it is also in the interest of sites and apps to make sure that you use good passwords. The problem is that it's really hard to define what makes a good password. However, <em>the National Institute of Standards and Technology</em> (NIST) knows what the second best thing is: To make sure you're at least not using a <em>bad</em> password. </p>
<p>In this notebook, we will go through the rules in <a href="https://pages.nist.gov/800-63-3/sp800-63b.html">NIST Special Publication 800-63B</a> which details what checks a <em>verifier</em> (what the NIST calls a second party responsible for storing and verifying passwords) should perform to make sure users don't pick bad passwords. We will go through the passwords of users from a fictional company and use R to flag the users with bad passwords. But us being able to do this already means the fictional company is breaking one of the rules of 800-63B:</p>
<blockquote>
  <p>Verifiers SHALL store memorized secrets in a form that is resistant to offline attacks. Memorized secrets SHALL be salted and hashed using a suitable one-way key derivation function.</p>
</blockquote>
<p>That is, never save users' passwords in plaintext, always encrypt the passwords! Keeping this in mind for the next time we're building a password management system, let's load in the data.</p>
<p><em>Warning: The list of passwords and the fictional user database both contain <strong>real</strong> passwords leaked from <strong>real</strong> websites. These passwords have not been filtered in any way and include words that are explicit, derogatory and offensive.</em></p>


```R
# Importing the tidyverse library
library(tidyverse)

# Loading in datasets/users.csv 
users <- read_csv("datasets/users.csv")

# Counting how many users we've got
count(users)

# Taking a look at the 12 first users
head(users, n = 12)
```

    Parsed with column specification:
    cols(
      id = col_integer(),
      user_name = col_character(),
      password = col_character()
    )



<table>
<thead><tr><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>982</td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th></tr></thead>
<tbody>
	<tr><td> 1              </td><td>vance.jennings  </td><td>joobheco        </td></tr>
	<tr><td> 2              </td><td>consuelo.eaton  </td><td>0869347314      </td></tr>
	<tr><td> 3              </td><td>mitchel.perkins </td><td>fabypotter      </td></tr>
	<tr><td> 4              </td><td>odessa.vaughan  </td><td>aharney88       </td></tr>
	<tr><td> 5              </td><td>araceli.wilder  </td><td>acecdn3000      </td></tr>
	<tr><td> 6              </td><td>shawn.harrington</td><td>5278049         </td></tr>
	<tr><td> 7              </td><td>evelyn.gay      </td><td>master          </td></tr>
	<tr><td> 8              </td><td>noreen.hale     </td><td>murphy          </td></tr>
	<tr><td> 9              </td><td>gladys.ward     </td><td>lwsves2         </td></tr>
	<tr><td>10              </td><td>brant.zimmerman </td><td>1190KAREN5572497</td></tr>
	<tr><td>11              </td><td>leanna.abbott   </td><td>aivlys24        </td></tr>
	<tr><td>12              </td><td>milford.hubbard </td><td>hubbard         </td></tr>
</tbody>
</table>




```R
library(testthat) 
library(IRkernel.testthat)
run_tests({
    test_that("Read in data correctly.", {
        expect_is(users, "tbl_df", 
            info = 'You should use read_csv (with an underscore) to read "datasets/users.csv" into users')
    })
    
    test_that("Read in data correctly.", {
        correct_users <- read_csv('datasets/users.csv')
        expect_equivalent(users, correct_users, 
            info = 'users should contain the data in "datasets/users.csv"')
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
        current_start_time: 5.5 0.211 2547.596 0.004 0
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


## 2. Passwords should not be too short
<p>If we take a look at the first 12 users above we already see some bad passwords. But let's not get ahead of ourselves and start flagging passwords <em>manually</em>. What is the first thing we should check according to the NIST Special Publication 800-63B?</p>
<blockquote>
  <p>Verifiers SHALL require subscriber-chosen memorized secrets to be at least 8 characters in length.</p>
</blockquote>
<p>Ok, so the passwords of our users shouldn't be too short. Let's start by checking that!</p>


```R
# Calculating the lengths of users' passwords
users$length <- str_length(users$password)

# Flagging the users with too short passwords
users$too_short <- ifelse(users$length < 8, TRUE, FALSE)

# Counting the number of users with too short passwords
sum(users$too_short)

# Taking a look at the 12 first rows
head(users, n = 12)
```


376



<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th><th scope=col>length</th><th scope=col>too_short</th></tr></thead>
<tbody>
	<tr><td> 1              </td><td>vance.jennings  </td><td>joobheco        </td><td> 8              </td><td>FALSE           </td></tr>
	<tr><td> 2              </td><td>consuelo.eaton  </td><td>0869347314      </td><td>10              </td><td>FALSE           </td></tr>
	<tr><td> 3              </td><td>mitchel.perkins </td><td>fabypotter      </td><td>10              </td><td>FALSE           </td></tr>
	<tr><td> 4              </td><td>odessa.vaughan  </td><td>aharney88       </td><td> 9              </td><td>FALSE           </td></tr>
	<tr><td> 5              </td><td>araceli.wilder  </td><td>acecdn3000      </td><td>10              </td><td>FALSE           </td></tr>
	<tr><td> 6              </td><td>shawn.harrington</td><td>5278049         </td><td> 7              </td><td> TRUE           </td></tr>
	<tr><td> 7              </td><td>evelyn.gay      </td><td>master          </td><td> 6              </td><td> TRUE           </td></tr>
	<tr><td> 8              </td><td>noreen.hale     </td><td>murphy          </td><td> 6              </td><td> TRUE           </td></tr>
	<tr><td> 9              </td><td>gladys.ward     </td><td>lwsves2         </td><td> 7              </td><td> TRUE           </td></tr>
	<tr><td>10              </td><td>brant.zimmerman </td><td>1190KAREN5572497</td><td>16              </td><td>FALSE           </td></tr>
	<tr><td>11              </td><td>leanna.abbott   </td><td>aivlys24        </td><td> 8              </td><td>FALSE           </td></tr>
	<tr><td>12              </td><td>milford.hubbard </td><td>hubbard         </td><td> 7              </td><td> TRUE           </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("The correct number of users are flagged", {
    sum(str_length(users$password) < 8)

    expect_equal(sum(str_length(users$password) < 8), sum(users$too_short), 
        info = "users$too_short should be a TRUE/FALSE column where all rows with passwords < 8 are TRUE.")
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
        current_start_time: 5.559 0.211 2547.654 0.004 0
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


## 3.  Common passwords people use
<p>Already this simple rule flagged a couple of offenders among the first 12 users. Next up in Special Publication 800-63B is the rule that</p>
<blockquote>
  <p>verifiers SHALL compare the prospective secrets against a list that contains values known to be commonly-used, expected, or compromised.</p>
  <ul>
  <li>Passwords obtained from previous breach corpuses.</li>
  <li>Dictionary words.</li>
  <li>Repetitive or sequential characters (e.g. ‘aaaaaa’, ‘1234abcd’).</li>
  <li>Context-specific words, such as the name of the service, the username, and derivatives thereof.</li>
  </ul>
</blockquote>
<p>We're going to check these in order and start with <em>Passwords obtained from previous breach corpuses</em>, that is, websites where hackers have leaked all the users' passwords. As many websites don't follow the NIST guidelines and encrypt passwords there now exist large lists of the most popular passwords. Let's start by loading in the 10,000 most common passwords which I've taken from <a href="https://github.com/danielmiessler/SecLists/tree/master/Passwords">here</a>.</p>


```R
# Reading in the top 10000 passwords
common_passwords <- read_lines("datasets/10_million_password_list_top_10000.txt")

# Taking a look at the top 100
head(common_passwords, n = 100)
```


<ol class=list-inline>
	<li>'123456'</li>
	<li>'password'</li>
	<li>'12345678'</li>
	<li>'qwerty'</li>
	<li>'123456789'</li>
	<li>'12345'</li>
	<li>'1234'</li>
	<li>'111111'</li>
	<li>'1234567'</li>
	<li>'dragon'</li>
	<li>'123123'</li>
	<li>'baseball'</li>
	<li>'abc123'</li>
	<li>'football'</li>
	<li>'monkey'</li>
	<li>'letmein'</li>
	<li>'696969'</li>
	<li>'shadow'</li>
	<li>'master'</li>
	<li>'666666'</li>
	<li>'qwertyuiop'</li>
	<li>'123321'</li>
	<li>'mustang'</li>
	<li>'1234567890'</li>
	<li>'michael'</li>
	<li>'654321'</li>
	<li>'pussy'</li>
	<li>'superman'</li>
	<li>'1qaz2wsx'</li>
	<li>'7777777'</li>
	<li>'fuckyou'</li>
	<li>'121212'</li>
	<li>'000000'</li>
	<li>'qazwsx'</li>
	<li>'123qwe'</li>
	<li>'killer'</li>
	<li>'trustno1'</li>
	<li>'jordan'</li>
	<li>'jennifer'</li>
	<li>'zxcvbnm'</li>
	<li>'asdfgh'</li>
	<li>'hunter'</li>
	<li>'buster'</li>
	<li>'soccer'</li>
	<li>'harley'</li>
	<li>'batman'</li>
	<li>'andrew'</li>
	<li>'tigger'</li>
	<li>'sunshine'</li>
	<li>'iloveyou'</li>
	<li>'fuckme'</li>
	<li>'2000'</li>
	<li>'charlie'</li>
	<li>'robert'</li>
	<li>'thomas'</li>
	<li>'hockey'</li>
	<li>'ranger'</li>
	<li>'daniel'</li>
	<li>'starwars'</li>
	<li>'klaster'</li>
	<li>'112233'</li>
	<li>'george'</li>
	<li>'asshole'</li>
	<li>'computer'</li>
	<li>'michelle'</li>
	<li>'jessica'</li>
	<li>'pepper'</li>
	<li>'1111'</li>
	<li>'zxcvbn'</li>
	<li>'555555'</li>
	<li>'11111111'</li>
	<li>'131313'</li>
	<li>'freedom'</li>
	<li>'777777'</li>
	<li>'pass'</li>
	<li>'fuck'</li>
	<li>'maggie'</li>
	<li>'159753'</li>
	<li>'aaaaaa'</li>
	<li>'ginger'</li>
	<li>'princess'</li>
	<li>'joshua'</li>
	<li>'cheese'</li>
	<li>'amanda'</li>
	<li>'summer'</li>
	<li>'love'</li>
	<li>'ashley'</li>
	<li>'6969'</li>
	<li>'nicole'</li>
	<li>'chelsea'</li>
	<li>'biteme'</li>
	<li>'matthew'</li>
	<li>'access'</li>
	<li>'yankees'</li>
	<li>'987654321'</li>
	<li>'dallas'</li>
	<li>'austin'</li>
	<li>'thunder'</li>
	<li>'taylor'</li>
	<li>'matrix'</li>
</ol>




```R
run_tests({
    correct_common_passwords <- read_lines("datasets/10_million_password_list_top_10000.txt")
    test_that("the data read in is correct", {
    expect_equal(correct_common_passwords, common_passwords, 
        info = "datasets/10_million_password_list_top_10000.txt should be read in using read_lines and put into common_passwords.")
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
        current_start_time: 5.593 0.211 2547.688 0.004 0
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


## 4.  Passwords should not be common passwords
<p>The list of passwords was ordered, with the most common passwords first, and so we shouldn't be surprised to see passwords like <code>123456</code> and <code>qwerty</code> above. As hackers also have access to this list of common passwords, it's important that none of our users use these passwords!</p>
<p>Let's flag all the passwords in our user database that are among the top 10,000 used passwords.</p>


```R
# Flagging the users with passwords that are common passwords
users$common_password <- ifelse(users$password %in% common_passwords, TRUE, FALSE)

# Counting the number of users using common passwords
sum(users$common_password)

# Taking a look at the 12 first rows
head(users, n = 12)
```


129



<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th><th scope=col>length</th><th scope=col>too_short</th><th scope=col>common_password</th></tr></thead>
<tbody>
	<tr><td> 1              </td><td>vance.jennings  </td><td>joobheco        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 2              </td><td>consuelo.eaton  </td><td>0869347314      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 3              </td><td>mitchel.perkins </td><td>fabypotter      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 4              </td><td>odessa.vaughan  </td><td>aharney88       </td><td> 9              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 5              </td><td>araceli.wilder  </td><td>acecdn3000      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 6              </td><td>shawn.harrington</td><td>5278049         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td></tr>
	<tr><td> 7              </td><td>evelyn.gay      </td><td>master          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td></tr>
	<tr><td> 8              </td><td>noreen.hale     </td><td>murphy          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td></tr>
	<tr><td> 9              </td><td>gladys.ward     </td><td>lwsves2         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td></tr>
	<tr><td>10              </td><td>brant.zimmerman </td><td>1190KAREN5572497</td><td>16              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td>11              </td><td>leanna.abbott   </td><td>aivlys24        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td>12              </td><td>milford.hubbard </td><td>hubbard         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("the number of flagged passwords is correct", {
    expect_equal(sum(users$password %in% common_passwords), sum(users$common_password), 
        info = "users$common_password should be TRUE for each row with a password that is also in common_passwords.")
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
        current_start_time: 5.633 0.215 2547.731 0.004 0
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


## 5. Passwords should not be common words
<p>Ay ay ay! It turns out many of our users use common passwords, and of the first 12 users there are already two. However, as most common passwords also tend to be short, they were already flagged as being too short. What is the next thing we should check?</p>
<blockquote>
  <p>Verifiers SHALL compare the prospective secrets against a list that contains [...] dictionary words.</p>
</blockquote>
<p>This follows the same logic as before: It is easy for hackers to check users' passwords against common English words and therefore common English words make bad passwords. Let's check our users' passwords against the top 10,000 English words from <a href="https://github.com/first20hours/google-10000-english">Google's Trillion Word Corpus</a>.</p>


```R
# Reading in a list of the 10000 most common words
words <- read_lines("datasets/google-10000-english.txt")

# Flagging the users with passwords that are common words
users$common_word <- ifelse(users$password %in% words, TRUE, FALSE)

# Counting the number of users using common words as passwords
sum(users$common_word)


# Taking a look at the 12 first rows
head(users, n = 12)
```


136



<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th><th scope=col>length</th><th scope=col>too_short</th><th scope=col>common_password</th><th scope=col>common_word</th></tr></thead>
<tbody>
	<tr><td> 1              </td><td>vance.jennings  </td><td>joobheco        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 2              </td><td>consuelo.eaton  </td><td>0869347314      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 3              </td><td>mitchel.perkins </td><td>fabypotter      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 4              </td><td>odessa.vaughan  </td><td>aharney88       </td><td> 9              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 5              </td><td>araceli.wilder  </td><td>acecdn3000      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 6              </td><td>shawn.harrington</td><td>5278049         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td> 7              </td><td>evelyn.gay      </td><td>master          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td><td> TRUE           </td></tr>
	<tr><td> 8              </td><td>noreen.hale     </td><td>murphy          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td><td> TRUE           </td></tr>
	<tr><td> 9              </td><td>gladys.ward     </td><td>lwsves2         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td>10              </td><td>brant.zimmerman </td><td>1190KAREN5572497</td><td>16              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td>11              </td><td>leanna.abbott   </td><td>aivlys24        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td></tr>
	<tr><td>12              </td><td>milford.hubbard </td><td>hubbard         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td></tr>
</tbody>
</table>




```R
run_tests({
    correct_words <- read_lines("datasets/google-10000-english.txt") 
    test_that("google-10000-english.txt is read in correctly", {
        expect_equal(correct_words, words, 
            info = "datasets/google-10000-english.txt should be read in using read_lines and put into words.")
    })
    
    test_that("the number of flagged passwords is correct", {
        users$common_word <- str_to_lower(users$password) %in% words
        expect_equal(sum(users$common_word), sum(str_to_lower(users$password) %in% correct_words), 
            info = "users$common_word should be TRUE for each row with a password that is also in words.")
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
        current_start_time: 5.681 0.215 2547.779 0.004 0
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


## 6. Passwords should not be your name
<p>It turns out many of our passwords were common English words too! Next up on the NIST list:</p>
<blockquote>
  <p>Verifiers SHALL compare the prospective secrets against a list that contains [...] context-specific words, such as the name of the service, the username, and derivatives thereof.</p>
</blockquote>
<p>Ok, so there are many things we could check here. One thing to notice is that our users' usernames consist of their first names and last names separated by a dot. For now, let's just flag passwords that are the same as either a user's first or last name.</p>


```R
# Extracting first and last names into their own columns
users$first_name <- str_extract(users$user_name, "^\\w+")
users$last_name <- str_extract(users$user_name, "\\w+$")

# Flagging the users with passwords that matches their names
users$uses_name <- ifelse(users$password == users$first_name | users$password == users$last_name , TRUE, FALSE)

# Counting the number of users using names as passwords
sum(users$uses_name)


# Taking a look at the 12 first rows
head(users, n = 12)
```


50



<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th><th scope=col>length</th><th scope=col>too_short</th><th scope=col>common_password</th><th scope=col>common_word</th><th scope=col>first_name</th><th scope=col>last_name</th><th scope=col>uses_name</th></tr></thead>
<tbody>
	<tr><td> 1              </td><td>vance.jennings  </td><td>joobheco        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>vance           </td><td>jennings        </td><td>FALSE           </td></tr>
	<tr><td> 2              </td><td>consuelo.eaton  </td><td>0869347314      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>consuelo        </td><td>eaton           </td><td>FALSE           </td></tr>
	<tr><td> 3              </td><td>mitchel.perkins </td><td>fabypotter      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>mitchel         </td><td>perkins         </td><td>FALSE           </td></tr>
	<tr><td> 4              </td><td>odessa.vaughan  </td><td>aharney88       </td><td> 9              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>odessa          </td><td>vaughan         </td><td>FALSE           </td></tr>
	<tr><td> 5              </td><td>araceli.wilder  </td><td>acecdn3000      </td><td>10              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>araceli         </td><td>wilder          </td><td>FALSE           </td></tr>
	<tr><td> 6              </td><td>shawn.harrington</td><td>5278049         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td><td>shawn           </td><td>harrington      </td><td>FALSE           </td></tr>
	<tr><td> 7              </td><td>evelyn.gay      </td><td>master          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td><td> TRUE           </td><td>evelyn          </td><td>gay             </td><td>FALSE           </td></tr>
	<tr><td> 8              </td><td>noreen.hale     </td><td>murphy          </td><td> 6              </td><td> TRUE           </td><td> TRUE           </td><td> TRUE           </td><td>noreen          </td><td>hale            </td><td>FALSE           </td></tr>
	<tr><td> 9              </td><td>gladys.ward     </td><td>lwsves2         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td><td>gladys          </td><td>ward            </td><td>FALSE           </td></tr>
	<tr><td>10              </td><td>brant.zimmerman </td><td>1190KAREN5572497</td><td>16              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>brant           </td><td>zimmerman       </td><td>FALSE           </td></tr>
	<tr><td>11              </td><td>leanna.abbott   </td><td>aivlys24        </td><td> 8              </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>leanna          </td><td>abbott          </td><td>FALSE           </td></tr>
	<tr><td>12              </td><td>milford.hubbard </td><td>hubbard         </td><td> 7              </td><td> TRUE           </td><td>FALSE           </td><td>FALSE           </td><td>milford         </td><td>hubbard         </td><td> TRUE           </td></tr>
</tbody>
</table>




```R
run_tests({
    correct_first_name <- str_extract(users$user_name, "^\\w+")
    correct_last_name <- str_extract(users$user_name, "\\w+$")

    # Flagging the users with passwords that matches their names
    correct_uses_name <- str_to_lower(users$password) == correct_first_name |
                         str_to_lower(users$password) == correct_last_name
    test_that("the number of flagged passwords is correct", {
        expect_equal(sum(correct_uses_name), sum( users$uses_name), 
            info = "users$uses_name should be TRUE for each row with a password which is also the first or last name.")
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
        current_start_time: 5.739 0.215 2547.836 0.004 0
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


## 7. Passwords should not be repetitive
<p>Milford Hubbard (user number 12 above), what where you thinking!? Ok, so the last thing we are going to check is a bit tricky:</p>
<blockquote>
  <p>verifiers SHALL compare the prospective secrets [so that they don't contain] repetitive or sequential characters (e.g. ‘aaaaaa’, ‘1234abcd’).</p>
</blockquote>
<p>This is tricky to check because what is <em>repetitive</em> is hard to define. Is <code>11111</code> repetitive? Yes! Is <code>12345</code> repetitive? Well, kind of. Is <code>13579</code> repetitive? Maybe not..? To check for <em>repetitiveness</em> can be arbitrarily complex, but here we're only going to do something simple. We're going to flag all passwords that contain 4 or more repeated characters.</p>


```R
# Splitting the passwords into vectors of single characters
split_passwords <- str_split(users$password, "")
# Picking out the max number of repeat characters for each password
users$max_repeats <- sapply(split_passwords, function(split_password) {
    rle(split_password)$lengths
})


# Flagging the passwords with >= 4 repeats
users$too_many_repeats <- sapply(users$max_repeats, function(x) {
    any(unlist(x) >= 4)
})


                                 
# Taking a look at the users with too many repeats
subset(users, too_many_repeats == TRUE )
```


<table>
<thead><tr><th scope=col>id</th><th scope=col>user_name</th><th scope=col>password</th><th scope=col>length</th><th scope=col>too_short</th><th scope=col>common_password</th><th scope=col>common_word</th><th scope=col>first_name</th><th scope=col>last_name</th><th scope=col>uses_name</th><th scope=col>max_repeats</th><th scope=col>too_many_repeats</th></tr></thead>
<tbody>
	<tr><td>147             </td><td>patti.dixon     </td><td>555555          </td><td>6               </td><td> TRUE           </td><td> TRUE           </td><td>FALSE           </td><td>patti           </td><td>dixon           </td><td>FALSE           </td><td>6               </td><td>TRUE            </td></tr>
	<tr><td>573             </td><td>cornelia.bradley</td><td>555555          </td><td>6               </td><td> TRUE           </td><td> TRUE           </td><td>FALSE           </td><td>cornelia        </td><td>bradley         </td><td>FALSE           </td><td>6               </td><td>TRUE            </td></tr>
	<tr><td>645             </td><td>essie.lopez     </td><td>11111           </td><td>5               </td><td> TRUE           </td><td> TRUE           </td><td>FALSE           </td><td>essie           </td><td>lopez           </td><td>FALSE           </td><td>5               </td><td>TRUE            </td></tr>
	<tr><td>799             </td><td>charley.key     </td><td>888888          </td><td>6               </td><td> TRUE           </td><td> TRUE           </td><td>FALSE           </td><td>charley         </td><td>key             </td><td>FALSE           </td><td>6               </td><td>TRUE            </td></tr>
	<tr><td>808             </td><td>thurman.osborne </td><td>rinnnng0        </td><td>8               </td><td>FALSE           </td><td>FALSE           </td><td>FALSE           </td><td>thurman         </td><td>osborne         </td><td>FALSE           </td><td>1, 1, 4, 1, 1   </td><td>TRUE            </td></tr>
	<tr><td>942             </td><td>mitch.ferguson  </td><td>aaaaaa          </td><td>6               </td><td> TRUE           </td><td> TRUE           </td><td>FALSE           </td><td>mitch           </td><td>ferguson        </td><td>FALSE           </td><td>6               </td><td>TRUE            </td></tr>
</tbody>
</table>




```R
run_tests({
    correct_max_repeats <- sapply(users$password, function(password) {
        split_password <- str_split(password, "")[[1]]
        rle_password <- rle(split_password)
        max(rle_password$lengths)
    })

    test_that("the number of flagged passwords is correct", {
        expect_equal(sum(users$too_many_repeats), sum( users$max_repeats >= 4), 
            info = "users$too_many_repeats should be TRUE for each row with a password with 4 or more repeats.")
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
        current_start_time: 5.852 0.215 2547.948 0.004 0
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


## 8. All together now!
<p>Now we have implemented all the basic tests for bad passwords suggested by NIST Special Publication 800-63B! What's left is just to flag all bad passwords and maybe to send these users an e-mail that strongly suggests they change their password.</p>


```R
# Flagging all passwords that are bad
users$bad_password <- users$too_short | users$common_password | users$common_word | users$uses_name | users$too_many_repeats

# Counting the number of bad passwords
sum(users$bad_password)

# Looking at the first 100 bad passwords
users %>% filter(bad_password) %>% select(password) %>% top_n(100)
```


424


    Selecting by password



<table>
<thead><tr><th scope=col>password</th></tr></thead>
<tbody>
	<tr><td>zvc1939     </td></tr>
	<tr><td>woodard     </td></tr>
	<tr><td>reid        </td></tr>
	<tr><td>wwewwf1     </td></tr>
	<tr><td>y8uM7D6     </td></tr>
	<tr><td>sanaang     </td></tr>
	<tr><td>thx1138     </td></tr>
	<tr><td>wishes      </td></tr>
	<tr><td>shy!        </td></tr>
	<tr><td>scanner     </td></tr>
	<tr><td>replaced    </td></tr>
	<tr><td>ware        </td></tr>
	<tr><td>rr55367     </td></tr>
	<tr><td>roland      </td></tr>
	<tr><td>stefan      </td></tr>
	<tr><td>vHO2y       </td></tr>
	<tr><td>precise     </td></tr>
	<tr><td>william     </td></tr>
	<tr><td>tdutza      </td></tr>
	<tr><td>winter      </td></tr>
	<tr><td>pharmacology</td></tr>
	<tr><td>prince      </td></tr>
	<tr><td>pugh        </td></tr>
	<tr><td>yewywe      </td></tr>
	<tr><td>zimmerman   </td></tr>
	<tr><td>porseza     </td></tr>
	<tr><td>vicente     </td></tr>
	<tr><td>pnai88      </td></tr>
	<tr><td>stuck       </td></tr>
	<tr><td>teCoFL      </td></tr>
	<tr><td>...</td></tr>
	<tr><td>sally       </td></tr>
	<tr><td>rick        </td></tr>
	<tr><td>wek1234     </td></tr>
	<tr><td>utilities   </td></tr>
	<tr><td>plines      </td></tr>
	<tr><td>summer      </td></tr>
	<tr><td>sapphire    </td></tr>
	<tr><td>pittman     </td></tr>
	<tr><td>toyota      </td></tr>
	<tr><td>realis      </td></tr>
	<tr><td>timeline    </td></tr>
	<tr><td>suga88      </td></tr>
	<tr><td>pitus1      </td></tr>
	<tr><td>rinnnng0    </td></tr>
	<tr><td>volunteers  </td></tr>
	<tr><td>yellow      </td></tr>
	<tr><td>shields     </td></tr>
	<tr><td>reproduction</td></tr>
	<tr><td>tremarr     </td></tr>
	<tr><td>robert      </td></tr>
	<tr><td>singapore   </td></tr>
	<tr><td>qwer1234    </td></tr>
	<tr><td>rangers     </td></tr>
	<tr><td>pedir5      </td></tr>
	<tr><td>pepper      </td></tr>
	<tr><td>raiders     </td></tr>
	<tr><td>spider      </td></tr>
	<tr><td>summer      </td></tr>
	<tr><td>seeks       </td></tr>
	<tr><td>rangers     </td></tr>
</tbody>
</table>




```R
run_tests({
    correct_bad_password <- users$too_short | users$common_word |
                      users$common_password | users$uses_name |
                      users$too_many_repeats
    test_that("all the bad passwords are flagged", {
    expect_equal(sum(correct_bad_password), sum(users$bad_password), 
        info = "All rows with passwords that should be flagged as bad should have users$bad_password set to TRUE.")
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
        current_start_time: 5.918 0.215 2548.013 0.004 0
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


## 9. Otherwise, the password should be up to the user
<p>In this notebook, we've implemented the password checks recommended by the NIST Special Publication 800-63B. It's certainly possible to better implement these checks, for example, by using a longer list of common passwords. Also note that the NIST checks in no way guarantee that a chosen password is good, just that it's not obviously bad.</p>
<p>Apart from the checks we've implemented above the NIST is also clear with what password rules should <em>not</em> be imposed:</p>
<blockquote>
  <p>Verifiers SHOULD NOT impose other composition rules (e.g., requiring mixtures of different character types or prohibiting consecutively repeated characters) for memorized secrets. Verifiers SHOULD NOT require memorized secrets to be changed arbitrarily (e.g., periodically).</p>
</blockquote>
<p>So the next time a website or app tells you to "include both a number, symbol and an upper and lower case character in your password" you should send them a copy of <a href="https://pages.nist.gov/800-63-3/sp800-63b.html">NIST Special Publication 800-63B</a>.</p>


```R
# Enter a password that passes the NIST requirements
# PLEASE DO NOT USE AN EXISTING PASSWORD HERE
new_password <- "ht14jklr"
```


```R
run_tests({
    temp_common_passwords <- read_lines("datasets/10_million_password_list_top_10000.txt")
    temp_words <- read_lines("datasets/google-10000-english.txt")

    is_bad <- str_length(new_password) < 8 |
        new_password %in% temp_common_passwords |
        str_to_lower(new_password) %in% temp_words |
        max(rle(str_split(new_password, "")[[1]])$lengths) >= 4

    test_that("", {
    expect_false(is_bad, 
        info = "This password does not fulfill the NIST requirements.")
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
        current_start_time: 5.955 0.215 2548.05 0.004 0
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

