DROP DATABASE IF EXISTS clothing_store;
CREATE DATABASE clothing_store;
USE clothing_store;

DROP TABLE IF EXISTS product_types;
CREATE TABLE product_types 
(
  id_product_type SERIAL PRIMARY KEY,
  product_type_name TEXT COMMENT 'product_type'
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
  `size` TEXT COMMENT 'clothing size'
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

DROP TABLE IF EXISTS products_colors_sizes_prices;
CREATE TABLE products_colors_sizes_prices 
(
  id_prices SERIAL PRIMARY KEY,
  product_color_size BIGINT UNSIGNED NOT NULL UNIQUE,
  price_in_rub BIGINT,
  FOREIGN KEY (product_color_size) REFERENCES products_colors_sizes(id_product_color_size)
);

DROP TABLE IF EXISTS supplies;
CREATE TABLE supplies 
(
  id_supply SERIAL PRIMARY KEY,
  store BIGINT UNSIGNED NOT NULL,
  exchange_rate BIGINT UNSIGNED NOT NULL,
  product_color_size BIGINT UNSIGNED NOT NULL,
  amount INT,
  purchase_price_in_rub INT COMMENT 'supplies',
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

-- Наполнение
INSERT INTO product_types VALUES 
(NULL,'pants and shorts'),
(NULL,'outerwear'),
(NULL,'turtlenecks'),
(NULL,'jumpers and cardigans'),
(NULL,'jeans'),
(NULL,'vests'),
(NULL,'carnival costumes'),
(NULL,'overalls and semi-overalls'),
(NULL,'costumes'),
(NULL,'long sleigh'),
(NULL,'homewear'),
(NULL,'jackets'),
(NULL,'sweatshirts'),
(NULL,'hoodies'),
(NULL,'T-shirts'),
(NULL,'dresses'),
(NULL,'tunics'),
(NULL,'skirts');

INSERT INTO manufacturers VALUES 
(NULL,'ASICS'),
(NULL,'Baon'),
(NULL,'Betsy'),
(NULL,'Bourjois'),
(NULL,'Caprice'),
(NULL,'COLIN'),
(NULL,'CROCS'),
(NULL,'Keddo'),
(NULL,'Finn Flare'),
(NULL,'GEOX'),
(NULL,'POSAYLEGOL'),
(NULL,'Tozzi'),
(NULL,'Pierre'),
(NULL,'Nike'),
(NULL,'Polaris'),
(NULL,'SOKOLOV'),
(NULL,'Trussardi'),
(NULL,'Rocher');

INSERT INTO colors VALUES 
(NULL,'fuchsia'),
(NULL,'gray'),
(NULL,'white'),
(NULL,'aqua'),
(NULL,'blue'),
(NULL,'teal'),
(NULL,'silver'),
(NULL,'black'),
(NULL,'purple'),
(NULL,'green'),
(NULL,'navy'),
(NULL,'olive'),
(NULL,'maroon'),
(NULL,'lime'),
(NULL,'pink'); 

INSERT INTO clothing_store.sizes (`size`) VALUES 
('XS')
,('S')
,('L')
,('M')
,('XL')
,('XXL');

INSERT INTO stores VALUES 
(NULL, '561 Cole Port','Kristopher Brown'),
(NULL, '927 Crist Mills Suite 834','Lenny Wintheiser'),
(NULL, '54023 Altenwerth Freeway','Tate Krajcik'),
(NULL, '02428 Seth Walk','Antonetta Heidenreich'),
(NULL, '73126 Runolfsson Ford Apt. 825','Prof. Ford Hermann MD'),
(NULL, '4429 Hodkiewicz Crest Apt. 900','Mrs. Keira Jaskolski'),
(NULL, '46136 Werner Summit','Caterina Stokes'),
(NULL, '64322 Cleveland Circles','Miss Alexandria Cremin MD'),
(NULL, '66754 Eugenia Prairie Suite 420','Candace Sawayn MD'),
(NULL, '4705 Davion Falls','Hassan Feest'),
(NULL, '64148 Johns Pass','Luis Reinger'),
(NULL, '971 Hoppe Park Apt. 685','Freeman Hilpert'),
(NULL, '85515 Nathanial Springs Apt. 180','Krystel Rohan'),
(NULL, '6817 Kuhn Oval Apt. 859','Dr. Melyna Skiles'),
(NULL, '22217 Padberg Views Suite 145','Helga Fritsch'),
(NULL, '9677 Cleveland Summit Suite 128','Urban Bartell'),
(NULL, '48363 Ullrich Plaza','Prof. Shaun Bogisich DVM'),
(NULL, '88754 Ledner Turnpike','Prof. Janick Roberts II'),
(NULL, '4033 Deckow Square','Carmela Shanahan'),
(NULL, '512 Addison Ville','Prof. Krista Nikolaus PhD'),
(NULL, '9190 Fletcher Fields Apt. 552','Ignatius O\'Connell'),
(NULL, '04508 Stone Harbor Suite 434','George Hirthe Sr.'),
(NULL, '784 Bogan Hills Apt. 402','Gretchen Padberg'),
(NULL, '38490 Brekke Prairie Apt. 056','Ms. Ofelia Mitchell Jr.'),
(NULL, '6974 Maude Cove Suite 769','Mr. Alfred McDermott'),
(NULL, '8635 Cassin Field','Owen Greenholt'),
(NULL, '41243 Boehm Island Suite 547','Rudy Auer MD'),
(NULL, '101 Clarissa Stream','Dr. Violette Kertzmann IV'),
(NULL, '990 Zelda Islands','Mr. Nelson Cronin DVM'),
(NULL, '25328 Lubowitz Squares','Laurine Bogisich'),
(NULL, '0965 Patience Lake Suite 703','Elnora Cremin'),
(NULL, '8631 Barrows Island','Jessica Kerluke'),
(NULL, '85433 Cronin Walk','Mr. Demond McKenzie'),
(NULL, '25508 Goyette Walk Suite 202','Prof. Jaeden Bayer'),
(NULL, '627 Nikolaus Lodge','Felicity Turcotte Sr.'),
(NULL, '127 Howell Prairie Suite 451','Mireille Schultz'),
(NULL, '2358 Sabryna Radial','Arnold Anderson'),
(NULL, '21233 Hayes Crest Suite 556','Chelsey Anderson'),
(NULL, '897 Gerlach Loop Apt. 703','Keeley Weimann'),
(NULL, '445 Turcotte Valleys Apt. 961','Prof. Darren Bergnaum IV'),
(NULL, '2120 Phoebe Common Apt. 774','Edna Medhurst'),
(NULL, '0901 Jayce Fords Suite 460','Dr. Ulices Wolff'),
(NULL, '5903 Domenick Land','Payton Franecki'),
(NULL, '0297 Wunsch Stravenue Suite 666','Tianna Runolfsson'),
(NULL, '217 Bernhard Pine Suite 135','Lavada Bosco'),
(NULL, '45235 Goldner Park','Dr. Omer Sanford PhD'),
(NULL, '736 Erdman Coves','Arlene Murray'),
(NULL, '7094 Schuppe Islands Apt. 608','Fermin Weimann PhD'),
(NULL, '47047 Octavia Points','Dr. Abraham Haley'),
(NULL, '186 Gertrude Path','Stanton Emard III'),
(NULL, '16623 Shanon Mills','Santa Keebler'),
(NULL, '67363 Konopelski Trafficway','Lucienne Hauck MD'),
(NULL, '607 Braden Dam Suite 453','Deja Harber Sr.'),
(NULL, '010 Alexander Vista','Erling Kunde'),
(NULL, '587 Brekke Mount','Prof. Willis McDermott'),
(NULL, '483 Lang Stravenue Apt. 174','Mrs. Matilda Erdman'),
(NULL, '097 Eliane Junction','Amely Hackett MD'),
(NULL, '20819 Bergstrom Plaza Apt. 471','Prof. D\'angelo Jacobson'),
(NULL, '57550 Kelsie Run','Johnny Carroll'),
(NULL, '51460 Wayne Parkway Suite 716','Quinton Douglas'),
(NULL, '806 Katheryn Track Apt. 418','Rodrick Zulauf PhD'),
(NULL, '10037 Wilber Greens','Brendan Pagac'),
(NULL, '63579 Garnett Turnpike','Miss Alexane Predovic DVM'),
(NULL, '1985 Monahan Grove Suite 792','Jayda Lakin'),
(NULL, '019 Mayert Dam','Verona Hansen'),
(NULL, '8005 Eulah Crossroad Suite 903','Prof. Quincy Hartmann'),
(NULL, '957 Krajcik Route Suite 056','Lynn Weissnat'),
(NULL, '35815 Lockman Springs Apt. 231','Mr. Johnathon Blick'),
(NULL, '299 Collins Parkways Suite 874','Dr. Frankie Stroman Sr.'),
(NULL, '4023 Larkin Manor Suite 293','Vickie Stark'),
(NULL, '2506 Phoebe Islands Suite 909','Eleanora Franecki'),
(NULL, '5508 Heaney Center','Dr. Amaya Collier II'),
(NULL, '98547 Terry Locks','Prof. Luigi Beer V'),
(NULL, '907 Vincent Harbor','Jessie Nicolas'),
(NULL, '017 Tanya Pine Suite 928','Mr. Robert Johns V'),
(NULL, '66121 Witting Grove Apt. 584','Evert Kassulke'),
(NULL, '694 Misty Cove Suite 843','Justen Hodkiewicz'),
(NULL, '3379 Emmerich Fork Suite 271','Dr. Gianni Turner II'),
(NULL, '182 Tomas Village','Mr. Isaiah Reinger DVM'),
(NULL, '4401 Delaney Ford','Jaylon Feeney'),
(NULL, '616 Hamill Forge Suite 406','Ephraim Mertz'),
(NULL, '87098 Beer Extension','Mr. Jayden Parker MD'),
(NULL, '5848 Shanahan Prairie','Mr. Olin Brekke II'),
(NULL, '958 Fredy Fork Apt. 049','Tracy Roberts DVM'),
(NULL, '01122 Taya Street','Louisa Bartoletti'),
(NULL, '8596 Gordon Avenue','Prof. Coralie Blick II'),
(NULL, '92192 Gail Roads','Mittie Gottlieb'),
(NULL, '99433 Gerald Junctions Apt. 492','Ms. Mariam Larson II'),
(NULL, '934 Stroman Pass','Rodrick Weber'),
(NULL, '20222 Kendall Plains','Myrtis Robel'),
(NULL, '20345 Dudley Oval','Lilla Pouros III'),
(NULL, '0863 Glen Lock Apt. 497','Georgette Dibbert'),
(NULL, '42933 Nico Glens Suite 399','Maiya Schamberger'),
(NULL, '64479 Waelchi Junctions Apt. 195','Josianne Wintheiser'),
(NULL, '419 Savanah Spurs','Ms. Krystal Von Jr.'),
(NULL, '168 Maudie Fall','Jerrell Terry'),
(NULL, '18362 Franecki Loaf Apt. 895','Breanna Smitham'),
(NULL, '78848 Hubert Village Apt. 602','Dr. Herman Hermann'),
(NULL, '415 Lind Junctions','Nikolas Krajcik'),
(NULL, '67754 Leannon Union Suite 745','Callie Boyer'); 

INSERT INTO clothing_store.exchange_rates (`data`,exchange_rate) VALUES 
('2018-07-04 21:00:00',50)
,('2018-07-05 21:00:00',51)
,('2018-07-06 21:00:00',52)
,('2018-07-07 21:00:00',53)
,('2018-07-08 21:00:00',54)
,('2018-07-09 21:00:00',55)
,('2018-07-10 21:00:00',56)
,('2018-07-11 21:00:00',57)
,('2018-07-12 21:00:00',58)
,('2018-07-13 21:00:00',59)
,('2018-07-14 21:00:00',59)
,('2018-07-15 21:00:00',58)
,('2018-07-16 21:00:00',57)
,('2018-07-17 21:00:00',58)
,('2018-07-18 21:00:00',59)
,('2018-07-19 21:00:00',58)
,('2018-07-20 21:00:00',57)
,('2018-07-21 21:00:00',59)
,('2018-07-22 21:00:00',59)
,('2018-07-23 21:00:00',59)
,('2018-07-24 21:00:00',58)
,('2018-07-25 21:00:00',59)
,('2018-07-26 21:00:00',58)
,('2018-07-27 21:00:00',57)
,('2018-07-28 21:00:00',59)
,('2018-07-29 21:00:00',59)
,('2018-07-30 21:00:00',58)
,('2018-07-31 21:00:00',58)
,('2018-08-01 21:00:00',58)
,('2018-08-02 21:00:00',58)
,('2018-08-03 21:00:00',58)
,('2018-08-04 21:00:00',58)
,('2018-08-05 21:00:00',58)
,('2018-08-06 21:00:00',58)
,('2018-08-07 21:00:00',58)
,('2018-08-08 21:00:00',57)
,('2018-08-09 21:00:00',57)
,('2018-08-10 21:00:00',57)
,('2018-08-11 21:00:00',57)
,('2018-08-12 21:00:00',58)
,('2018-08-13 21:00:00',59)
,('2018-08-14 21:00:00',60)
,('2018-08-15 21:00:00',60)
,('2018-08-16 21:00:00',60)
,('2018-08-17 21:00:00',60)
,('2018-08-18 21:00:00',60)
,('2018-08-19 21:00:00',60)
,('2018-08-20 21:00:00',60)
,('2018-08-21 21:00:00',60)
,('2018-08-22 21:00:00',60)
,('2018-08-23 21:00:00',60)
,('2018-08-24 21:00:00',60)
,('2018-08-25 21:00:00',61)
,('2018-08-26 21:00:00',62)
,('2018-08-27 21:00:00',63)
,('2018-08-28 21:00:00',63)
,('2018-08-29 21:00:00',63)
,('2018-08-30 21:00:00',63)
,('2018-08-31 21:00:00',63)
,('2018-09-01 21:00:00',63)
,('2018-09-02 21:00:00',63)
,('2018-09-03 21:00:00',63)
,('2018-09-04 21:00:00',63)
,('2018-09-05 21:00:00',63)
,('2018-09-06 21:00:00',63)
,('2018-09-07 21:00:00',63)
,('2018-09-08 21:00:00',63)
,('2018-09-09 21:00:00',62)
,('2018-09-10 21:00:00',62)
,('2018-09-11 21:00:00',62)
,('2018-09-12 21:00:00',62)
,('2018-09-13 21:00:00',62)
,('2018-09-14 21:00:00',62)
,('2018-09-15 21:00:00',62)
,('2018-09-16 21:00:00',61)
,('2018-09-17 21:00:00',60)
,('2018-09-18 21:00:00',60)
,('2018-09-19 21:00:00',59)
,('2018-09-20 21:00:00',58)
,('2018-09-21 21:00:00',57)
,('2018-09-22 21:00:00',57)
,('2018-09-23 21:00:00',57)
,('2018-09-24 21:00:00',57)
,('2018-09-25 21:00:00',57)
,('2018-09-26 21:00:00',57)
,('2018-09-27 21:00:00',57)
,('2018-09-28 21:00:00',57)
,('2018-09-29 21:00:00',57)
,('2018-09-30 21:00:00',56)
,('2018-10-01 21:00:00',55)
,('2018-10-02 21:00:00',54)
,('2018-10-03 21:00:00',55)
,('2018-10-04 21:00:00',56)
,('2018-10-05 21:00:00',57)
,('2018-10-06 21:00:00',58)
,('2018-10-07 21:00:00',59)
,('2018-10-08 21:00:00',60)
,('2018-10-09 21:00:00',60)
,('2018-10-10 21:00:00',60)
,('2018-10-11 21:00:00',60);

INSERT INTO product_groups VALUES 
(NULL,1,'For men')
,(NULL,2,'For women')
,(NULL,3,'For children')
,(NULL,4,'Unisex');

INSERT INTO clothing_store.products (product_type,product_group,manufacturer,description) VALUES 
(7,2,12,'adipiscing elit, sed do eiusmo')
,(14,1,12,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteu')
,(6,4,5,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d')
,(4,4,2,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit')
,(5,4,2,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
,(18,1,3,'ullamco laboris nisi u')
,(11,3,3,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mini')
,(14,4,8,'do eius')
,(7,2,13,'deserunt mollit ani')
,(12,4,8,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non pr')
,(9,2,11,'ullamco laboris nisi ut aliqui')
,(3,1,1,'adipiscing')
,(2,3,16,'in')
,(5,4,6,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing eli')
,(15,2,14,'sint occaecat cupidatat non proident, sunt in culpa q')
,(4,1,18,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco la')
,(4,1,7,'officia deserunt ')
,(3,3,18,'Ut enim ad minim veniam, quis nostrud exercitation ullamco labor')
,(5,3,18,'velit esse cillum dolore eu fugiat n')
,(16,4,11,'minim veniam, quis nostrud exerci')
,(17,2,18,'Excepteur sint occaecat cupidatat non p')
,(16,2,14,'ut labore et dolore magna aliqua. Ut enim ad minim ve')
,(7,4,2,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercit')
,(11,1,8,'ex ea commodo consequat. Duis a')
,(18,2,10,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ')
,(3,2,8,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in volu')
,(4,1,11,'veniam, quis nostrud exercitation ullamco la')
,(16,3,11,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occ')
,(1,1,13,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor i')
,(12,2,5,'non proident, sunt in c')
,(14,2,17,'magna ')
,(4,2,2,'ex e')
,(15,4,10,'id est laborum.Lorem ipsum')
,(18,1,17,'non proident, sunt in culpa qui officia deserunt mollit anim id est laboru')
,(12,1,17,'in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint')
,(17,4,5,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum')
,(2,3,9,'Duis aute irure dolor in reprehenderit in voluptate vel')
,(11,2,10,'pariatur. Excepteur si')
,(17,2,14,'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat')
,(6,3,1,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ')
,(6,1,18,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute')
,(5,3,11,'enim ad minim veniam, quis nostrud exercitation ullamco l')
,(18,4,14,'mollit anim id est laborum.Lorem ipsum d')
,(1,2,17,'adipiscing elit, sed do eiusmod tempor incididunt ut la')
,(11,3,9,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo conseq')
,(5,2,8,'sint occaecat cupidatat non proident, sunt in culpa qui of')
,(14,2,11,'amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut la')
,(14,2,15,'ut labo')
,(4,4,8,'in reprehenderit in voluptate velit esse cil')
,(6,3,16,'Excepteur sint occaecat cupidatat non proident, sunt ')
,(17,2,15,'cupidatat non proident, sunt in culp')
,(18,3,11,'consequat. Duis aute irure d')
,(14,2,10,'ex ea commodo consequat. Duis aute irure dolor in reprehenderit in')
,(6,3,2,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in repre')
,(3,4,2,'Excepteur')
,(16,3,18,'elit, sed do eiusmod tempor incididunt ut labore et dolore ma')
,(10,2,1,'occaecat cupidatat non proident, sunt in culpa qui offi')
,(2,2,17,'non proident, sunt in culpa qui officia deserunt mollit an')
,(3,1,9,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pari')
,(16,1,10,'cillum dolore eu fugiat nulla pariatur. Excepteur ')
,(11,3,4,'nisi ut aliquip ex ea commodo consequat. Duis aute i')
,(10,2,5,'cupidatat non proident, sunt in culpa qui officia deserunt mollit ani')
,(16,4,16,'sit amet, consectetur adipisci')
,(1,1,2,'sunt in culpa qui officia deserunt mollit anim id est ')
,(18,3,11,'eiusmod tempor incididunt ut labore et dolo')
,(17,1,3,'ir')
,(2,3,14,'nostr')
,(4,2,14,'incididunt ut labore et dolo')
,(2,2,1,'magna aliqua. Ut eni')
,(17,4,12,'magna ')
,(10,2,7,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea com')
,(12,4,8,'rum.Lorem ipsum dolor sit amet, consectetur adi')
,(1,3,10,'dolor sit amet, consectetur adi')
,(15,3,14,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adip')
,(17,2,14,'sunt in culpa qui officia deserunt mollit anim')
,(17,1,4,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est labo')
,(11,2,9,'sunt in culpa qui o')
,(13,1,2,'in reprehenderit in volup')
,(9,2,12,'labore')
,(1,4,12,'sunt in culpa qui officia deserunt mollit anim ')
,(8,2,3,'ullamco laboris nisi ut aliquip ex ea com')
,(17,2,6,'a')
,(5,2,3,'nostrud exercitation ullamco laboris')
,(10,3,8,'consectetur adipisc')
,(18,2,9,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidid')
,(8,3,2,'eu fugiat nulla pariatur')
,(16,3,6,'irure dolor in reprehenderit in voluptate velit esse cillum dolor')
,(14,3,3,'culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur ad')
,(17,3,3,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
,(12,1,6,'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaec')
,(7,4,12,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaec')
,(15,1,13,'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris')
,(3,3,7,'sed do eiusmod tempor incididunt ut ')
,(14,1,10,'mollit anim id')
,(7,4,9,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ')
,(15,3,5,'orum.Lorem ipsum dolor sit amet, c')
,(2,4,10,'anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit,')
,(4,3,2,'mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod')
,(12,1,18,'in voluptate velit esse cillum dolore eu fugiat nulla p')
,(4,3,3,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
,(17,4,14,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud')
,(16,2,3,'D')
,(1,3,18,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim ')
,(11,2,15,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipi')
,(10,4,5,'cillum dolore eu fugiat n')
,(17,2,15,'non proident, sunt in culpa qui officia deserunt mollit anim id es')
,(10,2,3,'ut labore et dolore magna aliqua. Ut enim ad')
,(11,4,15,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis no')
,(15,1,6,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
,(3,2,2,'in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet,')
,(6,1,11,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, s')
,(15,1,5,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupid')
,(8,4,5,'quis no')
,(18,1,16,'ut l')
,(13,3,5,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco lab')
,(14,2,6,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proiden')
,(3,1,13,'enim ad minim veniam, quis nostrud exercitation ullamco labo')
,(12,2,14,'ut aliquip ex ea commodo consequat. Duis aute ir')
,(8,4,4,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sin')
,(1,2,6,'elit, sed do eiusmod tempor incididunt ut labore et ')
,(2,2,13,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim venia')
,(7,4,11,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ')
,(7,2,15,'cupidatat non proident, sunt in culpa qu')
,(4,4,16,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia')
,(10,1,16,'um.Lorem ipsum dolor sit amet,')
,(18,4,3,'.Lorem ipsum dolor sit amet, consectetur a')
,(11,1,4,'aborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed')
,(2,1,14,'ut aliquip ex ea commodo conse')
,(2,4,12,'labore et dol')
,(16,4,14,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud e')
,(14,4,1,'esse cillum dolore eu fugiat nulla pariat')
,(8,1,15,'adipiscing eli')
,(13,3,18,'velit esse cillum')
,(12,2,2,'ullamco laboris nisi ut ali')
,(15,1,8,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ip')
,(15,3,5,'tempor ')
,(4,3,12,'dolor sit amet, consectetur adipiscing elit, sed')
,(10,3,16,'Duis aute irure dolor in reprehenderit in voluptate velit esse c')
,(18,4,10,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut l')
,(17,3,4,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercita')
,(4,2,18,'s')
,(1,3,15,'irure dolor in reprehenderit in voluptate velit esse c')
,(16,4,16,'veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ')
,(10,1,10,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud')
,(10,3,10,'pariatur. Excepteur ')
,(17,1,15,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidat')
,(17,1,8,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure ')
,(7,1,4,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ul')
,(17,2,2,'et dolore magna aliqu')
,(14,2,17,'adip')
,(7,3,2,'sunt in culpa qui officia deserunt mollit anim id es')
,(17,2,6,'ut aliquip ex ea ')
,(7,3,8,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui off')
,(15,2,6,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat no')
,(13,3,8,'cupid')
,(6,4,2,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp')
,(6,1,3,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in cu')
,(12,2,3,'sed do')
,(10,3,14,'elit, sed do eius')
,(15,1,11,'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteu')
,(15,3,3,'laborum.Lorem i')
,(8,3,6,'ut labore et dolore magna aliqua. ')
,(3,2,10,'pariatur. Excepteur sint occaecat cupid')
,(11,4,10,'velit esse cillum dolore eu fugiat nulla par')
,(3,1,13,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lo')
,(18,4,16,'ullamco laboris nisi ut aliquip ex ea commodo co')
,(16,1,18,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Except')
,(2,2,6,'cupidatat non proident, sunt in culpa qui officia d')
,(13,3,15,'la')
,(17,1,11,'cupidatat non proident, sunt in culpa qui officia des')
,(4,2,12,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nu')
,(15,2,1,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco l')
,(15,4,3,'aborum.Lorem ipsum dolor sit amet, consectetu')
,(7,4,13,'dolor i')
,(8,3,11,'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehe')
,(7,4,12,'ut labore et dolore magn')
,(9,1,9,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt i')
,(13,2,17,'non proident, sunt in culpa qui officia deserunt mollit anim id est ')
,(12,2,4,'do ei')
,(16,3,18,'ipsum dolor sit amet, consectetur adipiscing elit, se')
,(3,1,12,'culpa qui officia deserunt mollit anim ')
,(7,3,13,'occaecat c')
,(6,3,7,'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nul')
,(10,1,3,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetu')
,(3,2,14,'velit esse cillum dolore eu f')
,(9,3,12,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugia')
,(14,1,1,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,')
,(18,2,16,'non p')
,(10,2,10,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor')
,(16,3,16,'cillum dolore eu fugiat nulla pariat')
,(3,1,18,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco')
,(4,2,4,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation u')
,(7,1,11,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
,(3,1,18,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi')
,(9,4,1,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia dese')
,(3,4,10,'in culpa qui officia deserunt mo')
,(17,4,16,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing')
,(6,2,5,'in culpa qui officia deserunt mollit')
,(14,4,17,'Ut enim ad minim veniam, quis nostrud exercitation ullamco labo')
,(3,1,14,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dol')
,(17,3,17,'ex ea commodo consequat. Duis aute irure dolor in')
,(17,1,14,'ex ea commodo consequat. Duis aute irure dolor in reprehender')
,(18,2,13,'ex ea commodo consequat')
,(13,4,2,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ')
,(11,4,7,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in c')
,(5,4,3,'quis nostrud exercitation ')
,(6,3,4,'commodo co')
,(18,1,6,'eu fugiat nulla pariatur. Excepteur sint ')
,(5,4,7,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugia')
,(16,3,1,'ut aliquip ex ea commodo consequat. D')
,(5,4,7,'dolore eu fugiat ')
,(12,4,12,'exercitation ullamco laboris nisi ut ')
,(14,2,12,'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia des')
,(13,2,12,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod t')
,(2,1,18,'veniam, quis nostrud exercitation ull')
,(17,4,8,'ex ea commodo consequat')
,(12,3,7,'pariatur. Excepteur sint occaecat cupidatat non pr')
,(15,2,16,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. D')
,(13,3,4,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor')
,(11,3,12,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteu')
,(4,2,15,'sunt in culpa qui officia deserunt mollit anim id')
,(6,2,17,'ut labore et d')
,(10,3,9,'in reprehenderit in voluptate velit esse cillum dolo')
,(15,4,14,'velit esse cillum dolore eu fu')
,(3,1,1,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscin')
,(6,2,8,'minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
,(13,2,12,'dolor sit amet, consectetur adip')
,(12,1,1,'qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consecte')
,(8,1,17,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim venia')
,(4,3,15,'consequat. Duis aute irure dolor in reprehender')
,(16,1,10,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis')
,(4,1,6,'velit esse cillum dolo')
,(9,1,7,'laboris nisi ut aliquip ex ')
,(1,3,16,'commodo consequat. Duis aute irure dolor in reprehenderit in vol')
,(11,3,7,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud')
,(9,4,18,'dolore eu ')
,(15,3,3,'irure dolor in reprehenderit in voluptate velit ')
,(14,4,18,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia dese')
,(16,2,11,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, ')
,(9,1,13,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proiden')
,(13,1,1,'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in re')
,(3,4,12,'minim veniam, quis nostrud e')
,(1,4,8,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ')
,(17,2,8,'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magn')
,(16,2,16,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillu')
,(17,2,5,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia d')
,(11,3,2,'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deser')
,(11,1,10,'ut aliquip ex ea commodo consequat. Duis aut')
,(8,3,12,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,')
,(14,4,14,'aute irure dolor in rep')
,(18,2,17,'proident, sunt in culpa qui officia deserunt mollit anim id est laboru')
,(5,4,3,'cillum dolore eu fugiat nulla pariatur. Excepteur')
,(1,4,14,'enim ad minim veniam, quis nostrud e')
,(13,2,6,'ut labore et d')
,(9,3,17,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt')
,(15,2,8,'mollit anim id est laborum.Lorem ip')
,(9,1,15,'te')
,(10,1,12,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor ')
,(16,1,3,'labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ex')
,(2,1,13,'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat n')
,(7,2,7,'do eiusmod tempor incididunt ut ')
,(12,3,18,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercita')
,(18,2,9,'ex ea commo')
,(11,3,15,'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in vo')
,(15,1,14,'adi')
,(9,3,13,'cupidatat non ')
,(12,3,14,'in v')
,(17,1,14,'exercitation ullamco laboris nisi ut aliqui')
,(8,4,4,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ')
,(14,4,5,'commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit')
,(3,4,5,'consectetur adipiscing elit, sed do eiusmod tempor in')
,(11,3,12,'dolor sit amet, consectetur')
,(12,1,9,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia ')
,(9,3,10,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea ')
,(2,1,15,'exercitation ullamco laboris nisi ut aliquip ex ea commodo cons')
,(9,3,9,'ut labore et dolo')
,(13,3,11,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui of')
,(14,2,7,'commodo consequat. Duis aute irure dolor in reprehenderit in voluptate ve')
,(13,1,13,'eiusmod te')
,(11,4,1,'eu fugiat nulla pariatur. Excepteur si')
,(15,1,12,'non proident, sunt in culpa qui officia de')
,(11,2,15,'dolore magna aliqua. Ut enim ad minim veniam, quis n')
,(4,2,11,'laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit')
,(5,3,6,'.Lorem ipsum dolor')
,(5,4,11,'esse cillum dolore eu fugiat n')
,(1,3,10,'Ut enim ad minim veniam, quis nostrud exercitation ull')
,(16,3,10,'anim id est laborum.Lorem ipsum dolor')
,(16,4,3,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ')
,(5,1,9,'incididunt ut labore et dolore magna aliqua. Ut enim ad ')
,(3,3,18,'et dolore magna aliqu')
,(4,4,9,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam')
,(18,3,17,'D')
,(8,3,11,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dol')
,(10,4,9,'Excepteur sint occa')
,(18,4,2,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dol')
,(3,1,2,'est laborum.Lorem ipsum dolor sit')
,(16,3,8,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni')
,(8,1,17,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute ')
,(5,2,5,'laborum.Lor')
,(8,4,15,'nisi ut aliquip ex ea commodo consequat. Duis aute iru')
,(11,3,4,'qui officia des')
,(7,2,13,'anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusm')
,(16,2,3,'eu fugiat nulla pa')
,(18,1,13,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit,')
,(2,2,11,'D')
,(12,3,3,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ir')
,(12,3,16,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis ')
,(8,2,17,'in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor s')
,(8,3,10,'cupidatat non proident, sunt in culpa qui o')
,(17,3,8,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure')
,(3,4,11,'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla p')
,(15,3,16,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliq')
,(9,3,6,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ulla')
,(10,3,1,'est laborum.Lorem')
,(10,3,3,'nulla pariatur. Excepteu')
,(9,2,4,'i')
,(17,2,13,'Duis aute irure dolor in reprehend')
,(4,3,3,'eu fugiat nulla pariatur. Excepteur sint occaecat')
,(9,2,3,'veniam, quis nostrud exercit')
,(10,4,2,'nulla pariatur. Excepteur sint occaecat ')
,(10,4,2,'Ut enim ad minim veniam, quis nos')
,(6,4,4,'Duis aute irure dolor in reprehende')
,(10,4,7,'dolore eu fugiat nulla pariatur. Excepte')
,(4,4,2,'tempor incididunt ut labore e')
,(18,2,7,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur ad')
,(14,4,13,'sunt')
,(17,4,11,'nostrud exercitation ullamco laboris nisi ut ')
,(12,2,2,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercit')
,(2,1,7,'Ut enim ad minim veniam, q')
,(15,1,2,'quis nostrud exercitation ullamco labor')
,(14,3,11,'cillum dolore eu fugiat nu')
,(14,4,18,'velit ess')
,(1,4,12,'nisi u')
,(13,1,14,'voluptate velit esse cillum dolore eu fugiat nulla pariatu')
,(17,1,2,'exercitation ullamco laboris nisi ut')
,(18,3,1,'pariatur. Excepteur sint occaecat cupidatat no')
,(12,2,10,'anim id est laborum.Lorem ipsum dolor sit amet, consect')
,(1,4,16,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid')
,(2,1,8,'consectetur adipiscing elit, sed do eiusmod tempor incididun')
,(11,4,6,'cillum dolore eu fugiat nulla pariatu')
,(1,2,15,'deserunt mollit anim id est l')
,(1,2,5,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidid')
,(11,2,5,'dolor sit amet, consectetur adipiscing elit')
,(9,1,10,'qui officia deserunt mollit anim id est laborum.Lorem ip')
,(2,1,6,'elit, sed do ei')
,(2,4,15,'consequat. Duis aute irure dolor in reprehenderit in ')
,(12,1,4,'m.Lorem ipsum dol')
,(10,3,11,'tempor incididunt ut labore et dolore magna aliqua. Ut en')
,(7,3,16,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ips')
,(14,4,11,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proide')
,(17,1,4,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est')
,(11,4,1,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in repreh')
,(2,2,4,'et dolor')
,(14,4,18,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet,')
,(1,1,17,'et dolore magna aliqua. Ut ')
,(12,1,8,'nulla pariatur. Excepteur sint occaecat cupidatat non proi')
,(9,4,6,'et dolore magna aliqua. Ut enim ad minim veniam, qu')
,(6,4,16,'ut aliquip e')
,(11,4,5,'in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, cons')
,(6,3,15,'amet, consectetur adipiscing elit, sed do eiusmod tempor inci')
,(7,1,12,'eu fugiat nulla pariatur. Excepteur sint')
,(7,2,2,'exercitation ullamco laboris nisi ut al')
,(2,1,14,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut al')
,(15,3,1,'anim id est laborum.L')
,(5,1,14,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut ')
,(4,4,13,'mollit anim id est laborum.Lorem ipsum dolor sit amet, co')
,(8,4,2,'la')
,(7,1,8,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in rep')
,(3,4,3,'laborum.Lorem ipsum dolor sit amet, consectetur adi')
,(12,2,17,'aute irure dolor in reprehe')
,(7,4,16,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occae')
,(12,2,5,'Excepteur ')
,(16,3,13,'in reprehend')
,(2,2,1,'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occa')
,(9,1,6,'culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur ad')
,(3,3,3,'laborum.Lorem ipsum dolor')
,(4,1,1,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis')
,(10,3,17,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut a')
,(16,1,4,'eiusmod tempor incididunt ut labore et dolore magna al')
,(5,1,9,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lab')
,(18,3,15,'sint occaecat cupidatat non pro')
,(12,2,3,'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt m')
,(15,4,6,'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo co')
,(1,4,8,'non proident, sunt in culpa qui of')
,(4,3,8,'i')
,(1,1,3,'officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisc')
,(13,1,4,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dol')
,(15,4,13,'eu fu')
,(14,4,17,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labori')
,(1,2,6,'amet, consectetur adipiscing elit, ')
,(12,2,3,'ex ea commodo consequat. Duis aute irure dolor')
,(10,3,13,'amet, consectetur adi')
,(13,4,2,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscin')
,(17,3,12,'exercitation ullamco laboris nisi ut aliquip ex ea commodo co')
,(6,3,13,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco')
,(14,2,6,'sunt in culpa q')
,(17,1,1,'qui officia deserunt mollit anim id est laborum.Lorem ipsu')
,(6,4,7,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit an')
,(16,2,11,'anim id est ')
,(16,2,15,'dolor in reprehenderit i')
,(13,2,12,'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ')
,(5,4,18,'ullamco laboris nisi ut al')
,(7,2,2,'incididunt ut labore et dol')
,(11,4,16,'.Lorem ipsum dolor sit amet,')
,(16,4,13,'minim veniam, quis')
,(11,3,17,'deserunt mollit anim id est labo')
,(4,2,14,'e')
,(8,4,16,'Duis aute irure dolor in reprehenderit in volupt')
,(1,2,14,'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim')
,(9,1,2,'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco l')
,(5,2,4,'nisi ut aliquip ex ea commodo c')
,(4,3,2,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugia')
,(13,1,14,'anim id est laborum.L')
,(16,1,1,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliqu')
,(6,2,18,'qui officia deseru')
,(17,4,10,'consequa')
,(10,4,2,'exercitation ullamco laboris nisi ut ali')
,(16,4,15,'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
,(2,3,6,'sed do eiusmod tempor inci')
,(2,3,11,'laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate')
,(10,1,8,'adipiscing elit, sed do eiusmod tempor inc')
,(5,1,8,'deserunt mollit anim id est laborum.L')
,(12,3,12,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur')
,(14,4,1,'in culpa qui o')
,(9,4,5,'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidat')
,(1,3,16,'proident, sunt in culpa qui officia deserunt mo')
,(18,2,4,'laboris nisi ut aliquip ex ea commodo consequat. Du')
,(6,4,1,'cillum dolore eu fugia')
,(18,1,9,'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commod')
,(18,2,1,'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitatio')
,(1,4,3,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco')
,(13,4,15,'et dolore magna aliqua. Ut en')
,(14,4,17,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
,(12,3,17,'consequat. Duis aute irure dolor in reprehenderit in voluptate v')
,(4,1,8,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis a')
,(3,4,8,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ')
,(17,4,1,'ullam')
,(10,1,18,'ad minim veniam, qui')
,(15,4,7,'labore et dolore magna aliqua. Ut enim ad minim veniam')
,(16,4,16,'non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lor')
,(7,1,2,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, qui')
,(16,4,5,'anim id est laborum.Lorem ipsum dolor sit amet, consect')
,(4,1,5,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea ')
,(18,1,13,'dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ')
,(13,4,14,'nisi ut aliquip ex ea commodo consequat. Duis aute')
,(5,2,18,'non proident, sunt in culpa qui officia deserunt mollit anim')
,(17,2,6,'consectetur adipiscing elit, sed do eiusmod tempor incididun')
,(12,1,1,'magna aliqua. Ut enim ad')
,(6,2,17,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla paria')
,(5,3,8,'tempor incididunt ut labore ')
,(13,3,3,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia des')
,(9,4,4,'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in')
,(12,4,13,'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea')
,(16,2,16,'ut aliquip ex ea commodo consequat. Duis aute irure dolor in r')
,(17,2,2,'deserunt mollit anim id ')
,(2,2,2,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam')
,(9,1,17,'cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laboru')
,(4,3,16,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm')
,(11,4,15,'amet, consectetur a')
,(17,3,4,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proide')
,(4,2,17,'ex ea commodo consequat. Duis aute iru')
,(8,1,12,'ali')
,(1,2,9,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit am')
,(8,1,12,'in c')
,(12,3,5,'id est laborum.Lorem ips')
,(3,1,12,'cupidatat non ')
,(3,4,10,'id est laborum.Lorem ipsum dolor sit amet, consectetur')
,(17,3,15,'enim ad minim veniam, quis nos')
,(18,1,15,'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugi')
,(1,1,5,'culpa qui officia deserunt mollit anim id e')
,(12,4,17,'sed do eiusmod tempor incididun')
,(11,2,7,'ullamco laboris nisi ut ')
,(12,4,15,'ut labore et dolore magna')
,(18,1,2,'voluptate velit esse cillum ')
,(15,4,2,'elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut en')
,(16,1,4,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adip')
,(11,4,5,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non p')
,(2,2,10,'ex ea commodo ')
,(6,1,11,'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pa')
,(13,4,13,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni')
,(4,4,9,'ut aliquip ex ea commodo consequat. Duis')
,(18,2,17,'aborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d')
,(13,4,12,'in reprehenderit in voluptate velit e')
,(5,4,13,'nu')
,(1,2,6,'ad minim veniam, quis nostrud exercitation ullamco labori')
,(14,4,5,'minim veniam, ')
,(7,1,13,'dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla p')
,(10,2,5,'sint occaecat cupidatat non proident, s')
,(10,4,7,'in voluptate velit esse cillum dolore eu fu')
,(13,3,18,'culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetu')
,(2,3,13,'magna aliqua. Ut enim ad minim veniam, quis nostrud exerci')
,(12,2,11,'occaecat cupidatat non pro')
,(16,2,7,'et dolore magna ali')
,(4,3,12,'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ull')
,(7,3,14,'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commod')
,(18,4,13,'sunt in culpa qui officia deserunt mollit a')
,(7,3,11,'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui o')
,(3,2,13,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exe')
,(13,4,11,'incididunt ut labor')
,(16,4,11,'quis nostrud exercitation ullamco lab')
,(11,4,11,'ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nos')
,(9,1,14,'laboris nisi ')
,(11,1,4,'cupidatat non proident, sunt')
,(14,4,4,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupid')
,(18,4,6,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ')
,(8,4,11,'do eiusmod tempor incididunt ut labore et dolore ma')
,(6,4,8,'Ut enim ad minim ven')
,(7,3,7,'consectetur adipiscing elit, sed do eiusmod tempor incidi')
,(14,3,1,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non pro')
,(1,4,13,'exercitation ullamco laboris nisi ut ali')
,(15,4,1,'sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim ')
,(13,3,2,'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum d')
,(4,1,1,'aute irure dolor in reprehenderit in voluptate velit esse cillum dolor')
,(11,1,11,'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupid')
,(16,4,8,'elit, sed do eiusmod')
,(15,4,12,'nulla pariatur. Excepteur sint occaecat cupidatat non pro')
,(4,1,5,'cupidatat non proident, sunt in culpa qui officia deserunt m')
,(15,2,12,'occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum')
,(13,3,4,'Excepteur sint occaecat cupidatat non proident, sunt in cul')
,(18,3,5,'sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit ame')
,(2,4,8,'velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaec')
,(13,3,2,'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate ve')
,(7,2,4,'in voluptate velit esse cillum dolore ')
,(10,3,18,'ullam')
,(16,1,13,'non proident, sunt in culpa qui')
,(16,3,10,'ut')
,(8,4,17,'sunt in culpa qui officia deserun')
,(15,2,3,'irure dolor in reprehenderit in voluptate velit')
,(11,1,12,'esse cillum dolore eu fugiat nulla pariatur. E')
,(8,4,13,'minim veniam, quis nostrud exercitation ullamco')
,(11,3,14,'eu fugiat nulla pariatur. Excepteur sint occa')
,(12,3,2,'elit, sed do eiusmod tempor inci')
,(11,1,11,'sunt in culpa qui officia des')
,(18,2,12,'do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nost')
,(13,3,2,'deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetu')
,(9,3,6,'aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Ex')
,(17,1,17,'et dolore magna ali')
,(4,3,13,'um.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod')
,(8,4,2,'adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna a')
,(13,2,9,'quis nostrud exercitation ullamco laboris nisi ut aliqui')
,(9,3,10,'non pro')
,(2,2,6,'sunt in culpa')
,(17,3,13,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui off')
,(9,3,3,'Excepteur sint occaeca')
,(10,4,16,'aute irure dolor in repreh')
,(14,4,6,'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat ')
,(8,1,13,'velit esse cillum dolore eu fugi')
,(4,4,18,'deserunt mollit anim id est laborum.Lorem ipsum dolor')
,(18,1,2,'ad minim veniam, quis nostrud exercit')
,(4,2,17,'elit, sed do eiusmod tempor incididunt ut labore et dolo')
,(11,3,8,'cupidatat non proident, sunt in culpa qui officia')
,(3,3,10,'consectetur adipiscing elit, sed do eiusmod tempor i')
,(17,4,15,'nostrud')
,(13,1,15,'velit')
,(18,2,12,'magna aliqua. Ut enim ad minim ven')
,(10,1,12,'id est laborum.Lorem')
,(5,1,5,'cupidatat non proident, sunt ')
,(12,2,1,'et dolore magna aliqua. Ut enim ad minim veniam,')
,(14,1,1,'sint occaecat cupidatat non pro')
,(11,3,13,'et dolore')
,(4,3,10,'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui offic')
,(1,3,6,'nostrud exercitation ullamco laboris nisi ut aliquip ex ea')
,(13,1,5,'eu fugiat nulla pariatur. Excepteur sint occaecat cupid')
,(6,1,10,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa ')
,(12,1,17,'magna aliqua. Ut enim ad mini')
,(9,1,6,'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ')
,(4,4,14,'sunt in ')
,(16,1,12,'tempor incididunt ut labore et d')
,(14,2,5,'in culpa qui officia de')
,(5,1,17,'in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla paria')
,(8,4,13,'irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ')
,(5,2,12,'sed do eiusmod tempor in')
,(8,3,3,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labor')
,(14,3,17,'incididun')
,(18,3,7,'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercita')
,(12,4,5,'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim ve')
,(14,1,7,'eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, s')
,(10,1,11,'id est laborum.Lorem')
,(6,3,7,'sit amet, consectetur adipiscing elit, sed do eiusmod tempor inc')
,(7,3,1,'id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit')
,(9,2,5,'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm')
,(11,3,7,'cillum dolore eu fugia')
,(13,3,8,'mollit anim id')
,(16,1,11,'ullamco laboris')
,(3,4,8,'Duis aute irure dolor in reprehender')
,(1,2,10,'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint')
,(8,1,4,'ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ')
,(6,1,7,'quis')
,(18,2,3,'dolore eu fugiat nul')
,(3,2,2,'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nost')
,(3,2,2,'labore et dolo')
,(9,4,11,'nostrud ')
,(6,4,2,'in volupta')
,(5,2,16,'deserunt mollit anim')
,(13,2,4,'mollit anim id est laboru')
,(1,4,18,'ad minim veniam, quis nostrud exercitation ullamco laboris nis')
,(1,2,7,'mol')
,(13,3,13,'cupidatat non proident, sunt ')
,(6,4,17,'Ut enim a')
,(13,4,6,'pariatur. Excepte');

INSERT INTO clothing_store.products_colors_sizes (product,color,`size`) VALUES 
(268,4,1)
,(81,2,1)
,(164,9,2)
,(146,10,3)
,(196,6,5)
,(104,9,2)
,(244,6,4)
,(39,1,2)
,(573,7,5)
,(12,13,4)
,(160,15,5)
,(54,8,4)
,(44,13,4)
,(273,9,2)
,(424,8,3)
,(414,3,4)
,(15,8,5)
,(328,14,2)
,(527,6,2)
,(416,1,1)
,(54,5,4)
,(474,15,4)
,(162,4,1)
,(356,6,2)
,(419,1,1)
,(10,12,4)
,(36,12,1)
,(77,7,3)
,(176,9,4)
,(364,9,4)
,(28,9,3)
,(442,1,2)
,(215,6,5)
,(302,10,6)
,(56,6,1)
,(346,5,5)
,(396,5,4)
,(505,3,2)
,(275,14,1)
,(555,8,6)
,(359,2,5)
,(268,7,6)
,(545,1,6)
,(144,1,2)
,(470,6,1)
,(565,14,1)
,(428,9,6)
,(500,3,3)
,(304,3,1)
,(564,8,3)
,(487,14,2)
,(511,2,6)
,(139,2,5)
,(471,15,6)
,(279,7,5)
,(268,4,3)
,(199,1,3)
,(588,3,6)
,(2,12,2)
,(28,7,4)
,(84,5,1)
,(238,4,1)
,(599,3,4)
,(315,8,2)
,(413,10,6)
,(542,7,5)
,(205,3,5)
,(180,3,1)
,(480,9,6)
,(301,4,2)
,(56,9,2)
,(220,3,5)
,(597,4,4)
,(372,11,2)
,(582,1,3)
,(280,3,6)
,(204,8,2)
,(113,1,4)
,(327,9,2)
,(148,1,6)
,(308,4,5)
,(494,14,5)
,(27,6,3)
,(306,2,6)
,(566,4,5)
,(55,1,6)
,(573,6,2)
,(355,7,4)
,(88,3,3)
,(72,5,4)
,(165,11,3)
,(532,5,1)
,(477,3,1)
,(97,1,6)
,(308,14,6)
,(575,3,6)
,(457,12,3)
,(271,3,1)
,(472,14,5)
,(37,14,1)
,(67,15,3)
,(352,4,1)
,(279,10,6)
,(566,3,3)
,(275,5,4)
,(170,1,6)
,(441,13,2)
,(357,1,4)
,(195,2,6)
,(176,7,6)
,(542,9,5)
,(130,8,4)
,(201,9,2)
,(66,4,2)
,(430,10,3)
,(557,15,4)
,(122,10,4)
,(376,3,3)
,(399,8,2)
,(492,6,5)
,(19,7,6)
,(212,5,1)
,(337,7,2)
,(57,7,6)
,(1,10,6)
,(561,10,3)
,(326,2,4)
,(459,10,3)
,(600,12,5)
,(155,2,2)
,(69,8,4)
,(159,13,6)
,(273,7,1)
,(340,11,4)
,(381,5,6)
,(452,7,5)
,(548,5,6)
,(320,3,5)
,(310,9,5)
,(32,6,6)
,(213,6,1)
,(286,15,6)
,(172,15,4)
,(201,12,4)
,(59,12,4)
,(132,8,5)
,(509,10,2)
,(260,2,6)
,(347,10,6)
,(526,4,6)
,(194,13,1)
,(484,13,6)
,(179,10,5)
,(402,15,1)
,(258,11,3)
,(535,13,1)
,(155,13,3)
,(539,14,6)
,(81,4,5)
,(99,1,3)
,(422,4,3)
,(551,4,5)
,(335,3,6)
,(440,11,6)
,(501,7,3)
,(111,15,6)
,(349,9,6)
,(202,4,2)
,(77,15,2)
,(156,11,4)
,(163,5,3)
,(414,8,3)
,(503,6,2)
,(208,3,5)
,(445,1,6)
,(254,8,4)
,(141,12,4)
,(256,5,4)
,(564,15,1)
,(515,14,6)
,(565,9,1)
,(84,2,3)
,(328,14,1)
,(534,10,1)
,(454,6,5)
,(551,1,4)
,(227,4,5)
,(155,7,6)
,(38,5,4)
,(146,13,1)
,(97,7,3)
,(434,12,4)
,(126,1,2)
,(432,14,5)
,(444,6,3)
,(555,8,5)
,(517,8,1)
,(525,7,2)
,(339,15,1)
,(213,4,3)
,(1,5,4)
,(24,12,3)
,(594,9,2)
,(84,6,1)
,(285,14,1)
,(258,8,1)
,(214,7,5)
,(397,2,5)
,(292,5,6)
,(433,2,5)
,(415,3,3)
,(559,2,6)
,(148,4,4)
,(534,14,3)
,(295,10,5)
,(463,8,4)
,(165,13,3)
,(256,12,2)
,(193,11,4)
,(263,14,6)
,(264,2,6)
,(34,13,4)
,(515,9,4)
,(277,9,6)
,(597,9,5)
,(112,11,5)
,(470,3,4)
,(596,2,2)
,(324,13,6)
,(505,15,4)
,(532,11,2)
,(361,2,5)
,(533,3,3)
,(441,14,3)
,(89,14,4)
,(132,15,6)
,(251,1,2)
,(398,4,5)
,(465,13,5)
,(393,1,6)
,(580,15,2)
,(565,4,3)
,(257,9,2)
,(242,5,5)
,(372,12,5)
,(513,14,3)
,(194,3,2)
,(35,2,1)
,(542,1,2)
,(199,1,3)
,(233,7,5)
,(289,14,3)
,(68,8,5)
,(8,11,6)
,(290,15,3)
,(232,14,6)
,(222,5,5)
,(324,6,4)
,(458,11,1)
,(351,7,5)
,(174,5,6)
,(415,3,3)
,(99,6,3)
,(26,6,4)
,(484,10,6)
,(355,15,1)
,(434,9,6)
,(28,4,2)
,(494,10,1)
,(138,12,6)
,(36,10,3)
,(431,6,4)
,(599,3,5)
,(342,1,4)
,(95,15,2)
,(330,3,4)
,(592,7,2)
,(520,3,2)
,(398,14,3)
,(77,9,4)
,(389,4,5)
,(113,11,1)
,(372,1,1)
,(236,12,2)
,(406,4,3)
,(463,14,5)
,(202,11,5)
,(62,12,6)
,(493,15,6)
,(328,10,4)
,(83,12,6)
,(593,4,2)
,(207,11,3)
,(36,6,1)
,(284,14,2)
,(531,3,2)
,(243,2,2)
,(490,4,1)
,(449,4,3)
,(575,8,1)
,(184,10,2)
,(370,2,2)
,(51,4,2)
,(443,5,5)
,(580,8,2)
,(594,15,5)
,(390,14,6)
,(554,2,4)
,(14,7,3)
,(55,1,5)
,(270,13,2)
,(99,11,2)
,(61,12,4)
,(490,8,4)
,(49,13,5)
,(132,8,3)
,(498,2,2)
,(468,9,6)
,(439,4,2)
,(332,14,2)
,(263,8,5)
,(415,10,2)
,(23,1,4)
,(380,6,6)
,(523,9,5)
,(155,3,6)
,(116,6,2)
,(441,9,4)
,(14,3,6)
,(362,12,6)
,(556,6,5)
,(282,3,4)
,(263,13,3)
,(89,1,2)
,(592,5,5)
,(72,11,4)
,(589,2,6)
,(219,14,1)
,(159,7,4)
,(366,7,1)
,(193,14,3)
,(579,13,6)
,(318,5,1)
,(110,3,1)
,(475,15,6)
,(422,14,1)
,(386,6,2)
,(246,8,6)
,(292,5,4)
,(154,14,4)
,(566,9,6)
,(533,14,5)
,(224,1,2)
,(583,8,4)
,(216,8,4)
,(246,12,1)
,(230,5,1)
,(169,3,2)
,(141,7,2)
,(120,10,2)
,(280,15,5)
,(23,5,3)
,(269,7,6)
,(167,4,2)
,(325,8,6)
,(67,10,2)
,(273,1,4)
,(67,11,6)
,(158,10,4)
,(502,11,6)
,(153,14,3)
,(370,15,3)
,(262,6,2)
,(151,5,2)
,(338,14,2)
,(253,1,1)
,(546,15,5)
,(248,4,6)
,(229,4,3)
,(468,14,4)
,(247,8,5)
,(454,5,4)
,(394,9,2)
,(391,14,4)
,(307,8,2)
,(155,15,4)
,(187,4,2)
,(402,7,1)
,(108,3,5)
,(537,14,1)
,(453,12,4)
,(451,15,6)
,(245,10,6)
,(484,8,4)
,(289,11,2)
,(35,5,5)
,(255,11,1)
,(269,9,6)
,(322,1,3)
,(391,6,3)
,(44,14,1)
,(423,14,6)
,(182,13,1)
,(595,14,4)
,(399,7,6)
,(328,10,2)
,(247,1,2)
,(298,7,1)
,(215,5,4)
,(270,15,5)
,(460,5,2)
,(468,1,3)
,(169,13,3)
,(507,10,2)
,(488,7,3)
,(483,11,4)
,(45,12,3)
,(302,8,3)
,(356,14,2)
,(356,9,5)
,(441,15,6)
,(359,13,2)
,(528,10,4)
,(583,1,4)
,(194,13,2)
,(263,2,3)
,(100,12,4)
,(499,2,1)
,(530,8,2)
,(242,3,2)
,(165,2,5)
,(506,7,6)
,(411,2,2)
,(482,12,2)
,(364,14,2)
,(83,15,3)
,(321,6,5)
,(1,11,3)
,(464,6,6)
,(186,14,2)
,(21,10,3)
,(171,12,4)
,(275,5,5)
,(392,11,1)
,(77,14,2)
,(149,13,3)
,(490,6,4)
,(136,14,5)
,(145,13,4)
,(110,1,1)
,(358,8,3)
,(112,8,5)
,(273,8,6)
,(56,2,5)
,(160,4,3)
,(8,13,2)
,(131,4,6)
,(99,9,3)
,(370,15,1)
,(146,7,6)
,(144,4,3)
,(519,12,6)
,(288,8,3)
,(5,11,3)
,(302,4,1)
,(459,1,4)
,(580,1,5)
,(488,5,1)
,(80,8,5)
,(191,15,2)
,(473,6,1)
,(128,3,2)
,(593,4,5)
,(506,7,5)
,(192,13,2)
,(6,5,2)
,(63,10,2)
,(33,15,1)
,(22,1,1)
,(184,7,2)
,(452,4,2)
,(229,12,1)
,(367,3,5)
,(90,1,5)
,(337,6,5)
,(303,2,3)
,(3,12,2)
,(185,3,6)
,(83,6,3)
,(259,3,3)
,(222,6,5)
,(116,3,2)
,(167,13,4)
,(454,3,5)
,(390,13,5)
,(47,1,1)
,(385,3,6)
,(270,4,4)
,(397,5,5)
,(429,5,1)
,(552,5,5)
,(21,10,3)
,(183,1,1)
,(233,2,4)
,(94,3,1)
,(104,2,1)
,(253,12,5)
,(529,5,1)
,(387,4,3)
,(370,15,2)
,(47,2,6)
,(280,15,2)
,(401,4,4)
,(40,1,4)
,(593,2,4)
,(559,12,4)
,(243,14,4)
,(593,2,1)
,(260,3,1)
,(199,10,4)
,(390,9,2)
,(60,12,1)
,(93,12,6)
,(389,2,2)
,(529,8,1)
,(342,14,1)
,(411,5,2)
,(370,10,4)
,(385,11,6)
,(238,10,2)
,(402,5,4)
,(102,3,3)
,(157,14,1)
,(175,8,5)
,(372,3,4)
,(217,10,1)
,(545,10,6)
,(538,12,2)
,(527,12,4)
,(45,7,2)
,(22,2,1)
,(309,15,6)
,(562,4,4)
,(331,15,5)
,(205,12,5)
,(83,9,4)
,(73,4,3)
,(241,4,2)
,(300,1,1)
,(441,5,6)
,(40,8,3)
,(501,3,1)
,(514,7,5)
,(67,7,4)
,(267,14,3)
,(1,8,6)
,(580,11,6)
,(297,10,3)
,(252,9,1)
,(459,2,4)
,(282,12,4)
,(409,1,2)
,(334,4,2)
,(567,9,3)
,(475,13,6)
,(410,4,3)
,(542,10,6)
,(227,1,4)
,(573,13,5)
,(194,13,2)
,(506,4,3)
,(223,5,3)
,(170,9,3)
,(341,6,4)
,(514,12,4)
,(447,6,2)
,(460,14,2)
,(522,10,1)
,(26,7,3)
,(110,13,5)
,(160,13,5)
,(507,2,1)
,(201,3,1)
,(544,4,6)
,(304,8,3)
,(322,7,6)
,(444,7,3)
,(541,6,4)
,(427,1,1)
,(3,13,6)
,(476,6,1)
,(149,11,3)
,(359,13,3)
,(538,6,6)
,(14,1,2)
,(556,1,3)
,(519,15,5)
,(449,5,4)
,(377,13,5)
,(596,11,2)
;
INSERT INTO clothing_store.products_colors_sizes (product,color,`size`) VALUES 
(519,12,1)
,(325,1,3)
,(130,6,3)
,(457,11,5)
,(588,5,2)
,(582,2,6)
,(579,7,4)
,(549,5,2)
,(201,8,2)
,(161,14,6)
,(370,15,4)
,(473,10,6)
,(411,8,3)
,(532,11,6)
,(53,14,3)
,(548,1,4)
,(422,5,4)
,(142,12,1)
,(492,9,4)
,(579,5,1)
,(41,13,5)
,(320,14,5)
,(343,9,1)
,(133,11,4)
,(405,7,3)
,(468,12,2)
,(550,10,4)
,(90,6,1)
,(315,13,4)
,(152,14,3)
,(79,15,3)
,(368,15,3)
,(467,3,3)
,(95,3,5)
,(234,15,2)
,(121,9,2)
,(136,15,2)
,(245,5,2)
,(329,1,2)
,(340,14,4)
,(296,10,6)
,(596,2,1)
,(43,9,6)
,(206,8,5)
,(466,5,3)
,(328,15,2)
,(72,2,6)
,(53,9,6)
,(352,1,5)
,(355,1,4)
,(222,12,2)
,(561,7,5)
,(212,11,4)
,(581,6,1)
,(241,3,2)
,(191,8,4)
,(183,3,3)
,(196,1,3)
,(26,3,4)
,(204,1,2)
,(204,8,4)
,(44,4,6)
,(374,12,1)
,(402,15,1)
,(156,14,4)
,(460,15,3)
,(111,10,4)
,(130,5,2)
,(122,7,6)
,(509,4,3)
,(200,13,4)
,(62,4,4)
,(54,1,1)
,(367,10,4)
,(170,12,6)
,(393,8,2)
,(551,7,2)
,(585,12,4)
,(100,10,6)
,(566,13,4)
,(361,12,2)
,(397,2,1)
,(311,15,1)
,(242,15,3)
,(551,5,5)
,(270,4,6)
,(327,11,5)
,(591,6,6)
,(130,10,4)
,(294,10,1)
,(397,7,5)
,(525,5,6)
,(383,7,4)
,(249,7,4)
,(73,12,6)
,(495,13,5)
,(286,9,5)
,(440,9,5)
,(389,10,2)
,(432,14,3)
,(542,4,2)
,(522,8,6)
,(501,3,2)
,(416,7,4)
,(279,5,4)
,(310,6,1)
,(587,7,6)
,(447,5,5)
,(496,7,5)
,(429,1,6)
,(327,13,5)
,(236,15,2)
,(174,7,6)
,(191,4,4)
,(339,3,2)
,(234,11,1)
,(342,1,6)
,(53,7,1)
,(28,10,1)
,(160,7,6)
,(593,11,5)
,(599,3,4)
,(52,8,4)
,(579,1,3)
,(462,4,2)
,(193,1,5)
,(53,1,6)
,(187,10,5)
,(14,15,5)
,(174,8,4)
,(440,1,6)
,(103,14,2)
,(145,8,4)
,(25,11,5)
,(588,8,2)
,(261,2,1)
,(270,1,2)
,(292,15,4)
,(50,4,5)
,(290,3,6)
,(543,15,6)
,(456,15,5)
,(532,9,5)
,(522,11,2)
,(218,4,1)
,(15,11,1)
,(166,3,4)
,(509,14,5)
,(108,5,2)
,(497,15,5)
,(564,12,6)
,(7,8,2)
,(137,8,2)
,(1,15,5)
,(227,3,5)
,(217,3,6)
,(439,5,2)
,(243,8,5)
,(453,11,3)
,(81,15,3)
,(576,15,3)
,(76,11,5)
,(236,1,4)
,(107,5,4)
,(45,1,4)
,(502,13,4)
,(247,4,3)
,(474,12,3)
,(319,8,2)
,(199,14,3)
,(258,9,6)
,(568,15,4)
,(185,13,5)
,(53,6,1)
,(479,11,2)
,(445,13,2)
,(250,15,1)
,(216,5,6)
,(435,2,5)
,(583,12,3)
,(415,3,1)
,(123,8,3)
,(156,15,6)
,(295,10,3)
,(437,3,2)
,(545,4,1)
,(150,14,6)
,(452,8,4)
,(308,13,6)
,(64,13,2)
,(437,4,4)
,(294,15,1)
,(591,12,3)
,(205,8,1)
,(148,11,6)
,(225,14,6)
,(431,12,5)
,(316,11,2)
,(180,15,2)
,(11,14,2)
,(487,15,1)
,(17,10,1)
,(424,14,4)
,(476,7,6)
,(331,13,4)
,(104,9,1)
,(277,11,2)
,(473,14,6)
,(98,15,3)
,(37,15,2)
,(23,8,1)
,(285,4,1)
,(538,15,1)
,(369,8,6)
,(71,7,1)
,(389,11,3)
,(2,13,1)
,(586,6,2)
,(81,13,4)
,(454,11,1)
,(58,2,2)
,(38,9,2)
,(425,10,2)
,(182,8,4)
,(375,2,1)
,(460,11,2)
,(5,2,6)
,(51,7,6)
,(196,3,1)
,(271,15,5)
,(134,15,1)
,(587,15,6)
,(346,1,1)
,(159,1,6)
,(40,11,2)
,(114,14,2)
,(359,15,1)
,(246,10,3)
,(305,8,2)
,(258,7,4)
,(181,12,6)
,(436,10,4)
,(494,8,5)
,(194,12,6)
,(369,12,4)
,(471,3,2)
,(297,11,6)
,(21,13,2)
,(420,7,4)
,(554,15,3)
,(175,13,3)
,(45,10,4)
,(150,1,4)
,(377,3,6)
,(142,3,2)
,(388,2,3)
,(166,8,4)
,(22,2,3)
,(411,15,6)
,(351,5,2)
,(478,1,1)
,(11,2,5)
,(209,12,4)
,(192,11,1)
,(523,11,3)
,(77,1,4)
,(550,6,1)
,(398,1,6)
,(91,12,3)
,(322,15,1)
,(599,12,3)
,(587,1,5)
,(407,12,5)
,(455,10,2)
,(116,13,2)
,(57,7,5)
,(536,9,6)
,(504,4,6)
,(14,3,2)
,(122,6,6)
,(150,12,4)
,(68,1,6)
,(501,1,1)
,(172,6,4)
,(571,10,4)
,(283,11,6)
,(206,14,2)
,(357,5,1)
,(293,3,6)
,(320,2,4)
,(346,8,5)
,(184,9,2)
,(523,3,5)
,(229,12,5)
,(402,15,5)
,(387,8,5)
,(191,7,5)
,(240,7,5)
,(469,9,2)
,(420,6,2)
,(385,9,1)
,(120,14,6)
,(444,1,1)
,(488,9,1)
,(85,14,1)
,(451,4,3)
,(429,4,2)
,(544,4,6)
,(419,7,5)
,(256,2,3)
,(435,10,4)
,(521,1,1)
,(220,1,3)
,(67,12,4)
,(231,9,5)
,(62,7,2)
,(380,8,3)
,(163,14,3)
,(192,5,6)
,(196,1,6)
,(139,9,2)
,(564,14,1)
,(277,6,5)
,(138,9,5)
,(341,4,1)
,(225,11,5)
,(355,13,4)
,(275,3,4)
,(449,15,4)
,(578,11,3)
,(147,12,2)
,(1,3,4)
,(295,13,1)
,(453,15,2)
,(82,1,6)
,(127,12,4)
,(514,7,1)
,(364,3,1)
,(324,7,1)
,(259,2,4)
,(318,7,1)
,(251,7,4)
,(195,2,3)
,(574,9,3)
,(179,13,1)
,(5,13,1)
,(137,11,2)
,(417,12,6)
,(239,13,2)
,(226,8,6)
,(133,7,5)
,(239,8,3)
,(481,11,5)
,(327,2,4)
,(249,13,4)
,(137,6,4)
,(305,10,5)
,(386,8,4)
,(186,2,1)
,(314,3,3)
,(486,10,6)
,(248,8,3)
,(450,14,4)
,(79,9,3)
,(256,5,6)
,(508,15,4)
,(392,2,6)
,(106,1,3)
,(156,11,2)
,(494,5,3)
,(278,6,5)
,(356,11,6)
,(525,14,2)
,(550,4,2)
,(210,13,4)
,(484,4,6)
,(511,9,3)
,(372,5,2)
,(350,14,6)
,(585,3,4)
,(166,14,5)
,(350,3,3)
,(307,6,4)
,(583,2,3)
,(366,15,3)
,(253,3,4)
,(26,13,4)
,(314,12,4)
,(452,3,6)
,(36,14,4)
,(91,6,5)
,(396,1,3)
,(505,12,2)
,(29,10,5)
,(166,4,6)
,(68,5,1)
,(487,8,5)
,(354,9,6)
,(447,14,3)
,(158,1,5);

INSERT INTO clothing_store.sales (sale_date,store,product_color_size,amount,discount) VALUES 
('2019-07-08 18:09:49',90,874,1,5)
,('2019-07-08 18:09:49',25,224,2,5)
,('2019-07-08 18:09:49',92,110,3,5)
,('2019-07-08 18:09:49',81,980,4,5)
,('2019-07-08 18:09:49',34,284,1,5)
,('2019-07-08 18:09:49',77,632,1,5)
,('2019-07-08 18:09:50',9,956,1,5)
,('2019-07-08 18:09:50',3,845,2,3)
,('2019-07-08 18:09:50',72,948,2,3)
,('2019-07-08 18:09:50',57,912,2,3)
,('2019-07-08 18:09:50',37,381,2,3)
,('2019-07-08 18:09:50',41,63,2,3)
,('2019-07-08 18:09:50',95,737,3,3)
,('2019-07-08 18:09:50',30,801,3,3)
,('2019-07-08 18:09:50',68,592,3,3)
,('2019-07-08 18:09:50',41,943,3,3)
,('2019-07-08 18:09:50',92,87,3,3)
,('2019-07-08 18:09:50',31,519,3,3)
,('2019-07-08 18:09:50',36,220,3,3)
,('2019-07-08 18:09:50',99,918,2,5)
,('2019-07-08 18:09:50',15,614,2,5)
,('2019-07-08 18:09:50',65,658,2,5)
,('2019-07-08 18:09:50',53,893,2,5)
,('2019-07-08 18:09:50',1,600,2,5)
,('2019-07-08 18:09:50',5,191,2,5)
,('2019-07-08 18:09:50',62,126,3,5)
,('2019-07-08 18:09:50',3,602,3,5)
,('2019-07-08 18:09:50',64,402,3,5)
,('2019-07-08 18:09:50',59,558,1,5)
,('2019-07-08 18:09:50',67,298,1,5)
,('2019-07-08 18:09:50',44,19,1,7)
,('2019-07-08 18:09:50',30,856,1,7)
,('2019-07-08 18:09:50',25,58,1,7)
,('2019-07-08 18:09:50',43,146,1,7)
,('2019-07-08 18:09:50',58,217,1,7)
,('2019-07-08 18:09:50',18,392,1,7)
,('2019-07-08 18:09:50',38,178,1,7)
,('2019-07-08 18:09:50',81,673,1,7)
,('2019-07-08 18:09:50',67,317,2,7)
,('2019-07-08 18:09:50',96,22,2,7)
,('2019-07-08 18:09:50',24,210,2,7)
,('2019-07-08 18:09:50',74,735,2,7)
,('2019-07-08 18:09:50',91,474,2,7)
,('2019-07-08 18:09:50',50,21,2,7)
,('2019-07-08 18:09:50',44,419,2,7)
,('2019-07-08 18:09:50',84,147,2,10)
,('2019-07-08 18:09:50',99,358,2,10)
,('2019-07-08 18:09:50',76,303,2,10)
,('2019-07-08 18:09:50',27,632,2,10)
,('2019-07-08 18:09:50',46,525,2,10)
,('2019-07-08 18:09:50',35,811,2,10)
,('2019-07-08 18:09:50',11,17,2,10)
,('2019-07-08 18:09:50',24,76,3,10)
,('2019-07-08 18:09:50',50,699,3,10)
,('2019-07-08 18:09:50',91,989,3,10)
,('2019-07-08 18:09:50',26,182,3,10)
,('2019-07-08 18:09:50',1,857,3,10)
,('2019-07-08 18:09:50',71,789,3,10)
,('2019-07-08 18:09:50',51,716,3,15)
,('2019-07-08 18:09:50',93,391,3,15)
,('2019-07-08 18:09:50',10,52,3,15)
,('2019-07-08 18:09:50',45,375,3,15)
,('2019-07-08 18:09:50',52,352,3,15)
,('2019-07-08 18:09:50',72,579,3,15)
,('2019-07-08 18:09:50',89,965,3,15)
,('2019-07-08 18:09:50',76,547,3,15)
,('2019-07-08 18:09:50',19,300,1,15)
,('2019-07-08 18:09:50',1,329,1,15)
,('2019-07-08 18:09:50',8,386,1,3)
,('2019-07-08 18:09:50',96,72,1,3)
,('2019-07-08 18:09:50',69,124,1,3)
,('2019-07-08 18:09:50',6,175,1,3)
,('2019-07-08 18:09:50',6,50,1,3)
,('2019-07-08 18:09:50',1,795,1,3)
,('2019-07-08 18:09:50',83,640,1,5)
,('2019-07-08 18:09:50',6,613,1,5)
,('2019-07-08 18:09:50',100,375,1,5)
,('2019-07-08 18:09:50',49,184,1,5)
,('2019-07-08 18:09:50',57,659,1,5)
,('2019-07-08 18:09:50',6,788,2,5)
,('2019-07-08 18:09:50',5,277,2,5)
,('2019-07-08 18:09:50',83,117,2,5)
,('2019-07-08 18:09:50',68,469,2,5)
,('2019-07-08 18:09:50',71,860,2,5)
,('2019-07-08 18:09:50',32,287,2,7)
,('2019-07-08 18:09:50',28,939,2,7)
,('2019-07-08 18:09:50',55,531,2,7)
,('2019-07-08 18:09:50',7,174,2,7)
,('2019-07-08 18:09:50',86,840,2,7)
,('2019-07-08 18:09:50',32,202,2,7)
,('2019-07-08 18:09:50',43,849,4,7)
,('2019-07-08 18:09:50',25,895,4,7)
,('2019-07-08 18:09:50',9,935,4,7)
,('2019-07-08 18:09:50',76,656,4,7)
,('2019-07-08 18:09:50',16,70,3,7)
,('2019-07-08 18:09:50',55,438,3,7)
,('2019-07-08 18:09:50',10,700,3,10)
,('2019-07-08 18:09:50',2,46,3,10)
,('2019-07-08 18:09:50',86,885,3,10)
,('2019-07-08 18:09:50',91,891,3,10)
,('2019-07-08 18:09:50',24,720,3,10)
,('2019-07-08 18:09:50',70,624,3,10)
,('2019-07-08 18:09:50',93,356,2,10)
,('2019-07-08 18:09:50',50,699,2,10)
,('2019-07-08 18:09:50',66,569,2,10)
,('2019-07-08 18:09:50',65,78,2,10)
,('2019-07-08 18:09:50',99,717,2,10)
,('2019-07-08 18:09:50',9,484,2,10)
,('2019-07-08 18:09:50',23,626,2,10)
,('2019-07-08 18:09:50',51,59,2,10)
,('2019-07-08 18:09:50',80,650,2,10)
,('2019-07-08 18:09:50',17,49,2,10)
,('2019-07-08 18:09:50',78,401,2,20)
,('2019-07-08 18:09:50',3,265,2,20)
,('2019-07-08 18:09:50',96,885,1,20)
,('2019-07-08 18:09:50',19,50,1,20)
,('2019-07-08 18:09:50',60,529,1,20)
,('2019-07-08 18:09:50',22,127,1,20)
,('2019-07-08 18:09:50',71,677,1,20)
,('2019-07-08 18:09:50',66,68,1,20)
,('2019-07-08 18:09:50',2,456,1,20)
,('2019-07-08 18:09:50',53,233,1,20)
,('2019-07-08 18:09:50',41,597,1,20)
,('2019-07-08 18:09:50',70,432,1,20)
,('2019-07-08 18:09:50',76,515,1,20)
,('2019-07-08 18:09:50',9,98,1,20)
,('2019-07-08 18:09:50',80,687,1,20)
,('2019-07-08 18:09:50',5,603,1,33)
,('2019-07-08 18:09:50',96,454,1,33)
,('2019-07-08 18:09:50',64,657,1,33)
,('2019-07-08 18:09:50',68,846,1,33)
,('2019-07-08 18:09:50',67,170,1,33)
,('2019-07-08 18:09:50',17,960,1,33)
,('2019-07-08 18:09:50',59,109,2,33)
,('2019-07-08 18:09:50',73,833,2,33)
,('2019-07-08 18:09:50',34,199,2,33)
,('2019-07-08 18:09:50',64,162,2,33)
,('2019-07-08 18:09:50',90,461,2,33)
,('2019-07-08 18:09:50',21,675,2,33)
,('2019-07-08 18:09:50',84,196,2,33)
,('2019-07-08 18:09:50',68,496,2,33)
,('2019-07-08 18:09:50',33,873,2,33)
,('2019-07-08 18:09:50',21,303,2,33)
,('2019-07-08 18:09:50',7,235,2,33)
,('2019-07-08 18:09:50',42,600,2,33)
,('2019-07-08 18:09:50',89,575,2,33)
,('2019-07-08 18:09:50',62,440,3,10)
,('2019-07-08 18:09:50',100,375,3,10)
,('2019-07-08 18:09:50',8,768,3,10)
,('2019-07-08 18:09:50',30,819,3,10)
,('2019-07-08 18:09:50',53,231,3,10)
,('2019-07-08 18:09:50',44,411,3,10)
,('2019-07-08 18:09:50',11,356,3,10)
,('2019-07-08 18:09:50',8,822,3,10)
,('2019-07-08 18:09:50',96,574,3,10)
,('2019-07-08 18:09:50',80,125,3,10)
,('2019-07-08 18:09:50',84,205,3,10)
,('2019-07-08 18:09:50',68,105,3,10)
,('2019-07-08 18:09:50',47,409,3,10)
,('2019-07-08 18:09:50',43,551,3,10)
,('2019-07-08 18:09:50',91,845,3,10)
,('2019-07-08 18:09:50',7,126,3,10)
,('2019-07-08 18:09:51',51,372,3,10)
,('2019-07-08 18:09:51',30,482,3,10)
,('2019-07-08 18:09:51',16,326,3,5)
,('2019-07-08 18:09:51',35,819,2,5)
,('2019-07-08 18:09:51',22,239,2,5)
,('2019-07-08 18:09:51',72,462,2,5)
,('2019-07-08 18:09:51',16,234,2,5)
,('2019-07-08 18:09:51',77,604,2,5)
,('2019-07-08 18:09:51',21,599,2,5)
,('2019-07-08 18:09:51',47,515,2,5)
,('2019-07-08 18:09:51',76,733,2,5)
,('2019-07-08 18:09:51',54,517,2,5)
,('2019-07-08 18:09:51',40,14,2,5)
,('2019-07-08 18:09:51',31,877,2,5)
,('2019-07-08 18:09:51',1,935,1,5)
,('2019-07-08 18:09:51',65,161,1,7)
,('2019-07-08 18:09:51',6,578,1,7)
,('2019-07-08 18:09:51',98,960,1,7)
,('2019-07-08 18:09:51',55,470,1,7)
,('2019-07-08 18:09:51',99,841,1,7)
,('2019-07-08 18:09:51',1,99,1,7)
,('2019-07-08 18:09:51',94,976,1,7)
,('2019-07-08 18:09:51',31,985,1,7)
,('2019-07-08 18:09:51',87,220,1,7)
,('2019-07-08 18:09:51',61,358,1,0)
,('2019-07-08 18:09:51',84,554,1,0)
,('2019-07-08 18:09:51',65,823,1,0)
,('2019-07-08 18:09:51',61,943,1,0)
,('2019-07-08 18:09:51',10,247,1,0)
,('2019-07-08 18:09:51',14,901,1,0)
,('2019-07-08 18:09:51',4,5,1,0)
,('2019-07-08 18:09:51',98,690,1,0)
,('2019-07-08 18:09:51',2,803,1,0)
,('2019-07-08 18:09:51',64,15,1,0)
,('2019-07-08 18:09:51',24,222,1,0)
,('2019-07-08 18:09:51',41,663,1,0)
,('2019-07-08 18:09:51',28,595,1,0)
,('2019-07-08 18:09:51',2,438,1,0);

INSERT INTO clothing_store.supplies (store,exchange_rate,product_color_size,amount,purchase_price_in_rub) VALUES 
(68,89,195,2,2505)
,(75,51,37,20,29064)
,(48,70,108,5,9760)
,(43,54,8,23,22512)
,(20,28,255,6,12884)
,(6,72,293,13,30091)
,(84,34,69,15,15404)
,(59,99,244,3,4233)
,(93,40,53,1,704)
,(48,51,80,6,8098)
,(36,86,69,10,2904)
,(46,98,54,5,11760)
,(72,6,21,3,2845)
,(78,7,173,30,28771)
,(38,75,231,5,3638)
,(47,23,66,5,3165)
,(39,37,102,6,28358)
,(33,92,57,8,32247)
,(42,14,40,9,2244)
,(85,94,23,3,2389)
,(64,88,257,4,5866)
,(11,70,160,18,22650)
,(42,93,152,19,22023)
,(7,50,18,17,12020)
,(30,95,47,16,14091)
,(28,29,185,5,5272)
,(91,75,14,6,11859)
,(79,100,123,4,3452)
,(9,16,50,3,11307)
,(93,76,299,24,31254)
,(52,84,140,14,13338)
,(10,1,63,15,20118)
,(91,45,44,16,20196)
,(5,47,88,19,31890)
,(62,83,123,23,32496)
,(28,65,299,13,8305)
,(42,30,20,10,13386)
,(36,18,5,11,16726)
,(51,99,296,12,23014)
,(82,45,183,14,23920)
,(12,8,3,4,4391)
,(75,35,185,1,1512)
,(100,61,133,16,31769)
,(56,84,233,20,20431)
,(22,25,74,15,32423)
,(10,11,165,12,16243)
,(37,76,27,10,10215)
,(65,6,109,6,7984)
,(98,36,234,8,16212)
,(100,46,245,12,17364)
,(24,36,264,13,22244)
,(77,66,187,14,22707)
,(91,66,120,15,22175)
,(46,58,160,16,14783)
,(91,89,298,17,26183)
,(8,2,281,6,6371)
,(31,83,32,7,19751)
,(99,27,168,16,28168)
,(67,16,190,15,6410)
,(24,9,67,18,10546)
,(59,3,19,17,22329)
,(76,81,185,1,190)
,(78,12,16,2,15070)
,(49,73,240,9,25004)
,(39,45,36,8,17141)
,(25,69,98,7,9557)
,(28,39,12,6,14431)
,(93,18,53,15,20958)
,(30,97,300,2,5856)
,(48,49,271,20,28144)
,(2,4,78,5,7893)
,(41,4,26,6,6840)
,(31,85,196,7,8559)
,(6,43,1,9,18993)
,(50,81,179,10,10063)
,(77,29,107,11,32208)
,(98,10,204,13,26051)
,(36,18,207,1,1740)
,(31,93,159,13,13966)
,(4,23,281,15,29946)
,(76,98,283,14,20792)
,(67,58,189,10,13239)
,(8,24,236,6,5329)
,(89,61,273,2,10183)
,(85,70,210,31,31052)
,(16,50,208,28,25423)
,(39,75,177,6,3651)
,(34,76,201,7,19267)
,(100,15,71,8,18647)
,(40,7,162,9,13704)
,(48,83,140,10,11855)
,(66,10,91,14,25276)
,(46,42,218,30,32555)
,(31,75,56,5,5843)
,(5,52,86,12,24032)
,(98,15,227,15,30476)
,(73,76,283,10,13188)
,(100,23,194,1,787)
,(32,6,75,10,22035)
,(24,25,189,8,11416);

INSERT INTO `products_colors_sizes_prices` VALUES(NULL,'888', '808'),
(NULL,'575', '1437'),
(NULL,'625', '1133'),
(NULL,'242', '1629'),
(NULL,'567', '718'),
(NULL,'368', '4340'),
(NULL,'931', '2496'),
(NULL,'1', '228'),
(NULL,'417', '2776'),
(NULL,'178', '4241'),
(NULL,'216', '3521'),
(NULL,'477', '3964'),
(NULL,'205', '2058'),
(NULL,'172', '2752'),
(NULL,'584', '692'),
(NULL,'98', '3814'),
(NULL,'784', '4192'),
(NULL,'33', '3821'),
(NULL,'401', '1005'),
(NULL,'103', '1630'),
(NULL,'722', '1770'),
(NULL,'471', '851'),
(NULL,'793', '1645'),
(NULL,'935', '2956'),
(NULL,'800', '2573'),
(NULL,'266', '3668'),
(NULL,'488', '1220'),
(NULL,'737', '379'),
(NULL,'67', '1363'),
(NULL,'136', '2398'),
(NULL,'547', '1806'),
(NULL,'303', '3870'),
(NULL,'192', '1209'),
(NULL,'337', '782'),
(NULL,'155', '606'),
(NULL,'953', '3061'),
(NULL,'244', '906'),
(NULL,'624', '3215'),
(NULL,'150', '1178'),
(NULL,'115', '2638'),
(NULL,'1000', '1979'),
(NULL,'927', '714'),
(NULL,'801', '3016'),
(NULL,'269', '3765'),
(NULL,'28', '2729'),
(NULL,'839', '268'),
(NULL,'502', '2796'),
(NULL,'463', '2534'),
(NULL,'812', '2482'),
(NULL,'876', '2859'),
(NULL,'741', '4495'),
(NULL,'665', '3265'),
(NULL,'995', '4604'),
(NULL,'926', '3349'),
(NULL,'904', '3076'),
(NULL,'956', '3038'),
(NULL,'348', '1963'),
(NULL,'694', '2082'),
(NULL,'806', '3894'),
(NULL,'854', '4351'),
(NULL,'386', '2490'),
(NULL,'982', '4931'),
(NULL,'301', '3709'),
(NULL,'394', '2698'),
(NULL,'157', '4150'),
(NULL,'713', '4652'),
(NULL,'426', '3771'),
(NULL,'574', '3643'),
(NULL,'706', '4001'),
(NULL,'355', '205'),
(NULL,'683', '2565'),
(NULL,'82', '4404'),
(NULL,'481', '1180'),
(NULL,'108', '1732'),
(NULL,'234', '837'),
(NULL,'880', '703'),
(NULL,'566', '206'),
(NULL,'893', '2203'),
(NULL,'110', '284'),
(NULL,'260', '4754'),
(NULL,'946', '1526'),
(NULL,'369', '3155'),
(NULL,'101', '2276'),
(NULL,'819', '4510'),
(NULL,'257', '245'),
(NULL,'174', '237'),
(NULL,'152', '4020'),
(NULL,'88', '2243'),
(NULL,'797', '3800'),
(NULL,'318', '642'),
(NULL,'483', '3101'),
(NULL,'453', '3378'),
(NULL,'284', '2103'),
(NULL,'725', '3114'),
(NULL,'555', '217'),
(NULL,'427', '4885'),
(NULL,'816', '1435'),
(NULL,'526', '1860'),
(NULL,'619', '1463'),
(NULL,'156', '4677'),
(NULL,'528', '3269'),
(NULL,'247', '2134'),
(NULL,'81', '898'),
(NULL,'436', '3131'),
(NULL,'964', '679'),
(NULL,'219', '4055'),
(NULL,'397', '3647'),
(NULL,'499', '2028'),
(NULL,'920', '3455'),
(NULL,'631', '2583'),
(NULL,'560', '1932'),
(NULL,'217', '3161'),
(NULL,'907', '3943'),
(NULL,'221', '292'),
(NULL,'367', '2060'),
(NULL,'254', '718'),
(NULL,'255', '354'),
(NULL,'672', '4457'),
(NULL,'231', '4560'),
(NULL,'930', '1552'),
(NULL,'228', '703'),
(NULL,'726', '3004'),
(NULL,'302', '3564'),
(NULL,'538', '3057'),
(NULL,'179', '3377'),
(NULL,'475', '2620'),
(NULL,'544', '4643'),
(NULL,'406', '3116'),
(NULL,'896', '4567'),
(NULL,'294', '368'),
(NULL,'966', '3446'),
(NULL,'744', '3196'),
(NULL,'357', '4086'),
(NULL,'232', '3468'),
(NULL,'746', '3515'),
(NULL,'79', '4521'),
(NULL,'537', '2666'),
(NULL,'452', '2818'),
(NULL,'162', '348'),
(NULL,'965', '3450'),
(NULL,'425', '4961'),
(NULL,'161', '1744'),
(NULL,'261', '3379'),
(NULL,'603', '693'),
(NULL,'509', '4280'),
(NULL,'14', '4390'),
(NULL,'568', '946'),
(NULL,'180', '3340'),
(NULL,'184', '4204'),
(NULL,'837', '1807'),
(NULL,'208', '4693'),
(NULL,'924', '4040'),
(NULL,'203', '1264'),
(NULL,'611', '4208'),
(NULL,'650', '336'),
(NULL,'853', '296'),
(NULL,'866', '1712'),
(NULL,'48', '3295'),
(NULL,'504', '1894'),
(NULL,'419', '3333'),
(NULL,'785', '716'),
(NULL,'771', '1466'),
(NULL,'580', '3557'),
(NULL,'604', '3522'),
(NULL,'908', '423'),
(NULL,'823', '3018'),
(NULL,'736', '1308'),
(NULL,'944', '4929'),
(NULL,'130', '924'),
(NULL,'762', '2281'),
(NULL,'760', '353'),
(NULL,'39', '1783'),
(NULL,'57', '2812'),
(NULL,'925', '4893'),
(NULL,'176', '1433'),
(NULL,'239', '1836'),
(NULL,'541', '3805'),
(NULL,'649', '570'),
(NULL,'329', '444'),
(NULL,'125', '2736'),
(NULL,'738', '3805'),
(NULL,'994', '1116'),
(NULL,'354', '1640'),
(NULL,'826', '514'),
(NULL,'61', '774'),
(NULL,'229', '1829'),
(NULL,'520', '3649'),
(NULL,'975', '3953'),
(NULL,'638', '1808'),
(NULL,'449', '2404'),
(NULL,'466', '3392'),
(NULL,'693', '4861'),
(NULL,'976', '2505'),
(NULL,'138', '3464'),
(NULL,'412', '3268'),
(NULL,'112', '1603'),
(NULL,'135', '4355'),
(NULL,'391', '1752'),
(NULL,'657', '1817'),
(NULL,'842', '2436'),
(NULL,'698', '4637'),
(NULL,'119', '1840'),
(NULL,'593', '1454'),
(NULL,'153', '3527'),
(NULL,'565', '1747'),
(NULL,'163', '1967'),
(NULL,'445', '2799'),
(NULL,'249', '3115'),
(NULL,'454', '374'),
(NULL,'214', '3607'),
(NULL,'980', '356'),
(NULL,'340', '3882'),
(NULL,'395', '4630'),
(NULL,'359', '2532'),
(NULL,'934', '3375'),
(NULL,'279', '331'),
(NULL,'32', '2767'),
(NULL,'442', '1798'),
(NULL,'122', '4213'),
(NULL,'610', '1971'),
(NULL,'450', '4953'),
(NULL,'758', '4219'),
(NULL,'321', '2627'),
(NULL,'166', '4745'),
(NULL,'109', '667'),
(NULL,'940', '1945'),
(NULL,'147', '1708'),
(NULL,'23', '4194'),
(NULL,'280', '4265'),
(NULL,'374', '3965'),
(NULL,'313', '3191'),
(NULL,'443', '606'),
(NULL,'983', '2415'),
(NULL,'489', '3603'),
(NULL,'843', '3946'),
(NULL,'727', '1424'),
(NULL,'814', '4818'),
(NULL,'677', '2014'),
(NULL,'85', '578'),
(NULL,'750', '3092'),
(NULL,'993', '2272'),
(NULL,'748', '3321'),
(NULL,'707', '4230'),
(NULL,'895', '2539'),
(NULL,'69', '1055'),
(NULL,'201', '1366'),
(NULL,'634', '4641'),
(NULL,'723', '4571'),
(NULL,'690', '2975'),
(NULL,'414', '3306'),
(NULL,'100', '350'),
(NULL,'878', '3283'),
(NULL,'137', '3139'),
(NULL,'978', '1416'),
(NULL,'9', '3759'),
(NULL,'117', '669'),
(NULL,'308', '4740'),
(NULL,'807', '2563'),
(NULL,'674', '4088'),
(NULL,'938', '2439'),
(NULL,'263', '1181'),
(NULL,'331', '2786'),
(NULL,'701', '1319'),
(NULL,'894', '1817'),
(NULL,'515', '4031'),
(NULL,'540', '1687'),
(NULL,'434', '4753'),
(NULL,'733', '4481'),
(NULL,'408', '4764'),
(NULL,'932', '4097'),
(NULL,'287', '630'),
(NULL,'913', '2134'),
(NULL,'557', '3500'),
(NULL,'371', '4528'),
(NULL,'539', '2956'),
(NULL,'218', '992'),
(NULL,'372', '613'),
(NULL,'781', '1024'),
(NULL,'402', '2171'),
(NULL,'991', '4703'),
(NULL,'462', '1492'),
(NULL,'897', '1460'),
(NULL,'444', '643'),
(NULL,'12', '1895'),
(NULL,'170', '2421'),
(NULL,'997', '2407'),
(NULL,'286', '3748'),
(NULL,'199', '694'),
(NULL,'187', '3103'),
(NULL,'361', '3303'),
(NULL,'901', '3374'),
(NULL,'53', '2856'),
(NULL,'44', '4199'),
(NULL,'430', '2729'),
(NULL,'403', '4719'),
(NULL,'102', '3669'),
(NULL,'382', '4017'),
(NULL,'300', '551'),
(NULL,'794', '1970'),
(NULL,'855', '1730'),
(NULL,'194', '4335'),
(NULL,'94', '2608'),
(NULL,'691', '1930'),
(NULL,'107', '3120'),
(NULL,'366', '727'),
(NULL,'195', '4424'),
(NULL,'867', '862'),
(NULL,'721', '405'),
(NULL,'640', '3195'),
(NULL,'343', '2474'),
(NULL,'245', '810'),
(NULL,'464', '1460'),
(NULL,'795', '2206'),
(NULL,'72', '1180'),
(NULL,'620', '3023'),
(NULL,'703', '1988'),
(NULL,'885', '1003'),
(NULL,'339', '4080'),
(NULL,'527', '1307'),
(NULL,'133', '2293'),
(NULL,'376', '2200'),
(NULL,'874', '390'),
(NULL,'947', '2928'),
(NULL,'378', '3985'),
(NULL,'597', '732'),
(NULL,'989', '3661'),
(NULL,'181', '1303'),
(NULL,'512', '4240'),
(NULL,'500', '584'),
(NULL,'363', '802'),
(NULL,'628', '399'),
(NULL,'16', '1894'),
(NULL,'696', '2335'),
(NULL,'495', '4073'),
(NULL,'121', '4952'),
(NULL,'351', '1048'),
(NULL,'779', '1411'),
(NULL,'202', '4992'),
(NULL,'76', '4745'),
(NULL,'614', '1402'),
(NULL,'388', '4787'),
(NULL,'293', '2900'),
(NULL,'848', '4649'),
(NULL,'831', '3996'),
(NULL,'362', '4757'),
(NULL,'479', '2418'),
(NULL,'235', '1012'),
(NULL,'656', '1480'),
(NULL,'11', '3400'),
(NULL,'441', '3477'),
(NULL,'780', '4351'),
(NULL,'428', '610'),
(NULL,'41', '4730'),
(NULL,'92', '2019'),
(NULL,'316', '221'),
(NULL,'981', '1041'),
(NULL,'416', '4528'),
(NULL,'158', '4225'),
(NULL,'805', '4553'),
(NULL,'788', '3754'),
(NULL,'196', '743'),
(NULL,'233', '4292'),
(NULL,'131', '1546'),
(NULL,'792', '3734'),
(NULL,'459', '970'),
(NULL,'787', '1173'),
(NULL,'871', '1387'),
(NULL,'664', '2469'),
(NULL,'641', '3115'),
(NULL,'13', '3185'),
(NULL,'937', '4720'),
(NULL,'484', '1238'),
(NULL,'960', '4300'),
(NULL,'123', '4165'),
(NULL,'215', '745'),
(NULL,'154', '1124'),
(NULL,'240', '3537'),
(NULL,'311', '3137'),
(NULL,'506', '2180'),
(NULL,'915', '2091'),
(NULL,'833', '2479'),
(NULL,'213', '1482'),
(NULL,'948', '4432'),
(NULL,'105', '1914'),
(NULL,'64', '3461'),
(NULL,'711', '4395'),
(NULL,'490', '3628'),
(NULL,'716', '3911'),
(NULL,'742', '1935'),
(NULL,'90', '486'),
(NULL,'315', '3475'),
(NULL,'514', '1538'),
(NULL,'783', '3010'),
(NULL,'553', '1233'),
(NULL,'421', '896'),
(NULL,'542', '2329'),
(NULL,'211', '4728'),
(NULL,'322', '932'),
(NULL,'252', '802'),
(NULL,'493', '4885'),
(NULL,'643', '1759'),
(NULL,'264', '3229'),
(NULL,'846', '1779'),
(NULL,'682', '4130'),
(NULL,'841', '4778'),
(NULL,'617', '1475'),
(NULL,'333', '4456'),
(NULL,'168', '786'),
(NULL,'844', '3700'),
(NULL,'285', '3176'),
(NULL,'977', '4912'),
(NULL,'702', '2409'),
(NULL,'810', '4038'),
(NULL,'985', '497'),
(NULL,'914', '1782'),
(NULL,'979', '3629'),
(NULL,'513', '2184'),
(NULL,'18', '442'),
(NULL,'530', '1769'),
(NULL,'922', '2980'),
(NULL,'623', '4908'),
(NULL,'986', '4514'),
(NULL,'243', '1674'),
(NULL,'556', '535'),
(NULL,'676', '1406'),
(NULL,'89', '2328'),
(NULL,'969', '4588'),
(NULL,'290', '279'),
(NULL,'870', '4515'),
(NULL,'613', '319'),
(NULL,'134', '617'),
(NULL,'847', '3115'),
(NULL,'962', '1954'),
(NULL,'869', '3145'),
(NULL,'344', '1588'),
(NULL,'407', '1320'),
(NULL,'310', '2561'),
(NULL,'319', '1168'),
(NULL,'306', '4120'),
(NULL,'86', '4682'),
(NULL,'177', '2370'),
(NULL,'558', '1865'),
(NULL,'581', '4480'),
(NULL,'200', '2165'),
(NULL,'899', '1463'),
(NULL,'777', '1206'),
(NULL,'149', '1399'),
(NULL,'126', '4809'),
(NULL,'380', '1481'),
(NULL,'491', '1126'),
(NULL,'830', '1119'),
(NULL,'19', '4343'),
(NULL,'375', '2149'),
(NULL,'511', '3745'),
(NULL,'226', '4750'),
(NULL,'469', '1502'),
(NULL,'283', '3325'),
(NULL,'632', '3630'),
(NULL,'633', '3898'),
(NULL,'776', '509'),
(NULL,'729', '3961'),
(NULL,'182', '2659'),
(NULL,'561', '1673'),
(NULL,'25', '2694'),
(NULL,'400', '4040'),
(NULL,'289', '2220'),
(NULL,'718', '4036'),
(NULL,'272', '3731'),
(NULL,'546', '3429'),
(NULL,'618', '1639'),
(NULL,'695', '2818'),
(NULL,'20', '1030'),
(NULL,'186', '4322'),
(NULL,'974', '4576'),
(NULL,'265', '971'),
(NULL,'699', '833'),
(NULL,'275', '3774'),
(NULL,'622', '580'),
(NULL,'605', '3221'),
(NULL,'305', '4754'),
(NULL,'510', '2352'),
(NULL,'857', '3940'),
(NULL,'590', '4850'),
(NULL,'324', '2409'),
(NULL,'939', '449'),
(NULL,'399', '1858'),
(NULL,'666', '1283'),
(NULL,'259', '4442'),
(NULL,'222', '1855'),
(NULL,'942', '3311'),
(NULL,'755', '570'),
(NULL,'389', '2084'),
(NULL,'583', '3351'),
(NULL,'338', '3207'),
(NULL,'114', '1953'),
(NULL,'472', '260'),
(NULL,'892', '3717'),
(NULL,'525', '2929'),
(NULL,'404', '3782'),
(NULL,'175', '3746'),
(NULL,'789', '252'),
(NULL,'705', '2834'),
(NULL,'451', '4084'),
(NULL,'890', '3049'),
(NULL,'811', '1434'),
(NULL,'113', '3474'),
(NULL,'328', '2578'),
(NULL,'320', '4606'),
(NULL,'480', '661'),
(NULL,'167', '498'),
(NULL,'307', '2034'),
(NULL,'431', '800'),
(NULL,'3', '2761'),
(NULL,'720', '1739'),
(NULL,'84', '3847'),
(NULL,'891', '1342'),
(NULL,'292', '2165'),
(NULL,'809', '1999'),
(NULL,'591', '485'),
(NULL,'796', '3703'),
(NULL,'592', '2930'),
(NULL,'191', '3459'),
(NULL,'440', '497'),
(NULL,'972', '1651'),
(NULL,'517', '4535'),
(NULL,'817', '3498'),
(NULL,'645', '2790'),
(NULL,'554', '1973'),
(NULL,'496', '4296'),
(NULL,'164', '2514'),
(NULL,'144', '3121'),
(NULL,'884', '1961'),
(NULL,'773', '523'),
(NULL,'917', '3699'),
(NULL,'747', '373'),
(NULL,'377', '605'),
(NULL,'418', '2735'),
(NULL,'607', '3129'),
(NULL,'589', '4125'),
(NULL,'253', '2097'),
(NULL,'629', '759'),
(NULL,'47', '2879'),
(NULL,'612', '1355'),
(NULL,'687', '3152'),
(NULL,'709', '2945'),
(NULL,'996', '2770'),
(NULL,'654', '1590'),
(NULL,'669', '1025'),
(NULL,'143', '4366'),
(NULL,'21', '1884'),
(NULL,'872', '3327'),
(NULL,'326', '3496'),
(NULL,'15', '2700'),
(NULL,'159', '3808'),
(NULL,'728', '4364'),
(NULL,'519', '3647'),
(NULL,'173', '709'),
(NULL,'116', '4839'),
(NULL,'432', '2216'),
(NULL,'529', '1709'),
(NULL,'957', '1613'),
(NULL,'497', '2772'),
(NULL,'139', '845'),
(NULL,'50', '4703'),
(NULL,'99', '2160'),
(NULL,'548', '635'),
(NULL,'52', '4836'),
(NULL,'626', '2035'),
(NULL,'808', '3233'),
(NULL,'770', '2599'),
(NULL,'586', '961'),
(NULL,'959', '4468'),
(NULL,'821', '3871'),
(NULL,'160', '4401'),
(NULL,'393', '956'),
(NULL,'834', '4392'),
(NULL,'379', '387'),
(NULL,'429', '2276'),
(NULL,'370', '1877'),
(NULL,'941', '3106'),
(NULL,'668', '1158'),
(NULL,'769', '2330'),
(NULL,'549', '4750'),
(NULL,'188', '2275'),
(NULL,'578', '4563'),
(NULL,'879', '2668'),
(NULL,'531', '2347'),
(NULL,'45', '2257'),
(NULL,'274', '958'),
(NULL,'405', '1824'),
(NULL,'314', '4569'),
(NULL,'916', '4683'),
(NULL,'524', '4190'),
(NULL,'111', '3548'),
(NULL,'127', '2179'),
(NULL,'865', '642'),
(NULL,'692', '3516'),
(NULL,'40', '2055'),
(NULL,'971', '431'),
(NULL,'598', '2292'),
(NULL,'832', '1321'),
(NULL,'59', '3117'),
(NULL,'764', '4244'),
(NULL,'883', '212'),
(NULL,'905', '700'),
(NULL,'951', '958'),
(NULL,'183', '4657'),
(NULL,'350', '3118'),
(NULL,'559', '643'),
(NULL,'875', '4995'),
(NULL,'563', '3930'),
(NULL,'798', '1868'),
(NULL,'579', '1895'),
(NULL,'501', '2016'),
(NULL,'236', '1216'),
(NULL,'601', '925'),
(NULL,'456', '1535'),
(NULL,'850', '2924'),
(NULL,'644', '2848'),
(NULL,'409', '3403'),
(NULL,'56', '3530'),
(NULL,'198', '525'),
(NULL,'207', '389'),
(NULL,'689', '1322'),
(NULL,'373', '3152'),
(NULL,'461', '3008'),
(NULL,'54', '1211'),
(NULL,'670', '4666'),
(NULL,'954', '4573'),
(NULL,'595', '4743'),
(NULL,'813', '1964'),
(NULL,'802', '2307'),
(NULL,'655', '3599'),
(NULL,'467', '778'),
(NULL,'262', '3095'),
(NULL,'671', '3793'),
(NULL,'433', '3220'),
(NULL,'732', '286'),
(NULL,'352', '3536'),
(NULL,'840', '447'),
(NULL,'757', '979'),
(NULL,'582', '3765'),
(NULL,'10', '569'),
(NULL,'763', '2720'),
(NULL,'594', '3879'),
(NULL,'585', '3060'),
(NULL,'898', '1415'),
(NULL,'852', '1851'),
(NULL,'963', '855'),
(NULL,'739', '2771'),
(NULL,'836', '2462'),
(NULL,'681', '722'),
(NULL,'439', '295'),
(NULL,'608', '1166'),
(NULL,'124', '387'),
(NULL,'647', '1029'),
(NULL,'906', '4768'),
(NULL,'786', '2161'),
(NULL,'204', '992'),
(NULL,'949', '4144'),
(NULL,'803', '3548'),
(NULL,'987', '4952'),
(NULL,'468', '1915'),
(NULL,'476', '1492'),
(NULL,'128', '4522'),
(NULL,'719', '361'),
(NULL,'360', '2167'),
(NULL,'309', '1496'),
(NULL,'74', '2504'),
(NULL,'886', '3162'),
(NULL,'724', '1009'),
(NULL,'129', '4429'),
(NULL,'225', '2863'),
(NULL,'990', '4035'),
(NULL,'383', '3177'),
(NULL,'325', '424'),
(NULL,'749', '2507'),
(NULL,'714', '306'),
(NULL,'223', '2679'),
(NULL,'297', '425'),
(NULL,'347', '1796'),
(NULL,'827', '4604'),
(NULL,'921', '2411'),
(NULL,'268', '2168'),
(NULL,'91', '774'),
(NULL,'778', '650'),
(NULL,'478', '4514'),
(NULL,'171', '3034'),
(NULL,'765', '4537'),
(NULL,'753', '3371'),
(NULL,'58', '4706'),
(NULL,'815', '4442'),
(NULL,'889', '1862'),
(NULL,'902', '3072'),
(NULL,'78', '4304'),
(NULL,'349', '1942'),
(NULL,'950', '4142'),
(NULL,'345', '4995'),
(NULL,'258', '2092'),
(NULL,'936', '3051'),
(NULL,'312', '2891'),
(NULL,'688', '2805'),
(NULL,'327', '3237'),
(NULL,'933', '3720'),
(NULL,'6', '2389'),
(NULL,'474', '745'),
(NULL,'661', '3482'),
(NULL,'838', '2485'),
(NULL,'494', '4927'),
(NULL,'680', '4016'),
(NULL,'335', '3574'),
(NULL,'365', '3284'),
(NULL,'958', '4739'),
(NULL,'621', '4331'),
(NULL,'26', '4395'),
(NULL,'271', '2817'),
(NULL,'731', '3111'),
(NULL,'822', '4629'),
(NULL,'185', '3263'),
(NULL,'679', '4307'),
(NULL,'118', '2301'),
(NULL,'790', '1784'),
(NULL,'804', '4765'),
(NULL,'967', '513'),
(NULL,'411', '4296'),
(NULL,'522', '3368'),
(NULL,'551', '639'),
(NULL,'93', '2305'),
(NULL,'667', '4999'),
(NULL,'27', '687'),
(NULL,'83', '1174'),
(NULL,'900', '1317'),
(NULL,'754', '2389'),
(NULL,'735', '4930'),
(NULL,'73', '1260'),
(NULL,'535', '3866'),
(NULL,'573', '4840'),
(NULL,'30', '3857'),
(NULL,'465', '2567'),
(NULL,'663', '2319'),
(NULL,'485', '284'),
(NULL,'87', '701'),
(NULL,'470', '379'),
(NULL,'662', '1053'),
(NULL,'596', '4848'),
(NULL,'104', '1301'),
(NULL,'639', '2169'),
(NULL,'248', '4164'),
(NULL,'799', '2886'),
(NULL,'570', '825'),
(NULL,'637', '4161'),
(NULL,'7', '849'),
(NULL,'120', '3608'),
(NULL,'80', '3030'),
(NULL,'197', '2050'),
(NULL,'288', '1928'),
(NULL,'473', '3953'),
(NULL,'437', '689'),
(NULL,'209', '2950'),
(NULL,'791', '526'),
(NULL,'332', '476'),
(NULL,'396', '4475'),
(NULL,'256', '701'),
(NULL,'877', '2358'),
(NULL,'516', '739'),
(NULL,'212', '4654'),
(NULL,'224', '2894'),
(NULL,'295', '4499'),
(NULL,'919', '4355'),
(NULL,'774', '2356'),
(NULL,'55', '4913'),
(NULL,'752', '4884'),
(NULL,'710', '3931'),
(NULL,'384', '3895'),
(NULL,'533', '716'),
(NULL,'685', '4668'),
(NULL,'29', '2514'),
(NULL,'356', '2348'),
(NULL,'572', '550'),
(NULL,'521', '1158'),
(NULL,'740', '4780'),
(NULL,'599', '764'),
(NULL,'381', '2299'),
(NULL,'659', '1153'),
(NULL,'988', '2699'),
(NULL,'912', '2247'),
(NULL,'642', '1443'),
(NULL,'545', '1935'),
(NULL,'323', '1406'),
(NULL,'910', '1338'),
(NULL,'999', '3513'),
(NULL,'60', '1383'),
(NULL,'75', '1322'),
(NULL,'68', '933'),
(NULL,'734', '4996'),
(NULL,'678', '3269'),
(NULL,'189', '1677'),
(NULL,'4', '2914'),
(NULL,'845', '2447'),
(NULL,'606', '2650'),
(NULL,'460', '338'),
(NULL,'712', '2714'),
(NULL,'523', '3885'),
(NULL,'148', '820'),
(NULL,'828', '2283'),
(NULL,'835', '4396'),
(NULL,'675', '409'),
(NULL,'768', '266'),
(NULL,'151', '1884'),
(NULL,'587', '1444'),
(NULL,'413', '4482'),
(NULL,'220', '3771'),
(NULL,'961', '2187'),
(NULL,'775', '897'),
(NULL,'576', '376'),
(NULL,'730', '737'),
(NULL,'856', '2280'),
(NULL,'550', '3324'),
(NULL,'51', '4090'),
(NULL,'503', '1118'),
(NULL,'945', '3396'),
(NULL,'438', '3316'),
(NULL,'745', '3619'),
(NULL,'943', '951'),
(NULL,'562', '4555'),
(NULL,'820', '3847'),
(NULL,'704', '1533'),
(NULL,'296', '1355'),
(NULL,'873', '866'),
(NULL,'22', '1104'),
(NULL,'66', '936'),
(NULL,'364', '1195'),
(NULL,'38', '4903'),
(NULL,'588', '915'),
(NULL,'43', '1220'),
(NULL,'346', '1504'),
(NULL,'447', '2470'),
(NULL,'648', '659'),
(NULL,'392', '2407'),
(NULL,'227', '4442'),
(NULL,'423', '3314'),
(NULL,'862', '554'),
(NULL,'759', '3595'),
(NULL,'564', '4143'),
(NULL,'385', '2830'),
(NULL,'973', '1640'),
(NULL,'304', '3544'),
(NULL,'543', '376'),
(NULL,'863', '4550'),
(NULL,'62', '204'),
(NULL,'861', '2654'),
(NULL,'569', '1694'),
(NULL,'602', '1223'),
(NULL,'849', '3006'),
(NULL,'652', '4702'),
(NULL,'330', '2339'),
(NULL,'984', '2486'),
(NULL,'715', '4627'),
(NULL,'824', '1477'),
(NULL,'146', '865'),
(NULL,'140', '4863'),
(NULL,'482', '2163'),
(NULL,'446', '1121'),
(NULL,'952', '710'),
(NULL,'142', '4319'),
(NULL,'35', '3621'),
(NULL,'282', '4248'),
(NULL,'918', '2776'),
(NULL,'507', '1086'),
(NULL,'36', '4403'),
(NULL,'435', '2960'),
(NULL,'334', '2420'),
(NULL,'536', '2204'),
(NULL,'717', '1434'),
(NULL,'230', '4992'),
(NULL,'686', '1910'),
(NULL,'615', '4621'),
(NULL,'97', '3712'),
(NULL,'106', '3137'),
(NULL,'8', '3191'),
(NULL,'358', '1157'),
(NULL,'77', '3933'),
(NULL,'818', '2764'),
(NULL,'636', '396'),
(NULL,'31', '4174'),
(NULL,'210', '1437'),
(NULL,'766', '806'),
(NULL,'278', '4612'),
(NULL,'487', '1491'),
(NULL,'276', '1344'),
(NULL,'929', '4799'),
(NULL,'206', '858'),
(NULL,'96', '4673'),
(NULL,'743', '3442'),
(NULL,'387', '4723'),
(NULL,'46', '791'),
(NULL,'552', '1775'),
(NULL,'165', '2042'),
(NULL,'341', '2503'),
(NULL,'273', '609'),
(NULL,'616', '1165'),
(NULL,'751', '1072'),
(NULL,'518', '4496'),
(NULL,'24', '1021'),
(NULL,'881', '4214'),
(NULL,'190', '1872'),
(NULL,'782', '384'),
(NULL,'353', '2755'),
(NULL,'95', '3927'),
(NULL,'410', '1810'),
(NULL,'398', '3333'),
(NULL,'660', '2521'),
(NULL,'903', '4375'),
(NULL,'270', '437'),
(NULL,'5', '3289'),
(NULL,'492', '280'),
(NULL,'534', '2130'),
(NULL,'708', '3764'),
(NULL,'928', '2495'),
(NULL,'923', '954'),
(NULL,'992', '811'),
(NULL,'390', '298'),
(NULL,'653', '1705'),
(NULL,'825', '1590'),
(NULL,'498', '2911'),
(NULL,'267', '3878'),
(NULL,'998', '402'),
(NULL,'858', '4610'),
(NULL,'970', '1438'),
(NULL,'577', '1425'),
(NULL,'237', '795'),
(NULL,'37', '2715'),
(NULL,'761', '4358'),
(NULL,'864', '255'),
(NULL,'505', '2199'),
(NULL,'887', '2078'),
(NULL,'486', '908'),
(NULL,'63', '1425'),
(NULL,'422', '2244'),
(NULL,'673', '2125'),
(NULL,'277', '708'),
(NULL,'859', '4476'),
(NULL,'767', '4215'),
(NULL,'34', '2528'),
(NULL,'193', '3553'),
(NULL,'70', '1365'),
(NULL,'882', '4127'),
(NULL,'968', '4002'),
(NULL,'455', '1383'),
(NULL,'281', '1444'),
(NULL,'42', '935'),
(NULL,'65', '2768'),
(NULL,'684', '225'),
(NULL,'700', '3770'),
(NULL,'246', '1953'),
(NULL,'646', '1486'),
(NULL,'457', '1223'),
(NULL,'756', '2009'),
(NULL,'317', '1921'),
(NULL,'635', '3908'),
(NULL,'772', '3610'),
(NULL,'241', '590'),
(NULL,'169', '3493'),
(NULL,'291', '4840'),
(NULL,'600', '1955'),
(NULL,'415', '4422'),
(NULL,'448', '4218'),
(NULL,'132', '3729'),
(NULL,'141', '2306'),
(NULL,'336', '1170'),
(NULL,'627', '3339'),
(NULL,'508', '3151'),
(NULL,'630', '826'),
(NULL,'250', '4902'),
(NULL,'458', '2491'),
(NULL,'145', '1619'),
(NULL,'651', '3218'),
(NULL,'251', '3217'),
(NULL,'532', '2106'),
(NULL,'17', '2361'),
(NULL,'697', '1903'),
(NULL,'868', '1507'),
(NULL,'851', '3910'),
(NULL,'658', '1198'),
(NULL,'299', '3152'),
(NULL,'420', '817'),
(NULL,'424', '774'),
(NULL,'909', '3237'),
(NULL,'829', '4032'),
(NULL,'71', '846'),
(NULL,'2', '3382'),
(NULL,'238', '1204'),
(NULL,'342', '454'),
(NULL,'298', '1563'),
(NULL,'49', '1792'),
(NULL,'860', '4792'),
(NULL,'955', '482'),
(NULL,'571', '382'),
(NULL,'911', '1408'),
(NULL,'609', '4536');
