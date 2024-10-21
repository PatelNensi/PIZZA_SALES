# Advanced:
# 1 Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(
        SUM(orders_details.quantity * pizzas.price) / 
        (
            SELECT SUM(orders_details.quantity * pizzas.price)
            FROM orders_details
            JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id
        ) * 100, 2
    ) AS percentage_revenue
FROM
    pizza_types
JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.category
ORDER BY 
    percentage_revenue DESC;


# 2 Analyze the cumulative revenue generated over time.

SELECT date,
SUM(REV) OVER (ORDER BY date) AS CUM_REV
FROM
(SELECT orders.date,
SUM(orders_details.quantity*pizzas.price) AS REV
FROM 
orders_details JOIN pizzas
ON orders_details.pizza_id = pizzas.pizza_id
JOIN orders
ON orders.order_id = orders_details.order_id
GROUP BY orders.date) AS SALES;


# 3 Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT NAME, CATE_REVENUE FROM
(SELECT CATEGORY, NAME, CATE_REVENUE,
RANK() OVER(PARTITION BY CATEGORY ORDER BY CATE_REVENUE DESC) AS RNK 
FROM
(SELECT pizza_types.category, pizza_types.name,
SUM((orders_details.quantity) * pizzas.price) AS CATE_REVENUE
FROM pizza_types
JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details 
ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) AS PIZZA_CATEGORY) AS PIZZA_B
WHERE RNK <= 5
ORDER BY CATE_REVENUE DESC 
LIMIT 10;