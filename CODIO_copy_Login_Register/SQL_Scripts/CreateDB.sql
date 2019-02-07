## file name    : CreateDB.sql
## Created by   : Nick Skripnikov
## Date created : 31/01/2019
## Purpose      :- 
## Notes        :-
## last updated : 01/02/2019 by: Nick Skripnikov
## last updated : 07/02/2019 by: Mike Wright
## Change Log   :- Added course level into the ‘course’ table.

DROP DATABASE IF EXISTS bursary_database;
CREATE DATABASE bursary_database; /*Creating the database*/
USE bursary_database;

# userType can be only be one of the following (staff, student, admin).
# Creating user table that holds user information.*/
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    userID INTEGER NOT NULL UNIQUE,
    userFirstName VARCHAR(15) NOT NULL,
    userLastName VARCHAR(25) NOT NULL,
    userPassword VARCHAR(255) DEFAULT NULL,
    userEmail VARCHAR(255) NOT NULL,
    userType ENUM('Staff', 'Student', 'Admin') NOT NULL,
    userActive TINYINT(1) NOT NULL DEFAULT 0,
    userLastLoginDate DATE DEFAULT NULL,
    userAgreementGDPR TINYINT(1) DEFAULT 0,
    PRIMARY KEY(userID)
);

# Creating students table*/
DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE student (
  studentID INTEGER NOT NULL UNIQUE, 
  dOB DATE NOT NULL,
  gender BOOLEAN NOT NULL, 
  availableBalance DECIMAL(5,2) NOT NULL, 
  PRIMARY KEY (studentID),
  FOREIGN KEY (studentID) REFERENCES users(userID) /*Linking to user CHILD TABLE OF USER*/
);

# Creating tutors table */
DROP TABLE IF EXISTS staff CASCADE;
CREATE TABLE staff (
  staffID INTEGER NOT NULL UNIQUE, 
  PRIMARY KEY (staffID),
  FOREIGN KEY (staffID) REFERENCES users(userID) /*Linking to user CHILD TABLE OF USER*/
);

# Creating admins table*/
DROP TABLE IF EXISTS admin CASCADE;
CREATE TABLE admin (
  adminID INTEGER NOT NULL UNIQUE,
  PRIMARY KEY (adminID),
  FOREIGN KEY(adminID) REFERENCES users(userID) /*Linking to user CHILD TABLE OF USER*/
);

# Creating Courses table */
DROP TABLE IF EXISTS course CASCADE;
CREATE TABLE course (
  courseID VARCHAR(255) NOT NULL UNIQUE, 
  courseTitle VARCHAR(35) NOT NULL, 
  courseSubject VARCHAR(25) NOT NULL,
  courseType ENUM('Full_Time', 'Part_Time') NOT NULL,
  courseLevel ENUM('4', '5','6') NOT NULL,
  #fullTime BOOLEAN DEFAULT NULL, 
  #partTime BOOLEAN DEFAULT NULL,
  courseStartDate DATE NOT NULL,
  courseEndDate DATE NOT NULL,
  PRIMARY KEY (courseID)
); 

# Creating a table which links student to course.*/
DROP TABLE IF EXISTS studentToCourse CASCADE;
CREATE TABLE studentToCourse (
  stcCourseID VARCHAR(255) NOT NULL, 
  stcStudentID INTEGER NOT NULL, 
  stcStudentStatus VARCHAR(30) NOT NULL,
  PRIMARY KEY (stcCourseID, stcStudentID),
  FOREIGN KEY (stcStudentID) REFERENCES student(studentID),
  FOREIGN KEY (stcCourseID) REFERENCES course(courseID)
);

# Creating departments table
DROP TABLE IF EXISTS department CASCADE;
CREATE TABLE department (
  departmentID VARCHAR(255) NOT NULL UNIQUE, 
  departmentName VARCHAR(35) NOT NULL, 
  departmentCampusName ENUM('Lincoln', 'Gainsborough', 'Newark', 'Air_&_defence', 'Arabic', 'Construction') NOT NULL, 
  PRIMARY KEY (departmentID)
);

# Creating a table that links Staff to department
DROP TABLE IF EXISTS staffToDepartment CASCADE;
CREATE TABLE staffToDepartment (
  stDepartmentID VARCHAR(255) NOT NULL, 
  stStaffID INTEGER NOT NULL, 
  PRIMARY KEY (stDepartmentID, stStaffID),
  FOREIGN KEY (stDepartmentID) REFERENCES department(departmentID),
  FOREIGN KEY (stStaffID) REFERENCES staff(staffID)
);

# Creating bursary requests table */
DROP TABLE IF EXISTS bursaryRequests CASCADE;
CREATE TABLE bursaryRequests (
  bRequestsID INTEGER NOT NULL AUTO_INCREMENT, 
  bRequestsCourseID VARCHAR(255) NOT NULL, 
  bRequestsStaffID INTEGER NOT NULL, 
  bRequestsJustification VARCHAR(200) NOT NULL, 
  bRequestsTutorComments VARCHAR(200), 
  bRequestsAdminComments VARCHAR(200), 
  bRequestsStaffApproved VARCHAR(3) DEFAULT NULL, 
  bRequestsAdminApproved VARCHAR(3) DEFAULT NULL,
  bRequestsRequestDate DATE NOT NULL, 
  bRequestsDraft BOOLEAN DEFAULT NULL, 
  bRequestsStudentRequest BOOLEAN DEFAULT NULL,
  bRequestsStaffRequest BOOLEAN DEFAULT NULL, 
  PRIMARY KEY (bRequestsID),
  FOREIGN KEY (bRequestsCourseID) REFERENCES course(courseID),
  FOREIGN KEY (bRequestsStaffID) REFERENCES staff(staffID)
);

# Creating bursary request items table */
DROP TABLE IF EXISTS bursaryRequestItems CASCADE;
CREATE TABLE bursaryRequestItems (
  brItemID INTEGER NOT NULL AUTO_INCREMENT, 
  brItemCategory VARCHAR(30) NOT NULL, 
  brItemDesc VARCHAR(100) NOT NULL,
  brItemURL VARCHAR(200) NOT NULL, 
  brItemPrice DECIMAL(5,2) NOT NULL,
  brItemPostage DECIMAL(5,2) DEFAULT NULL,
  brItemAdditionalCharges DECIMAL(5,2) DEFAULT NULL,   
  PRIMARY KEY (brItemID)
);

# Creating items with requests table table*/
DROP TABLE IF EXISTS itemsAndRequests CASCADE;
CREATE TABLE itemsAndRequests (
  ItemID INTEGER NOT NULL, 
  RequestID INTEGER NOT NULL, 
  StudentID INTEGER NOT NULL, 
  StaffItemApproved VARCHAR(3) DEFAULT NULL,
  AdminItemApproved VARCHAR(3) DEFAULT NULL,
  Ordered BOOLEAN DEFAULT NULL,
  Delivered BOOLEAN DEFAULT NULL, 
  PRIMARY KEY(ItemID, RequestID, StudentID),
  FOREIGN KEY(ItemID) REFERENCES bursaryRequestItems(brItemID),
  FOREIGN KEY(RequestID) REFERENCES bursaryRequests(bRequestsID),
  FOREIGN KEY(StudentID) REFERENCES student(studentID)
);

# Creating a table that links departments, staff, courses and students together*/
DROP TABLE IF EXISTS departmentsStaffCourseStudents CASCADE;
CREATE TABLE departmentsStaffCourseStudents (
  bscsDepartmentID VARCHAR(255) NOT NULL, 
  bscsStaffID INTEGER NOT NULL, 
  bscsStudentID INTEGER NOT NULL, 
  bscsCourseID VARCHAR(255) NOT NULL,
  PRIMARY KEY (bscsDepartmentID, bscsStaffID, bscsStudentID, bscsCourseID),
  FOREIGN KEY (bscsDepartmentID) REFERENCES department(departmentID),
  FOREIGN KEY (bscsStaffID) REFERENCES staff(staffID),
  FOREIGN KEY (bscsStudentID) REFERENCES student(studentID),
  FOREIGN KEY (bscsCourseID) REFERENCES course(courseID)
);