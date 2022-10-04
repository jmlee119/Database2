CREATE or replace FUNCTION get_length(tt movie.title%type, yy movie.year%type) 
RETURN float
is
    ret_len float;
begin
    select length into ret_len
    from movie
    where title = tt and year = yy;
    ret_len := round(ret_len/60.3);
    return ret_len;
end;