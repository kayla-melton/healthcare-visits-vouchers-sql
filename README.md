# 🏥 Healthcare SQL Project — Patient Visits, Costs & Voucher Analysis

A full SQL-based analytics project exploring **patient visits**, **clinic performance**, **voucher usage**, and **medical condition trends** using a fully normalized database schema.

---

## 🏷️ Badges  
![SQL](https://img.shields.io/badge/SQL-MySQL8-blue?logo=mysql)
![Database Design](https://img.shields.io/badge/Database-Design-success)
![ERD](https://img.shields.io/badge/ERD-Entity%20Modeling-purple)
![Analytics](https://img.shields.io/badge/Data-Analysis-orange)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Controlled-black?logo=github)

---

## 📚 Project Overview

This SQL project analyzes clinic visits, patient demographics, medical conditions, and voucher activity.  
The goal is to uncover:

- Which clinics are the most expensive  
- Which patients visit most frequently  
- Condition trends  
- Voucher expiration risk  
- Unpaid balances  
- Cost differences by clinic type  

The project includes:

- **Fully normalized SQL schema**  
- **ERD (Entity Relationship Diagram)**  
- **Analytical SQL queries**  
- **Business insights & recommendations**

---

## 📁 Project Structure  

Healthcare_SQL_Project/  
│  
├─ sql/  
│  ├─ schema.sql              ← Full database structure (DDL)  
│  ├─ analysis_queries.sql    ← All analytical queries (DML)  
│  └─ erd.png                 ← ERD diagram (exported from MySQL Workbench)  
│  
└─ README.md                  ← You’re reading this file  

---

## 🧬 Entity Relationship Diagram (ERD)

[ERD Diagram](sql/erd.png)

### 📌 ERD Summary  


PATIENTS (1) ──< (M) VISIT (1) ──< (M) VISIT_CONDITION  
  └─ (M) MEDICAL_CONDITION  
  └─ (M) VOUCHER  

CLINIC (1) ──< (M) VISIT

---

### **Key relationships explained:**

- **One patient** can have **many visits**  
- **One clinic** can have **many visits**  
- **One visit** can have **many medical conditions** (M:M join table)  
- **One patient** can have **multiple vouchers**  
- **Each voucher** belongs to **one patient** and **one visit**

---

## 📜 Schema & Queries

### 📌 Database Schema (DDL)

You can view the complete schema here:

👉 [/sql/schema.sql]([/sql/analysis_queries.sql]
)

This includes:

- Table definitions  
- Keys & constraints  
- Foreign key relationships  
- Indexes  

---

### 📌 Analytical SQL Queries (DML)

All questions + queries are stored here:

👉 [/sql/analysis_queries.sql](/sql/analysis_queries.sql
)

## 📊 Analytical Questions Answered

### 1️⃣ Revenue: *Which clinic types generate the most money?*  
Includes average bill, total revenue, and volume.

### 2️⃣ Patients: *Who visits the most?*  
Counts visits per patient with demographic details.

### 3️⃣ Conditions: *What are the most common medical issues?*

### 4️⃣ Billing: *Where are unpaid balances the highest?*

### 5️⃣ Vouchers: *Which vouchers expire within 30 days?*

### 6️⃣ Demographics: *Visit trends by age band × gender*

---

## 🚀 How to Run This Project

### 1️⃣ Import the schema

In MySQL Workbench:

File → Open SQL Script → **sql/schema.sql** → Run

---

### 2️⃣ Import data (CSV files)

Use:

Table Data Import Wizard → Select your CSV file → Import → Finish

---

### 3️⃣ Run the analysis queries

File → Open SQL Script → **sql/analysis_queries.sql** → Run

The output includes tables, rankings, counts, and aggregated insights.

--- 

## ⭐ Skills Demonstrated

### **SQL (Advanced)**  
- Multi-table JOINs  
- Aggregate functions (SUM, COUNT, AVG)  
- CASE logic for grouping  
- LEFT/INNER JOIN mastery  
- GROUP BY + ORDER BY  
- DISTINCT + GROUP_CONCAT  
- Filtering & subqueries  
- DDL: CREATE TABLE, keys, constraints  
- Index creation  

### **Database Design**  
- Fully normalized schema  
- Primary/foreign keys  
- Many-to-many bridge table (visit_condition)  
- ER modeling  
- Referential integrity  

### **MySQL Workbench Expertise**  
- Building schemas  
- Importing data  
- Generating ERDs  
- Running scripts  
  
---

## 📬 Contact

If you'd like to discuss this project or collaborate:

**Kayla Melton**  
📧 Email: kaylamelton22@icloud.com  
💼 LinkedIn: https://www.linkedin.com/in/jakayla-melton-001a782bb/  
🗂️ GitHub: https://github.com/kayla-melton  

---

## ⭐ If this project helped you…  
Please consider giving the repo a **star**! ⭐
