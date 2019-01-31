#
#--- drop the DB WEB admin control user
#
DROP USER 'WEBAuth';
/* create test DB WEB admin*/
CREATE USER 'WEBAuth' IDENTIFIED BY 'WEBAuthPW';

/*give web admin SELECT and INSERT*/
GRANT INSERT, SELECT, UPDATE ON users TO 'WEBAuth';

/*
Adding users to the DB
all testUser Accounts have their password set to:- PasswordA
which is then encrypted using md5, which is what is inserted into the database.*/

#-------Student user insertion------------#
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (293779, "Nikita", "Skripnikov", "cf622eb3d4a59567353c2a13cd702514", '293779@student.lincolncollege.ac.uk', "Student", '1');
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (29000, "Danny", "McCoombs", "cf622eb3d4a59567353c2a13cd702514", '29000@student.lincolncollege.ac.uk', "Student", '1');
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (27865, "Andrius", "Williams", "cf622eb3d4a59567353c2a13cd702514", '27865@student.lincolncollege.ac.uk', "Student", '1');

#-------Staff user insertion------------#
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (52354,"John","Rogers", "cf622eb3d4a59567353c2a13cd702514", 'JRogers@lincolncollege.ac.uk', "Staff", '1');
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (59021,"Jeremy","Smith", "cf622eb3d4a59567353c2a13cd702514", 'JSmith@lincolncollege.ac.uk', "Staff", '1');
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (53270,"Rebbeca","Jenkins", "cf622eb3d4a59567353c2a13cd702514", 'RJenkins@lincolncollege.ac.uk', "Staff", '1');

#-------Admin user insertion------------#
INSERT INTO users (userID, userFirstName, userLastName, userPassword, userEmail, userType, userActive)
  VALUES (4561,"Stephen","Smith", "cf622eb3d4a59567353c2a13cd702514", 'SSmith@lincolncollege.ac.uk', "Admin", '1');

#-------Student table insertion------------#
INSERT INTO student(studentID,dOB,gender,availableBalance) 
VALUES (293779,'1997-07-11',TRUE,500);
INSERT INTO student(studentID,dOB,gender,availableBalance) 
VALUES (29000,'1998-10-11',TRUE,500);
INSERT INTO student(studentID,dOB,gender,availableBalance) 
VALUES (27865,'1991-11-11',TRUE,500);

#-------Staff table insertion------------#
INSERT INTO staff(staffID) VALUES (52354);
INSERT INTO staff(staffID) VALUES (59021);
INSERT INTO staff(staffID) VALUES (53270);

#-------Admin table insertion------------#
INSERT INTO admin(adminID) VALUES (4561);

#-------Course table insertion------------#
INSERT INTO course(courseID,courseTitle,courseSubject,courseType,courseStartDate,courseEndDate)
VALUES ("HEBCSIT111","BCs Computer Science", "Information Technology","Full_Time","2018-09-05","2019-06-30");
INSERT INTO course(courseID,courseTitle,courseSubject,courseType,courseStartDate,courseEndDate)
VALUES ("HEBCSIT112","BCs Computer Science", "Information Technology","Part_Time","2018-09-05","2022-06-30");
INSERT INTO course(courseID,courseTitle,courseSubject,courseType,courseStartDate,courseEndDate)
VALUES ("HEMNG001","BCs Mechanical Engineering", "Mechanical Engineering","Full_Time","2018-09-05","2019-06-30");

#-------Department table insertion------------#
INSERT INTO department(departmentID,departmentName,departmentCampusName)
VALUES ("CompLincCol1001","Bishops building","Lincoln");
INSERT INTO department(departmentID,departmentName,departmentCampusName)
VALUES ("HairLincCol1111","Abbey building","Lincoln");
INSERT INTO department(departmentID,departmentName,departmentCampusName)
VALUES ("SiemensLincCol1002","Cathedral building","Lincoln");

#-------Student to course table insertion------------#
INSERT INTO studentToCourse(stcCourseID,stcStudentID,stcStudentStatus)
VALUES ("HEBCSIT111",29000,"Continuing");
INSERT INTO studentToCourse(stcCourseID,stcStudentID,stcStudentStatus)
VALUES ("HEBCSIT112",293779,"Continuing");
INSERT INTO studentToCourse(stcCourseID,stcStudentID,stcStudentStatus)
VALUES ("HEMNG001",27865,"Continuing");

#-------Staff to department table insertion------------#
INSERT INTO staffToDepartment(stDepartmentID,stStaffID)
VALUES ("CompLincCol1001",52354);
INSERT INTO staffToDepartment(stDepartmentID,stStaffID)
VALUES ("HairLincCol1111",53270);
INSERT INTO staffToDepartment(stDepartmentID,stStaffID)
VALUES ("SiemensLincCol1002",59021);





