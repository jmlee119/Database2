declare
    tname   varchar2(100) := 'TEST_';
    attrs   varchar2(500) := '
        name varchar2(50) primary key,
        address varchar2(200) not null,
        age number(3)';
        
begin
    for i in 1..20 loop
        execute immediate 'create table '||tname||i||'('||attrs||')';
    end loop;
end;