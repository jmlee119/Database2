declare
    tname user_tables.table_name%type := 'movie';
    cursor csr(t user_tables.table_name%type)is select * from user_tables 
        where table_name like '%'||t||'%';    
begin
    for t in csr(tname) loop
        execute immediate 'drop table '||t.table_name||' cascade constraints';
        dbms_output.put_line(t.table_name||' dropped !!');
    end loop;

end;
