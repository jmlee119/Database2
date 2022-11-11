insert into people values('경성대','2000-09-15',phone_tab(),addr_tab());
insert into people values('홍길동','2000-09-15',
    phone_tab(
        phone_ty('mobile',1,'010-1234-1234'),
        phone_ty('home',2,'051-234-1234')
        ),
    addr_tab(
        addr_ty('부산시','남구','대연3동')
    )
);
insert into table(select phone_list from people where name = '경성대') values(
    phone_ty('mobile',1,'010-6877-8442')
);
-- 이름이 경성대인 사람의 폰 추가
insert into table(select addresses from people where name = '경성대') values(
    addr_ty('부산시','남구','대연3동')
);
-- 이름이 경성대인 사람의 주소 추가

select p.name , ph.no, ph.name
from people p, table(p.phone_list) ph 
;

select p.name , ph.no, ph.name , ad.city, ad.gu,ad.dong
from people p, table(p.phone_list) ph , table(p.addresses) ad
;

select * from star_info;