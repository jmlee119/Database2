create or replace trigger fox_studio 
instead of insert or update on fox_studio -- 뷰를 대상으로만 사용가능
for each row
declare
    chk     integer;
begin
    select count(*) into chk from Movie
    where title = :new.title and year = :new.year;
    if chk = 0 then
        insert into movie(title,year,studioname) values(:new.title, :new.year,'fox');
    else 
        update movie
        set studioname = 'fox'
        where title = :new.title and year = :new.year;
    end if;
    
    
    
end;
