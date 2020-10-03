# Prediction-Bank-Term-Deposit-Subscription-

![bankdeposit](https://user-images.githubusercontent.com/49653689/94882718-be287680-0436-11eb-85b8-18392952e129.png)

#### -- Project Status: [Completed]

## Project Objective
The purpose of this project is to target potential customers for bank term deposit subscription.

### Methods Used
* Exploratory Data Analysis
* Feature Engineering 
* Crosstab and Dummy Coding 
* Predictive Modeling
* Scoring and KS test

### Technologies
* SAS

## Project Description
(Provide more detailed overview of the project.  Talk a bit about your data sources and what questions and hypothesis you are exploring. What specific data analysis/visualization and modelling work are you using to solve the problem? What blockers and challenges are you facing?  Feel free to number or bullet point things here)

### Data 

* The dataset was obtained from the University of California’s Machine Learning Repository. 

* The particular dataset for this project is related with direct marketing campaigns (phone calls) of a Portuguese banking institution. The dataset is relevant with 17 campaigns from May 2008 to November 2010 and it demonstrates the details of each contract the bank offered to the clients.

* 41,188 customer records by 20 attributes.

### Project Flow

![projectflow](https://user-images.githubusercontent.com/49653689/94937269-5e18eb00-049d-11eb-94ba-b38c28438fab.png)

## Scoring Card

![chart](https://user-images.githubusercontent.com/49653689/94979707-546da280-04f2-11eb-8ae2-f648775ae305.png)
 
### Kolmogorov-Smirnov Test

![kstest](https://user-images.githubusercontent.com/49653689/94947429-a212ec80-04ab-11eb-9b29-b86dc7bb1083.png)

## Results

Score 550 is a reasonable cutoff level that separates the customers most efficiently. More specifically, 60.6% of the term deposit subscribers scored above 550, while 12.9% of the non-subscribers scored above 550. With a cutoff of 550, 18.21% of the total population will be selected into target customer group and be regarded as potential subscriber of the term deposit. Among selected customers, 62.78% of them are expected to decline the term deposit offer. In other words, 37.22% of the campaigned customers are expected to accept the offer. Without using our model, only 11.27% of the campaigned customers would subscribe the term deposit.


