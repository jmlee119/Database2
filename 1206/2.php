<?php
function p_error() {
    $e = oci_error();
    print htmlentities($e['message']);
    die();
}
function gcd(int $a,int $b){
    $c = $a*$b;
    return $c;
}
$conn = oci_connect("db2019575047","db68774842", "localhost/course");
if (!$conn) p_error();

$stmt = oci_parse($conn,
	"select name, address addr from movieexec order by name ");
if (!$stmt)    p_error();


if (!oci_execute($stmt)) p_error ();

print "<TABLE bgcolor=#F2F2F2 border=1 cellspacing=2>\n";
print "<TR class=header align=center><TH> 순번 <TH>  이름 <TH> 주소 <TH> 영화사 <TH>제작 영화 <TH> 출연 영화 </TR>\n";


$nrows = oci_fetch_all($stmt, $row,null,null,OCI_FETCHSTATEMENT_BY_ROW);
if($nrows >0) {
    
   for($i=0; $i<$nrows; $i++) {

        $newi = $i+1;
        $name = $row[$i]['NAME'];
        $na_stmt = oci_parse($conn, "select name sname from studio where presno in (select certno from movieexec where name = '$name' ) ");
        if (!$na_stmt)    p_error();
        if (!oci_execute($na_stmt)) p_error ();
        $mv_stmt = oci_parse($conn, "select title tt ,year yy from movie where producerno in (select certno from movieexec where name='$name') order by yy ");
        if (!$mv_stmt)   p_error();
        if(!oci_execute($mv_stmt)) p_error();
        $movies = oci_parse($conn, "select movietitle mvtt ,movieyear mvyy from starsin where starname = '$name' order by mvyy ");
        if (!$movies)   p_error();
        if(!oci_execute($movies)) p_error();
        
        $na_cnt = oci_fetch_all($na_stmt, $mv_rows, null,null,OCI_FETCHSTATEMENT_BY_ROW);
        $mv_cnt = oci_fetch_all($mv_stmt,$mv_rows2 , null,null,OCI_FETCHSTATEMENT_BY_ROW);
        $movies_cnt = oci_fetch_all($movies, $movies_row, null,null,OCI_FETCHSTATEMENT_BY_ROW);
     
        print "<TR> <TD class=number> $newi <TD> $name <TD> {$row[$i]['ADDR']} ";    
        
         if($na_cnt==0) print "<td class=no> 없음";
        else {
             print "<TD> <TABLE align=center>\n";
              for($j=0;$j<$na_cnt;$j++){
                if ($j!=$na_cnt-1) {
                    print "<tr> <td> {$mv_rows[$j]['SNAME']}  </tr>" ;
                }
                else {
                    print "<tr> <td> {$mv_rows[$j]['SNAME']}  </tr>" ;
                }
            } print "</TABLE>";
        }
        
        if ($mv_cnt == 0) print "<td class=no> 없음";
        else{
            print "<TD> <TABLE align=center>\n";
            for($x=0;$x<$mv_cnt;$x++){           
                if ($x!=$mv_cnt-1){
                       print "<tr> <td> {$mv_rows2[$x]['TT']}<span>({$mv_rows2[$x]['YY']})</span> </tr>" ;
                }
                else {
                    print "<tr> <td> {$mv_rows2[$x]['TT']}<span>({$mv_rows2[$x]['YY']})</span> </tr>" ;
                }
            }
            print "</TABLE>";
        } 
        if ($movies_cnt == 0) print "<td class=no> 없음";
        else{
            print "<TD> <TABLE align=center>\n";
            for($z=0; $z<$movies_cnt; $z++){
                if ($z!=$movies_cnt-1){
                    print "<tr> <td> {$movies_row[$z]['MVTT']}<span>({$movies_row[$z]['MVYY']})</span> </tr>" ;
                }
                else {
                    print "<tr> <td> {$movies_row[$z]['MVTT']}<span>({$movies_row[$z]['MVYY']})</span> </tr>" ;
                }
            }
            print "</TABLE>";
        print "</tr> \n";
        }
    }
  }




print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>

<style>
    .header {
        background-color: lightgreen;
        color:white;   
    }
    .number {
        background-color: blue;
        color:white;
    }
    .no {
        color: red;
    }
    table,td,th,tr {
        text-align: center;
    }
    span{
        color:pink;
    }
  
</style>