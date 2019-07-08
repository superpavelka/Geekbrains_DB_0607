USE clothing_store;

-- Показать (упорядочено по номеру магазина) какой магазин(по номеру) в какой день по какому курсу делал закупку
SELECT supplies.store, exchange_rates.`data`, exchange_rates.exchange_rate 
 FROM supplies
   JOIN exchange_rates
 ON supplies.exchange_rate = exchange_rates.id_exchange_rate
 ORDER BY supplies.store;

-- Представление ЗАКУПКИ-МАГАЗИНЫ объединяющее колонки: 
-- МАГАЗИНЫ: Id магазина, Адрес магазина, 
-- ЗАКУПКИ: Id закупки, магазин закупки, курс закупки
DROP VIEW IF EXISTS supplies_stores;
CREATE VIEW supplies_stores AS 
 SELECT stores.id_store, stores.address, supplies.id_supply, supplies.store, supplies.exchange_rate 
 FROM stores,supplies;
 
-- Показать (упорядочено по дате) какой магазин(по адресу) в какой день по какому курсу делал закупку
SELECT supplies_stores.address, exchange_rates.`data`, exchange_rates.exchange_rate 
 FROM supplies_stores
   JOIN exchange_rates
 ON supplies_stores.exchange_rate = exchange_rates.id_exchange_rate
 ORDER BY exchange_rates.`data`;

-- Представление ТИПЫ ПРОДУКТОВ-ПРОДУКТЫ объединяющее колонки: 
-- ТИПЫ ПРОДУКТОВ: Id типа продукта, название типа продукта, 
-- ПРОДУКТЫ Id продукта, тип продукта, производитель продукта, описание продукта
DROP VIEW IF EXISTS product_types_products;
CREATE VIEW product_types_products AS 
 SELECT product_types.id_product_type, product_types.product_type_name, products.product_type, products.manufacturer, products.id_product,products.description
 FROM product_types,products;

-- Показать все футболки размера L фирмы Baon
SELECT product_types_products.product_type_name, manufacturers.name, sizes.`size`, product_types_products.description
  FROM product_types_products
  	JOIN manufacturers
  	JOIN sizes
  ON product_types_products.manufacturer = manufacturers.id_manufacturer
    WHERE (sizes.`size` = 'L') AND (product_types_products.product_type_name = 'T-shirts') AND (manufacturers.name = 'Baon');
 

