create or replace trigger MovieExec 
before insert on movieexec 
for each row
declare
    cnt     integer;
    chk     integer;
    -- pragma autonomous_transaction;
  
begin
     select count(*) into chk from movieexec where certno = :new.certno;
    if chk = 1 or :new.certno is null then
        select max(certno) into cnt from movieExec;
        :new.certno := cnt +1; -- certno 의 unique 하게 max +1 값을 넣음
    end if;


    if :new.name is null then
        select count(*) into cnt from movieExec;
        :new.name := 'TEMP_'||cnt;
    end if;
    if :new.address is null then
        select address into :new.address
            from (select address from movieExec order by dbms_random.value) where rownum =1;     
            --랜덤하게 주소를 뽑아서 주소를 넣음   
    end if;
    if :new.networth is null then
        select avg(networth) into :new.networth from movieexec;
        -- 평균 연봉을 뽑아서 넣음
    end if;
end;
