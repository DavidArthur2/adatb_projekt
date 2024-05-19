CREATE OR REPLACE FUNCTION insert_category(categoryName VARCHAR2, categoryDescription VARCHAR2)RETURN NUMBER IS
BEGIN
    INSERT INTO CATEGORY VALUES (
                                 (SELECT MAX(id)+1 FROM CATEGORY),
                                 categoryName,
                                 categoryDescription);
    DBMS_OUTPUT.PUT_LINE(categoryName || ' beszúrva');
    COMMIT;
    RETURN SQL%ROWCOUNT;
end insert_category;
/
CREATE OR REPLACE FUNCTION insert_subcategory(subcategoryName VARCHAR2, subcategoryDescription VARCHAR2, categoryID NUMBER)RETURN NUMBER IS
BEGIN
    INSERT INTO SUBCATEGORY VALUES (
                                 (SELECT MAX(id)+1 FROM SUBCATEGORY),
                                 subcategoryName,
                                 subcategoryDescription,
                                 categoryID);
    DBMS_OUTPUT.PUT_LINE(subcategoryName || ' beszúrva');
    COMMIT;
    RETURN SQL%ROWCOUNT;
end insert_subcategory;
/
CREATE OR REPLACE PROCEDURE add_article(articleName VARCHAR2, newQuantity NUMBER, subcatID NUMBER := 0, price NUMBER := 0, discount NUMBER := 0) IS
    artid NUMBER := -1;
    currQuantity NUMBER := 0;
BEGIN
    SELECT id INTO artid FROM ARTICLE WHERE name = articleName;
    SELECT QUANTITY INTO currQuantity FROM WAREHOUSE WHERE ARTICLEID = artid;

    UPDATE WAREHOUSE SET QUANTITY = currQuantity + newQuantity WHERE ARTICLEID = artid;
    DBMS_OUTPUT.PUT_LINE(articleName || ' száma módosítva erre: ' || (newQuantity + currQuantity));

    COMMIT;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_article(articleName, newQuantity, subcatID, price, discount);
end add_article;
/
CREATE OR REPLACE PROCEDURE new_article(articleName VARCHAR2, newQuantity NUMBER, subcatID NUMBER, price NUMBER, discount NUMBER) IS
BEGIN
    INSERT INTO ARTICLE VALUES(
                               (SELECT MAX(id)+1 FROM ARTICLE),
                               subcatID,
                                articleName,
                               price,
                               discount);
    DBMS_OUTPUT.PUT_LINE(articleName || ' beszúrva ' || newQuantity || 'mennyiséggel');
    COMMIT;
end new_article;
/