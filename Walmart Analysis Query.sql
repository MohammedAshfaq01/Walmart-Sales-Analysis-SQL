-- Data cleaning
SELECT
	*
FROM sales;


-- Add the time_of_day column
SELECT 
  CASE
    WHEN [time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN [time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM Sales;

ALTER TABLE sales 
ADD time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
    CASE
        WHEN [time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN [time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);
-- Add day_name column
SELECT 
    [Date],
    DATENAME(WEEKDAY, [Date]) AS DayName
FROM Sales;

Alter TABLE Sales
ADD DayName VARCHAR(10)

UPDATE Sales
SET DayName = DATENAME(WEEKDAY, [Date]);

-- Add month_name column
SELECT
	[Date],
	DATENAME(MONTH, [Date]) AS MonthName
FROM sales;

Alter TABLE Sales
ADD MonthName VARCHAR(10)

Update Sales
SET MonthName = DATENAME(MONTH, [Date])

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
DISTINCT City From 

-- In which city is each branch?
SELECT 
DISTINCT City,branch From Sales

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?

SELECT Distinct product_line From Sales

-- What is the most selling product line
SELECT * From Sales

SELECT SUM(quantity) AS qty,product_line From Sales 
Group By product_line 
Order by qty DESC;

-- What is the total revenue by month

Select MonthName , SUM(Total) AS Total_Revenue
From Sales 
Group by MonthName 
Order by Total_Revenue DESC;

-- What month had the largest COGS?
SELECT SUM(cogs) AS COG , MonthName
From Sales
Group by MonthName
ORDER By COG DESC;

-- What product line had the largest revenue?

SELECT SUM(total) AS Revenue , product_line
From Sales
Group by product_line
ORDER By Revenue DESC;

-- What is the city with the largest revenue?
SELECT * From Sales

Select SUM(total) AS Revenue, City, Branch
From Sales
Group  by City,Branch
Order By Revenue DESC;

-- What product line had the largest VAT?

SELECT
	product_line,
	AVG(Tax_5) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
SELECT Avg(Quantity) AS AVG_Sales
FROM Sales

SELECT
    Product_Line,
    CASE
        WHEN AVG(Quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM
    Sales
GROUP BY
    Product_Line;
	
-- Which branch sold more products than average product sold?
SELECT * From Sales

Select SUM(Quantity) As total_sold, Branch
From Sales
Group By Branch

Having Sum(Quantity) > (Select Avg(Quantity) From Sales)

-- What is the most common product line by gender

SELECT * From Sales

Select Gender, Product_line, Count(Gender) AS Total_Gender FROM Sales
Group by Gender,Product_line
Order BY Gender;

-- What is the average rating of each product line

Select Round(Avg(Rating) ,2 ) As Avg_rating,Product_line From Sales
Group by Product_line
Order by Avg_rating DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------

-- How many unique customer types does the data have?

Select * From Sales


Select DISTINCT Customer_type From Sales;

-- How many unique payment methods does the data have?

Select Distinct Payment From Sales

-- What is the most common customer type?

SELECT
	customer_type,
	count(*) As Count
FROM sales
GROUP BY customer_type
Order By Count DESC;

-- Which customer type buys the most?

Select customer_type,
Count(*) From Sales
Group By customer_type ;

-- What is the gender of most of the customers?

Select Gender , Count(*) As Gender_count From Sales
Group by Gender 
Order By Gender_count DESC;

-- What is the gender distribution per branch?
Select Gender, Count(*) As genderr From 
Sales
WHERE branch = 'A'
GROUP BY Gender
ORDER BY genderr DESC;
Select Gender, Count(*) As genderr From 
Sales
WHERE branch = 'B'
GROUP BY Gender
ORDER BY genderr DESC;
Select Gender, Count(*) As genderr From 
Sales
WHERE branch = 'C'
GROUP BY Gender
ORDER BY genderr DESC;

-- Which time of the day do customers give most ratings?
Select * From Sales

Select time_of_day , ROUND(Avg(Rating),2) As Average From Sales
Group by time_of_day
Order By Average DESC;

-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?

Select time_of_day , Round(Avg(Rating),2) As Average From Sales
Where Branch = 'A'
Group by time_of_day
Order By Average DESC;

Select time_of_day , Round(Avg(Rating),2) As Average From Sales
Where Branch = 'B'
Group by time_of_day
Order By Average DESC;

Select time_of_day , Round(Avg(Rating),2) As Average From Sales
Where Branch = 'C'
Group by time_of_day
Order By Average DESC;

-- Which day of the week has the best avg ratings?

Select * From Sales

Select DayName , Round(Avg(Rating),2) As Average From Sales
Group by DayName
Order by Average DESC;

-- Which day of the week has the best average ratings per branch?

Select DayName , Avg(Rating) As Average From Sales
Where Branch ='A'
Group by DayName
Order By Average DESC;

Select DayName , Avg(Rating) As Average From Sales
Where Branch ='B'
Group by DayName
Order By Average DESC;

Select DayName , Avg(Rating) As Average From Sales
Where Branch ='C'
Group by DayName
Order By Average DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 

Select time_of_day , Count(*) As Total From Sales
Where DayName='Sunday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Monday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Tuesday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Wednesday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Thursday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Friday'
Group by time_of_day
Order by Total Desc;

Select time_of_day , Count(*) As Total From Sales
Where DayName='Saturday'
Group by time_of_day
Order by Total Desc;

-- Which of the customer types brings the most revenue? 
Select Customer_type,Round(Sum(total),2) As Revenue From Sales
Group by Customer_type
Order by Revenue Desc;

-- Which city has the largest tax/VAT percent?
Select City, Round(Avg(Tax_5),2) As Tax From Sales
Group by City
Order by Tax Desc;

-- Which customer type pays the most in VAT?

Select Customer_type , Round(Avg(Tax_5),2) As tax From Sales
Group by Customer_type
Order By tax Desc;






