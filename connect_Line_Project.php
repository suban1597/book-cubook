<?php
/**** function connection to database  for mssql ****/
$objConnect = mssql_connect("localhost","sa","Adminchul@book1") or die("Error Connect to Database");
$objDB = mssql_select_db("Line_Project");
?>
