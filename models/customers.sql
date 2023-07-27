WITH customers AS (

    SELECT
        customers.id AS customer_id,
        customers.first_name,
        customers.last_name

    FROM raw.jaffle_shop.customers

),

orders AS (

    SELECT
        orders.id AS order_id,
        orders.user_id AS customer_id,
        orders.order_date,
        orders.status

    FROM raw.jaffle_shop.orders

),

customer_orders AS (

    SELECT
        orders.customer_id,
        min(orders.order_date) AS first_order_date,
        max(orders.order_date) AS most_recent_order_date,
        count(orders.order_id) AS number_of_orders
    FROM orders

    GROUP BY 1

),

final AS (

    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) AS number_of_orders

    FROM customers

    LEFT OUTER JOIN customer_orders ON customers.customer_id = customer_orders.customer_id

)

SELECT * FROM final
