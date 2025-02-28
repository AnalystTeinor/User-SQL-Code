Select*
from users_data;

Create table user_data_dup
like users_data;

Select*
from user_data_dup;

Insert user_data_dup
Select*
from users_data;

----------------------------------- Data Cleaning and Data Explortation ----------------------

Select*,
row_number() over( partition by id, current_age, retirement_age, birth_year, birth_month, gender, address, latitude, 
longitude, per_capita_income, yearly_income, total_debt, credit_score, num_credit_cards) as row_num
from user_data_dup;

With duplicate_cte as
(Select*,
row_number() over( partition by id, current_age, retirement_age, birth_year, birth_month, gender, address, latitude, 
longitude, per_capita_income, yearly_income, total_debt, credit_score, num_credit_cards) as row_num
from user_data_dup)

Select*
from duplicate_cte
where row_num > 1; 

Select*
from user_data_dup;

----------- What is the total Customers the data have?-----------

Select 
count(distinct id) as Total_Customers
from user_data_dup;

----------- How many unique credit cards does the data have?-----------

Select 
count(distinct num_credit_cards) as Total_Unique_Credit_cards
from user_data_dup;

----------- What is the most common gender in the dataset?-----------

SELECT 
gender, 
COUNT(*) AS gender_population
FROM
user_data_dup
GROUP BY gender
ORDER BY gender_population DESC;

----------------------------------- Business Key Problems and Answers --------------------


----------------- 1. What is the average per capita income of users? -----------------

SELECT AVG(CAST(REPLACE(per_capita_income, '$', '') AS DECIMAL)) 
AS avg_per_capita_income 
FROM user_data_dup;

----------------- 2. What is the average total debt for users by gender? -----------------

SELECT gender, AVG(CAST(REPLACE(total_debt, '$', '') AS DECIMAL)) 
AS avg_total_debt
FROM user_data_dup
GROUP BY gender;

----------------- 3. Which birth year has the most users? -----------------

SELECT birth_year, COUNT(*) AS total_users
FROM user_data_dup
GROUP BY birth_year
ORDER BY total_users DESC
LIMIT 1;

----------------- 4. What is the average number of credit cards per user? -----------------

SELECT AVG(num_credit_cards) AS avg_credit_cards
FROM user_data_dup;

----------------- 5. Which address has the highest per capita income? -----------------

SELECT address, MAX(CAST(REPLACE(per_capita_income, '$', '') AS DECIMAL)) 
AS max_per_capita_income
FROM user_data_dup
GROUP BY address
ORDER BY max_per_capita_income DESC
LIMIT 1;

----------------- 6. What is the average credit score of users with more than 3 credit cards? -----------------

SELECT AVG(credit_score) AS avg_credit_score
FROM user_data_dup
WHERE num_credit_cards > 3;

-----------------  7. Which age group has the highest debt? -----------------

SELECT current_age, AVG(CAST(REPLACE(total_debt, '$', '') AS DECIMAL)) AS avg_debt
FROM user_data_dup
GROUP BY current_age
ORDER BY avg_debt DESC
LIMIT 1; 

----------------- 8. How many users have reached retirement age? -----------------

SELECT COUNT(*) AS retired_users
FROM user_data_dup
WHERE current_age >= retirement_age;

