SELECT city, weather_code, count(weather_code) AS total_occurances,
	MD5(
        city || '|' || weather_code
    ) AS snapshot_id
FROM {{ ref("weather_data_lab1") }}
GROUP BY city, weather_code
ORDER BY weather_code