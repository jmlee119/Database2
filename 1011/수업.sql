accept Movie_title prompt '영화 제목은?'
accept Movie_year prompt '개봉 년도는?'

declare
    std studio.name%type;
    len movie.length%type := 100;
    cnt integer; -- number(3);
    tt movie.title%type := '&Movie_title';
    yy movie.year%type := &Movie_year;
begin
    /*
    select length into len
    from movie
    where title = tt and year = yy; -- &키보드 입력, 한번만 나와야함
    */
    -- len := get_length(tt,yy); -- get_length 함수 호출
    get_movieinfo(tt,yy,len,std,cnt);
    if len >= 0 then
        dbms_output.put_line(tt||'('||yy||'년 개봉) 상영시간 : '||len||' 제작사 : '||std||', 출연배우 수 :'||cnt);
    else
        dbms_output.put_line(tt||'('||yy||'년 개봉) 검색실패 !!! '||len);
    end if;
    
exception
    when others then
        dbms_output.put_line(tt||'('||yy||'년 개봉) 검색실패 !!! '||len); -- 검색 실패하면 exception 문을 쓴다.
end;