<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    die();
}
$conn = oci_connect("db2019575047","db68774842", "localhost/course");
if (!$conn) p_error();
$birth = date('Y/m/d', strtotime('1930-01-01'));
$where = " where birthdate > :birth ";

$stmt = oci_parse($conn,
	"select name, address addr, gender, to_char(birthdate,'YYYY-MM-DD') birth from moviestar  ".
         $where." order by 3 desc, 1 ");
if (!$stmt)    p_error();
oci_bind_by_name($stmt, ":birth", $birth);// excute 전에 해야함
if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH bgcolor:red> 이름 <TH> 주소 <TH> 출연영화 <TH>생년월일 </TR>\n";


$nrows = oci_fetch_all($stmt, $row,null,null,OCI_FETCHSTATEMENT_BY_ROW);
if($nrows >0) {
   for($i=0; $i<$nrows; $i++) {
        $name = $row[$i]['NAME'];
        $birth = date('Y-n-j', strtotime( $row[$i]['BIRTH']));
        $b = explode("-", $birth) ; //- 기준으로 split
        if (!strcasecmp($row['GENDER'], "female"))$gender ="여" ;    
        else $gender ="남";
        

        $mvs_stmt = oci_parse($conn, "select movietitle tt , movieyear yy from starsin where starname ='$name' order by 1,2  ");
        if (!$mvs_stmt)    p_error();
        if (!oci_execute($mvs_stmt)) p_error ();
        $mv_cnt = oci_fetch_all($mvs_stmt, $mv_rows, null,null,OCI_FETCHSTATEMENT_BY_ROW);

       for($j=0;$j<$mv_cnt;$j++){
            if($j == 0){
                print "<TR> <TD rowspan=$mv_cnt> $name($gender) <TD rowspan=$mv_cnt> {$row[$i]['ADDR']} ";
                
                print "<td> {$mv_rows[$j]['TT']}({$mv_rows[$j]['YY']})";
                print  "<TD rowspan=$mv_cnt> $b[0]년 $b[1]월 $b[2]일 ";
            }else{
                print "<tr> <td> {$mv_rows[$j]['TT']}({$mv_rows[$j]['YY']})";
            }
            print "</tr> \n";
        }
        print "</tr> \n";
    }
  }

else {
    print "<td colspan=3>No Data Found";
}
        



print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>