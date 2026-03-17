# 🚀 Snowflake CI/CD Data Pipeline with AWS S3 and GitHub Actions

## 📌 Overview

This project demonstrates an end-to-end modern data pipeline using:

- AWS S3 for data ingestion
- Snowflake as the data warehouse
- GitHub Actions for CI/CD automation

The pipeline follows a Medallion Architecture (Bronze Layer) and implements automated deployment workflows.

---

## 🏗️ Architecture

AWS S3 → Snowflake External Stage → COPY INTO → Bronze Layer → Procedures → Tasks → CI/CD

---

## ⚙️ Tech Stack

- AWS S3
- Snowflake
- GitHub Actions
- SnowSQL
- SQL

---

## 📂 Repository Structure

sql/
├── DDL/bronze/bronze_customers.sql
├── file_format/parquet_format.sql
├── procedures/
├── tasks/
└── STAGE_PUBLIC_PRA_BRONZE.sql

---

## 🔧 Implementation Steps

### Create File Format

CREATE OR REPLACE FILE FORMAT PARQUET_FORMAT
TYPE = PARQUET
COMPRESSION = AUTO;

---

### Create Bronze Table

CREATE TABLE IF NOT EXISTS bronze_customers (
    raw VARIANT,
    filename STRING,
    created_at TIMESTAMP
);

---

### Load Data

COPY INTO bronze_customers
FROM(
   SELECT
       METADATA$FILENAME,
       $1,
       CURRENT_TIMESTAMP 
    FROM @north/cust
    (FILE_FORMAT => PARQUET_FORMAT)
);

---

## 🔐 Snowflake Info

SELECT CURRENT_ACCOUNT();
SELECT CURRENT_USER();
SELECT CURRENT_WAREHOUSE();
SELECT SYSTEM$ALLOWLIST();

---

## 🔁 CI/CD

Secrets:

- SNOWSQL_ACCOUNT
- SNOWSQL_USER
- SNOWSQL_PWD

---

## 🚀 Deploy Example

snowsql -a <account.region> -u <user> -d POC -w COMPUTE_WH -s DEV -f sql/DDL/bronze/bronze_customers.sql

---

## 👨‍💻 Author

Igor Conceição
