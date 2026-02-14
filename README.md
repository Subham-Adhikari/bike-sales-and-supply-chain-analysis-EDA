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

## 📧 Contact

For questions or collaboration opportunities, feel free to reach out!

- 🔗 LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)
- 📧 Email: your.email@example.com

---

⭐ **If you found this project useful, please consider giving it a star!**
