
# Employee Management and Attendance Tracker

## 📋 Project Overview
This project is a **PostgreSQL-based database system** designed to manage employee information and track attendance efficiently. It provides functionalities such as recording attendance, calculating work hours, generating monthly reports, and monitoring late arrivals.

The system is built using **PostgreSQL** and managed through **pgAdmin**.

---

## ✅ Features
- ✅ Store employee details, departments, roles, and attendance records
- ✅ Insert bulk dummy data for testing (200+ records)
- ✅ Track attendance with timestamps and status updates (Present/Late)
- ✅ Calculate total work hours per employee
- ✅ Generate attendance reports with aggregation and filtering
- ✅ Use triggers to automate status determination based on check-in time
- ✅ Implement functions to compute attendance metrics

---

## 📂 Database Schema
1. **Departments** – Stores department information  
2. **Roles** – Stores job roles  
3. **Employees** – Stores employee details  
4. **Attendance** – Stores attendance data including check-in/check-out times and status

---

## ⚙ Tools Used
- **PostgreSQL** – Database management system
- **pgAdmin** – Interface for managing the database
- **PL/pgSQL** – Procedural language for triggers and functions

---

## 🚀 Setup Instructions

### 1. Install PostgreSQL and pgAdmin
- Download and install PostgreSQL from [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
- Install pgAdmin from [https://www.pgadmin.org/download/](https://www.pgadmin.org/download/)

### 2. Create the database
```sql
CREATE DATABASE employee_management;

## ✅ Run the SQL Scripts

## 1. Create Tables
Execute the scripts in `schema.sql` to create the following tables:
- **Departments** – Holds department details
- **Roles** – Stores job roles information
- **Employees** – Maintains employee records
- **Attendance** – Logs attendance entries with check-in/check-out times and status

### 2. Insert Dummy Data
Run the `dummy_data.sql` file to populate the tables with sample data. The dataset includes:
- 200+ employee records
- Department and role references
- Attendance logs across multiple dates for realistic testing

### 3. Create Functions and Triggers
Use the scripts in `functions.sql` and `triggers.sql` to add:
- **Functions**: For calculating total work hours based on check-in/check-out times
- **Triggers**: To automatically determine attendance status (Present/Late) based on the check-in time

### 4. Execute Queries for Reports
Run the `reports.sql` file or paste the queries directly into your SQL interface to generate reports such as:
- Monthly attendance summaries
- Lists of late arrivals
- Work hour calculations using aggregation functions

---

## 📂 View Reports

After running the scripts, you can query the database to view:
- Attendance summaries by month and employee
- Employees with repeated late arrivals
- Total work hours per employee
- Data insights using `GROUP BY` and `HAVING` clauses

These reports will help in evaluating employee attendance patterns and productivity.

---

## 📜 Key SQL Components

### ✅ Tables
The database includes four primary tables:
- **Employees** – Stores employee details like name, department, and role
- **Departments** – Lists all departments in the organization
- **Roles** – Holds role-related information
- **Attendance** – Logs attendance data with timestamps and status updates

### ✅ Triggers
Triggers automatically update attendance status based on the employee’s check-in time. If an employee checks in after the designated time, the status is marked as "Late."

### ✅ Functions
Functions are used to calculate the total work hours for each employee based on their check-in and check-out times. This helps in generating accurate attendance and productivity reports.

### ✅ Reports
The system provides ready-to-use queries for:
- Monthly attendance tracking
- Identifying late arrivals
- Highlighting employees with frequent lateness
- Aggregating total work hours to assess overall attendance behavior

---



