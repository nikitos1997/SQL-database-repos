<?php
// file name: logout.php
// author: Mike Wright
// date created: 27/01/2019
session_start();
session_unset();
session_destroy();
# mysqli_close ($connection); // won't need this as going to be pdo and pdo disconnects at page shut
# header('Location: ../index.html');
redirect('Location: ../index.html');

?>