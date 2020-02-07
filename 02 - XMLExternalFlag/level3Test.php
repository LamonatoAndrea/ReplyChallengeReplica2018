<?php
  $flagDir = __DIR__ . "/door/";
  $binDir = __DIR__ . "/bin/";
?>

            <html>
        <style>
        body {
            display: block;
            margin-left: auto;
            margin-right: auto;
            background-color: black;
            color: green;
            text-align: center;

        }
        </style>
               <body>

                <?php
                  if (isset($_GET['xml'])) {
                    $xml = str_split($_GET['xml']);
                    $sanitized = "";
                    $replaced = False;
                    for ($i = 0; $i < sizeof($xml); $i ++) {
                      if (preg_match('/([^a-zA-Z0-9;])/', $xml[$i])) {
                        $sanitized = $sanitized . "\\" . $xml[$i];
                        $replaced = True;
                      } else {
                        $sanitized = $sanitized . $xml[$i];
                      }
                    }

                    $result = shell_exec("cd $flagDir && export PATH='$binDir' && rbash -c 'expr length $sanitized' 2>&1");

                    echo "Result: <br>" . $result . "<br>";
                  }
                ?>

              <form action = "level3Test.php" method = "GET">
                 <p><h3>String Length</h3></p>
                 <textarea class="input" name="xml" cols="44" rows="2"></textarea>
                 <p><input type = 'submit' value = 'Calculate'/></p>
              </form>
               </body>
            </html>
            