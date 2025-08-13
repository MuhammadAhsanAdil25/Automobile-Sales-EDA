# Automobile Sales Data Analysis (SQL)

## Overview
This project performs **Exploratory Data Analysis (EDA)** on an automobile sales dataset sourced from **Kaggle**.  
The goal is to uncover key business insights such as sales trends, top customers, best-selling products, order efficiency, and profitability analysis.

## Dataset
- **Source:** Kaggle (Automobile Sales Dataset)
- **Table Name:** `auto_sales_details`
- **Key Columns:**
  - `ORDERDATE` – Date of the order
  - `SALES` – Total sales amount
  - `STATUS` – Order status (e.g., Shipped, Cancelled)
  - `COUNTRY`, `CITY` – Customer location
  - `CUSTOMERNAME` – Customer name
  - `PRODUCTLINE`, `PRODUCTCODE` – Product details
  - `QUANTITYORDERED`, `PRICEEACH`, `MSRP` – Product pricing and quantity
  - `DEALSIZE` – Deal category

##  Analysis Performed
- **Sales Trends**
  - Monthly and yearly sales performance
  - Sales breakdown by country and city
- **Customer Analysis**
  - Most frequent customers by order count and revenue
- **Product Insights**
  - Most in-demand products and product lines
  - Profitability analysis (Price vs MSRP)
- **Order Efficiency**
  - Percentage of completed vs incomplete orders
  - Sales lost due to cancellations or disputes
- **Pricing Analysis**
  - Average price and total sales per deal size

## Tools & Technologies
- **Language:** SQL
- **Database:** Microsoft SQL Server
- **Concepts Used:** 
  - `GROUP BY`, `ORDER BY`, `WHERE`
  - Aggregate functions (`SUM`, `AVG`, `COUNT`)
  - Window functions (`ROW_NUMBER`, `OVER PARTITION`)
  - Common Table Expressions (CTEs)
  - Conditional filtering

## Key Insights
- Identified **top-performing months** and regions for sales.
- Determined **most loyal customers** and their contribution to revenue.
- Highlighted **best-selling products** and **high-profit product lines**.
- Measured **order fulfillment efficiency** and calculated **lost sales** due to disputes/cancellations.

