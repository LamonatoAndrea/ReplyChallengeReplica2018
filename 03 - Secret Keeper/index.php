<?php
  $servername = "localhost";
  $mysqlPort = 3306;
  $dbUser = "web400";
  $dbUserPsw = "password";
  $dbName = "web400";
  $dockerImg = "mysql";
  $rootPsw = "password";
?>
<html>
  <head>
    <title>Secret Keeper 2.0</title>
    <link rel="stylesheet" type="text/css" href="/static/styles.css" />
  </head>
  <body>
    <center>
      <h1>Secret Keeper 2.0</h1>
      <br>
      <br>
      <br>
      <br>

<?php
function printLogin() {
  ?>
    <form method="POST">
      <!--<label for="user">Username</label>-->
      <input id="user" type="text" name="username" placeholder="Username" />
      <br/>
      <!--<label for="psw">Password</label>-->
      <input id="psw" type="password" name="password" placeholder="Password" />
      <br/>
      <input type="submit" value="Login"/>
    </form>
  <?php
}

function printCredentialError() {
  ?>
    <h3 class="error">Invalid credentials</h2>
  <?php
}

function printAttackError() {
 ?>
    <h3 class="error">Nice try, but it won&#39;t be so easy! You have to go deeper :)</h2>
 <?php 
}

$removeChars = array("/", "\\", "-", "*", " ");
$inputs = str_replace($removeChars, "", strtolower($_POST['username'] . $_POST['password']));

if (strpos($inputs, 'information_schema') !== false || 
    strpos($inputs, 'mysql')              !== false || 
    strpos($inputs, 'performance_schema') !== false || 
    strpos($inputs, 'sys')                !== false ||
    strpos($inputs, 'sleep')              !== false ||
    strpos($inputs, 'benchmark')          !== false ||
    strpos($inputs, 'if')                 !== false ||
    strpos($inputs, 'file')               !== false ||
    strpos($inputs, 'concat')             !== false) {
  printLogin();
  printAttackError();
} elseif (isset($_POST['username']) || isset($_POST['username'])) {
  $mysqli = new mysqli($servername . ":" . $mysqlPort, $dbUser, $dbUserPsw, $dbName);

  $query = "SELECT user, date, secret FROM S3cr3t_Us3rs WHERE user = '" . $_POST['username'] . "' AND psw = '" . $_POST['password'] . "'";

  $num_of_res = 0;
  if ($mysqli->multi_query($query)) {
      do {
          if ($result = $mysqli->store_result()) {
              echo "<h2>Welcome</h2><table>";
              $first = true;
              while ($row = $result->fetch_assoc()) {
                $num_of_res += 1;
                $keys = array_keys($row);
                if ($first) {
                  echo "<thead><th>" . $keys[0] . "</th><th>" . $keys[1] . "</th><th>" . $keys[2] . "</th></thead>";
                  $first = false;
                }
                echo "<tr><td>" . $row[$keys[0]] . "</td><td>" . $row[$keys[1]] . "</td><td>" . $row[$keys[2]] . "</td></tr>";
              }
              $result->free();
          }
      } while ($mysqli->next_result());
      echo "</table>";
  }

  if ($num_of_res === 0) {
    printLogin();
    printCredentialError();
  }
 } else {
  printLogin();
 }

?>



    </center>
  </body>
</html>