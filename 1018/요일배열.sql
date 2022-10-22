declare 
    type n_ty is varray(10) of varchar2(10);
    nums n_ty := n_ty ('하나', '둘','셋');
    
begin
    for i in nums.first..nums.last loop
        dbms_output.put_line ('[' || i || '] '||nums(i));
    end loop;
    dbms_output.put_line(rpad('-' , 50,'-'));
    nums.extend(3);
    nums(4) := '넷' ;
    nums(5) := '다섯';
    
    for i in nums.first..nums.last loop
        dbms_output.put_line ('[' || i || '] '||nums(i));
    end loop;
    dbms_output.put_line(rpad('-' , 50,'-'));
    nums.trim(3);
     for i in nums.first..nums.last loop
        dbms_output.put_line ('[' || i || '] '||nums(i));
    end loop;
    dbms_output.put_line(rpad('-' , 50,'-'));
end;