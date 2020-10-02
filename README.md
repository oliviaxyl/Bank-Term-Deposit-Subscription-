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

### Scoring Card

![chart](https://user-images.githubusercontent.com/49653689/94939383-0def5800-04a0-11eb-99dd-9d05eac247d8.png)

Table 5 contains the results of KS test for total dataset. The cutoff score is 551 to 600.
The true positive is 60.60%, but the false positive is 12.90% if using this cutoff score,
which means 60.60% customers whose scores are higher than551 will truly have
deposit, while at the same time 12.90% of total no-deposit customers will be filtered
into the group by mistake. In general, the cut-off works will as the false positive counts
is relatively lower, and the total difference, 47.70%, is still an attractive difference
when we want to filter the customers.

### Kolmogorov-Smirnov Test


