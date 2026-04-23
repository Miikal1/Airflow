{% snapshot snapshot_average_temps %}
{{
config(
target_schema='snapshot',
unique_key='city',
strategy='check',
check_cols=['average_max_temp', 'average_min_temp'],
)
}}
SELECT * FROM {{ ref('average_temps') }}
{% endsnapshot %}