insert into movie(length, incolor,producerNo) values(100,t,null);
insert into movie(length) values(null);
select * from movie;
insert into movieprod values('star wars',1977,'sharky');

insert into movie(producerno) values(null);


select studioname,count(*) cnt from movie where (studioname,count(*)) in
(select studioname,count(studioname) from movie group by studioname) order by 2;

select studioname,count(*) from movie group by studioname;


with z as (select count(studioname), studioname from movie group by studioname order by 1)
select * from z;


-- 이건 가장 적은 영화수가 1로 동일한 영화사 모두 뽑음 
with temp_tab as (
    select studioname, count(*) as movie_cnt
    from movie
    group by studioname
)
, min_movie as (
    select min(movie_cnt) as min_cnt 
    from temp_tab
) 
select *
from temp_tab a
join min_movie b
on a.movie_cnt = b.min_cnt;

-- 이건 rank를 계산해서 같은 1이더라도 하나만 뽀ㅃ게되어있고. 
select studioname
from (
        select  row_number() over (order by movie_cnt)  rk, z.*
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z
      ) x 
where 1=1
  and x.rk = 1
  ;

select * 
from (
        select  row_number() over (order by movie_cnt)  rk, z.*
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z
      ) x 
where 1=1
  and x.rk = 1
  ;

-- order by dbms_random.value
-- rank 함수 사용  -- 갯수가 1편인 모두 다나옴 
select * 
from (
        select  rank() over (order by movie_cnt)  rk, z.*
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z
      ) x 
where 1=1
  and x.rk = 1
  ;
  
  -- rank 함수 사용  -- dbms_random.value 사용하여 랜덤하게 같은 갯수일떄 하나의 영화사만 뽑음 
select studioname into stu
from (
        select  rank() over (order by movie_cnt, dbms_random.value)  rk, z.* ,  dbms_random.value as random_rk
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z       
      ) x 
where 1=1
  and x.rk = 1;
  
select networh from movieexec where certno in
(select presno from studio where name = stu);

insert into movieprod values('qfasdasd',2000,'asdwzxcaw');
select * from movieprod;
select * from movie;
select * from movieexec;


--김도균

with studio_cnt as (
    select studioname, count(*) as movie_cnt
    from movie
    group by studioname
)
, min_movie as (
    select min(movie_cnt) as min_cnt 
    from studio_cnt
)
select * from(
select s.*,rownum r
from studio_cnt s,min_movie m
where s.movie_cnt = m.min_cnt
order by dbms_random.value) where r<2;

select min(count(*)) from movie group by studioname;
select studioname,count(*) from movie group by studioname;

        
select name , count(producerno) from movie, movieExec
where producerNo = certno group by producerno, name;

select *
        from ( select  row_number() over (order by prod_cnt desc)  rk, z.*
        from ( select name ,count(producerno) as prod_cnt
        from movie, movieExec group by producerno, name ) z ) x 
        where 1=1 and x.rk = 1 ;

select *
from (
        select  rank() over (order by movie_cnt, dbms_random.value)  rk, z.* ,  dbms_random.value as random_rk
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z       
      ) x 
where 1=1
  and x.rk = 1;


select name into na 
        from ( select  row_number() over (order by prod_cnt desc)  rk, z.*
        from ( select name ,count(producerno) as prod_cnt
        from movie, movieExec group by producerno, name ) z ) x 
        where 1=1 and x.rk = 1 ;

select certno from movieexec 
where name = na;






select gender from moviestar where birthdate in (
 select  max(birthdate) from moviestar);


select producerno into :new.producerNo
        from ( select  row_number() over (order by prod_cnt desc)  rk, z.*
        from ( select name ,count(producerno) as prod_cnt
        from movie, movieExec group by producerno, name ) z ) x 
        where 1=1 and x.rk = 1 ;
        
select studioname into stu
from (
        select  rank() over (order by movie_cnt, dbms_random.value)  rk, z.* ,  dbms_random.value as random_rk
        from (
                select studioname
                      ,count(*) as movie_cnt
                  from movie
                 group by studioname 
              ) z       
      ) x 
where 1=1
  and x.rk = 1;
  
  
 insert into movie(title,year,length,incolor,studioname,producerno) values ('X5',2022,null,'f','fox',1);
insert into movie(title,year,length,incolor,studioname,producerno) values ('X2',2022,104,null,'fox',1);
insert into movie(title,year,length,incolor,studioname,producerno) values ('X3',2022,104,'f',null,1);
insert into movie(title,year,length,incolor,studioname,producerno) values ('X4',2022,104,'f','fox',null);

select * from movie;

  Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T1','busan',null,1004);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values (null,'busan',50,1004);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T2',null,51,1004);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T3','busan',52,null);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T4','busan',53,null);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T5','busan',54,null);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T6','busan',55,null);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values ('T7','busan',null,null);
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH) values (null,null,null,null);


select * from movieExec;

 insert into StarPlays(title, year,name) values ('X01',2022,'meryl streep');
insert into StarPlays(title, year,name) values ('X02',2022,'Lin');
insert into StarPlays(title, year,name) values ('X03',2022,'meryl streep');

select * from starplays;

select trunc(dbms_random.value(1,10000)) from dual;


select title, year, length , p.name, boss.name from movie, studio s , movieexec p , movieexec boss
where producerno =p.certno and boss.certno = presno and studioname = s.name order by year, length;

select * from movieExec
where name = 'sharky';
select starname from starsin where movietitle = 'star wars' and movieyear = 1977;
select count(*) from starsIn,movie where movietitle =tittle and movieYear= year; 


select studioname, count(studioname) from movie
group by studioname;

select title, starname from starsIn, movie where movietitle = title and movieYear= year
order by year;