declare
    ins_p   varchar2(200) := 'insert into people values
         (:1 ,:2 ,phone_tab(),addr_tab())';
    ins_phone varchar2(200) := 'insert into 
    table(select phone_list from people where name = :1) values(
    phone_ty(:2,:3,:4)) ';
    ins_ad varchar2(200) := 'insert into table(select addresses from people where name = :1) 
    values (addr_ty(:2,:3,:4)) ';

begin
    for i in 1..5 loop
        execute immediate ins_p using '홍길동'||i, '2020-01-01';
        for j in 1..3 loop
            execute immediate ins_phone 
                using '홍길동'||i, 'mobile',j, '010-4577-4561';
        end loop;
        for j in 1..5 loop
            execute immediate ins_ad 
                using '홍길동'||i, '부산시','해운대구', '반여1동';
        end loop;
    end loop;
end;