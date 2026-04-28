SELECT
    DATE_TRUNC('month', pickup_datetime) AS revenue_month,
    pickup_location_id,
    SUM(total_amount) AS total_revenue,
    SUM(tip_amount) AS total_tips,
    COUNT(*) AS total_trips
FROM {{ ref('stg_yellow_trips') }}
GROUP BY 1, 2