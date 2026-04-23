SELECT
    city,
    date_trunc('week', date) AS week_start,
    SUM(precipitation) AS weekly_precipitation,
    MD5(
        city || '|' || TO_CHAR(date_trunc('week', date))
    ) AS snapshot_id
FROM {{ ref("weather_data_lab1") }}
WHERE city IN ('San Jose', 'Lake Tahoe')
GROUP BY 
    city,
    date_trunc('week', date)
ORDER BY
    week_start