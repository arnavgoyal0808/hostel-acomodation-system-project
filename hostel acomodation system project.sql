-- Create the hostel database if it does not exist
CREATE DATABASE IF NOT EXISTS hostel;

-- Use the hostel database
USE hostel;

-- Create the hostels table if it does not exist
CREATE TABLE IF NOT EXISTS hostels (
    hostel_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT
);

-- Create the room_types table if it does not exist
CREATE TABLE IF NOT EXISTS room_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    rate DECIMAL(10, 2) NOT NULL
);

-- Create the rooms table if it does not exist
CREATE TABLE IF NOT EXISTS rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_id INT NOT NULL,
    type_id INT NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id),
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

-- Create the students table if it does not exist
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    hostel_id INT NOT NULL,
    room_id INT NOT NULL,  -- Assuming room_id is a foreign key referencing rooms(room_id)
    FOREIGN KEY (hostel_id) REFERENCES hostel(hostel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Create the mess table if it does not exist
CREATE TABLE IF NOT EXISTS mess (
    mess_name VARCHAR(100),
    hostel_id INT NOT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id)
);

-- Insert data into hostels table
INSERT INTO hostels (hostel_name, location, description)
VALUES
('Aurobindo Hostel', 'Mnnit Jaipur', 'Boys hostel'),
('Gargi Hostel', 'Mnit Jaipur', 'Girls hostel');

-- Insert data into room_types table
INSERT INTO room_types (type_name, capacity, rate) VALUES 
('Single', 1, 32000),
('Double', 2, 32000);

-- Insert data into rooms table
INSERT INTO rooms (hostel_id, type_id, room_number) VALUES 
(1, 1, '101'),
(1, 1, '102'),
(2, 2, '201'),
(2, 1, '202');

-- Insert data into mess table
INSERT INTO mess (mess_name, hostel_id, capacity) VALUES 
('Aurobindo Mess', 1, 250),
('Gargi Mess', 2, 120);

-- Insert data into students table (example)
-- Adjust the room_id based on your rooms table structure
INSERT INTO students (student_id,student_name, hostel_id, room_id) VALUES
(1120 ,'Arnav', 1, 1),-- Assuming room_id 1 exists in rooms table
(1483,'ashish' , 1  , 1),
(1322,'sahil' , 1 , 1),
(1768 ,'jyoti' ,2 ,2),
(1417, 'priya' , 2 , 1);


-- Verify data insertion
SELECT * FROM hostels;
SELECT * FROM room_types;
SELECT * FROM rooms;
SELECT * FROM mess;
SELECT * from students;


SELECT h.hostel_name, r.room_number, rt.type_name
FROM hostels h
JOIN rooms r ON h.hostel_id = r.hostel_id
JOIN room_types rt ON r.type_id = rt.type_id;
-- students belongs to aurobindo hostel--

SELECT s.student_id, s.student_name, h.hostel_name
FROM students s
JOIN hostels h ON s.hostel_id = h.hostel_id
WHERE h.hostel_name = 'Aurobindo Hostel';
-- select students by there rooms
SELECT s.student_id, s.student_name, h.hostel_name, r.room_number
FROM students s
JOIN hostels h ON s.hostel_id = h.hostel_id
LEFT JOIN rooms r ON s.room_id = r.room_id;
-- fetch all mess details correspond to its hostel
SELECT m.mess_name, m.capacity, h.hostel_name
FROM mess m
JOIN hostels h ON m.hostelm_id = h.hostel_id;
-- fetch hsotels with average room rates
SELECT h.hostel_name, AVG(rt.rate) AS average_room_rate
FROM hostels h
JOIN rooms r ON h.hostel_id = r.hostelss_id
JOIN room_types rt ON r.type_id = rt.type_id
GROUP BY h.hostel_name;

SELECT h.hostel_name, rt.type_name, rt.capacity, rt.rate
FROM hostels h
JOIN rooms r ON h.hostel_id = r.hostelss_id
JOIN room_types rt ON r.type_id = rt.type_id;

-- total mess charges and total capaciy of a particular sem
SELECT SUM(m.capacity) AS total_capacity, SUM(m.capacity * 180) AS total_monthly_charge
FROM mess m;



