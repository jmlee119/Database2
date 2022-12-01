create or replace trigger Studio 
before insert on Studio
for each row
declare
    cnt     integer;
    chk     integer;
    -- pragma autonomous_transaction;
  
begin
     select count(*) into chk from studio where name = :new.name;
    if chk = 1 or :new.name is null then
        select count(*) into cnt from studio;
        :new.name := 'TEMP_'||cnt; 
    end if;
    if :new.address is null then
        select address into :new.address
            from (select address from studio order by dbms_random.value) where rownum =1;     
            --랜덤하게 주소를 뽑아서 주소를 넣음   
    end if;
    if :new.presno is null then
       select certno into :new.presno 
       from (select certno from movieExec 
            where certno not in (select presno from studio)
            order by dbms_random.value)  where rownum=1;
       
       
       --moviewexec 에서 certno 를 뽑는데 사장이 아닌 사람의 번호를 받고싶음. 근데 랜덤으로
    end if;
end;