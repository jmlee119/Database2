CREATE or replace procedure get_length_p 
    (tt in movie.title%type, yy in movie.year%type, len in out float, sname out movie.studioname%type) 
is
    
begin
    select studioname, length into sname,len
    from movie
    where title = tt and year = yy;
    len := round(len/60,3);
end;