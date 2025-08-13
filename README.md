# **SQL Digital Marketing Campaign Analysis**

## **Overview**

This project analyzes a **February 2021 digital marketing dataset** to evaluate campaign performance across different categories, weeks, and KPIs.
Using **Microsoft SQL Server (v21)**, I applied **data transformation, aggregation, and ranking functions** to extract actionable insights such as top-performing campaigns, category winners, and ROI calculations.

The aim was to **blend my SQL expertise** with newly acquired digital marketing knowledge, demonstrating adaptability and cross-domain problem-solving.

---

## **Objectives**

* Explore campaign, category, and weekly performance.
* Calculate key marketing metrics (**CTR, CPC, CPL, CPQL, ROI**).
* Identify **top campaigns** based on revenue, conversions, and ROI.
* Generate **week-by-week** and **category-level** performance reports.

---

## **Dataset**

* **Source:** Practice marketing dataset (1 table).
* **Period:** February 2021 (1 month).
* **Fields:** Campaign details, spend, impressions, clicks, leads, orders, revenue, category, and dates.

---

## **Key SQL Operations**

### **1. Data Exploration**

* Checked available date range and campaign categories.
* Counted campaigns per category.
* Found highest and lowest spending campaigns.

### **2. Data Transformation**

* Added computed columns: **CTR, CPC, CPL, CPQL**.
* Created **week\_number** column to group campaigns into 4 weekly buckets.

### **3. Aggregated Performance Metrics**

* **By Campaign** – Spend, impressions, clicks, leads, orders, revenue, and KPIs.
* **By Category** – Total spend, performance metrics, and rankings.
* **By Week & Category** – Weekly KPIs and spend breakdowns.

### **4. Ranking & Insights**

* Best campaign by **week** (highest revenue).
* Best campaign by **category** (highest conversion rate).
* Overall top campaign for the month.
* Weekly category winners.

### **5. ROI Calculation**

* Formula:

  ```
  ROI (%) = (Revenue - Marketing Spend) / Marketing Spend * 100
  ```
* Ranked campaigns by ROI to identify the most cost-effective.

---

## **Example Insights**

* **Category Leaders:** Certain categories consistently outperformed others in weekly ROI.
* **CTR & CPC Trends:** Some high-CTR campaigns had low ROI due to high CPC.
* **Revenue Peaks:** Weeks 2 and 3 showed significant revenue spikes in specific categories.

---

## **Tech Stack**

* **Database:** Microsoft SQL Server 2021
* **SQL Techniques:** Joins, Aggregations, CASE statements, GROUP BY, Ranking functions, Window functions, Data formatting.

---

## **Why This Project Stands Out**

* Demonstrates **cross-domain adaptability** (applied SQL analytics to marketing).
* Highlights **practical business KPIs** used in digital marketing.
* Includes **clean, optimized SQL queries** for real-world reporting scenarios.

