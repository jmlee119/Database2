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
if(!empty($title)) $where = 
        " and title like '%$title%' ";
$year = $_GET['year'];
if(!empty($year)) $where = $where." and year > $year ";
$incolor = $_GET['incolor'];
if(!empty($incolor)) $where = $where." and incolor='$incolor' ";
$stmt = oci_parse($conn,
   "select title tt,year yy,studioname sname,name pname from movie,movieexec where producerno = certno ".
        $where." order by 3 desc, 1 ");
if (!$stmt)    p_error();
if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 영화제목 <TH> 영화사 <TH> 제작자 </TR>\n";

$nrows = oci_fetch_all($stmt, $row);
if($nrows > 0) {
    for($i=0;$i<$nrows;$i++) {
        print "<TR> <TD> {$row['TT'][$i]}({$row['YY'][$i]}) <TD> {$row['SNAME'][$i]} <TD>{$row['PNAME'][$i]} </tr> \n";
    }
}else {
    print "<td colspan=3>No Data Found";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>