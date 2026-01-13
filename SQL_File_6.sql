#we are using where clause to find out the number of orders being placed
select count(*) from restaurants
where cuisine = 'Italian'

#Top 10 Driver_Id who has delivered the orders
select driver_id, count(order_id) as drive from orders
group by driver_id
order by drive desc
limit 10;

#Top 10 drivers with maximum revenue
select driver_id, round(sum(final_price),2) as revenue from orders
group by driver_id
order by revenue desc
limit 10;

#Total revenue monthwise wrt orders placed
select month(order_date) as monthwise, round(sum(final_price),2) as revenue, count(order_id) as orders
from orders
group by monthwise
order by revenue desc;

#fastest delivery wrt order
select timediff(delivered_time,order_time) as difference, driver_id  from orders
order by difference asc;

#longest delivery wrt order
select timediff(delivered_time,order_time) as difference, driver_id  from orders
order by difference desc;

#Which food item order maximum time and which restaurant serve it along with cuisine
select f.item_name, sum(o.quantity) as number_of_orders, r.cuisine,r.restaurant_name from food_items f
left join orders_items o on f.item_id=o.item_id
left join restaurants r on r.restaurant_id=f.restaurant_id
where o.quantity is not null
group by f.item_name, r.restaurant_name, r.cuisine
order by number_of_orders desc;

#Revenue generate within a given time frame
Select sum(final_price) as revenue from orders
where order_date between '2022-06-15' and '2022-06-30';

#Number of restaurants cuisine wise
select cuisine,count(*) from restaurants
group by cuisine;

#Which customer orders mostly online
select c.first_name, count(order_id) as orders, sum(o.total_price) as revenue from customers c
left join orders o on c.customer_id=o.customer_id
group by  c.first_name
order by revenue desc, orders asc
limit 10;

#It will give an insight of number of orders day wise in which day we get the maximum number of orders
SELECT 
       DAYNAME(order_date) AS day_name, count(order_id) as no_of_orders, sum(total_price) as revenue
FROM orders
group by day_name
order by revenue desc;

#Rank wise restaurant wrt to total food items (Menu)
SELECT
    restaurant_id,
    COUNT(item_id) AS total_food_items,
    RANK() OVER (ORDER BY COUNT(item_id) DESC) AS restaurant_rank
FROM food_items
GROUP BY restaurant_id;

#Case Statement:-
#Find the number of restaurant category wise by using case statement
select category, count(Category) as Number_Of_Restaurant from
(
select food_type,
case
when food_type = 'vegetarian' then 'Vegetarian'
when food_type = 'non-vegetarian' then 'Non-Vegetarian'
when food_type = 'veg' then 'Vegetarian'
when food_type = 'non-veg' then 'Non-Vegetarian'
end as 'Category'
from food_items
)t
group by Category

