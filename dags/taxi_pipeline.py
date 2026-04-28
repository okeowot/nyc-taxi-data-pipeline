from datetime import datetime
from airflow import DAG
from cosmos import DbtTaskGroup, ProjectConfig, ProfileConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_default",
        profile_args={"database": "NYC_TAXI", "schema": "STAGING"},
    )
)

with DAG(
    dag_id="nyc_taxi_dbt_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule="@daily",
    catchup=False,
) as dag:

    transform_data = DbtTaskGroup(
        group_id="transform_data",
        project_config=ProjectConfig("/usr/local/airflow/dags/taxi_transforms"),
        profile_config=profile_config
    )

    transform_data