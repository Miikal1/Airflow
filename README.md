Overview
This project implements an end-to-end data analytics pipeline for weather data using modern data engineering tools:

Apache Airflow for orchestration (ETL + scheduling)
Snowflake for data storage and processing
dbt (Data Build Tool) for transformations (ELT)
BI Tool (Tableau / Superset / Preset) for visualization
The pipeline ingests weather data from an external API, transforms it into analytics-ready tables, and enables visualization of insights such as precipitation trends and rainy-day patterns.

Pipeline Components
1. ETL (Airflow)
Extracts weather data from Open-Meteo API
Transforms JSON responses into tabular format
Loads data into Snowflake (RAW.weather_data_lab1)
Scheduled and managed via Airflow DAGs
2. ELT (dbt)
dbt transforms raw data into structured models:

Transform Layer
  - weather_data_lab1.sql
    -Cleans and standardizes raw data
Analytics Layer
  -average_temps
    -Calculates the average maximum and minimum temperatures of both city
  -percent_rainy_days_monthly
    -Calculates rainy days and percentage per month
  -weather_code_distribution
    -finds te distribution of weather code across both cities
  -weather_weekly_precipitation
    -Aggregates precipitation weekly by city
Snapshot
  -snapshot_average_temps
  - snapshot_percent_rainy_days_monthly
  - snapshot_weather_code_distribution
  - snapshot_weather_weekly_precipitation
Tracks historical changes in weather records (optional)
3. Visualization
A BI tool is used to build dashboards based on dbt models.

Example insights:

Weekly precipitation trends
Monthly percentage of rainy days
City comparisons (San Jose vs South Lake Tahoe)

Project Structure
.
├── dags/
│   └── build_elt_with_dbt.py        # Airflow DAG to run dbt
│
├── dbt/
│   ├── dbt_project.yml
│   ├── profiles.yml
│   ├── models/
│   │   ├── source.yml
│   │   ├── schema.yml
│   │   ├── transform/
│   │   │   └── weather_data_lab1.sql
│   │   └── analytics/
│   │       ├── average_temps.sql
│   │       ├── percent_rainy_days_monthly.sql
│   │       ├── weather_code_distribution.sql
│   │       └── weather_weekly_precipitation.sql
│   └── snapshots/
│       ├── snapshot_average_temps.sql
│       ├── snapshot_percent_rainy_days_monthly.sql
│       ├── snapshot_weather_code_distribution.sql
│       └── snapshot_weather_weekly_precipitation.sql
│
├── docker-compose-mlflow.yaml       # Airflow + dbt environment
└── README.md

Setup Instructions
1. Start Airflow Environment
docker-compose -f docker-compose-mlflow.yaml up
This starts:

Airflow scheduler
Airflow webserver
PostgreSQL backend
dbt-enabled Airflow container
2. Configure Airflow Connection
In Airflow UI:

Create connection: snowflake_conn
Required fields:
Account
User
Password
Database
Schema
Warehouse
Role
This connection is used by the dbt DAG.

3. Verify dbt Setup
Inside the Airflow container:

dbt debug --profiles-dir /opt/airflow/dbt --project-dir /opt/airflow/dbt

Running the Pipeline
Option 1: Run via Airflow UI
Open Airflow Web UI
Find DAG: BuildELT_dbt
Trigger DAG manually
The DAG executes:

dbt run
dbt test
dbt snapshot

