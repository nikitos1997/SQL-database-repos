<?php  //Start the Session
// file name: login.php
// author: Mike Wright
// date created: 02/02/2019
    echo " start Step 1.0<br>"; // for testing purposes
    echo "<p>logging in....</p>"; // for testing purposes
    session_start();
#
    // Ensures the DB is connected too
    //require 'connect.php';
    echo " start Step 1.1<br>"; // for testing purposes

    require_once 'connect.php';//creates a connection to the database
    //
    echo " start Step 2.1..<br>"; // for testing purposes

    echo " start Step 2.1.1..<br>"; // for testing purposes
//    if (isset($_POST['userid']) and isset($_POST['userFirstName']) and isset($_POST['userLastName']) and isset($_POST['userEmail']) and isset($_POST['password'])){
    if (isset($_POST['userid']) && isset($_POST['firstname']) && isset($_POST['lastname']) && isset($_POST['email']) && isset($_POST['password'])){
      
      echo " start Step 2.1.1.1..<br>"; // for testing purposes
        if(isset($_POST) & !empty($_POST)){
            //  If the form is submitted assign variables for userid and password
            $userid = $_POST['userid'];
            $userfirstname = $_POST['firstname'];
            $userlastname  = $_POST['lastname'];
            $useremail = $_POST['email'];
            $password = $_POST['password'];
            
            //echo "User pre-password encrypt merged :'$pwad'";
            $SQL_stmt = "SELECT userID, userPassword, userFirstName, userLastName, userType, userActive, userEmail FROM users WHERE userID = '" . $userid . "'";   
            // now to run the query
            echo " start Step 2.1.1.2..<br>"; // for testing purposes
            //echo "<p> start Step 2.1.1.2a..'$SQL_stmt'</p>"; // for testing purposes

            // first prepare and excecurte
            $result = $DBconnection->query($SQL_stmt);
            echo " start Step 2.1.1.2b..<br>"; // for testing purposes

            if ($row = $result->fetch()){
                // varify that it is a valid userID
                echo " start Step 2.1.1.3..<br>"; // for testing purposes
                // Bind results by column name
                $userPassword = $row['userPassword'];
                echo " start Step 2.1.1.3b..<br>"; // for testing purposes
                $userFirstName = $row['userFirstName'];
                echo " start Step 2.1.1.3c..'$userFirstName'<br>"; // for testing purposes
                $userLastName = $row['userLastName'];
                echo " start Step 2.1.1.3d..'$userLastName'<br>"; // for testing purposes
                $userType = $row['userType'];
                echo " start Step 2.1.1.3e..'$userType'<br>"; // for testing purposes
                $userActive = $row['userActive'];
                echo " start Step 2.1.1.3f..'$userActive'<br>"; // for testing purposes
                $userEmail = $row['userEmail'];
                echo " start Step 2.1.1.3f..'$userEmail'<br>"; // for testing purposes
              
                if ($userPassword == NULL) {

                    // now ensure the user is an active user within the course
                    echo " start Step 2.1.1.4..<br>"; // for testing purposes
                    if ($userActive == 1){
                        // ensure that the users is valid and is who they say they are
                        echo " start Step 2.1.1.5..<br>"; // for testing purposes
                        if (($userfirstname == $userFirstName) & ($userlastname == $userLastName) & ($useremail == $userEmail)){
                            // Verification success! User has loggedin!
                            // and create a sesssion store of user credentials
                            $_SESSION['loggedin'] = TRUE;
                            $_SESSION['userid'] = $userid;
                            $_SESSION['firstName'] = $userFirstNname;
                            $_SESSION['lastName'] = $userLastName;
                            $_SESSION['userType'] = $userType;
                            // now encrypt the password
                            $userPassword =  md5($userid . $password);
                            // we update the last logged in date within the database.
                            $SQL_stmt = "UPDATE users SET userLastLoginDate = NOW(), userPassword = '$userPassword' WHERE userID = '$userid'";
                            $stmt = $DBconnection->prepare($SQL_stmt);
                            $stmt -> execute();
                            echo "<p>login date updated</p>"; // for test purposes.
                            // now transfere to the appropriate users logged in area.
                            echo " start Step 2.1.1.6..<br>"; // for testing purposes
                            //Return the user to the login page so they can login with the new password
                            header("Location: ../index.html? activity=register_complete");
                            echo " start Step 2.1.1.8..<br>"; // for testing purposes
                        }else{
                            echo "<p>User details are invalid</p>";
                            // Return to login screen
                            header("Location: ../index.html? activity=register_wrong_details_error");
                        }
                    }else{
                        echo "<p>you are not registered as an active student for busrsary requests</p>";
                        // return the user back to the login screen
                        header("Location: ../index.html? activity=register_not_active_error");
                    }
                }else{
                    echo "<p>you are already registered on the busrsary request system</p>";
                    // return the user back to the login screen
                    header("Location: ../index.html? activity=register_already_registered_error");
                }
            }else{
                // userid is not valid
                echo 'Incorrect user ID!';
                $fmsga = "User does not exist";
                $fmsgb = "Invalid Login Credentials.";
                echo " Step 2.2. $userid, $fmsga , $fmsgb..."; // for testing purposes
                header("Location: ../index.html? activity=register_id_error");
            }

            
            // action $SQL_stmt;
        }// credentials left out, do nothing
        
    }

    //echo '<input type="button" value="back to previous page" onclick="window.history.back();"/>'
?>