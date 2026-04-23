{% snapshot snapshot_weather_weekly_precipitation %}
{{
config(
target_schema='snapshot',
unique_key='snapshot_id',
strategy='check',
check_cols=['weekly_precipitation'],
)
}}
SELECT * FROM {{ ref('weather_weekly_precipitation') }}
{% endsnapshot %}