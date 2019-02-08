## file name    : nickQueries.sql
## Created by   : Nikita Skripnikov
## Date created : 08/02/2019
## Purpose      :- Selective queries SQL queries for PHP system purposes
## Notes        :-
## last updated : 08/02/2019
## change made  :- 

/*Nicks queries*/

/*Select student name of a specific student TEST*/
SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = 293779;
/*FOR PHP*/
/*SELECT CONCAT(userFirstName, " ", userLastName) as 'Name' from users
where userID = $UserID;*/

/*Select course title of a specific student TEST*/
SELECT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = 293779 and studentToCourse.stcStudentID = 293779;
/*FOR PHP*/
/*SELECT courseTitle as 'Course' from course inner join studentToCourse
on course.courseID = studentToCourse.stcCourseID inner join users 
on users.userID = $UserID and studentToCourse.stcStudentID = $UserID;*/

/*COUNT all bursary requests that are not approved (Submitted) NOT DRAFT as well TEST */
SELECT COUNT(*) as 'Total' from bursaryRequests inner join itemsAndRequests
on itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = 29000
and bursaryRequests.bRequestsStaffApproved is NULL and bursaryRequests.bRequestsAdminApproved is NULL 
and bRequestsDraft is NULL;
/*FOR PHP*/
/*SELECT COUNT(*) as 'Total' from bursaryRequests inner join itemsAndRequests
where itemsAndRequests.RequestID = bursaryRequests.bRequestsID and itemsAndRequests.StudentID = $UserID
and bursaryRequests.bRequestsStaffApproved is NULL and bursaryRequests.bRequestsAdminApproved is NULL 
and bRequestsDraft is NULL;*/

/*OUTPUT specific bursary request linked to a specific student TEST */
SELECT courseTitle, CONCAT(userFirstName, " ", userLastName) as 'Tutor',
bRequestsJustification as 'Justification', 
bRequestsTutorComments as 'Tutor comments', 
bRequestsAdminComments as 'Admin comments', 
bRequestsRequestDate as 'Request date' from bursaryRequests
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
bRequestsRequestDate as 'Request date' from bursaryRequests
inner join course on bursaryRequests.bRequestsCourseID = course.courseID
inner join users on users.userID = bursaryRequests.bRequestsStaffID
inner join itemsAndRequests on itemsAndRequests.RequestID = $RequestID 
and bursaryRequests.bRequestsID = $RequestID
and itemsAndRequests.StudentID = $UserID*/

/*OUTPUT all items linked to a specific bursary request of a specific student TEST */
SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = 1
and itemsAndRequests.StudentID = 29000;
/*FOR PHP*/
/*SELECT brItemCategory as 'Category', brItemDesc as 'Item description',
brItemURL as 'URL', brItemPrice as 'Price', brItemPostage as 'Postage',
brItemAdditionalCharges as 'Additional charges' from bursaryRequestItems
inner join itemsAndRequests on itemsAndRequests.ItemID = bursaryRequestItems.brItemID 
and itemsAndRequests.RequestID = $RequestID
and itemsAndRequests.StudentID = $UserID;*/


