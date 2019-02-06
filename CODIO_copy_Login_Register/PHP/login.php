<?php
    //Start the Session
    // file name: login.php
    // author: Mike Wright
    // date created: 01/02/2019
    echo "<p> start Step 1.0..</p>"; // for testing purposes
    echo "<p>logging in....</p>"; // for testing purposes
    //session_start();

    // Ensures the DB is connected too
    echo "<p> start Step 1.1..</p>"; // for testing purposes
    //require 'connect.php';
    require_once 'connect.php';//creates a connection to the database

    echo " start Step 2.1.1..<br>"; // for testing purposes
    if (isset($_POST['userid']) and isset($_POST['password'])){
        echo " start Step 2.1.1.1..<br>"; // for testing purposes

        if(isset($_POST) & !empty($_POST)){
            //  If the form is submitted assign variables for userid and password
            $userid = $_POST['userid'];
            $pword_A = $_POST['password'];
            $pword_merged = $userid . $pword_A;
            $password = md5($userid . $pword_A);
            //echo "User pre-password encrypt merged :'$pword_merged', encrypted: '$password'";// for testing purposes
            $SQL_stmt = "SELECT userID, userPassword, userFirstName, userLastName, userType, userActive FROM users WHERE userID = '" . $userid . "'";   
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

                if ($userPassword != NULL) {
                    // now ensure the user is an active user within the course
                    echo " start Step 2.1.1.4..<br>"; // for testing purposes
                    if ($userActive == 1){
                        // ensure that the users password is valid
                        echo " start Step 2.1.1.5..<br>"; // for testing purposes
                        if ($userPassword == $password){
                            // Verification success! User has loggedin!
                            // and create a sesssion store of user credentials
                            $_SESSION['loggedin'] = TRUE;
                            $_SESSION['userid'] = $userid;
                            $_SESSION['firstName'] = $userFirstName;
                            $_SESSION['lastName'] = $userLastName;
                            $_SESSION['userType'] = $userType;
                            // we update the last logged in date within the database.
                            $SQL_stmt = "UPDATE users SET userLastLoginDate = NOW() WHERE userID = '$userid'";
                            $stmt = $DBconnection->prepare($SQL_stmt);
                            $stmt -> execute();
                            echo "<p>login date updated</p>"; // for test purposes.
                            // now transfere to the appropriate users logged in area.
                            echo " start Step 2.1.1.6..<br>"; // for testing purposes
                            if ($userType == 'Staff'){
                                // connect to staff area
                                echo "<p>Welcome back to the " . $userType . " area of the Bursary Request system </p>";
                                //open the admin page. user information will be retrieved through session variable rather than the URL
                                header("Location: ../staff.php");
                            }
                            echo " start Step 2.1.1.7..<br>"; // for testing purposes
                            if ($userType == 'Student'){
                                // connect to Student area
                                echo "<p>Welcome back to the " . $userType . " area of the Bursary Request system </p>";
                                //open the admin page. user information will be retrieved through session variable rather than the URL
                                header("Location: ../student.php");
                            }
                            echo " start Step 2.1.1.8..<br>"; // for testing purposes
                            if ($userType == 'Admin'){
                                // connect to Admin area
                                echo "<p>Welcome back to the " . $userType . " area of the Bursary Request system </p>";
                                //open the admin page. user information will be retrieved through session variable rather than the URL
                                header("Location: ../admin.php");
                            }
                        }else{
                            echo "<p>password is invalid</p>";
                            // Return to login screen
                            header("Location: ../index.html? activity=login_password_error");
                        }
                    }else{
                        echo "<p>you are not registered as an active student for busrsary requests</p>";
                        // return the user back to the login screen
                        header("Location: ../index.html? activity=login_not_active_error");
                    }
                }else{
                    // userid is not valid
                    echo 'Incorrect user ID!';
                    $fmsga = ", or User does not exist, or password has not been set";
                    $fmsgb = "Invalid Login Credentials.";
                    echo " Step 2.2. $userid, $fmsga , $fmsgb..."; // for testing purposes
                    header("Location: ../index.html? activity=login_id_password_error");
                }
            }else{
                echo "No user details found";
                header("Location: ../index.html? activity=login_error");
            }

        }// credentials left out, do nothing

    }
    // only for once any javascripts have been writen for this purpose.
    //echo '<p>input type="button" value="back to previous page" onclick="window.history.back();"</p>';

?>