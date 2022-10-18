declare
    type m_ty is record(
        tt movie.title%type,
        yy movie.year%type,
        len movie.length%type,
        pname movieexec.name%type,
        bname movieexec.name%type
    );
    type mvs_ty is table of m_ty index by varchar2(100); -- assosiative array 선언
    i varchar(100);
    movs mvs_ty; -- assosiative array 를 위한 변수
    cursor m_cur is select title tt,year yy,length len,p.name pname,boss.name bname  
                    from movie,movieexec p,studio s,movieexec boss
                    where producerNo = p.certNo and studioname = s.name 
                            and presno = boss.certno; 
begin
    for m in m_cur loop
        movs(m.tt||m.yy) := m;
    end loop;
    i := movs.first;
    while i is not null loop
        dbms_output.put_line(movs(i).tt||'('||movs(i).yy||') 상영시간: '||movs(i).len||
        ', 제작자: '||movs(i).pname||', 사장: '||movs(i).bname);
        i := movs.next(i);
    end loop;
end;