#  Hospitality Analytics Project
## Overview 
The objective of this project is to analyze hospitality industry data and uncover meaningful business insights.
Using Excel, Power BI, Tableau, and MySQL on the same dataset, the project demonstrates how different tools can be applied for:

1 Data cleaning & preparation
2 KPI calculation (Revenue, ADR, RevPAR, Occupancy, Cancellation %)
3 Visualization & interactive dashboards
4 Comparative performance analysis across cities, room classes, and booking platforms

##  Excel Analysis
- Performed **data cleaning and transformation** using Power Query  
- Built a **data model** for structured analysis  
- Created **pivot tables** to summarize bookings, cancellations, and occupancy  
- Designed charts to visualize key trends  
- Developed an **Excel dashboard with slicers** for interactive filtering  

 File: ((https://github.com/laybaismail12345/Hospitality-Project/blob/main/Hospitality_Analytics_Dashboard2.csv))

 Screenshot:((https://github.com/laybaismail12345/Hospitality-Project/blob/main/Screenshot%20Excel.png))


##  Power BI Dashboard
- Designed an **interactive dashboard** to analyze hospitality performance  
- Key KPIs: **Revenue, Occupancy Rate, Cancellation %**  
- Added **filters (City & Room Type)** for drill-down analysis  
- Visualized **weekly performance trends** for better business tracking  

 [Download Power BI File (.pbix)](https://github.com/laybaismail12345/Hospitality-Project/blob/main/Hospitality_Analatics_Dashboard%20power%20bi.pbix)  

 Dashboard Preview:  
![Power BI Dashboard](https://github.com/laybaismail12345/Hospitality-Project/blob/main/Screenshot%202025-09-05%20121607.png)


##  Tableau Dashboard
- Built a **visual story** highlighting hospitality KPIs  
- Analyzed **city-wise revenue distribution**  
- Compared **room-class contributions** to overall revenue  
- Visualized **weekly trends** for occupancy and cancellations  

 Download Tableau File  https://github.com/laybaismail12345/Hospitality-Project/blob/main/Tableau%20Hospitality%20Analytics%20Dashboard.twbx

 Dashboard Preview:  https://github.com/laybaismail12345/Hospitality-Project/blob/main/Screenshot%20Tableau.png


##  MySQL Analysis
- Wrote SQL queries to calculate **Revenue, Occupancy %, Cancellation status**  
- Performed **aggregations and joins** for insights by city and room type
- Create functions to format large numbers in B (Billions) or M (Millions)
- Extracted cancellation patterns and platform performance  
- Created a dataset to support dashboard building in BI tools  

 https://github.com/laybaismail12345/Hospitality-Project/blob/main/MySQL%20Hospitality%20Analytics%20Project.sql 

 Query Example:  
```sql
 select format_num(sum(revenue_generated)) as Total_Revenue from fact_bookings; 
