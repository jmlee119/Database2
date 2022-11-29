create or replace trigger MovieProd
instead of insert on MovieProd
for each row
declare
    p_no movieexec.certno%type;
    chk integer;
begin   
     select count(*) into chk from movie
     where title = :new.title and year = :new.year;
     if chk =0 then
        insert into movie(title,year) values (:new.title ,:new.year);
     end if;

     select count (*) into chk from movieExec
     where name = :new.producer;
     if chk =0 then
        insert into movieExec(name) values (:new.producer);
     end if;
    
     select certno into p_no from movieexec where name = :new.producer;
     update movie
     set producerno = p_no
    where title = :new.title and year = :new.year;
end;  



