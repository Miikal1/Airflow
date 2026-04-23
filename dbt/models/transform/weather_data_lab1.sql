SELECT latitude, longitude, date, city, temp_max, temp_min, precipitation, weather_code, ts
FROM {{ source('raw', 'weather_data_lab1') }}
