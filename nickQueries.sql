## file name    : nickQueries.sql
## Created by   : Nikita Skripnikov
## Date created : 08/02/2019
## Purpose      :- Selective queries SQL queries for PHP system purposes
## Notes        :-
## last updated : 08/02/2019
## change made  :- Start of the queries
## last updated : 09/02/2019
## change made  :- Altered queries due to one of the tables being altered
## last updated : 10/02/2019
## change made  :- New queries added and tested
## last updated : 12/02/2019
## change made  :- New queries added and tested
## last updated : 13/02/2019
## change made  :- New queries added, tested and updated due to database course table change


/*Nicks queries*/

/*-------------------------------------------------*/

/*Select student name of a specific student TEST*/
SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = 293779;
/*FOR PHP*/
/*SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = $userid;*/

/*-------------------------------------------------*/

/*Select course title of a specific student TEST*/
SELECT DISTINCT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = 293779 and studentToCourse.stcStudentID = 293779;
/*FOR PHP*/
/*SELECT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = $userID and studentToCourse.stcStudentID = $userid;*/

/*-------------------------------------------------*/

/*COUNT all bursary requests that are not approved (Submitted) NOT DRAFT as well TEST */
SELECT COUNT(*) as 'Total' from bursaryRequests inner join itemsAndRequests
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = 29000
and bursaryRequests.bRequestsStaffApproved is NULL and bursaryRequests.bRequestsAdminApproved is NULL 
and bRequestsStatus = "Submitted";
/*FOR PHP*/
/*SELECT COUNT(*) as 'Total' from bursaryRequests inner join itemsAndRequests
where itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = $userid
and bursaryRequests.bRequestsStaffApproved is NULL and bursaryRequests.bRequestsAdminApproved is NULL 
and bRequestsStatus = "Submitted";*/

/*-------------------------------------------------*/

/*OUTPUT specific bursary request linked to a specific student TEST */
SELECT courseTitle, CONCAT(userFirstName, " ", userLastName) as 'Tutor',
bRequestsJustification as 'Justification', 
bRequestsTutorComments as 'Tutor comments', 
bRequestsAdminComments as 'Admin comments', 
bRequestsRequestDate as 'Request date',
bRequestsStatus as 'Status' from bursaryRequests
inner join course on bursaryRequests.bRequestsCourseID = course.courseID
inner join users on users.userID = bursaryRequests.bRequestsStaffID
inner join itemsAndRequests on itemsAndRequests.RequestID = 1 
and bursaryRequests.bRequestsID = 1
and itemsAndRequests.StudentID = 29000;
/*FOR PHP*/
/*SELECT courseTitle, CONCAT(userFirstName, " ", userLastName) as 'Tutor',
bRequestsJustification as 'Justification', 
bRequestsTutorComments as 'Tutor comments', 
bRequestsAdminComments as 'Admin comments', 
bRequestsRequestDate as 'Request date',
bRequestsStatus as 'Status' from bursaryRequests
inner join course on bursaryRequests.bRequestsCourseID = course.courseID
inner join users on users.userID = bursaryRequests.bRequestsStaffID
inner join itemsAndRequests on itemsAndRequests.RequestID = $RequestID 
and bursaryRequests.bRequestsID = $requestid
and itemsAndRequests.StudentID = $userid*/

/*-------------------------------------------------*/

/*OUTPUT all items linked to a specific bursary request of a specific student TEST */
SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = 4
and itemsAndRequests.StudentID = 25432\G
/*FOR PHP*/
/*SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = $requestid
and itemsAndRequests.StudentID = $userid;*/

/*-------------------------------------------------*/

/*Select all items of all requests that are a draft linked to a specific student*/
/*UPDATE bursaryRequests SET bRequestsDraft = TRUE where bRequestsID =1;
INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID) VALUES(2,1,29000); FOR TESTING ONLY*/ 
SELECT brItemDesc as 'Item', 
IFNULL(brItemPrice,0) + IFNULL(brItemPostage,0) + IFNULL(brItemAdditionalCharges,0)
as 'Total price', bursaryRequests.bRequestsRequestDate from bursaryRequestItems 
inner join itemsAndRequests on bursaryRequestItems.brItemID = itemsAndRequests.ItemID 
and itemsAndRequests.StudentID = 29000
inner join bursaryRequests on bursaryRequests.bRequestsID = itemsAndRequests.RequestID
and bursaryRequests.bRequestsStatus = "Draft"
ORDER BY bursaryRequests.bRequestsRequestDate DESC;
/*FOR PHP*/
/*SELECT brItemDesc as 'Item', 
IFNULL(brItemPrice,0) + IFNULL(brItemPostage,0) + IFNULL(brItemAdditionalCharges,0)
as 'Total price', bursaryRequests.bRequestsRequestDate from bursaryRequestItems 
inner join itemsAndRequests on bursaryRequestItems.brItemID = itemsAndRequests.ItemID 
and itemsAndRequests.StudentID = $userid
inner join bursaryRequests on bursaryRequests.bRequestsID = itemsAndRequests.RequestID
and bursaryRequests.bRequestsStatus = "Draft"
ORDER BY bursaryRequests.bRequestsRequestDate DESC;*/

/*-------------------------------------------------*/

/*UPDATE specific draft request info that is linked to a specific student TEST */
/*UPDATE bursaryRequests SET bRequestsJustification = "" where bRequestsID = 1; */
/*FOR PHP*/
/*UPDATE bursaryRequests SET bRequestsJustification = "" where bRequestsID = $requestid;*/

/*-------------------------------------------------*/

/*UPDATE specific item linked to a specific draft request of a specific student TEST*/
/*UPDATE bursaryRequestItems SET brItemCategory = "",brItemDesc = "",brItemURL = "",brItemPrice = "", brItemPostage = "", 
brItemAdditionalCharges = "" where brItemID = 1; FOR TEST*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES(1,1,293779);*/
/*FOR PHP*/
/*UPDATE bursaryRequestItems SET brItemCategory = "",brItemDesc = "",brItemURL = "",brItemPrice = "", brItemPostage = "", 
brItemAdditionalCharges = "" where brItemID = $itemid;*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES($itemid,$requestid,$userid);*/

/*-------------------------------------------------*/

/*-	OUTPUT all bursary requests that are pending with the total price of all items and item count 
(Linked to specific student and linked to the requests) TEST- */
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES(1,2,25432);*/ /*FOR TESTING PURPOSES to add the person to a new request*/
SELECT bRequestsRequestDate as 'Date submitted', COUNT(itemsAndRequests.ItemID) as 'Item count',
SUM(IFNULL(brItemPrice,0) + IFNULL(brItemPostage,0) + IFNULL(brItemAdditionalCharges,0))
as 'Total price', bRequestsStatus as 'Status' from bursaryRequests inner join itemsAndRequests
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID
and itemsAndRequests.StudentID = 25432 and itemsAndRequests.StaffItemApproved is NULL
and itemsAndRequests.AdminItemApproved is NULL inner join bursaryRequestItems on 
itemsAndRequests.ItemID = bursaryRequestItems.brItemID and bursaryRequests.bRequestsStaffApproved is NULL
and bursaryRequests.bRequestsAdminApproved is NULL and bursaryRequests.bRequestsStatus = "Submitted"
GROUP BY bursaryRequests.bRequestsID ORDER BY bursaryRequests.bRequestsRequestDate ASC;
/*FOR PHP*/
/*SELECT bRequestsRequestDate as 'Date submitted', COUNT(itemsAndRequests.ItemID) as 'Item count',
SUM(IFNULL(brItemPrice,0) + IFNULL(brItemPostage,0) + IFNULL(brItemAdditionalCharges,0))
as 'Total price' from bursaryRequests inner join itemsAndRequests
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID
and itemsAndRequests.StudentID = $userid and itemsAndRequests.StaffItemApproved is NULL
and itemsAndRequests.AdminItemApproved is NULL inner join bursaryRequestItems on 
itemsAndRequests.ItemID = bursaryRequestItems.brItemID and bursaryRequests.bRequestsStaffApproved is NULL
and bursaryRequests.bRequestsAdminApproved is NULL and bursaryRequests.bRequestsStatus = "Submitted"
GROUP BY bursaryRequests.bRequestsID ORDER BY bursaryRequests.bRequestsRequestDate ASC;*/

/*-------------------------------------------------*/

/*DELETE specific DRAFT linked to a specific Student TEST-Based on draft being deleted needs a draft added*/
/*DELETE from bursaryRequests where bRequestsID =1 and bRequestsStatus = "Draft"; */
/*FOR PHP*/
/*DELETE from bursaryRequests where bRequestsID =$requestid and bRequestsStatus = "Draft";*/

/*-------------------------------------------------*/

/*Cancel a specific request that is pending for approval (Specific request) TEST*/
/*UPDATE bursaryRequests SET bRequestsStatus = "Cancelled" where bRequestsID = 1 and bRequestsStatus = "Submitted"
and bRequestsAdminApproved is NULL and bRequestsStaffApproved is NULL; FOR TESTING ONLY*/
#SELECT bRequestsStatus from bursaryRequests; FOR PROOF THAT IT WORKS
/*FOR PHP*/
/*UPDATE bursaryRequests SET bRequestsStatus = "Cancelled" where bRequestsID = $requestid and bRequestsStatus = "Submitted"
and bRequestsAdminApproved is NULL and bRequestsStaffApproved is NULL;*/

/*-------------------------------------------------*/

/*SELECT all requests from specific course, year, level and status linked to specific student*/
SELECT itemsAndRequests.StudentID as "Student_ID", bursaryRequests.bRequestsRequestDate as 'Date_submitted',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total_price',
bRequestsStatus as 'Status' from bursaryRequests inner join itemsAndRequests 
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = 25432
and bursaryRequests.bRequestsCourseID = "HEHAIR001" inner join course on course.courseTitle = "BCs Hair and beauty"
and course.courseLevel = "4" and course.courseYear = "2018/2019" inner join bursaryRequestItems 
on bursaryRequestItems.brItemID = itemsAndRequests.ItemID and bursaryRequests.bRequestsStatus = "Submitted" 
GROUP BY itemsAndRequests.RequestID ORDER BY bursaryRequests.bRequestsRequestDate ASC; 
/*Tested with by adding this student to another request*/
/*FOR PHP*/
/*SELECT itemsAndRequests.StudentID as "Student_ID", bursaryRequests.bRequestsRequestDate as 'Date_submitted',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total_price',
bRequestsStatus as 'Status' from bursaryRequests inner join itemsAndRequests 
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = $userid
and bursaryRequests.bRequestsCourseID = $courseid inner join course on course.courseTitle = $courseTitle
and course.courseLevel = $courseLevel and course.courseYear = $courseYear inner join bursaryRequestItems 
on bursaryRequestItems.brItemID = itemsAndRequests.ItemID and bursaryRequests.bRequestsStatus = $requestStatus 
GROUP BY itemsAndRequests.RequestID ORDER BY bursaryRequests.bRequestsRequestDate ASC;*/

/*-------------------------------------------------*/

/*SELECT all Courses linked to specific student (FOR SELECTING) TEST*/
SELECT DISTINCT courseTitle from course inner join studentToCourse on course.courseID = studentToCourse.stcCourseID
and studentToCourse.stcStudentID = 293779;
/*FOR PHP*/
/*SELECT courseTitle from course inner join studentToCourse where course.courseID = studentToCourse.stcCourseID
and studentToCourse.stcStudentID = $userid;*/

/*-------------------------------------------------*/

/*-	SELECT all Years linked to specific student (FOR SELECTING) TEST*/
SELECT courseYear as 'Year' from course 
inner join studentToCourse on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = 29000;
/*FOR PHP*/
/*SELECT courseYear as 'Year' from course 
inner join studentToCourse on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = $userid;*/

/*-------------------------------------------------*/

/*SELECT all levels linked to specific student (FOR SELECTING) TEST */
SELECT courseLevel as 'Level' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = 29000;
/*FOR PHP*/
/*SELECT courseLevel as 'Level' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = $userid;*/

/*-------------------------------------------------*/

/*UPDATE users table for specific user to agree/disagree to GDPR TEST */
/*UPDATE users SET userAgreementGDPR = 1 where userID = 293779;
SELECT userAgreementGDPR from users where userID = 293779; FOR TESTING ONLY*/
/*FOR PHP*/
/*UPDATE users SET userAgreementGDPR = $agreementGDPR where userID = $userid*/

/*-------------------------------------------------*/

/*INSERT new bursary request with data for specific course and staff member (SUBMIT-Student) TEST */
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStudentRequest)
VALUES ("HEBCSIT111",52354,"Rasberry Pi for course work.","2019-10-01","Submitted",TRUE); *//*Student request for rasberry Pi for full time computer course*/
/*FOR PHP*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStudentRequest)
VALUES ($courseid,$userid,$txbJustication,$dateNow,"Submitted",TRUE); Student request for rasberry Pi for full time computer course*/

/*-------------------------------------------------*/

/*INSERT items belonging to a specific bursary request and specific student (SUBMIT) TEST*/
/*INSERT INTO bursaryRequestItems(brItemCategory,brItemDesc,brItemURL,brItemPrice,brItemPostage,brItemAdditionalCharges)
VALUES("Equipment and resources","New computer keyboard","https://www.amazon.co.uk/dp/B00M75WPKO/ref=asc_df_B00M75WPKO58142109/?tag=googshopuk-21&creative=22146&creativeASIN=B00M75WPKO&linkCode=df0&hvadid=310665672682&hvpos=1o2&hvnetw=g&hvrand=3873864805278938592&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=1006876&hvtargid=pla-563720906553",9.99,NULL,NULL);*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES(1,1,29000);*/
/*FOR PHP*/
/*INSERT INTO bursaryRequestItems(brItemCategory,brItemDesc,brItemURL,brItemPrice,brItemPostage,brItemAdditionalCharges)
VALUES($txbItemCategory,$txbItemDescription,,$txbPrice, $txbPostage, $txbAdditionalCharges);*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES($itemid,$requestid,$userid);*/

/*-------------------------------------------------*/

/*INSERT new bursary request with data for specific course and staff member AS DRAFT TEST */
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStudentRequest)
VALUES ("HEBCSIT111",52354,"Rasberry Pi for course work.","2019-10-01","Draft",TRUE);*/
/*FOR PHP*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStudentRequest)
VALUES ($courseid,$userid,$txbJustication,$dateNow,"Draft",TRUE);*/

/*-------------------------------------------------*/

/*SELECT Tutor name relating to specific student TEST*/
SELECT DISTINCT CONCAT(userFirstName, " ", userLastName) as 'Tutor' from users
inner join departmentsStaffCourseStudents on users.userID = departmentsStaffCourseStudents.bscsStaffID
and departmentsStaffCourseStudents.bscsStudentID = 293779;
/*FOR PHP*/
/*SELECT CONCAT(userFirstName, " ", userLastName) as 'Tutor' from users
inner join departmentsStaffCourseStudents on users.userID = departmentsStaffCourseStudents.bscsStaffID
and departmentsStaffCourseStudents.bscsStudentID = $userid;*/

/*-------------------------------------------------*/

/*Delete an item from a specific request TEST */
/*DELETE from bursaryRequestItems where brItemID = 1;*/
/*FOR PHP*/
/*DELETE from bursaryRequestItems where brItemID = $itemid;*/

/*-------------------END OF STUDENT QUERIES----------------------------*/

/*-------------------Staff Queries----------------------------*/

/*SELECT all students belonging to a specific staff member and are on a specific course, level and year TEST */
SELECT userID as "Student_ID", CONCAT(userFirstName, " ",userLastName) as "Student_name",
student.availableBalance from users inner join student on users.userID = student.studentID
inner join departmentsStaffCourseStudents on users.userID = departmentsStaffCourseStudents.bscsStudentID
and departmentsStaffCourseStudents.bscsStaffID = 59021 
inner join course on departmentsStaffCourseStudents.bscsCourseID = course.courseID and 
course.courseTitle = "BCs Mechanical Engineering" and course.courseLevel = "4" and 
course.courseYear = "2017/2018" GROUP BY userID;
/*FOR PHP*/
/*SELECT userID as "Student_ID", CONCAT(userFirstName, " ",userLastName) as "Student_name",
student.availableBalance from users inner join student on users.userID = student.studentID
inner join departmentsStaffCourseStudents on users.userID = departmentsStaffCourseStudents.bscsStudentID
and departmentsStaffCourseStudents.bscsStaffID = $userid 
inner join course on departmentsStaffCourseStudents.bscsCourseID = course.courseID and 
course.courseTitle = $txbCourseTitle and course.courseLevel = $txbCourseLevel and 
course.courseYear = $txbCourseYear GROUP BY userID;*/

/*-------------------------------------------------*/

/*INSERT new staff bursary request info for a specific student and to a specific course TEST*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStaffRequest,bRequestsStaffApproved)
VALUES ("HEMNG001",59021,"Spanner for each student.","2019-01-01","Submitted",TRUE,"Yes");*/ /*Staff request for bulk order for mechanical engineering course for 2 people*/
/*FOR PHP*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStaffRequest,bRequestsStaffApproved)
VALUES ($courseid,$userid,$txbJustication,$dateNow,"Submitted",TRUE,"Yes");*/

/*-------------------------------------------------*/

/*INSERT a specific item linked to a specific staff request for a specific student
  INSERT a specific student belonging to that staff member to a staff bursary request 
  (Ticking a student to a request) TEST TWO PRETTY MUCH SAME QUERIES*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES(1,6,25432);*/
/*FOR PHP*/
/*INSERT INTO itemsAndRequests(ItemID,RequestID,StudentID)
VALUES($itemid,$requestid,$userid);*/

/*-------------------------------------------------*/

/*INSERT new staff bursary request info for specific student as DRAFT to specific course TEST*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStaffRequest)
VALUES ("HEMNG001",59021,"Spanner for each student.","2019-01-01","Draft",TRUE);*/
/*FOR PHP*/
/*INSERT INTO bursaryRequests(bRequestsCourseID,bRequestsStaffID,bRequestsJustification,bRequestsRequestDate,bRequestsStatus,bRequestsStaffRequest)
VALUES ($courseid,$userid,$txbJustication,$dateNow,"Draft",TRUE);*/

/*-------------------------------------------------*/

/*-	SELECT all specific staff bursary requests which are DRAFTS, work out the item count for each of that request and the total price. 
OUTPUT (Date submitted, item count and total price). TEST*/
SELECT bRequestsRequestDate as "Request_Date", COUNT(itemsAndRequests.ItemID) as 'Item_count',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total_price' from bursaryRequests
inner join itemsAndRequests on itemsAndRequests.RequestID = bursaryRequests.bRequestsID
inner join bursaryRequestItems on itemsAndRequests.ItemID = bursaryRequestItems.brItemID
and bursaryRequests.bRequestsStaffRequest is TRUE and bursaryRequests.bRequestsStatus = "Draft"
and bursaryRequests.bRequestsStaffID = 52354;
/*FOR PHP*/
/*SELECT bRequestsRequestDate as "Request_Date", COUNT(itemsAndRequests.ItemID) as 'Item_count',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total_price' from bursaryRequests
inner join itemsAndRequests on itemsAndRequests.RequestID = bursaryRequests.bRequestsID
inner join bursaryRequestItems on itemsAndRequests.ItemID = bursaryRequestItems.brItemID
and bursaryRequests.bRequestsStaffRequest is TRUE and bursaryRequests.bRequestsStatus = "Draft"
and bursaryRequests.bRequestsStaffID = $userid;*/