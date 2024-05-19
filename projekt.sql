DECLARE
    id NUMBER := -1;
BEGIN
    id := insert_customer('Robi', '0775569272', 'robi@yahoo.com', 'Kutyfalva');
    DBMS_OUTPUT.PUT_LINE(id);
end;
/
select * from customer;