# Coffee Sales & Profitability Analytics

## Project Overview

This project analyses coffee sales, product profitability and customer behaviour using an end-to-end data analytics workflow.

The project follows a practical analytics pipeline:

**Raw Excel → Python/Pandas → SQL Server → Business Analysis → Power BI**

The objective was not only to build dashboards, but to understand the data structure, identify data-quality issues, model the data correctly and answer business questions using SQL and Power BI.

---

## Business Objectives

The analysis focuses on:

- Measuring overall sales, profit and units sold
- Understanding sales and profitability by coffee type
- Comparing roast types and product sizes
- Analysing sales performance by country
- Understanding sales and customer behaviour over time
- Comparing loyalty-card and non-loyalty customers
- Identifying products and categories with stronger profitability

---

## Dataset

The original dataset contained:

- 1,000 order-line records
- 1,000 customer records
- 48 products
- 957 distinct orders
- 913 distinct customers
- Order dates from January 2019 to August 2022

The original source data contained customer-related information. Public versions of the datasets have therefore been created with personal fields removed.

---

## Data Cleaning & Preparation

Python and Pandas were used to:

- Inspect the raw Excel workbook
- Identify missing and inconsistent values
- Validate customer and product relationships
- Remove unnecessary fields
- Merge customer and product information into the order data
- Create derived sales and profit calculations
- Create date-related fields
- Export cleaned datasets for downstream analysis

### Important Data Discovery

A key finding during data preparation was that `order_id` was **not unique**.

The orders table contains multiple rows for some orders because each row represents an **order line**, rather than one complete order.

Therefore:

- `order_line_id` was created as the primary key
- `order_id` represents the business order
- Order counts use `DISTINCT order_id`

This distinction was important for calculating metrics such as order count and Average Order Value correctly.

---

## Data Model

The SQL Server model consists of three main tables:

```text
customers
    │
    │ 1-to-many
    ▼
orders
    ▲
    │ many-to-one
    │
products