# 🚀 RunBook_Snowflake_EventBridge_Streaming

## 📌 Overview
Hybrid event-driven and scheduled data pipeline using AWS and Snowflake.

## 🏗️ Architecture
API → Lambda → S3 → SNS → Snowpipe → Snowflake  
EventBridge → Lambda (fallback)

## ⚙️ Key Features
- Event-driven ingestion
- Streaming via Snowpipe
- Scheduled fallback with EventBridge
- Secure integration via Storage Integration (IAM)

## 🔐 Security
- No hardcoded credentials
- IAM Role + External ID
- Storage Integration

## 📂 Repository
https://github.com/igorconceicao/snowflake-igor-penarruda.git

## 🚀 Execution Flow
1. Lambda consumes API
2. Stores JSON in S3
3. SNS triggers Snowpipe
4. Snowflake ingests into Bronze
5. Dynamic Tables process data
6. EventBridge ensures reliability

## 🎯 Business Value
- Scalable pipeline
- Low latency ingestion
- Reduced operational overhead
- Production-ready architecture

## 👨‍💻 Author
Igor Conceição
