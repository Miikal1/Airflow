{% snapshot snapshot_weather_code_distribution %}
{{
config(
target_schema='snapshot',
unique_key='snapshot_id',
strategy='check',
check_cols=['total_occurances'],
)
}}
SELECT * FROM {{ ref('weather_code_distribution') }}
{% endsnapshot %}

