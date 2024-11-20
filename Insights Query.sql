-- 1.  View menu_items table

SELECT * FROM menu_items;

-- 2. Find the number of items on the ?
SELECT COUNT(*) FROM menu_items;

-- 3. What is the least and most expensive items on the menu?
-- Least expensive
SELECT * FROM menu_items
ORDER BY price;

-- Most expensive
SELECT * FROM menu_items
ORDER BY price DESC;

-- 4. How many italian dishes are on the menu?
SELECT category, COUNT(category)
FROM menu_items 
WHERE category = "italian"
GROUP BY category;

-- 5. What are the least and most expensive italian dishes on the menu
-- Least
SELECT category, price
FROM menu_items
WHERE category = "italian"
ORDER BY price;

-- most
SELECT category, price
FROM menu_items
WHERE category = "italian"
ORDER BY price DESC;


-- 6. How many dishes are in each category?
SELECT COUNT(DISTINCT item_name) AS dishes, category FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category?
SELECT  category, round(AVG(price),1) FROM menu_items
GROUP BY category;

-- 8. View the order_table
SELECT * FROM order_details;

-- 9. What is the date range of the table?
 SELECT MIN(order_date), MAX(order_date) FROM order_details;
 
 -- 10. How many orders were made within this date range?
 SELECT COUNT(DISTINCT order_id) FROM order_details;
 
 -- 11. How many items were ordered within this date range?
 SELECT COUNT(order_id) AS items FROM order_details;
 
 -- 12. Which orders had the most number of items?
 SELECT DISTINCT order_id AS order_id, COUNT(item_id) AS item_count FROM order_details
 GROUP BY order_id
 ORDER BY item_count DESC;
 
 -- 13. How many orders had more than 12 items?
 SELECT COUNT(*) FROM
 (SELECT DISTINCT order_id AS order_count, COUNT(item_id) AS counts FROM order_details
 GROUP BY order_count
 HAVING counts > 12) as order_table;
 
 -- 14. Combine the menu_items and order_details into a single table
 SELECT * FROM order_details as o
 Left JOIN menu_items as m
 ON o.item_id = m.menu_item_id;
 
-- 15. What are the most least and most ordered items? What category are they in?
-- Least item
SELECT item_name, category, COUNT(order_details_id) as num_purchases
FROM order_details od
LEFT JOIN menu_iteems mi 
ON od.item_id = mi.item_id
GROUP BY item_name, category
ORDER BY num_purchases;

-- Most item

SELECT item_name, category, COUNT(order_details_id) as num_purchases
FROM order_details od
LEFT JOIN menu_items mi 
ON od.item_id = mi.item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;

-- 16. What were the Top 5 orders that spent the most money?
SELECT order_id, SUM(price) as Total_price FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.item_id
GROUP BY order_id
ORDER BY Total_price DESC
LIMIT 5;

-- 17. View the details of the highest spend order.
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category;

-- 18. View the details of the top 5 highest spend orders.
 SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
 

