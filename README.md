# Optimizing Revenue & Operational Efficiency: Data-Driven Performance Analysis for Sedukopi
## End-to-End Business Analysis using PostgreSQL &amp; Microsoft Excel

**Sedukopi Operations & Sales Performance Analysis** is an end-to-end data analytics project analyzing sales and operational performance across **20 coffee shop outlets** in multiple cities.

The project uses **PostgreSQL** for data querying, aggregation, and analysis, while **Microsoft Excel** is used for exploratory analysis, visualization, and business reporting.

The analysis focuses on five key business areas:

- 🏪 Outlet revenue performance
- ☕ Best-selling products by category
- ⏰ Peak-hour transaction patterns
- 🛍️ Order type & channel performance
- 📊 Menu revenue contribution using Pareto Analysis

The objective is to transform transactional data into **actionable business insights** that can support operational planning, inventory management, product strategy, and channel optimization.

---

## 📊 Executive Summary

| Business Area | Key Finding |
|---|---|
| **Outlet Performance** | **Sedukopi - Senopati (OUT003)** generated the highest revenue at **Rp25.53M** among 18 active outlets. |
| **Product Performance** | **Coffee** was the largest category by sales volume, contributing **36.18% (3,695 units)**. |
| **Peak Hours** | Transactions followed a **three-wave pattern**: morning, lunch, and evening peaks. |
| **Order Channels** | **Dine-In** recorded the highest peak volume, reaching **315 orders at 13:00**. |
| **Menu Contribution** | **48 of 70 menus (68.57%)** generated approximately **80.35% of total menu revenue**. |

---

## 🎯 Business Objectives

This project was designed to answer practical business questions around:

1. Which outlets generate the highest and lowest revenue?
2. Which menu items are the best sellers within each category?
3. When are Sedukopi's busiest transaction periods?
4. How do customer ordering patterns differ across `dine_in`, `takeaway`, and `delivery`?
5. Which menu items contribute the most to total revenue?
6. How concentrated is revenue across the menu portfolio?

---

# 🔎 Business Cases & Analysis

## 1. Outlet Revenue Performance

### Business Question

> Which Sedukopi outlets generate the highest revenue, and which outlets are underperforming?

### Analytical Approach

- Joined outlet and transaction data.
- Aggregated `total_amount` by outlet.
- Filtered out temporarily closed outlets.
- Ranked active outlets based on total revenue.

### Key Finding

**Sedukopi - Senopati (OUT003)** ranked #1 with revenue of:

**Rp25.53M**

Meanwhile, **Sedukopi - Margonda (OUT020)** ranked last among the 18 active outlets with:

**Rp15.99M**

Two outlets, **OUT015** and **OUT018**, were temporarily closed and had no transactions, so they were excluded from the active-outlet ranking.

### Business Implication

The performance gap between high- and low-performing outlets provides an opportunity to investigate differences in:

- Customer demand
- Location performance
- Product mix
- Local marketing activity
- Operational execution

<p align="center">
<img width="543" height="315" alt="Outlet chart" src="https://github.com/user-attachments/assets/f1787fd1-2dff-484b-bea6-3e72be99373e" />
</p>


---

## 2. Best-Selling Menu by Category

### Business Question

> Which menu items sell the most within each product category?

### Analytical Approach

- Aggregated `quantity` from order details.
- Grouped products by category.
- Ranked products within each category.
- Compared total unit contribution across categories.

### Key Finding

**Coffee** was the largest category by sales volume:

**3,695 units — 36.18% of total units sold**

| Category | Best-Selling Product | Units Sold |
|---|---|---:|
| Coffee | Matcha Espresso Fusion | 180 |
| Makanan | Croissant Butter | 176 |
| Non-Coffee | Strawberry Smoothie | 174 |
| Snack | Cheese Cake Slice | 177 |

Total recorded sales volume reached **10,214 units**.

### Business Implication

High-volume products can receive higher priority for:

- Inventory availability
- Product promotion
- Stock planning
- Operational preparation

---

## 3. Peak Hour Analysis

### Business Question

> When are Sedukopi's busiest transaction periods?

### Analytical Approach

- Extracted the hour from transaction time.
- Grouped transactions by hour.
- Analyzed transaction patterns across the network.
- Identified peak and off-peak periods.

### Key Finding

Sedukopi transactions followed a **three-wave peak pattern**:

| Period | Time | Pattern |
|---|---|---|
| Morning | 07:00–08:00 | Morning Peak |
| Lunch | 12:00–13:00 | Highest Peak |
| Evening | 17:00–19:00 | Evening Peak |

Off-peak periods were observed around:

- 09:00–11:00
- 14:00–16:00

<p align="center">
<img width="543" height="315"  alt="peak hours chart" src="https://github.com/user-attachments/assets/72ebc40c-8e11-470a-b5a8-b1fc543e56ea" />
</p>


### Business Implication

The identified peak periods can be used to optimize workforce scheduling.

For example:

- Increase staffing during peak hours.
- Schedule restocking during off-peak periods.
- Allocate preparation resources based on expected transaction volume.

---

## 4. Order Type & Channel Analysis

### Business Question

> How do customer ordering patterns differ between `dine_in`, `takeaway`, and `delivery`?

### Analytical Approach

- Calculated AOV by order type.
- Compared transaction volume across channels.
- Analyzed peak hours for each order type.

### Key Finding

Each order channel showed a different peak pattern:

| Order Type | Peak Period | Highest Observed Volume |
|---|---|---:|
| **Dine-In** | 12:00–13:00 & 17:00–19:00 | **315 orders/hour** |
| **Takeaway** | 07:00–08:00, 12:00–13:00, 17:00–19:00 | **181 orders/hour** |
| **Delivery** | 07:00, 12:00, 18:00 | **120 orders/hour** |

**Dine-In** recorded the highest observed hourly volume at **13:00 with 315 orders**.

**Takeaway** peaked at **07:00 with 181 orders**.

### Business Implication

Operational resources can be allocated differently by channel.

For example, additional packaging and order-processing capacity can be prepared during periods when Takeaway and Delivery demand increases.

---

# 📊 5. Menu Revenue Contribution — Pareto Analysis

### Business Question

> Is Sedukopi's revenue concentrated in a small number of menu items?

### Analytical Approach

For each menu item:

1. Calculate total revenue.
2. Calculate individual revenue contribution.
3. Rank menus by revenue.
4. Calculate cumulative revenue percentage.
5. Identify the group contributing approximately 80% of revenue.

### Key Finding

| Pareto Group | Number of Menus | % of Menus | Revenue | Revenue Contribution |
|---|---:|---:|---:|---:|
| **Top 80% Revenue** | 48 | 68.57% | Rp315.86M | **80.35%** |
| **Bottom 20% Revenue** | 22 | 31.43% | Rp77.22M | **19.65%** |
| **Total** | 70 | 100% | Rp393.08M | 100% |

The analysis shows that **48 of 70 menus (68.57%)** were required to generate approximately **80% of total menu revenue**.

Therefore, the revenue distribution does **not** follow a highly concentrated traditional 80/20 pattern.

### Business Implication

The result suggests that revenue is relatively distributed across the menu portfolio.

This can support further evaluation of:

- Inventory priorities
- Product profitability
- Menu complexity
- Promotional focus
- Menu rationalization

---

# 💡 Key Business Insights

### 1. Outlet performance varies significantly

Senopati generated the highest revenue among active outlets, while Margonda recorded the lowest.

This performance gap provides an opportunity to investigate differences in customer demand, location, product mix, and operational performance.

### 2. Coffee is the largest sales-volume category

Coffee contributed **36.18% of total units sold**, making it the largest category by volume.

### 3. Transactions follow predictable peak periods

Transaction activity follows a **three-wave pattern** around morning, lunch, and evening periods.

This creates opportunities for more efficient workforce and resource planning.

### 4. Ordering channels behave differently

Dine-In, Takeaway, and Delivery show different peak-hour patterns.

Therefore, staffing and operational capacity can be adjusted according to channel demand.

### 5. Revenue is relatively distributed across the menu

The Pareto analysis shows that **68.57% of the menu portfolio is required to generate approximately 80% of revenue**, indicating that revenue is not concentrated in only a small number of products.

---

# 🚀 Business Recommendations

## 1. Investigate Low-Performing Outlets

Conduct further analysis on lower-performing outlets such as **Margonda** and **Setia Budi Medan**.

Potential areas of investigation:

- Customer traffic
- Local demand
- Product mix
- Operating hours
- Local marketing activity

---

## 2. Prioritize High-Volume Products

Maintain sufficient inventory and preparation capacity for high-volume products such as:

- Matcha Espresso Fusion
- Croissant Butter
- Strawberry Smoothie
- Cheese Cake Slice

This is particularly important during peak transaction periods.

---

## 3. Optimize Workforce Scheduling

Use the identified peak periods to implement staggered staffing:

- **07:00–09:00**
- **12:00–14:00**
- **17:00–20:00**

Off-peak periods can be used for:

- Restocking
- Food preparation
- Cleaning
- Staff breaks
- Operational preparation

---

## 4. Optimize Channel Operations

Increase packaging and order-processing capacity during periods with high Takeaway and Delivery demand, particularly during the morning peak.

---

## 5. Evaluate the Long Tail of the Menu

Use the Pareto analysis as a starting point to review lower-contributing menu items.

Further analysis can determine whether selected products should be:

- Retained
- Promoted
- Repositioned
- Bundled
- Eventually rationalized

---

# 🛠️ Tools & Technical Skills

### PostgreSQL

- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `SUM()`
- `AVG()`
- `COUNT()`
- `CASE WHEN`
- `EXTRACT()`
- Window Functions
- CTE

### Microsoft Excel

- PivotTable
- PivotChart
- Data visualization

---

# 🔄 Analytical Workflow

```text
Business Questions
        ↓
Data Understanding
        ↓
Data Preparation
        ↓
SQL Query & Aggregation
        ↓
Exploratory Analysis
        ↓
Excel Visualization
        ↓
Business Insights
        ↓
Actionable Recommendations




