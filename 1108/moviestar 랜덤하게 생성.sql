declare
    ins_q   varchar2(200) := 'insert into moviestar values(:1,:2,:3,:4)';
    gender  varchar2(10);
    function get_addr return varchar2 -- 함수는 맨 마지막에 넣어야함
    is
        type a_ty is table of varchar2(100);
        city a_ty := a_ty('부산시','서울시','거제시','대전시','울산시'); 
        gu a_ty := a_ty('남구','북구','서구','중구','동구','해운대구');
        dong a_ty := a_ty('대연동','용호동','좌동','우동','대방동','대장동');
    begin
        return city(dbms_random.value(1,city.count))||' '||
                gu(dbms_random.value(1,gu.count))||' '||
                dong(dbms_random.value(1,dong.count));
    end;
begin
    for i in 1..5 loop
        if dbms_random.value(1,2) = 1 then
            gender := 'female';
        else 
            gender := 'male';
        end if;
        -- gender random 하게 생성
        execute immediate ins_q using '홍길동'||i, get_addr, gender, sysdate;
    end loop;
end;