create or replace trigger movie
before insert on movie
for each row
declare
    cnt integer;
    chk integer;
begin
    if :new.length is null then
        select avg(length) into :new.length from movie;
    end if;
    if :new.producerno is null then
        :new.producerno := 1;
    else
        select count(*) into chk from movieexec where certno = :new.producerno;
        if chk = 0 then
            insert into movieexec(certno) values (:new.producerno);
            -- 트리거 안에 트리거를 이용
        end if;
    end if;
    if :new.studioname is null then
        :new.studioname := 'fox';
    else
        select count(*) into chk from studio where name = :new.studioname;
        if chk = 0 then
            insert into studio(name) values (:new.studioname);
        end if;
        -- 영화 제작자를 넣기 위해 certno 중 제작ㅈ자가 아닌 번호를 뽑아서 movie 에 넣음
    end if;
end;