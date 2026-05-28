# 📡 Telecom Customer Churn Analysis

An end-to-end data analytics project analyzing telecom customer churn using **Python**, **SQL**, and **Tableau** — covering data cleaning, exploratory analysis, and interactive dashboard visualization.

---

## 📌 Project Overview

Customer churn is one of the biggest challenges in the telecom industry. This project identifies **why customers leave**, **which segments are at highest risk**, and **how much revenue is being lost** — providing actionable insights to support data-driven retention strategies.

**Overall Churn Rate: 50.84% | Revenue Lost: $3,684,459.82 (35.34% of total revenue)**

---

## 🎯 Business Questions Answered

1. What is the overall customer churn rate?
2. Which contract type has the highest churn rate?
3. Which internet type has the highest churn rate?
4. How does satisfaction score affect churn?
5. Which age group churns the most?
6. What are the top churn reasons and categories?
7. How much revenue was lost due to churn — and which categories drove it?
8. Which customer segments carry the highest churn risk and revenue loss?
9. Which high-CLTV churned customers should be targeted for win-back?

---

## 🗂️ Repository Structure

```
telco-customer-churn-analysis/
│
├── data/
│   ├── raw_telco.csv                    # Original raw dataset
│   └── cleaned_telco_churn.csv          # Cleaned dataset used for analysis
│
├── notebooks/
│   └── data_cleaning.ipynb              # Python data cleaning notebook
│
├── sql/
│   └── churn_analysis.sql               # Full SQL analysis with insights & recommendations
│
├── tableau/
│   └── telco_churn_dashboard.twb        # Tableau workbook (2 dashboards)
│
├── images/
│   ├── Churn_Analysis.png               # Churn Analysis Dashboard screenshot
│   └── Revenue_Impact_of_Customer_Churn.png  # Revenue KPI Dashboard screenshot
│
├── README.md
├── requirements.txt
└── LICENSE
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas) | Data cleaning & preprocessing |
| MySQL | Exploratory data analysis & KPI queries |
| Tableau | Interactive dashboard visualization |

---

## 📊 Dashboards

### 1. Churn Analysis Dashboard
Covers churn KPIs, churn rate by contract type, internet type, age group, satisfaction score, top churn categories, and top churn reasons.

![Churn Analysis Dashboard](images/Churn_Analysis.png)

### 2. Revenue KPI Dashboard
Covers total revenue, revenue loss, revenue loss % by payment method, revenue loss by churn category and reason, top 10 high-CLTV churned customers, and high-risk customer segments.

![Revenue KPI Dashboard](images/Revenue_Impact_of_Customer_Churn.png)

---

## 📂 Dataset

- **Source:** Telecom customer dataset cleaned for analysis (3,676 customers, 44 features)
- **Key columns:** `customer_id`, `contract`, `internet_type`, `satisfaction_score`, `churn_category`, `churn_reason`, `total_revenue`, `cltv`, `customer_status`, `age_group`

---

## 🔍 Key Findings

| # | Insight |
|---|---------|
| 1 | **50.84% churn rate** — 1,869 out of 3,676 customers churned |
| 2 | **Month-to-Month contracts** have the highest churn rate at **74.52%** vs 6.28% for Two Year |
| 3 | **Fiber Optic** customers churn the most by internet type at **60.71%** |
| 4 | Customers with satisfaction scores of **1 and 2** have a **100% churn rate** |
| 5 | **Middle-age** customers have the highest churn rate at **55.65%** |
| 6 | **Competitor-related reasons** are the top churn drivers (better devices, better offers) |
| 7 | **Competitor category** caused the highest revenue loss at **$1,694,413.15** |
| 8 | **Bank Withdrawal** customers have the highest churn rate by payment method at **57.14%** |
| 9 | Highest-risk segment: **Month-to-Month Fiber Optic with satisfaction score 1 or 2** (100% churn) |
| 10 | **$3,684,459.82** in revenue lost — **35.34%** of total revenue |

---

## 💡 Business Recommendations

1. **Incentivize contract upgrades** — Offer discounts and loyalty benefits to move Month-to-Month customers to annual or two-year contracts.
2. **Proactively target low-satisfaction customers** — Customers scoring 1 or 2 churn at 100%; intervene with priority support and service recovery before they leave.
3. **Improve Fiber Optic experience** — Review pricing, speed reliability, and support quality for this high-churn segment.
4. **Respond to competitor threats** — Benchmark competitor device offers and pricing; improve promotional strategies to retain at-risk customers.
5. **Simplify payment methods** — Reduce friction for Bank Withdrawal and Mailed Check users; promote auto-pay or credit card options.
6. **Prioritize high-risk segments** — Month-to-Month Fiber Optic customers with low satisfaction scores represent the highest combined churn rate and revenue risk.
7. **Build a win-back strategy** — Target high-CLTV churned customers with personalized re-engagement offers.

---

## ▶️ How to Run

### Python (Data Cleaning)
```bash
# Install dependencies
pip install -r requirements.txt

# Launch notebook
jupyter notebook notebooks/data_cleaning.ipynb
```

### SQL (Analysis)
```sql
-- Import cleaned_telco_churn.csv into your MySQL database, then run:
SOURCE sql/churn_analysis.sql;
```

### Tableau (Dashboard)
Open `tableau/telco_churn_dashboard.twb` in **Tableau Desktop** (version 2022.1 or later recommended).
Connect to `data/cleaned_telco_churn.csv` if prompted for a data source.

---

## 👤 Author

**Aditya Pandey**
📧 [adityapandey12391@gmail.com](mailto:adityapandey12391@gmail.com)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
