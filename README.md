# nyc-taxi-data-pipeline

# 🚕 NYC Taxi Modern Data Pipeline (ELT)

An end-to-end ELT (Extract, Load, Transform) data pipeline orchestrating the processing of NYC TLC Taxi data using a cloud-native Modern Data Stack. 

This flagship project demonstrates production-grade data engineering practices, including containerized orchestration, modular data modeling, and cloud data warehousing.

## 🏗️ Architecture & Technologies

* **Cloud Data Warehouse:** Snowflake
* **Data Transformation:** dbt (Data Build Tool) Core
* **Orchestration:** Apache Airflow
* **Integration Layer:** Astronomer Cosmos
* **Containerization:** Docker & Astro CLI
* **Source Data:** NYC TLC Yellow Taxi Dataset (Parquet)

## 💡 Engineering Highlights (The "Why")

Rather than writing isolated scripts, this project is built on enterprise data engineering principles:

1. **ELT Methodology:** Data is extracted and loaded directly into Snowflake in its raw format. Transformation is handled inside the warehouse leveraging Snowflake's compute engine, reducing transit bottlenecks.
2. **Modular dbt Architecture:** The transformation layer is strictly split into `staging` (data cleansing and type casting) and `marts` (business logic and aggregations) to adhere to DRY principles.
3. **Granular DAG Orchestration via Cosmos:** Instead of running dbt as a single black-box `dbt run` bash command, this pipeline uses Astronomer Cosmos to parse the `dbt_project.yml` and render every single SQL model as a native Airflow task. This provides pinpoint failure tracking and true dependency management.
4. **Environment Reproducibility:** The entire orchestration layer runs inside an isolated Docker container, eliminating "it works on my machine" dependencies.

## 🗺️ Pipeline Orchestration & Lineage

The pipeline is orchestrated locally using Apache Airflow. By leveraging Cosmos, Airflow understands the exact lineage of the dbt models, ensuring that the final `fct_monthly_revenue` table is never built if the upstream `stg_yellow_trips` model fails.

![Airflow DAG Execution]
<img width="711" height="283" alt="image" src="https://github.com/user-attachments/assets/83bf7031-8ebe-497d-808e-4c98da81e21c" />


## 📂 Project Structure

```text
├── dags/
│   ├── taxi_pipeline.py         # Airflow DAG definition using Cosmos
│   └── taxi_transforms/         # The entire dbt project
│       ├── dbt_project.yml      # dbt routing and configuration
│       ├── models/
│       │   ├── staging/         # Base views: Cleansed names & parsed timestamps
│       │   └── marts/           # Gold tables: Aggregated revenue & trip metrics
├── Dockerfile                   # Custom Docker image adding dbt to Airflow
├── requirements.txt             # Python dependencies (cosmos, snowflake provider)
└── README.md
