# Intermediate:
# 1. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS Catergory_Qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Catergory_Qty DESC;


# 2. Determine the distribution of orders by hour of the day.

SELECT 
   HOUR(time) AS Hour, COUNT(order_id) AS Order_count
FROM
    orders
GROUP BY HOUR(time); 


# 3. Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;

# 4. Group the orders by date and calculate the average number of pizzas ordered per day.
# in this USE SUB QUERY LIKE CREATE 1 TABLE IN ADD ANOTHER TABLE FOR FING AVG

SELECT 
    ROUND(AVG(QTY), 0) AS Avg_Qty_Day
FROM
    (SELECT 
        orders.date, SUM(orders_details.quantity) AS QTY
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.date
    ORDER BY QTY DESC) AS QTY;


# 5. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue DESC
LIMIT 5;