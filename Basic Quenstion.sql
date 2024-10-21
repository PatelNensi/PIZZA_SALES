create database Pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

Select * from pizzahut.orders;

create table orders_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));

Select * from orders_details;
Select * from pizzahut.pizzas;
Select * from pizzahut.pizza_types;

# BASIC QUENTIONS


# 1 Retrieve the total number of orders placed.
select count(order_id) as total_order from orders;


# 2 Calculate the total revenue generated from pizza sales.
select * from pizzahut.orders_details;
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS Total_Revenue
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;


# 3.Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
 

# 4. Identify the most common pizza size ordered. COUNT THE ORDER USE COUNT FUNCTION
SELECT 
    pizzas.size, COUNT(orders_details.order_details_id) as Order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY Order_count DESC
LIMIT 5;


# 5.List the top 5 most ordered pizza types along with their quantities. USE SUM FORMULA

SELECT 
    pizza_types.name, 
    SUM(orders_details.quantity) AS QUANTITY
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN
	orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY 
    pizza_types.name
ORDER BY 
    QUANTITY DESC
LIMIT 5;



