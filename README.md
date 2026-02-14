# 📊 Sales Performance Analysis

![SQL](https://img.shields.io/badge/SQL-MSSQL-blue)
![Analysis](https://img.shields.io/badge/Type-Data%20Analysis-orange)
![Status](https://img.shields.io/badge/Status-Complete-success)

## 🎯 Project Overview

This project analyzes sales transaction data from a bike retail business spanning 2011-2014. The analysis focuses on customer segmentation, product performance, and operational efficiency to identify revenue drivers and potential business risks.

---

## 📈 Key Metrics

| Metric | Value |
|--------|-------|
| **Sales Transactions** | 60,379 |
| **Unique Customers** | 18,482 |
| **Products Analyzed** | 130 |
| **Time Period** | 2011-2014 (3+ years) |
| **Invalid Records Excluded** | 19 |

---

## 🔍 Key Findings

### 💡 Customer Concentration Risk
> **Top 10% of customers generated 40% of total revenue**

This indicates significant dependency on a small customer base, presenting both an opportunity (focus on high-value retention) and a risk (vulnerability to customer churn).

### 🚴 Product Category Dominance
> **Bikes category contributed 96% of revenue** with an average order value of **$1,061**

Strong product-market fit but highlights potential over-reliance on a single category, suggesting need for product diversification.

### 📦 Operational Excellence
> **7-day average shipping time** with **100% on-time delivery rate**

Demonstrates efficient logistics operations and strong fulfillment capabilities.

---

## 🛠️ Technical Approach

### SQL Techniques Used:

- **Multi-table Joins**: Connected fact and dimension tables (`fact_sales`, `dim_customers`, `dim_products`)
- **Common Table Expressions (CTEs)**: Structured complex queries for customer revenue aggregation
- **Window Functions**: Used `RANK` and `PERCENT_RANK` for customer segmentation analysis
- **Aggregations**: `SUM`, `AVG`, `COUNT` with `GROUP BY` for performance metrics
- **Data Quality Handling**: Excluded 19 invalid records with missing order dates to ensure analysis accuracy

---

## 📊 Database Schema

### Tables:

**`fact_sales`** - Transaction-level data
- `order_number`, `product_key`, `customer_key`
- `order_date`, `shipping_date`, `due_date`
- `sales_amount`, `quantity`, `price`

**`dim_customers`** - Customer demographics
- `customer_key`, `customer_id`, `customer_number`
- `first_name`, `last_name`, `country`
- `gender`, `birthdate`, `marital_status`

**`dim_products`** - Product hierarchy
- `product_key`, `product_id`, `product_name`
- `category`, `subcategory`, `product_line`
- `cost`, `maintenance`, `start_date`

---

## 💼 Business Recommendations

Based on the analysis, the following strategic actions are recommended:

1. **Customer Retention Program**  
   Implement targeted retention strategies for top 10% high-value customers to protect 40% of revenue

2. **Customer Acquisition Strategy**  
   Diversify customer base to reduce concentration risk and dependency on small customer segment

3. **Product Diversification**  
   Expand beyond Bikes category to reduce 96% revenue dependency on single product line

4. **Leverage Operational Strength**  
   Maintain and market 100% on-time delivery as competitive advantage in customer acquisition

---

## 📁 Project Structure

```
sales-performance-analysis/
│
├── queries/
│   ├── data_quality_check.sql
│   ├── customer_segmentation.sql
│   ├── product_performance.sql
│   └── shipping_analysis.sql
│
├── results/
│   └── analysis_findings.md
│
└── README.md
```

---

## 🚀 How to Use

1. Clone this repository
2. Import the SQL queries from the `queries/` folder into Microsoft SQL Server
3. Execute queries sequentially to reproduce the analysis
4. Review findings in `results/analysis_findings.md`

---

## 🎓 Skills Demonstrated

- ✅ Advanced SQL querying and optimization
- ✅ Customer segmentation and cohort analysis
- ✅ Product performance analysis
- ✅ Operational metrics evaluation
- ✅ Data quality assessment and handling
- ✅ Business insight generation from raw data
- ✅ Strategic thinking and recommendation development

---

## 📧 Contact

For questions or collaboration opportunities, feel free to reach out!

- 🔗 LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)
- 📧 Email: your.email@example.com

---

⭐ **If you found this project useful, please consider giving it a star!**




---
---



# 🚲 Bike Sales Supply Chain Analytics (EDA & ADA using SQL)

## 📌 Project Overview
SQL-based analytics project built using **T-SQL (MS SQL Server)** to analyze bike sales and supply chain performance.  
The project converts raw transactional data into **dashboard-ready analytical views** for fast insight generation and business decision-making.

---

## 🏢 Business Context
- **Domain:** 🚲 Bike Sales & Supply Chain Analytics  
- **Primary Consumers:** 📊 Dashboards, business users, analysts  
- **Objective:** Enable quick performance monitoring and insight discovery without additional data transformation

---

## 🗂 Dataset Summary
- Company-like mock dataset
- ~**60,000** sales records
- Data period: **late 2010 – early 2014**
- Star schema model:
  - `fact_sales`
  - `dim_products`
  - `dim_customers`

---

## 🔍 Analysis Coverage

### Exploratory Data Analysis (EDA)
- Time-based sales and revenue trends
- Category and product contribution
- Order volume and quantity distribution
- Customer purchasing patterns

### Advanced Data Analysis (ADA)
- Product and customer-level aggregations
- Revenue-based performance segmentation
- Product lifecycle and recency analysis
- KPI calculation for reporting and dashboards

---

## 📊 Demo Business Metrics (Sample Insights)

> ⚠️ *Figures shown below are representative demo values for illustration.  
Actual values will be updated based on final outputs.*

### 🔹 Overall Sales Performance
- Sales records analyzed: **~60,000**
- Total revenue generated: **~₹29.36 Million**
- Average Order Revenue (AOR): **~₹1,061**
- Average Monthly Revenue (AMR): **~₹XX,XXX**

---

### 🔹 Product Performance
- Products analyzed: **~XXX**
- High-performing products contribution: **~XX% of total revenue**
- Mid-performing products contribution: **~XX% of sales volume**
- Low-performing products: **consistent but lower revenue impact**

---

### 🔹 Product Lifecycle Metrics
- Product lifespan range: **~X – ~XX months**
- Long-lifecycle products: **higher AMR**
- Early-stage products: **faster initial revenue growth**

---

### 🔹 Recency Metrics
- Products sold in last 12 months: **~XX%**
- Recently sold products: **higher AOR**
- Dormant products: **declining monthly revenue trend**

---

### 🔹 Customer Metrics (Customer-Level View)
- Unique customers: **~18,484**
- Revenue from repeat customers: **avgerage ~1000**
  
---

## 🧱 Reporting Layer (Final Output)

Two reusable analytical views were created:

### 🧾 Product-Level View
- Revenue, quantity, and order metrics
- Product segmentation (High / Mid / Low)
- Product lifespan and recency KPIs

### 👥 Customer-Level View
- Customer order frequency and value
- Recency indicators
- Supports retention and behavioral analysis

These views act as a **semantic layer** and can be directly connected to **Power BI / Tableau**.

---

## 🛠 SQL & Analytics Techniques Used
- CTE-based transformations
- Multi-level aggregations
- Date intelligence using `DATEDIFF`
- Safe KPI calculations using `NULLIF`
- Reusable analytical view design

---

## 🎯 Why This Project
- Demonstrates SQL-only end-to-end analytics
- Focuses on metrics businesses actually track
- Built with dashboard and reporting consumption in mind
- Mirrors real-world analytics workflows

---

## 💻 Tools & Technologies
- MS SQL Server (T-SQL)
- Relational Data Modeling
- Analytical SQL Design

---

## 📝 Notes
- Dataset is a **company-like mock dataset**
