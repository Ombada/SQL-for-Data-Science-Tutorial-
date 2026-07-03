-- Introduction   (This is an example for single line comment)

/* This is an example for multiple lines comments

Comments make your code easier to share with colleages, but not only that 

they also help you with troubleshooting or when you try to modify your code 

a couple of years later */




-- In order to deploy the approach: understand first, think second, and write third you need the following:

-- 1. SHOW:  This will show all the databases in your Workbench

SHOW DATABASES;


-- 2. USE: This is the way to choose the dataset you want to work with

USE sql_store;

-- 3. SHOW TABLES: here you can see all the tables in the chosen dataset (sql_store)

SHOW TABLES;

-- 4.DESCRIBE: here you can check the description of a selected table (customers), the data type and the default values are important

DESCRIBE customers;


-- you can write sql commands in small letters or capital letters but dont mix them (SHOW == show but not ShoW)


/* The databse contains of the following tables:
1. `customers` (
  `customer_id`    int(11)             NOT NULL AUTO_INCREMENT,
  `first_name`     varchar(50)         NOT NULL,
  `last_name`      varchar(50)         NOT NULL,
  `birth_date`     date DEFAULT        NULL,
  `phone`          varchar(50)         DEFAULT NULL,
  `address`        varchar(50)         NOT NULL,
  `city`           varchar(50)         NOT NULL,
  `state`          char(2)             NOT NULL,
  `points`         int(11)             NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
)

2. `products` (
  `product_id`                 int(11)              NOT NULL AUTO_INCREMENT,
  `name`                       varchar(50)          NOT NULL,
  `quantity_in_stock`          int(11)              NOT NULL,
  `unit_price`                 decimal(4,2)         NOT NULL,
  PRIMARY KEY (`product_id`)
) 

3. `shippers` (
  `shipper_id`             smallint(6)    NOT NULL AUTO_INCREMENT,
  `name`                   varchar(50)    NOT NULL,
  PRIMARY KEY (`shipper_id`)
)

4. `order_statuses` (
  `order_status_id`            tinyint(4)              NOT NULL,
  `name`                       varchar(50)             NOT NULL,
  PRIMARY KEY (`order_status_id`)
)

5.`orders` (
  `order_id`                  int(11)                 NOT NULL AUTO_INCREMENT,
  `customer_id`               int(11)                 NOT NULL,
  `order_date`                date                    NOT NULL,
  `status`                    tinyint(4)              NOT NULL DEFAULT '1',
  `comments`                  varchar(2000)           DEFAULT NULL,
  `shipped_date'              date DEFAULT            NULL,
  `shipper_id`                smallint(6)             DEFAULT NULL,
  PRIMARY KEY (`order_id`)
  
  
  
6.`order_items` (
  `order_id`                 int(11)                  NOT NULL AUTO_INCREMENT,
  `product_id`               int(11)                  NOT NULL,
  `quantity`                 int(11)                  NOT NULL,
  `unit_price`               decimal(4,2)             NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`)
  
  7.`order_item_notes` (
  `note_id`                   INT             NOT NULL,
  `order_Id`                  INT             NOT NULL,
  `product_id`                INT             NOT NULL,
  `note`                      VARCHAR(255)    NOT NULL,
  PRIMARY KEY (`note_id`))
*/




