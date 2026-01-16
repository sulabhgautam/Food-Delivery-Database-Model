#We used where clause to find the particular driver_id and the price gap.
select driver_id, count(order_id)  as place_order from orders
group by driver_id
order by place_order desc
limit 10
where driver_id = 10 and order_date between '2022-07-01' and '2022-07-31' and total_price > 50;

#Number of cuisine restaurant wise
select * from restaurants
select cuisine, count(restaurant_name) as number from restaurants
group by cuisine

#Day function used to find the trend in the month.
SELECT order_date,
       DAYNAME(order_date) AS day_name, count(order_id) as revenue
FROM orders
where order_date > '2022-09-01'
group by day_name, order_date
having day_name = 'monday'

#Revenue for the 15 days in a september month
select sum(final_price) as revenue from orders
where order_date between '2022-09-01' and '2022-09-15'

#NUmbers of orders placed in the given time and price must be above 35
select count(order_id) as number_order from orders
where order_date = '2022-07-01' and final_price < 35

#Average discount per month wrt revenue
select month(order_date) as months,count(order_id),sum(final_price) as revenue, sum(discount) as discount  from orders
group by months
order by discount desc;

#Rank wise restaurant wrt to total food items (Menu)
SELECT
    restaurant_id,
    COUNT(item_id) AS total_food_items,
    RANK() OVER (ORDER BY COUNT(item_id) DESC) AS restaurant_rank
FROM food_items
GROUP BY restaurant_id;

#Order placed by customer more than 1 order
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1

select * from drivers;
select driver_id, avg(rating) as average from drivers
group by driver_id
order by average desc;

select * from customers;
select * from orders;
select customer_id, count(customer_id) as total_orders
from orders
group by customer_id
order by total_orders desc;

select * from food_items;
select * from orders_items;

select f.item_id, f.restaurant_id, f.item_name, sum(o.quantity) as total
from food_items f
left join orders_items o on f.item_id = o.item_id
where restaurant_id = 10
group by f.item_id, f.restaurant_id, f.item_name
order by total desc;

select * from restaurants
select * from food_items;
Question 7
#What is the average calories per dish for each cuisine type? Values are close to nearest integer
select r.cuisine, avg(f.calories) as calories
from food_items f
left join restaurants r on r.restaurant_id = f.restaurant_id
group by r.cuisine

select avg(order_rating) as avg_rating, driver_id from orders
group by driver_id
order by avg_rating desc


#Which food items are ordeing maximum time
select f.item_name, sum(o.quantity) as quantity from food_items f
left join orders_items o on o.item_id = f.item_id
group by f.item_name
order by quantity desc;

select * from drivers
order by rating desc;
