DROP DATABASE IF EXISTS clothing_store;
CREATE DATABASE clothing_store;
USE clothing_store;

DROP TABLE IF EXISTS product_types;
CREATE TABLE product_types 
(
  id_product_type SERIAL PRIMARY KEY,
  color TEXT COMMENT 'color name'
);

DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers 
(
  id_manufacturer SERIAL PRIMARY KEY,
  name TEXT COMMENT 'manufacturer name'
);

DROP TABLE IF EXISTS colors;
CREATE TABLE colors 
(
  id_color SERIAL PRIMARY KEY,
  color TEXT COMMENT 'color name'
);

DROP TABLE IF EXISTS sizes;
CREATE TABLE sizes 
(
  id_size SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL,
  `size` TEXT COMMENT 'clothing size',
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type)
);

DROP TABLE IF EXISTS stores;
CREATE TABLE stores 
(
  id_store SERIAL PRIMARY KEY,
  address TEXT,
  director_name TEXT COMMENT 'name of store manager'
);

DROP TABLE IF EXISTS exchange_rates;
CREATE TABLE exchange_rates 
(
  id_exchange_rate SERIAL PRIMARY KEY,
  `data` DATETIME DEFAULT CURRENT_TIMESTAMP,
  exchange_rate INT COMMENT 'exchange_rates'
);

DROP TABLE IF EXISTS product_groups;
CREATE TABLE product_groups 
(
  id_product_group SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL,
  product_group TEXT COMMENT 'product_groups' ,
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products 
(
  id_product SERIAL PRIMARY KEY,
  product_type BIGINT UNSIGNED NOT NULL ,
  product_group BIGINT UNSIGNED NOT NULL,
  manufacturer BIGINT UNSIGNED NOT NULL,
  description TEXT COMMENT 'Description',
  FOREIGN KEY (product_type) REFERENCES product_types(id_product_type),
  FOREIGN KEY (product_group) REFERENCES product_groups(id_product_group),
  FOREIGN KEY (manufacturer) REFERENCES manufacturers(id_manufacturer)
);

DROP TABLE IF EXISTS products_colors_sizes;
CREATE TABLE products_colors_sizes 
(
  id_product_color_size SERIAL PRIMARY KEY,
  product BIGINT UNSIGNED NOT NULL,
  color BIGINT UNSIGNED NOT NULL,
  `size` BIGINT UNSIGNED NOT NULL COMMENT 'products_colors_sizes',
  FOREIGN KEY (product) REFERENCES products(id_product),
  FOREIGN KEY (color) REFERENCES colors(id_color),
  FOREIGN KEY (`size`) REFERENCES sizes(id_size)
);

DROP TABLE IF EXISTS supplies;
CREATE TABLE supplies 
(
  id_supply SERIAL PRIMARY KEY,
  store BIGINT UNSIGNED NOT NULL,
  exchange_rate BIGINT UNSIGNED NOT NULL,
  product_color_size BIGINT UNSIGNED NOT NULL,
  amount INT,
  purchase_price INT COMMENT 'supplies',
  FOREIGN KEY (store) REFERENCES stores(id_store),
  FOREIGN KEY (exchange_rate) REFERENCES exchange_rates(id_exchange_rate),
  FOREIGN KEY (product_color_size) REFERENCES products_colors_sizes(id_product_color_size)
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales 
(
  id_sale SERIAL PRIMARY KEY,
  sale_date DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  store BIGINT UNSIGNED NOT NULL,
  product_color_size BIGINT UNSIGNED NOT NULL,
  amount INT,
  discount INT COMMENT 'sales',
  FOREIGN KEY (store) REFERENCES stores(id_store),
  FOREIGN KEY (product_color_size) REFERENCES products_colors_sizes(id_product_color_size)
);

