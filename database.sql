DROP DATABASE IF EXISTS BursaryDatabase;
CREATE DATABASE BursaryDatabase; /*Creating the database*/
USE BursaryDatabase;


DROP TABLE IF EXISTS Students CASCADE;

/*Creating students table*/
CREATE TABLE Students (
  StudentID INTEGER NOT NULL UNIQUE, 
  StudentFirstName VARCHAR(15) NOT NULL, 
  StudentLastName VARCHAR(25) NOT NULL, 
  DOB DATE NOT NULL,
  GENDER BOOLEAN NOT NULL, 
  AvailableBalance DECIMAL(5,2) NOT NULL, 
  PRIMARY KEY (StudentID)
);

DROP TABLE IF EXISTS Staff CASCADE;

/*Creating tutors table */
CREATE TABLE Staff (
  StaffID INTEGER NOT NULL UNIQUE, 
  StaffFirstName VARCHAR(15) NOT NULL, 
  StaffLastName VARCHAR(25) NOT NULL, 
  PRIMARY KEY (StaffID)
);

DROP TABLE IF EXISTS Admin CASCADE;

/*Creating admins table*/
CREATE TABLE Admin (
  AdminID INTEGER NOT NULL UNIQUE,
  AdminFirstName VARCHAR(25) NOT NULL,
  AdminLastName VARCHAR(35) NOT NULL,
  PRIMARY KEY (AdminID)
);
DROP TABLE IF EXISTS Courses CASCADE;

/*Creating Courses table */
CREATE TABLE Courses (
  CourseID VARCHAR(255) NOT NULL UNIQUE, 
  CourseTitle VARCHAR(35) NOT NULL, 
  Subject VARCHAR(25) NOT NULL, 
  FullTime BOOLEAN DEFAULT NULL, 
  PartTime BOOLEAN DEFAULT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  PRIMARY KEY (CourseID)
); 

DROP TABLE IF EXISTS Departments CASCADE;

/*Creating departments table */
CREATE TABLE Departments (
  DepartmentID VARCHAR(255) NOT NULL UNIQUE, 
  DepartmentName VARCHAR(35) NOT NULL, 
  CampusName VARCHAR(30) NOT NULL, 
  PRIMARY KEY (DepartmentID)
);

DROP TABLE IF EXISTS BursaryRequests CASCADE;

/*Creating bursary requests table */
CREATE TABLE BursaryRequests (
  RequestID INTEGER NOT NULL AUTO_INCREMENT, 
  CourseID VARCHAR(255) NOT NULL, 
  StaffID INTEGER NOT NULL, 
  Justification VARCHAR(200) NOT NULL, 
  TutorComments VARCHAR(200), 
  AdminComments VARCHAR(200), 
  StaffApproved VARCHAR(3) DEFAULT NULL, 
  AdminApproved VARCHAR(3) DEFAULT NULL,
  RequestDate DATE NOT NULL, 
  Draft BOOLEAN DEFAULT NULL, 
  StudentRequest BOOLEAN DEFAULT NULL,
  StaffRequest BOOLEAN DEFAULT NULL, 
  PRIMARY KEY (RequestID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

DROP TABLE IF EXISTS BursaryRequestItems CASCADE;

/*Creating bursary request items table */
CREATE TABLE BursaryRequestItems (
  ItemID INTEGER NOT NULL AUTO_INCREMENT, 
  Category VARCHAR(30) NOT NULL, 
  ItemDesc VARCHAR(100) NOT NULL,
  ItemURL VARCHAR(200) NOT NULL, 
  Price DECIMAL(5,2) NOT NULL,
  Postage DECIMAL(5,2) DEFAULT NULL,
  AdditionalCharges DECIMAL(5,2) DEFAULT NULL,   
  PRIMARY KEY (ItemID)
);

DROP TABLE IF EXISTS ItemsAndRequests CASCADE;

/*Creating items with requests table table*/
CREATE TABLE ItemsAndRequests (
  ItemID INTEGER NOT NULL, 
  RequestID INTEGER NOT NULL, 
  StudentID INTEGER NOT NULL, 
  StaffItemApproved VARCHAR(3) DEFAULT NULL,
  AdminItemApproved VARCHAR(3) DEFAULT NULL,
  Ordered BOOLEAN DEFAULT NULL,
  Delivered BOOLEAN DEFAULT NULL, 
  PRIMARY KEY(ItemID, RequestID, StudentID),
  FOREIGN KEY(ItemID) REFERENCES BursaryRequestItems(ItemID),
  FOREIGN KEY(RequestID) REFERENCES BursaryRequests(RequestID),
  FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
);

DROP TABLE IF EXISTS DepartmentsStaffCoursesStudents CASCADE;

/*Creating a table that links departments, staff, courses and students together*/
CREATE TABLE DepartmentsStaffCoursesStudents (
  DepartmentID VARCHAR(255) NOT NULL, 
  StaffID INTEGER NOT NULL, 
  StudentID INTEGER NOT NULL, 
  CourseID VARCHAR(255) NOT NULL,
  StudentStatus VARCHAR(20) NOT NULL,
  PRIMARY KEY (DepartmentID, StaffID, StudentID, CourseID),
  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

DROP TABLE IF EXISTS studentUserDetails CASCADE;

/*Student user details table for login*/
CREATE TABLE StudentUserDetails (
  StudentID INTEGER NOT NULL,
  StudentUserPassword VARCHAR(255) NOT NULL,
  StudentUserType VARCHAR(30) NOT NULL,
  StudentUserActive TINYINT(1) NOT NULL DEFAULT 0,
  StudentUserLastLoginDate DATE DEFAULT NULL,
  PRIMARY KEY(StudentID),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

DROP TABLE IF EXISTS staffUserDetails CASCADE;

/*Staff user details table for login*/
CREATE TABLE StaffUserDetails (
  StaffID INTEGER NOT NULL,
  StaffUserPassword VARCHAR(255) NOT NULL,
  StaffUserType VARCHAR(30) NOT NULL,
  StaffUserActive TINYINT(1) NOT NULL DEFAULT 0,
  StaffUserLastLoginDate DATE DEFAULT NULL,
  PRIMARY KEY(StaffID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

DROP TABLE IF EXISTS AdminUserDetails CASCADE;

/*Admin user details table for login*/
CREATE TABLE AdminUserDetails (
  AdminID INTEGER NOT NULL,
  AdminUserPassword VARCHAR(255) NOT NULL,
  AdminUserType VARCHAR(30) NOT NULL,
  AdminUserActive TINYINT(1) NOT NULL DEFAULT 0,
  AdminUserLastLoginDate DATE DEFAULT NULL,
  PRIMARY KEY(AdminID),
  FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

#
# drop the DB WEB admin control user
#
DROP USER 'WEBAuth';
/* create test DB WEB admin*/
CREATE USER 'WEBAuth' IDENTIFIED BY 'WEBAuthPW';

/*give web admin SELECT and INSERT*/
GRANT INSERT, SELECT, UPDATE ON StudentUserDetails TO 'WEBAuth';
GRANT INSERT, SELECT, UPDATE ON StaffUserDetails TO 'WEBAuth';
GRANT INSERT, SELECT, UPDATE ON AdminUserDetails TO 'WEBAuth';

GRANT SELECT, UPDATE ON Students TO 'WEBAuth';
GRANT SELECT, UPDATE ON Staff TO 'WEBAuth';
GRANT SELECT, UPDATE ON Admin TO 'WEBAuth';


/*
Adding users to the DB
all testUser Accounts have their password set to:- PasswordA
which is then encrypted using md5, which is what is inserted into the database.*/

/*Populating student, staff and admin tables*/
INSERT INTO Students(StudentID,StudentFirstName,StudentLastName,DOB,GENDER,AvailableBalance) VALUES(293779,"Nikita","Skripnikov","07-11-1997",TRUE,500.00);
INSERT INTO Staff(StaffID,StaffFirstName,StaffLastName) VALUES(52354,"John","Rogers");
INSERT INTO Admin(AdminID,AdminFirstName,AdminLastName) VALUES(4561,"Stephen","Smith");

/*Populating student staff and admin user details for login testing*/
INSERT INTO StudentUserDetails(StudentID,StudentUserPassword,StudentUserType, StudentUserActive) VALUES(293779,"cf622eb3d4a59567353c2a13cd702514","Student", '1');
INSERT INTO StaffUserDetails(StaffID,StaffUserPassword,StaffUserType, StaffUserActive) VALUES(52354,"cf622eb3d4a59567353c2a13cd702514","Staff", '1');
INSERT INTO AdminUserDetails(AdminID,AdminUserPassword,AdminUserType, AdminUserActive) VALUES(4561,"cf622eb3d4a59567353c2a13cd702514","Admin", '1');
