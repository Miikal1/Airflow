{% snapshot snapshot_percent_rainy_days_monthly %}
{{
config(
target_schema='snapshot',
unique_key='snapshot_id',
strategy='check',
check_cols=['rainy_days', 'pct_rainy_days'],
)
}}
SELECT * FROM {{ ref('percent_rainy_days_monthly') }}
{% endsnapshot %}