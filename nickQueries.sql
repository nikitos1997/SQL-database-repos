## file name    : nickQueries.sql
## Created by   : Nikita Skripnikov
## Date created : 08/02/2019
## Purpose      :- Selective queries SQL queries for PHP system purposes
## Notes        :-
## last updated : 08/02/2019
## change made  :- Start of the queries
## last updated : 09/02/2019
## change made  :- Altered queries due to one of the tables being altered

/*Nicks queries*/

/*Select student name of a specific student TEST*/
SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = 293779;
/*FOR PHP*/
/*SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = $userid;*/

/*Select course title of a specific student TEST*/
SELECT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = 293779 and studentToCourse.stcStudentID = 293779;
/*FOR PHP*/
/*SELECT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = $userID and studentToCourse.stcStudentID = $userid;*/

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

/*OUTPUT all items linked to a specific bursary request of a specific student TEST */
SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = 4
and itemsAndRequests.StudentID = 25432;
/*FOR PHP*/
/*SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = $requestid
and itemsAndRequests.StudentID = $userid;*/

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

/*Cancel a specific request that is pending for approval (Specific request) TEST*/

/*UPDATE bursaryRequests SET bRequestsStatus = "Cancelled" where bRequestsID = 1 and bRequestsStatus = "Submitted"
and bRequestsAdminApproved is NULL and bRequestsStaffApproved is NULL; FOR TESTING ONLY*/
#SELECT bRequestsStatus from bursaryRequests; FOR PROOF THAT IT WORKS
/*FOR PHP*/
/*UPDATE bursaryRequests SET bRequestsStatus = "Cancelled" where bRequestsID = $requestid and bRequestsStatus = "Submitted"
and bRequestsAdminApproved is NULL and bRequestsStaffApproved is NULL;*/

/*SELECT all requests from specific course, year, level and status linked to specific student*/
SELECT itemsAndRequests.StudentID as "Student ID", bursaryRequests.bRequestsRequestDate as 'Date submitted',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total price',
bRequestsStatus as 'Status' from bursaryRequests inner join itemsAndRequests 
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = 25432
and bursaryRequests.bRequestsCourseID = "HEHAIR001" inner join course on course.courseTitle = "BCs Hair and beauty"
and course.courseLevel = "4" and course.courseStartDate = "2018-09-05" inner join bursaryRequestItems 
on bursaryRequestItems.brItemID = itemsAndRequests.ItemID and bursaryRequests.bRequestsStatus = "Submitted" 
GROUP BY itemsAndRequests.RequestID ORDER BY bursaryRequests.bRequestsRequestDate ASC; 
/*Tested with by adding this student to another request*/
/*FOR PHP*/
/*SELECT itemsAndRequests.StudentID as "Student ID", bursaryRequests.bRequestsRequestDate as 'Date submitted',
SUM(IFNULL(bursaryRequestItems.brItemPrice,0) + IFNULL(bursaryRequestItems.brItemPostage,0) + 
IFNULL(bursaryRequestItems.brItemAdditionalCharges,0)) as 'Total price',
bRequestsStatus as 'Status' from bursaryRequests inner join itemsAndRequests 
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = $userid
and bursaryRequests.bRequestsCourseID = $courseid inner join course on course.courseTitle = $courseTitle
and course.courseLevel = $courseLevel and course.courseStartDate = $courseStartDate inner join bursaryRequestItems 
on bursaryRequestItems.brItemID = itemsAndRequests.ItemID and bursaryRequests.bRequestsStatus = $requestStatus
GROUP BY itemsAndRequests.RequestID ORDER BY bursaryRequests.bRequestsRequestDate ASC;*/

/*SELECT all Courses linked to specific student (FOR SELECTING) TEST*/
SELECT courseTitle from course inner join studentToCourse on course.courseID = studentToCourse.stcCourseID
and studentToCourse.stcStudentID = 293779;
/*FOR PHP*/
/*SELECT courseTitle from course inner join studentToCourse where course.courseID = studentToCourse.stcCourseID
and studentToCourse.stcStudentID = $userid;*/

/*-	SELECT all Years linked to specific student (FOR SELECTING) TEST*/
SELECT courseStartDate as 'Start date' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = 29000;
/*FOR PHP*/
/*SELECT courseStartDate as 'Start date' from course inner join studentToCourse
where course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = $userid;*/

/*SELECT all levels linked to specific student (FOR SELECTING) TEST */
SELECT courseLevel as 'Level' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = 29000;
/*FOR PHP*/
/*SELECT courseLevel as 'Level' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID and studentToCourse.stcStudentID = $userid;*/
