declare
   type  n_ty is table of varchar2(100) index by varchar2(10);
   num      n_ty;
   i varchar2(10);
   

begin
    num ('월') := 'Monday';
    num ('화') := 'Tuesday';
    num ('수') := 'Wednesday';
    num ('목') := 'Thursday';
    num ('금') := 'Friday';
    num ('토') := 'Saturday';
    num ('일') := 'Sunday';

    i  := num.first;
    while i is not null loop 
       dbms_output.put_line('['||i||']'||num(i));
        i := num.next(i);
    end loop;
    dbms_output.put_line(rpad('-' , 50,'-'));
    num.delete('수,토');
    
      i  := num.first;
    while i is not null loop 
       dbms_output.put_line('['||i||']'||num(i));
        i := num.next(i);
           end loop;
end;