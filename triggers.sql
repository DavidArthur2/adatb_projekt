CREATE OR REPLACE TRIGGER warehouse_trigger
AFTER
UPDATE OF QUANTITY
ON Warehouse
FOR EACH ROW
declare
    articlename VARCHAR2(100) := 'N/A';
BEGIN

    SELECT name INTO articlename FROM ARTICLE WHERE ARTICLE.ID = :NEW.articleid; -- Lekérjük a nevét

    IF :NEW.quantity < 5 THEN
        DBMS_OUTPUT.PUT_LINE('Figyelmeztetés: ' || articlename || ' mennyisége 5 alá csökkent!');
    END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Hiba a warehouse triggernel!');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Others: Hiba a warehouse triggernel!');

END warehouse_trigger;
/
CREATE OR REPLACE TRIGGER category_delete_trigger
AFTER
DELETE
ON CATEGORY
FOR EACH ROW
BEGIN
    DELETE FROM SUBCATEGORY WHERE CATEGORYID = :OLD.id;
END category_delete_trigger;
/
CREATE OR REPLACE TRIGGER subcategory_delete_trigger
AFTER
DELETE
ON SUBCATEGORY
FOR EACH ROW
BEGIN
    UPDATE ARTICLE SET SUBCATID = null WHERE SUBCATID = :OLD.id;
END subcategory_delete_trigger;
/
select * from ARTICLE;
/
