# API Test

I used this simple code snippet to test a third party provider API update function with data from our company.
Some of the useful tidbits that you can use are:<br>
-  Use of the arrow package to convert dates to UTC
-  Use of numpy to check for nan
-  Use of pandas to merge two data frames, drop na values and loop using itertuples to loop through the dataframe
-  Use of requests to make the API call
<br>
Note that I have to hide some information from the code but I am including the example for illustration purposes
<br>
<br>

```python
import arrow
import numpy as np
import requests
import pandas as pd

def is_nan(x):
    return (x is np.nan or x != x)

def build_results_string(testlength, testRL, testFDR, testImpedance):
    ##payload = "{\"test_length\":" + str(row.testlength) +  ",\"test_rl\": \"" + str(row.testRL) + "\",\"fdr\": \"" + str(row.testFDR) + "\",\"impedance\": "  + str(row.testImpedance) +  "}}"
    resultstring = ""
    if (is_nan(testlength) == False): 
        resultstring = "\"test_length\":" + str(testlength) +  ","
    if(is_nan(testRL) == False):
        resultstring = resultstring  + "\"test_rl\": \"" + str(testRL) + "\","
    if(is_nan(testFDR) == False):
        resultstring = resultstring  + "\"fdr\": \"" + str(testFDR) + "\","
    if(is_nan(testImpedance) == False):
        resultstring = resultstring  + "\"impedance\": "  + str(testImpedance) 
    return resultstring
  

#example date conversion code
#t = arrow.get(section_data["teststarttime"]).replace(tzinfo='US/Eastern').to('UTC').isoformat()

batches =  pd.read_csv("Batches.csv", header = 0)
section_data = pd.read_csv("Data_Sections.csv", header = 0, parse_dates=['teststarttime'])

final_data = pd.merge(section_data, batches,  left_on='section', right_on='batchname')


#GET The names of the columns in Dataframe
#list(section_data)

#Discard records without a test time.
section_data_clean = final_data[final_data["teststarttime"].isnull() == False]

#Header for API call
headers = {
    'Authorization': "Token ************************************",
    'Content-Type': "application/json"
    }
                                                  


i = 1
for row in section_data_clean.itertuples():
    url = "https://**********************************************"
    payload =  "{\"batch_id\": \"" + row.batchid   + "\",\"timestamp\": \"" + str(arrow.get(row.teststarttime).replace(tzinfo='US/Eastern').to('UTC').isoformat()) + "\",\"results\": {" + build_results_string(row.testlength, row.testRL, row.testFDR, row.testImpedance) +  "}}"
    payload = payload.replace(",}}", "}}")
    

    response = requests.request("POST", url, data=payload, headers=headers)
    #check the response code
    if response.status_code != 200:
          print(str(i), str(response.status_code),  payload)
          print()
    i = i + 1
print("Finished uploading data")
```

    Finished uploading data
    
