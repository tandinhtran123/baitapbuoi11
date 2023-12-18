--bai 1
Select COUNTRY.Continent,
FLOOR (avg(CITY.Population))
from CITY 
INNER JOIN COUNTRY 
on COUNTRY.CODE = CITY.COUNTRYCODE
Group by COUNTRY.Continent
--bai 2
SELECT ROUND(
SUM( CASE WHEN texts.email_id IS NOT NULL THEN 1
ELSE 0 END)::DECIMAL
/ COUNT(user_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
ON emails.email_id = texts.email_id
AND signup_action = 'Confirmed';
--bai 3
SELECT b.age_bucket,
ROUND(sum(case when a.activity_type = 'open' then time_spent else 0 end)/sum(case when a.activity_type = 'open' or a.activity_type= 'send' then time_spent else 0 end) *100.0,2) as open_perc,
ROUND(SUM(case when a.activity_type= 'send' then time_spent else 0 end)/sum(case when a.activity_type = 'open' or a.activity_type= 'send' then time_spent else 0 end) *100.0,2) as send_perc
FROM activities as a inner join age_breakdown as b
on a.user_id = b.user_id 
where a.activity_type = 'open' or a.activity_type = 'send'
GROUP BY b.age_bucket
--bai 4
SELECT customer_id
From customer_contracts a LEFT JOIN products b 
ON a.product_id= b.product_id
GROUP BY customer_id
HAVING COUNT (DISTINCT product_category) >= (SELECT COUNT(DISTINCT product_category) from products)
--bai 5
select e1.employee_id, name, reports_count, average_age from 
    (select reports_to as employee_id, count(distinct employee_id) as reports_count, round(avg(age)) as average_age
    from Employees
    Group by reports_to 
    Having reports_to is not NULL) e1
Left Join Employees e2
on e1.employee_id=e2.employee_id
group by e1.employee_id
--bai 6
Select p.product_name, sum(unit) as unit
From Products p 
Left Join Orders o
On p.product_id = o.product_id
where o.order_date between '2020-02-01' and '2020-02-29'
Group by p.product_id
Having sum(unit) >=100
--bai 7
SELECT a.page_id
FROM pages a Left Join page_likes b
ON a.page_id = b.page_id
Where liked_date is NULL
ORDER BY a.page_id ASC

--mid-course test
--bai 1
select distinct replacement_cost, 
min (replacement_cost)
from film
group by replacement_cost
--bai 2
Select
case 
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
when replacement_cost between 25.00 and 29.99 then 'high'
end as tier,
count (*) as amount
from film
group by tier
--bai 3
select 
a.film_id, a.title, a.length, b.category_id, a.description
from film a left join film_category b
on a.film_id = b.film_id
group by a.film_id, a.title, a.length,b.category_id
having description like '%Drama%' or description like '%Sports%'
Order by a.length DESC
--bai 4


