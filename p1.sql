
-- create
-- Create Departments table
CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Create Roles table
CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

-- Create Employees table
CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES Departments(department_id),
    role_id INT REFERENCES Roles(role_id),
    hire_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Create Attendance table
CREATE TABLE Attendance (
    attendance_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES Employees(employee_id),
    attendance_date DATE NOT NULL,
    check_in_time TIMESTAMP,
    check_out_time TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Present'
);


-- Departments
INSERT INTO Departments (department_name) VALUES
('HR'), ('Finance'), ('IT'), ('Marketing'), ('Operations');

-- Roles
INSERT INTO Roles (role_name) VALUES
('Manager'), ('Executive'), ('Analyst'), ('Technician'), ('Support');

-- Employees (extend this with loops or scripts)
INSERT INTO Employees (name, department_id, role_id, hire_date) VALUES
('John Doe', 1, 1, '2020-01-10'),
('Jane Smith', 2, 2, '2019-03-25'),
('Robert Brown', 3, 3, '2021-07-15'),
('Emily Davis', 4, 4, '2022-11-05'),
('Michael Wilson', 5, 5, '2018-09-17');

-- Attendance records (extend for multiple dates and employees)
INSERT INTO Attendance (employee_id, attendance_date, check_in_time, check_out_time, status) VALUES
(1, '2025-09-01', '2025-09-01 09:05:00', '2025-09-01 17:00:00', 'Present'),
(1, '2025-09-02', '2025-09-02 09:15:00', '2025-09-02 17:10:00', 'Late'),
(2, '2025-09-01', '2025-09-01 09:00:00', '2025-09-01 17:00:00', 'Present'),
(3, '2025-09-01', '2025-09-01 09:20:00', '2025-09-01 16:45:00', 'Late');


SELECT e.employee_id, e.name, COUNT(a.attendance_id) AS total_days_present
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 9
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.employee_id, e.name
ORDER BY total_days_present DESC;

SELECT e.employee_id, e.name, a.attendance_date, a.check_in_time
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 9
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
  AND a.status = 'Late'
ORDER BY a.attendance_date;

-- Create function to update status based on check-in time
CREATE OR REPLACE FUNCTION set_attendance_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.check_in_time IS NOT NULL THEN
        IF EXTRACT(HOUR FROM NEW.check_in_time) >= 9 AND EXTRACT(MINUTE FROM NEW.check_in_time) > 0 THEN
            NEW.status := 'Late';
        ELSE
            NEW.status := 'Present';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to invoke the function
CREATE TRIGGER trg_set_attendance_status
BEFORE INSERT OR UPDATE ON Attendance
FOR EACH ROW
EXECUTE FUNCTION set_attendance_status();


CREATE OR REPLACE FUNCTION calculate_work_hours(emp_id INT, att_date DATE)
RETURNS INTERVAL AS $$
DECLARE
    work_duration INTERVAL;
BEGIN
    SELECT (check_out_time - check_in_time)
    INTO work_duration
    FROM Attendance
    WHERE employee_id = emp_id AND attendance_date = att_date;

    RETURN work_duration;
END;
$$ LANGUAGE plpgsql;


SELECT employee_id, attendance_date, calculate_work_hours(employee_id, attendance_date) AS work_hours
FROM Attendance
WHERE attendance_date = '2025-09-01';


SELECT e.employee_id, e.name, COUNT(a.attendance_id) AS late_count
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Late'
  AND EXTRACT(MONTH FROM a.attendance_date) = 9
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.employee_id, e.name
HAVING COUNT(a.attendance_id) > 3;


SELECT e.employee_id, e.name, SUM(a.check_out_time - a.check_in_time) AS total_work_hours
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 9
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.employee_id, e.name
ORDER BY total_work_hours DESC;




