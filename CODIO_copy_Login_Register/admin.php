<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Student Sample</title>
		<style>
		/*body {
		padding-top: 20px;
		padding-bottom: 30px;
		background-color: #ededed;
		}*/
		
		.form-login {
			max-width: 300px;
			margin: 0 auto;
			font-family: Tahoma, Geneva, sans-serif;
		}
		.form-login h1 {
			text-align: center;
			color: #ffffff;
			font-size: 24px;
			background-color: #0097c5;
			border: 0;
			box-sizing: border-box;
			padding: 20px 0 20px 0;
		}

		.form-login input[type="email"],
		.form-login input[type="text"],
		.form-login input[type="password"] {
			width: 100%;
			padding: 15px;
			border: 1px solid #dddddd;
			margin-bottom: 15px;
			box-sizing:border-box;
		}
		.form-login input[type="submit"] {
			width: 100%;
			padding: 15px;
			background-color: #535b63;
			border: 0;
			box-sizing: border-box;
			cursor: pointer;
			font-weight: bold;
			color: #ffffff;
		}
		.form-login link[type="link_button"] {
			/*width: 100%;
			padding: 15px;*/
			text-align: center;
			background-color: #535b63;
			border: 0;
			box-sizing: border-box;
			cursor: pointer;
			font-weight: bold;
			color: #ffffff;
		}
		.form-login .form-login-heading,
		.form-login .checkbox {
			text-align: center;
			/*position: relative;*/
			color: #4d4d4d;
			font-size: 24px;
			margin-bottom: 10px;
		}
		</style>
	</head>
	<body>
		<div class="form-login">
			<?php
				// script which gets the studentName
				//$userName = $_GET['userName'];
                $userid = $_GET['userID'];
                // write sequence to query the Students table to get the student name, if it is not done in the first script..
                echo '<h1>Welcome ' . $userid . ' to the Admin area of the Bursary Request System</h1>';
			?>
				  <form class="form-login" method="POST">
					<h2 class="form-login-heading">Welcome</h2>
					<div class="input-group">
            <!-- <input type="text" name="email" placeholder="Email" required> -->
				  	<!-- <input type="text" name="username" placeholder="Username" required> -->
				</div>
					<!-- <input type="password" name="password" id="inputPassword" placeholder="Password" required> -->
					<!-- <input type="submit" name="Login" value="Register"> -->
          <!-- requires an action= "" to send the variable data and post the data back to the server -->
					<!-- <a class="link_button" type="Register" href="register.php">Register</a> -->
				  </form>
      <?php
      // authentication and passing of data to the database needs to be carried out here.
      ?>
		</div>
	</body>
</html>