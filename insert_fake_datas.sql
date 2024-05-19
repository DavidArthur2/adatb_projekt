-- Beszúrjuk a kategóriákat
INSERT INTO Category (id, name, description) VALUES (1, 'Electronics', 'Electronic items');
INSERT INTO Category (id, name, description) VALUES (2, 'Books', 'Various books');
INSERT INTO Category (id, name, description) VALUES (3, 'Clothing', 'Men and Women clothing');

-- Beszúrjuk az alkategóriákat
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (1, 'Mobile Phones', 'Smartphones and accessories', 1);
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (2, 'Laptops', 'Laptops and accessories', 1);
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (3, 'Fiction', 'Fiction books', 2);
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (4, 'Non-Fiction', 'Non-fiction books', 2);
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (5, 'Men Clothing', 'Clothing for men', 3);
INSERT INTO Subcategory (id, name, description, categoryid) VALUES (6, 'Women Clothing', 'Clothing for women', 3);

-- Beszúrjuk a cikkeket
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (1, 1, 'iPhone 12', 1000, 0.00);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (2, 1, 'Samsung Galaxy S21', 800, 0);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (3, 2, 'MacBook Pro', 1300, 0.2);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (4, 2, 'Dell XPS 13', 1100, 0.1);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (5, 3, 'The Great Gatsby', 11, 0);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (6, 3, '1984', 9, 0);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (7, 4, 'Sapiens', 13, 0);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (8, 4, 'Educated', 15, 0);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (9, 5, 'Levis Jeans', 50, 0.15);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (10, 5, 'Nike T-Shirt', 20, 0.3);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (11, 6, 'Adidas Jacket', 60, 0.05);
INSERT INTO Article (id, subcatid, name, price, discount) VALUES (12, 6, 'H&M Dress', 40, 0.21);


-- Beszúrjuk a raktár készleteket
INSERT INTO Warehouse (articleid, quantity) VALUES (1, 50);
INSERT INTO Warehouse (articleid, quantity) VALUES (2, 30);
INSERT INTO Warehouse (articleid, quantity) VALUES (3, 20);
INSERT INTO Warehouse (articleid, quantity) VALUES (4, 15);
INSERT INTO Warehouse (articleid, quantity) VALUES (5, 100);
INSERT INTO Warehouse (articleid, quantity) VALUES (6, 90);
INSERT INTO Warehouse (articleid, quantity) VALUES (7, 50);
INSERT INTO Warehouse (articleid, quantity) VALUES (8, 60);
INSERT INTO Warehouse (articleid, quantity) VALUES (9, 40);
INSERT INTO Warehouse (articleid, quantity) VALUES (10, 70);
INSERT INTO Warehouse (articleid, quantity) VALUES (11, 25);
INSERT INTO Warehouse (articleid, quantity) VALUES (12, 30);

-- Beszúrjuk a vásárlókat
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (1, 'John Doe', '1234567890', 'john.doe@example.com', '123 Main St', 500.00, 'pw123', 0);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (2, 'Jane Smith', '0987654321', 'jane.smith@example.com', '456 Elm St', 300.00, 'pw123', 0);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (3, 'Alice Johnson', '5555555555', 'alice.johnson@example.com', '789 Oak St', 400.00, 'pw123', 0);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (4, 'Bob Brown', '6666666666', 'bob.brown@example.com', '101 Pine St', 450.00, 'pw123', 0);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (5, 'Charlie Davis', '7777777777', 'charlie.davis@example.com', '202 Birch St', 350.00, 'pw123', 0);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (6, 'David Arthur', '7777777777', 'arti@yahoo.com', '202 Birch St', 35000.00, 'admin', 2);
INSERT INTO Customer (id, name, tel, email, address, money, password, admin) VALUES (7, 'Manager', '7777777777', 'manager@yahoo.com', '202 Birch St', 35000.00, 'admin', 1);

-- Beszúrjuk a rendeléseket
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (1, 1, 1, 1, 999.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (2, 2, 3, 1, 1199.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (3, 3, 5, 2, 21.98, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (4, 4, 9, 1, 44.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (5, 5, 11, 1, 54.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (6, 1, 2, 1, 799.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (7, 2, 7, 1, 12.99, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (8, 3, 10, 3, 59.97, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (9, 4, 12, 2, 73.98, SYSDATE);
INSERT INTO OrderTable (id, customerid, articleid, quantity, total, orderdate) VALUES (10, 5, 4, 1, 949.99, SYSDATE);

commit;