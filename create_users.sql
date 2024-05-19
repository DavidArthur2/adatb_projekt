-- Magyarázat:

-- Administrator - Mindenhez van hozzáférése: Rendszergazda
-- Manager - Ő végez módositásokat az eladandó árukon, ő intézi a boltot, és a raktárfeltöltést is
-- Seller - A UI erre van bejelentkezve, joga van lekérdezésekre, és eladáskor a cikkek csökkentésére
-- Viewer - Csak lekérdezésekre van jogosultsága

--Userek és Role-ok létrehozása
CREATE USER C##administrator IDENTIFIED BY adminpw123;
CREATE USER manager IDENTIFIED BY managerpw123;
CREATE USER C##seller IDENTIFIED BY sellerpw123;
CREATE USER viewer IDENTIFIED BY viewerpw123;

--Nem müködik a felhasználó létrehozás

CREATE ROLE admin_role;
CREATE ROLE manager_role;
CREATE ROLE seller_role;
CREATE ROLE viewer_role;


-- Admin role
GRANT ALL PRIVILEGES TO admin_role;

-- Manager role
GRANT SELECT, INSERT, UPDATE, DELETE ON Warehouse TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Category TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Subcategory TO manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Article TO manager_role;
GRANT SELECT ON Customer TO manager_role;
GRANT SELECT ON OrderTable TO manager_role;

-- Seller role
GRANT SELECT, UPDATE ON Warehouse TO seller_role;
GRANT SELECT ON Category TO seller_role;
GRANT SELECT ON Subcategory TO seller_role;
GRANT SELECT ON Article TO seller_role;
GRANT SELECT ON Customer TO seller_role;
GRANT SELECT ON OrderTable TO seller_role;

-- Viewer role
GRANT SELECT ON Warehouse TO viewer_role;
GRANT SELECT ON Category TO viewer_role;
GRANT SELECT ON Subcategory TO viewer_role;
GRANT SELECT ON Article TO viewer_role;
GRANT SELECT ON Customer TO viewer_role;
GRANT SELECT ON OrderTable TO viewer_role;

-- Szerepkörök hozzárendelése a felhasználókhoz
GRANT admin_role TO administrator;
GRANT manager_role TO manager;
GRANT seller_role TO seller;
GRANT viewer_role TO viewer;
