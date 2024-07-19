<h1 align="center" id="title">TimeZY</h1>

<p align="center"><img src="https://socialify.git.ci/Absolute-oreZ/TimeZY/image?language=1&amp;logo=https%3A%2F%2Fi.postimg.cc%2F43wscZ9K%2Flogo.png&amp;name=1&amp;owner=1&amp;pattern=Charlie%20Brown&amp;stargazers=1&amp;theme=Light" alt="project-image"></p>

<p id="description">"Stay on top of tasks and boost productivity effortlessly with TimeZY - your ultimate solution for streamlined employee task tracking and seamless deadline management."</p>

<h2>Project Screenshots:</h2>

<img src="https://i.postimg.cc/y6h437C7/Login-Page.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/0N7ZX2fQ/Admin-Dashboard.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/zBj75t4Y/User-List.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/PJ54qbkp/Register-New-User.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/d142g7Tq/Attendance-List.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/zfNTBwCz/Location-List.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/V6LM9YZ2/Register-New-Location.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/ZqJyZbm0/Tasks-List.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/bdXs58Ly/Register-Task.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/FK8zz3kW/My-Attendance-Post-Login.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/WzQ4GyMB/Profile.png" alt="project-screenshot" width="1920" height="400/">

<img src="https://i.postimg.cc/yYZx1VKs/Edit-Profile.png" alt="project-screenshot" width="1920" height="400/">

  
  
<h2>🧐 Features</h2>

Here're some of the project's best features:

*   Attendance Logging
*   Employee Management
*   Real Time Task Monitoring
*   Admin Dashboard
*   Task Assignment

<h2>🛠️ Installation Steps:</h2>

Follow these steps to set up the project locally on your machine.

<strong>Prerequisites</strong>

Make sure you have the following installed on your machine:

*   Java Development Kit (JDK)
*   Maven
*   MySQL Server
*   Preferred MySQL Server Client
*   Git

<p>1. Set up a local database by using a MySQL client with following queries:</p>

```
-- Create the database if not exists
-- DROP DATABASE IF EXISTS TIMEZY;
CREATE DATABASE IF NOT EXISTS timezy;
USE timezy;

-- Users table
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(225) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('CLEANER', 'MANAGER', 'ADMIN') NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email_user (email)
);

-- Attendances table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    cleaner_id INT,
    login_time DATETIME,
    logout_time DATETIME,
    attendance_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('PRESENT', 'ABSENT', 'LATE') NOT NULL DEFAULT 'ABSENT',
    reason TEXT,
    notes TEXT,
    FOREIGN KEY (cleaner_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_cleaner_id_attendance (cleaner_id),
    INDEX idx_attendance_date (attendance_date),
    INDEX idx_status (status)
);

-- Locations table
CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(50) NOT NULL,
    building_name VARCHAR(100),
    floor_number INT
);

-- Tasks table 
CREATE TABLE Task (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    task_name VARCHAR(225) NOT NULL,
    task_description TEXT,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    status ENUM('CREATED', 'IN_PROGRESS', 'OVERDUE','COMPLETED') NOT NULL DEFAULT 'CREATED',
    task_priority ENUM('LOW', 'MEDIUM', 'HIGH') NOT NULL DEFAULT 'MEDIUM',
    task_deadline DATETIME,
    task_category ENUM('GENERAL_CLEANING','SANITIZATION','MAINTENANCE','WASTE_MANAGEMENT','SPECIAL_CLEANING','SUPPLY_RESTOCK') NOT NULL DEFAULT 'GENERAL_CLEANING',
    cleaner_id INT,
    manager_id INT,
    location_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    completed_at DATETIME,
    FOREIGN KEY (cleaner_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_cleaner_id_task (cleaner_id),
    INDEX idx_manager_id_task (manager_id),
    INDEX idx_location_id_task (location_id)
);

-- Create the event to update task status every minute
DELIMITER //
CREATE EVENT update_task_status
ON SCHEDULE EVERY 1 MINUTE
DO
    UPDATE Task
    SET status = 'OVERDUE', updated_at = CURRENT_TIMESTAMP
    WHERE CURRENT_TIMESTAMP > task_deadline AND is_completed = FALSE;
//
DELIMITER ;

-- Create an event to check and update attendance status
DELIMITER //
CREATE EVENT update_attendance_status
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    -- Update status to 'LATE' if current time > 9 AM and status is not 'PRESENT'
    UPDATE Attendance
    SET status = 'LATE'
    WHERE CURRENT_TIME() > '09:00:00'
      AND status != 'PRESENT'
      AND attendance_date = CURRENT_DATE();

    -- Update status to 'ABSENT' if current time > 5 PM and status is not 'PRESENT'
    UPDATE Attendance
    SET status = 'ABSENT'
    WHERE CURRENT_TIME() > '17:00:00'
      AND status != 'PRESENT'
      AND attendance_date = CURRENT_DATE();
END;
//
DELIMITER ;

-- Create an event to insert new attendance records daily for all users
DELIMITER //
CREATE EVENT insert_new_attendance
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_DATE() + INTERVAL 1 DAY
DO
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id_val INT;
    DECLARE cur CURSOR FOR SELECT user_id FROM User;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO user_id_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO Attendance (cleaner_id, attendance_date)
        VALUES (user_id_val, CURRENT_DATE());

    END LOOP;
    CLOSE cur;
END;
//
DELIMITER ;

-- Enable Event Scheduler
SET GLOBAL event_scheduler = ON;

-- Sample data insertion
INSERT INTO User (name, email, password, role, phone) VALUES
('John Doe', 'john.doe@example.com', 'password123', 'ADMIN', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', 'password456', 'MANAGER', '987-654-3210'),
('Michael Johnson', 'michael.johnson@example.com', 'password789', 'CLEANER', '555-123-4567'),
('Emily Brown', 'emily.brown@example.com', 'passwordabc', 'CLEANER', '111-222-3333'),
('David Lee', 'david.lee@example.com', 'passwordxyz', 'MANAGER', '999-888-7777');

INSERT INTO Attendance (cleaner_id, login_time, logout_time, status, attendance_date, reason, notes) VALUES
(3, '2024-07-18 08:17:00', '2024-06-30 16:00:00', 'LATE', '2024-07-19', 'Started slightly late due to traffic', 'Call Manager David'),
(4, '2024-07-18 08:00:00', '2024-06-30 16:30:00', 'PRESENT', '2024-07-19', NULL, 'Regular work day'),
(4, NULL, NULL, 'ABSENT', '2024-07-20', 'Annual Leave', 'Approved'),
(3, NULL, NULL, 'ABSENT', '2024-07-20', NULL, NULL);

INSERT INTO Location (location_name, building_name, floor_number) VALUES
('Head Office', 'Central Building', 10),
('Branch A', 'West Building', 5),
('Branch B', 'East Building', 3),
('Warehouse', 'South Building', 1),
('Retail Store', 'North Building', 2);

INSERT INTO Task (task_name, task_description, is_completed, status, task_priority, task_deadline, task_category, cleaner_id, manager_id, location_id) VALUES
('Clean floors', 'Daily cleaning of all floors', FALSE, 'IN_PROGRESS', 'HIGH', '2024-07-20 08:00:00', 'GENERAL_CLEANING', 3, 2, 1),
('Sanitize washrooms', 'Weekly deep cleaning of washrooms', FALSE, 'CREATED', 'MEDIUM', '2024-07-20 12:00:00', 'SANITIZATION', 4, 5, 2),
('Fix plumbing issue', 'Repair leak in restroom', FALSE, 'CREATED', 'HIGH', '2024-07-20 10:00:00', 'MAINTENANCE', 3, 2, 3),
('Dispose of waste', 'Daily disposal of waste bins', TRUE, 'COMPLETED', 'LOW', '2024-06-30 18:00:00', 'WASTE_MANAGEMENT', 4, 5, 4),
('Restock supplies', 'Weekly restocking of cleaning supplies', FALSE, 'OVERDUE', 'MEDIUM', '2024-07-03 16:00:00', 'SUPPLY_RESTOCK', 3, 2, 5);
```

<p>2. Clone the project</p>

```
git clone https://github.com/Absolute-oreZ/TimeZY.git
```

<p>3. Navigate to the Project Directory</p>

```
cd timezy
```

<p>4. Build and run your Spring Boot application using Maven</p>

```
mvn clean package
mvn spring-boot:run
```

<p>5. Open in Your Browser</p>

```
http://localhost:8080
```

  
  
<h2>💻 Built with</h2>

Technologies used in the project:

*   Docker<div style="display: inline-flex; margin-left: 5px; vertical-align: middle;"><img src="https://techstack-generator.vercel.app/docker-icon.svg" alt="icon" width="30" height="30" /></div>
*   Java <div style="display: inline-flex; margin-left: 5px; vertical-align: middle;"><img src="https://techstack-generator.vercel.app/java-icon.svg" alt="icon" width="30" height="30" /></div>
*   MySQL <div style="display: inline-flex; margin-left: 5px; vertical-align: middle;"><img src="https://techstack-generator.vercel.app/mysql-icon.svg" alt="icon" width="30" height="30" /></div>
*   GitHub<div style="display: inline-flex; margin-left: 5px; vertical-align: middle;"><img src="https://techstack-generator.vercel.app/github-icon.svg" alt="icon" width="30" height="30" /></div>
*   REST API <div style="display: inline-flex; margin-left: 5px; vertical-align: middle;"><img src="https://techstack-generator.vercel.app/restapi-icon.svg" alt="icon" width="30" height="30" /></div>
*   Tailwind CSS <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 54 33" width="30" height="30" style="display: inline-flex;margin-left: 5px; vertical-align: middle;">
    <path fill="#38bdf8" fill-rule="evenodd" d="M27 0c-7.2 0-11.7 3.6-13.5 10.8 2.7-3.6 5.85-4.95 9.45-4.05 2.054.513 3.522 2.004 5.147 3.653C30.744 13.09 33.808 16.2 40.5 16.2c7.2 0 11.7-3.6 13.5-10.8-2.7 3.6-5.85 4.95-9.45 4.05-2.054-.513-3.522-2.004-5.147-3.653C36.756 3.11 33.692 0 27 0zM13.5 16.2C6.3 16.2 1.8 19.8 0 27c2.7-3.6 5.85-4.95 9.45-4.05 2.054.514 3.522 2.004 5.147 3.653C17.244 29.29 20.308 32.4 27 32.4c7.2 0 11.7-3.6 13.5-10.8-2.7 3.6-5.85 4.95-9.45 4.05-2.054-.513-3.522-2.004-5.147-3.653C23.256 19.31 20.192 16.2 13.5 16.2z" clip-rule="evenodd"/>
</svg>

<h2>🛡️ License:</h2>

Distributed under the no License.

<h2> 🤝 Contact </h2>
Email: yongchunhao2003@gmail.com

LinkedIn: www.linkedin.com/in/yongch03

Project Link: https://github.com/Absolute-oreZ/TimeZY