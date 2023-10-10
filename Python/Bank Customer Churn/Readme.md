# Bank Customer Churn Prediction

The aim of this project is to analyze the bank customer's demographics and financial information, including the customer's age, gender, country, credit score, balance, and more, to predict whether the customer will leave the bank or not.

## About the Dataset

The dataset is sourced from [Kaggle](https://www.kaggle.com/datasets/mathchi/churn-for-bank-customers?datasetId=797699&sortBy=voteCount) and consists of 10,000 rows and 14 columns. The objective of the dataset is to predict whether a customer will leave the bank based on their demographics and financial information.

The dataset includes several independent variables that can influence a customer's decision to leave the bank. The target variable, termed the dependent variable, is the customer's decision to leave the bank.

## Data Dictionary

| Column Name       | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| RowNumber         | Row number                                                    |
| CustomerId        | Unique identification key for different customers             |
| Surname           | Customer's last name                                          |
| CreditScore       | Credit score of the customer                                 |
| Geography         | Country of the customer                                      |
| Age               | Age of the customer                                           |
| Tenure            | Number of years for which the customer has been with the bank |
| Balance           | Bank balance of the customer                                  |
| NumOfProducts     | Number of bank products the customer is utilizing             |
| HasCrCard         | Binary flag indicating whether the customer holds a credit card with the bank or not |
| IsActiveMember    | Binary flag indicating whether the customer is an active member with the bank or not |
| EstimatedSalary   | Estimated salary of the customer in Dollars                   |
| Exited            | Binary flag (1 if the customer closed the account with the bank, 0 if the customer is retained) |
