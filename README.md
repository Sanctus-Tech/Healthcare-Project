# **US Medicare Part D Drug Spending Analysis**  

## **Introduction**  
This project analyzes **US Medicare Part D drug spending data** (2018-2022) to understand trends in pharmaceutical costs, beneficiary usage, and drug pricing. The goal is to identify high-cost medications, measure year-over-year spending growth, and evaluate cost efficiency per beneficiary.  

## **Background**  
Medicare Part D is a federal program that provides prescription drug coverage to Medicare beneficiaries. Rising drug costs have been a major concern, prompting analysis of spending patterns, volume trends, and cost-per-patient metrics. This project explores:  
- **Total spending** by drug  
- **Dosage volume** (prescription claims)  
- **Cost per beneficiary**  
- **Year-over-year trends** in drug pricing  

## **Tools Used**  
- **SQL** (PostgreSQL/MySQL) – Data aggregation and analysis  
- **Excel** – Data cleaning and preprocessing  
- **Power BI** – Interactive dashboards and visualizations  

## **Analysis**  
### **1. Total Spending by Drug**  
Identified the highest-cost medications and their spending trends over five years.  
```sql
SELECT 
    brnd_name,
    gnrc_name,
    SUM(tot_spndng_2018 + tot_spndng_2019 + tot_spndng_2020 + tot_spndng_2021 + tot_spndng_2022) AS total_spending
FROM medicare_drug_spending
GROUP BY brnd_name, gnrc_name
ORDER BY total_spending DESC;
```
**Key Insight:** Specialty drugs (e.g., Eliquis, Revlimid) dominated spending.  

### **2. Total Prescription Volume**  
Analyzed which drugs had the highest prescription counts.  
```sql
SELECT 
    brnd_name,
    gnrc_name,
    SUM(tot_dsg_unts_2018 + tot_dsg_unts_2019 + tot_dsg_unts_2020 + tot_dsg_unts_2021 + tot_dsg_unts_2022) AS total_volume
FROM medicare_drug_spending
GROUP BY brnd_name, gnrc_name
ORDER BY total_volume DESC;
```
**Key Insight:** Common chronic medications (e.g., insulin, blood pressure drugs) had the highest volume.  

### **3. Cost per Beneficiary**  
Calculated the average spending per patient for each drug.  
```sql
SELECT
    brnd_name,
    gnrc_name,
    ROUND(SUM(tot_spndng_2022) / NULLIF(SUM(tot_benes_2022), 0), 2) AS cost_per_bene_2022
FROM medicare_drug_spending
GROUP BY brnd_name, gnrc_name
ORDER BY cost_per_bene_2022 DESC;
```
**Key Insight:** Specialty and cancer drugs had the highest per-patient costs.  

### **4. Year-over-Year Drug Trend**  
Measured spending growth rates for each medication.  
```sql
WITH yearly_spending AS (
    SELECT
        brnd_name,
        gnrc_name,
        SUM(tot_spndng_2021) AS spending_2021,
        SUM(tot_spndng_2022) AS spending_2022
    FROM medicare_drug_spending
    GROUP BY brnd_name, gnrc_name
)
SELECT
    brnd_name,
    gnrc_name,
    spending_2021,
    spending_2022,
    ROUND((spending_2022 - spending_2021) / NULLIF(spending_2021, 0) * 100, 2) AS yoy_growth
FROM yearly_spending
ORDER BY yoy_growth DESC;
```
**Key Insight:** Newer drugs (e.g., weight-loss medications) showed the highest growth rates.  

## **What I Learned**  
- **High-cost drugs** (e.g., specialty, oncology) drive most Medicare Part D spending.  
- **Volume vs. Cost:** Some drugs have high prescription counts but lower costs, while others are low-volume but extremely expensive.  
- **Trends:** Drug prices are increasing, especially for newer treatments.  

## **Conclusions**  
1. **Cost Control Needed:** Medicare should explore price negotiations for high-cost drugs.  
2. **Focus on Chronic Medications:** High-volume drugs (e.g., diabetes meds) need cost-effective alternatives.  
3. **Monitor Growth Trends:** New specialty drugs are rapidly increasing in price.  

## **Bonus: Data Processing & Visualization**  
- **Excel:** Used for cleaning (removing duplicates, fixing missing values).  
- **Power BI:** Created interactive dashboards showing spending trends, top drugs, and cost-per-beneficiary comparisons.  

### **Dashboard Insights**  
- **Top 10 Drugs by Spending** (Bar chart)  
- **Yearly Trend Analysis** (Line graph)  
- **Cost per Beneficiary Heatmap** (Highlighting expensive drugs)  

---
This analysis helps policymakers and healthcare stakeholders understand Medicare Part D spending patterns and identify cost-saving opportunities. 🚀
