declare
    sname   moviestar.name%type := 'f';
    s       moviestar%rowtype;
    cnt     integer;
begin
    select count(*) into cnt
    from moviestar
    where name like '%'||s.name||'%';
    if cnt >1 then
        update moviestar
        set address= '['||address||']'
        where name like '%'||sname||'%';
        DBMS_OUTPUT.PUT_LINE(sql%rowcount||'개의 moviestar 튜플들이 변경 됨');
    else
        if SQL%found then -- 검색이 된다면 
        DBMS_OUTPUT.PUT_LINE(s.name || '('||s.gender||')');
        elsif sql%notfound then -- 검색 실패 한다면
        DBMS_OUTPUT.PUT_LINE(sname||'의 Moviestar 튜플 검색 실패!!'); -- 오류가남 데이터가 없다구 ,, 
    end if;
   
    end if;
exception
    when too_many_rows then --실제 인출은 요구된 것보다 많은 수의 행을 추출합니다 의 오류 처리
        DBMS_OUTPUT.PUT_LINE('여러 튜플들이 검색 됨');
    when no_data_found then -- 오류 데이터를 찾을수 없습니다 나올때
        DBMS_OUTPUT.PUT_LINE(sname||'의 Moviestar 튜플 검색 실패!!');
end;