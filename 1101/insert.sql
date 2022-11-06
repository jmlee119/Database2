declare
    q_str varchar2(250) := 'insert into movieexec values(:1,:2,:3,:4)';
    cno     movieexec.certno%type;
begin
    select max(certno) into cno from movieexec;
    for i in 1..10 loop
        cno := cno +1;
        execute immediate q_str using 'KIM_'||cno , '부산시 남구 대연 ' || cno||'동',
                                    cno, dbms_random.value(100000,100000000);
         
    
    end loop;

end;