<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    die(); //일종의 exit
}
$conn = oci_connect("db2019575047","db68774842", "localhost/course");
if (!$conn) p_error();
$where = "";
$title = $_GET['title'];
$title = str_replace("'", "''", $title);
$title= str_replace("%", "*%", $title);
if(!empty($title)) {
    if($title ) $where = " and '%$title%' like '%*%%' escape '*' ";
    $where = " and lower(title) like lower('%$title%') escape '*' ";
    
}
$minlength = $_GET['minlength'];
if(!empty($minlength)) $where = $where." and length > $minlength ";
$maxlength = $_GET['maxlength'];
if(!empty($maxlength)) $where = $where." and length < $maxlength ";

$birthdate = $_GET['birthdate'];
if(!empty($birthdate)) $birthdate = date('Y/m/d', strtotime("$birthdate-01-01"));
if(!empty($birthdate)) $where = $where." and (title,year) in (select movietitle,movieyear from starsin,moviestar where starname = name and birthdate> '$birthdate') ";

$gender = $_GET['gender'];
if(!empty($gender)) $where = $where."  and (title,year) in (select movietitle,movieyear from starsin,moviestar where starname = name and gender ='$gender' ) ";

$stmt = oci_parse($conn,
   "select title tt , year yy  , ex.name  exname, s.name sname , s.address sadd from movie, movieexec ex ,studio s  ".
        " where certno = producerNo and studioname = s.name ".$where);
if (!$stmt)    p_error();
if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 영화제목 <TH> 제작자 이름 <TH> 영화사 이름 <TH> 영화사 주소 </TR>\n";

$nrows = oci_fetch_all($stmt, $row);
if($nrows > 0) {
    for($i=0;$i<$nrows;$i++) {
        print "<TR> <TD> {$row['TT'][$i]}({$row['YY'][$i]}) <TD> {$row['EXNAME'][$i]} <TD>{$row['SNAME'][$i]} <TD>{$row['SADD'][$i]}  </tr> \n";
    }
}else {
    print "<td colspan=3>No Data Found";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>