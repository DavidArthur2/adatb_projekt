select * from C##SZAMT4.CATEGORY;

select * from C##SZAMT4.SUBCATEGORY;

select art.id, art.SUBCATID, art.NAME, art.PRICE, art.DISCOUNT, ware.QUANTITY from C##SZAMT4.ARTICLE art, C##SZAMT4.WAREHOUSE ware
where art.id = ware.ARTICLEID and art.SUBCATID is not null;