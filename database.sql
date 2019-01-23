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

DROP TABLE IF EXISTS Tutors CASCADE;

/*Creating tutors table */
CREATE TABLE Staff (
  StaffID INTEGER NOT NULL UNIQUE, 
  StaffFirstName VARCHAR(15) NOT NULL, 
  StaffLastName VARCHAR(25) NOT NULL, 
  PRIMARY KEY (StaffID)
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
  CourseID VARCHAR NOT NULL, 
  StaffID INTEGER NOT NULL, 
  Justification VARCHAR(200) NOT NULL, 
  TutorComments VARCHAR(200), 
  AdminComments VARCHAR(200), 
  StaffApproved VARCHAR(3) DEFAULT NULL, 
  AdminApproved VARCHAR(3) DEFAULT NULL,
  Ordered BOOLEAN DEFAULT NULL,
  Delivered BOOLEAN DEFAULT NULL, 
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
  PRIMARY KEY(ItemID, RequestID, StudentID),
  FOREIGN KEY(ItemID) REFERENCES BursaryRequestItems(ItemID),
  FOREIGN KEY(RequestID) REFERENCES BursaryRequests(RequestID),
  FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
);

DROP TABLE IF EXISTS DepartmentsWithStudentsCoursesAndTutors CASCADE;

/*Creating departs with students, courses and tutors table */
CREATE TABLE DepartmentsWithStudentsCoursesAndTutors (
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