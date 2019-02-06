<?php
  // $DBServer = 'localhost';
  echo "<p>Starting Connecting to database.</p>"; // for testing purposes
  //$DB_Host = 'smile-size.codio.io[:1024-9999]';
  $DB_Host = 'localhost';
  $DB_User = 'WEBAuth'; //'root';
  $DB_Pass = 'WEBAuthPW';
  $DB_Name = 'bursary_database';
  // now start connection to DB, catting any errors
  try{
    $DBconnection = new PDO("mysql:host=$DB_Host; dbname=$DB_Name" , $DB_User, $DB_Pass);
    $DBconnection -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "<p>Database connection established and open</p>";
  }catch(PDOException $ex){
    echo "Exception error: " . $ex->getMessage();// for testing ourposes.
    die($ex->getMessage());
  }
?>