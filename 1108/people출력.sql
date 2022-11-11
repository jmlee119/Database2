declare
    cursor csr is select * from people; 
    phones people.phone_list%type;
    addrs  people.addresses%type;
begin
    for p in csr loop
        dbms_output.put_line(p.name||', 생일: '||p.birthdate);
        phones := p.phone_list;
        if phones.count> 0 then
            for i in phones.first..phones.last loop
                dbms_output.put_line
                    ('    -'||phones(i).name||': '||phones(i).no);
            end loop;
        end if;
        addrs := p.addresses;
        if addrs.count >0 then
            for i in addrs.first..addrs.last loop
                dbms_output.put_line
                    ('    #'||addrs(i).city||': '||addrs(i).gu);
            end loop;
        end if;
    end loop;
end;