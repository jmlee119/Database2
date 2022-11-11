declare
    cursor st_csr is select * from moviestar;
    cursor m_csr(n moviestar.name%type) is 
        select movietitle tt, movieyear yy from starsin where starname = n;  
    cursor p_csr(n moviestar.name%type) is
        select title tt, year yy from movie, movieexec 
        where producerno = certno and name = n; 
    ins_st    varchar2(200) := 'insert into star_info values (:1,:2,:3,
        smov_tab(), pmov_tab())';
    ins_smov varchar2(200) :='insert into 
        table(select s_movies from star_info where name = :1) 
        values(smov_ty(:2,:3,:4)) ';  
    ins_pmov varchar2(200) :='insert into 
        table(select p_movies from star_info where name = :1) 
        values(pmov_ty(:2,:3,:4)) ';  
    
begin
    for st in st_csr loop
        execute immediate ins_st using st.name, st.address, st.gender;
        for m in m_csr(st.name) loop
            execute immediate ins_smov using st.name, m.tt, m.yy,3;
        end loop;
        for m in m_csr(st.name) loop
            execute immediate ins_pmov using st.name, m.tt, m.yy,300000;
        end loop;
    end loop;
end;

