

select * from C##SZAMT4.CUSTOMER;

select * from C##SZAMT4.ORDERTABLE;

select * from C##SZAMT4.WAREHOUSE;

select * from C##SZAMT4.ARTICLE;

select * from C##SZAMT4.SUBCATEGORY;

select * FROM C##SZAMT4.CATEGORY;

/
-- TOP 5 Article listazasa subcategory alapjan amelyekbol van meg raktaron

create type StringArray1 IS table of varchar2(3000);

create or replace function top5articles(
    psubcatid number
) return StringArray1
is
    articles StringArray1;
begin
    select name
    bulk collect into articles
    from (select name, coalesce(sumquantity, 0) as sumquantity
          from C##SZAMT4.ARTICLE
                   full join (select ARTICLEID, sum(QUANTITY) as sumquantity
                              from C##SZAMT4.ORDERTABLE
                              group by ARTICLEID)
                             on ARTICLEID = id
          where SUBCATID = psubcatid
            and id not in (select ARTICLEID from C##SZAMT4.WAREHOUSE where QUANTITY = 0)
          order by sumquantity desc, PRICE
              fetch first 5 row only);

    return articles;
end top5articles;

/

select * from top5articles(6);

/
-- Rendeles megtervezese

create or replace function make_order(
    particleid number,
    pquantity number,
    poarticles out StringArray1
) return number
is
    vqt number;
begin

    select QUANTITY
    into vqt
    from C##SZAMT4.WAREHOUSE
    where ARTICLEID = pquantity;

    if vqt = 0 then

        select SUBCATID
        from C##SZAMT4.article
        where id = particleid;

        poarticles := top5articles();
        return -1;

    end if;


    return 0;
end make_order;
/

select SUBCATID
from C##SZAMT4.article
where id = particleid;

/

