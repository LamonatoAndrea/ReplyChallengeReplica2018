<?php
  $dom = new DOMDocument(); 
  $dom->loadXML($_POST['xml'], LIBXML_NOENT | LIBXML_DTDLOAD); 
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
               <body >

              <!--  <form action = "level3Test.php" method = "GET">
                 <p ><h3 color="red">Check String Length</h3></p>
                 <textarea class="input" name="xml" cols="44" rows="30"></textarea>
                 <p><input type = 'submit' value = 'Check'/></p>
              </form> -->
                  <form action = "level3.php" method = "POST">
                     <p><h3>Write your text here</h3></p>
                     <textarea class="input" name="xml" cols="44" rows="30"></textarea>
                     <p><input type = 'submit' value = 'Check'/></p>
                  </form>
               </body>
            </html>
            