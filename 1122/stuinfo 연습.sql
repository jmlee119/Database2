create or replace trigger studioinfo
instead of insert or update on studioinfo
for each row
declare
    p_no movieexec.certno%type;
    chk integer;
begin
    select count(*) into chk from studio
        where name = :new.name;
    if chk = 0 then
        insert into studio(name) values (:new.name);
    end if;
    select count(*) into chk from movieexec
        where name = :new.boss;
    if chk = 0 then
        insert into movieexec(name) values (:new.boss);
    end if;
    
    select certno into p_no from movieexec
        where name = :new.boss;
    update studio
    set presno = p_no
    where name = :new.name;
    -- 서로 조인 해주는 문장
    
end;


  CREATE OR REPLACE  VIEW StudioInfo (name,boss) AS 
  SELECT  s.name, b.name
  FROM studio s, movieexec b
  WHERE presno = certno;