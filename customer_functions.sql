CREATE OR REPLACE FUNCTION insert_customer(customerName VARCHAR2, customerTel VARCHAR2, customerEmail VARCHAR2,
customerAddress VARCHAR2) RETURN NUMBER
IS
    row_num NUMBER := 0;
    id NUMBER := -1;
BEGIN
    SELECT COUNT(*)
    INTO row_num
    FROM CUSTOMER
    WHERE email = customerEmail;

    IF row_num = 0 THEN  -- Újat szúrunk be
        INSERT INTO CUSTOMER
        VALUES((SELECT MAX(id) FROM CUSTOMER) + 1,
               customerName,
               customerTel,
               customerEmail,
               customerAddress,
               0.0);
    END IF;

    IF SQL%ROWCOUNT > 0 OR row_num > 0 THEN  -- Belett szurva
        SELECT CUSTOMER.id INTO id FROM CUSTOMER WHERE EMAIL = customerEmail;
    END IF;

    COMMIT;

    RETURN id;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Sikertelen beszúrás');
            return id;

END insert_customer;
/