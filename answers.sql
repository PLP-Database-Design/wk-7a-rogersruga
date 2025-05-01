-- Question 1 Achieving 1NF (First Normal Form)

SELECT 
    pd.OrderID,
    pd.CustomerName,
    TRIM(jt.Product) AS Product
FROM ProductDetail pd,
JSON_TABLE(
    CONCAT('[', REPLACE(pd.Products, ',', '","'), ']'),
    '$[*]' COLUMNS(Product VARCHAR(100) PATH '$')
) AS jt;



-- QUESTION 2 ACHIEVING 2NF (Second Normal Form)

-- Table 1: Orders (CustomerName depends on OrderID)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Table 2: OrderItems (Only product and quantity per order)

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


