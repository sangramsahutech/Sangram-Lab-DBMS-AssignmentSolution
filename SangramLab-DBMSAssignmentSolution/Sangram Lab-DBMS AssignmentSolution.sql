Create Database if not exists `order-directory` ;
use `order-directory`;

create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)	
);

CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`)
 );

 CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
   PRIMARY KEY (`CAT_ID`)
  );

  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)  
  );

 CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)  
  );

CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );

CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  ); 

insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");

INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);

INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);

INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);

INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);

select * from supplier;
select * from customer;
select * from category;
select * from product;
select * from product_details;
select * from `order`;
select * from rating;
CREATE TABLE IF NOT EXISTS `orders` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );
  INSERT INTO `ORDERS` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDERS` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDERS` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDERS` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDERS` VALUES(30,3500,"2021-08-16",4,3);

/* 3) Display the number of the customer group by their genders who have placed any order
of amount greater than or equal to Rs.3000.*/
SELECT 
    c.cus_gender, COUNT(c.cus_gender)
FROM
    customer c
        JOIN
    orders o ON c.cus_id = o.cus_id
WHERE
    o.ord_amount >= 3000
GROUP BY c.cus_gender; 

/*4. Display all the orders along with the product name ordered by a customer having
Customer_Id=2.*/
SELECT 
    o.cus_id CUSTOMER_ID,
    o.ord_date ORDER_DATE,
    P.PRO_NAME PRODUCT_NAME,
    P.PRO_DESC PRODUCT_DESCRIPTION,
    O.ORD_AMOUNT ORDER_AMOUNT
FROM
    ORDERS O
        JOIN
    PRODUCT_DETAILS PD ON O.PROD_ID = PD.PROD_ID
        JOIN
    PRODUCT P ON P.PRO_ID = PD.PRO_ID
WHERE
    O.CUS_ID = 2;
    
/*5. Display the Supplier details who can supply more than one product.*/
SELECT 
    *
FROM
    supplier s
WHERE
    s.supp_id IN (SELECT 
            pd.supp_id
        FROM
            product_details pd
        GROUP BY pd.supp_id
        HAVING COUNT(pd.supp_id) > 1)
GROUP BY s.supp_id;

/*6. Find the category of the product whose order amount is minimum.*/
SELECT 
    C.*
FROM
    ORDERS O
        JOIN
    PRODUCT_DETAILS PD ON PD.PROD_ID = O.PROD_ID
        JOIN
    PRODUCT P ON P.PRO_ID = PD.PRO_ID
        JOIN
    CATEGORY C ON C.CAT_ID = P.CAT_ID
HAVING MIN(O.ORD_AMOUNT);

/*7. Display the Id and Name of the Product ordered after “2021-10-05”.*/
SELECT 
    p.pro_id, p.pro_name
FROM
    product_details pd
        JOIN
    orders o ON pd.prod_id = o.prod_id
        JOIN
    product p ON p.pro_id = pd.pro_id
WHERE
    o.ord_date > '2021-10-05';
    
/*8. Print the top 3 supplier name and id and their rating on the basis of their rating along
with the customer name who has given the rating.*/
SELECT 
    s.supp_name, s.supp_id, r.rat_ratstars, c.cus_name
FROM
    rating r
        JOIN
    customer c ON r.cus_id = c.cus_id
        JOIN
    supplier s ON r.supp_id = s.supp_id
ORDER BY r.rat_ratstars DESC
LIMIT 3;

/*9. Display customer name and gender whose names start or end with character 'A'.*/
SELECT 
    cus_name
FROM
    customer
WHERE
    cus_name LIKE 'A%' OR cus_name LIKE '%A';

/*10. Display the total order amount of the male customers.*/
SELECT c.CUS_GENDER,
    SUM(o.ord_amount)
FROM
    orders o
        JOIN
    customer c ON o.cus_id = c.cus_id
WHERE
    c.cus_gender = 'M';

/*11. Display all the Customers left outer join with the orders.*/
SELECT 
    *
FROM
    customer c
        LEFT OUTER JOIN
    orders o ON o.cus_id = c.cus_id;  

/*12. Create a stored procedure to display the Rating for a Supplier if any along with the
Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
Supplier” else “Supplier should not be considered”.*/
CALL RATE_SUPPLIERS();