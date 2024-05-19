-- Subcategory Table
CREATE INDEX idx_subcategory_categoryid ON C##SZAMT4.Subcategory(categoryid);

-- Customer Table
CREATE UNIQUE INDEX idx_customer_email ON C##SZAMT4.Customer(email);

-- OrderTable Table
CREATE INDEX idx_ordertable_customerid ON C##SZAMT4.OrderTable(customerid);
CREATE INDEX idx_ordertable_articleid ON C##SZAMT4.OrderTable(articleid);

-- Article Table
CREATE INDEX idx_article_subcatid ON C##SZAMT4.Article(subcatid);