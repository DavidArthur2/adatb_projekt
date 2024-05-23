

select * from C##SZAMT4.CUSTOMER;

select * from C##SZAMT4.ORDERTABLE;

select * from C##SZAMT4.WAREHOUSE;

select * from C##SZAMT4.ARTICLE;

select * from C##SZAMT4.SUBCATEGORY;

select * FROM C##SZAMT4.CATEGORY;

/
-- MAIN
-- elvegez egy rendelest
-- amennyiben a customer-nek nincs eleg penze jelzi
-- amennyiben nincs termek a raktaron ajanl mast
create or replace procedure main_order(
    pcustomerid number,
    particleid number,
    pquantity number
) is
    vcode number;
    varticles StringArray1;
    vart varchar2(3000);
begin
    vcode := try_to_order(pcustomerid, particleid, pquantity, varticles);
    if vcode = -2 then
        DBMS_OUTPUT.put_line('The customer is poor');
        return;
    elsif vcode = -1 then
        if varticles is not null then
            DBMS_OUTPUT.put_line('Stock is out. Suggestions: ');
            for i in 1..varticles.COUNT
            loop
                vart := varticles(i);
                DBMS_OUTPUT.put_line(vart);
            end loop;
        end if;
    else
        DBMS_OUTPUT.put_line('Order successfully made');
    end if;
end main_order;

/

begin
    main_order(5, 2, 5);
end;

/
-- Rendeles megtervezese
-- 0 - sikeresen megrendelve
-- -1 - nincs stock-on az adott termek ezert ajanl mast (poarticles)
-- -2 - nincs eleg penze a customernek

create or replace function try_to_order(
    pcustomerid number,
    particleid number,
    pquantity number,
    poarticles out StringArray1
) return number
is
    vqt number;
    vsubcatid number;
    vprice number;
    vmoney number;
begin

    select QUANTITY
    into vqt
    from C##SZAMT4.WAREHOUSE
    where ARTICLEID = particleid
    for update; -- transaction lock (row)

    if pquantity < vqt then
        vqt := pquantity;
    end if;

    if vqt = 0 then
        select SUBCATID
        into vsubcatid
        from C##SZAMT4.article
        where id = particleid;

        if vsubcatid is not null then
            poarticles := top5articles(vsubcatid);
        end if;

        commit; -- transaction unlock

        return -1;
    end if;

    vprice := calculate_price(particleid, vqt);

    select money
    into vmoney
    from C##SZAMT4.CUSTOMER
    where id = pcustomerid
    for update; -- transaction lock (row)

    if vmoney < vprice then
        commit; -- transaction unlock
        return -2;
    end if;

    make_order(pcustomerid, particleid, vqt, vprice);

    return 0;
end try_to_order;

/

-- elvegzi a rendelest:
-- beszur az ORDERTABLE tablaba
-- update-olja a customer penztarcajat
-- update-olja a warehouse tartalmat
create or replace procedure make_order(
    pcustomerid number,
    particleid number,
    pquantity number,
    ptotal number
) is
begin

    insert into C##SZAMT4.ORDERTABLE
    values ((select max(id) + 1 from C##SZAMT4.ORDERTABLE), pcustomerid, particleid, pquantity, ptotal, sysdate);

    update C##SZAMT4.CUSTOMER
    set money = money - ptotal
    where id = pcustomerid;

    update C##SZAMT4.WAREHOUSE
    set quantity = quantity - pquantity
    where ARTICLEID = particleid;

    commit; -- transaction unlock

end make_order;

/

-- amennyiben 1 darabot vasarol a termekbol teljes arat kell fizetnie
-- viszont amennyiben tobbet vasarol akkor egyik termekre kap discount-ot

create or replace function calculate_price(
    particleid number,
    pquantity number
) return number
is
    vprice number;
    vdiscount number;
begin

    select price
    into vprice
    from C##SZAMT4.ARTICLE
    where id = particleid;

    if pquantity != 1 then
        select discount
        into vdiscount
        from C##SZAMT4.ARTICLE
        where id = particleid;

        vprice := vprice * (pquantity - vdiscount);

    end if;

    return vprice;
end calculate_price;

/

declare
    price number;
begin
    price := calculate_price(9, 2);
    DBMS_OUTPUT.put_line(price);
end;

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

begin
    main_order(3, 2, 1);
end;
/
select * from ORDERTABLE;