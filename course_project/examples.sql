USE clothing_store;

-- Показать сколько позиций товара было продано и сколько стоит одна позиция такого товара по номеру магазина + столбец с полной суммой покупки
SELECT sales.amount , products_colors_sizes_prices.price_in_rub, sales.amount*products_colors_sizes_prices.price_in_rub AS total_price
FROM sales, products_colors_sizes_prices
WHERE (sales.product_color_size = products_colors_sizes_prices.product_color_size) AND (sales.store = 64);

-- Полная сумма покупок в магазине
SELECT sales.amount , products_colors_sizes_prices.price_in_rub, SUM(sales.amount*products_colors_sizes_prices.price_in_rub) AS total_price
FROM sales, products_colors_sizes_prices
WHERE (sales.product_color_size = products_colors_sizes_prices.product_color_size) AND (sales.store = 64);

-- Полная сумма покупок во всех магазинах
SELECT sales.store AS store, sales.amount , products_colors_sizes_prices.price_in_rub, SUM(sales.amount*products_colors_sizes_prices.price_in_rub) AS total_price
FROM sales, products_colors_sizes_prices
WHERE (sales.product_color_size = products_colors_sizes_prices.product_color_size)
GROUP BY sales.store
ORDER BY store;

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

-- Пример вложенного запроса
-- Показать Id продукта, описание и цвет, сортировка по ID продукта  
SELECT desc_color.id_product, desc_color.description, colors.color
FROM
(SELECT products.id_product, products.description, products_colors_sizes.color,products.product_group
FROM products, products_colors_sizes
WHERE products.id_product = products_colors_sizes.product) desc_color, colors
WHERE desc_color.color = colors.id_color
ORDER BY desc_color.id_product;

-- Транзакция по добавлению позиции товара     
START TRANSACTION;

INSERT INTO products (product_type,product_group,manufacturer,description)
  VALUES (9, 1, 13, 'new_collection 2019');

SELECT @last_user_id := (SELECT MAX(id_product) FROM products);

INSERT INTO products_colors_sizes (product,color,`size`)
  VALUES (@last_user_id, 5, 3); 
  
COMMIT; 
-- Смотрим таблицы products и products_colors_sizes упорядоченные по id_product и id_product_color_size
-- в обратном порядке первые 5 записей и видим новую позицию
SELECT * FROM products 
ORDER BY id_product DESC
LIMIT 5;

SELECT * FROM products_colors_sizes 
ORDER BY id_product_color_size DESC
LIMIT 5;
-- Транзакция по удалению позиции товара     
START TRANSACTION;

SELECT @last_product_id := (SELECT id_product FROM products WHERE description = 'new_collection 2019');

DELETE FROM products_colors_sizes
where product = @last_user_id;

DELETE FROM products
WHERE id_product = @last_user_id;

COMMIT;
-- Смотрим таблицы products и products_colors_sizes упорядоченные по id_product и id_product_color_size
-- в обратном порядке первые 5 записей и видим что новая позиция удалена
SELECT * FROM products 
ORDER BY id_product DESC
LIMIT 5;

SELECT * FROM products_colors_sizes 
ORDER BY id_product_color_size DESC
LIMIT 5;

-- Функция считает стоимость закупки в долларах по ее id 
DROP FUNCTION IF EXISTS price_in_dollars;

DELIMITER //
CREATE FUNCTION price_in_dollars(supply_id INT)
RETURNS FLOAT READS SQL DATA
  BEGIN
    DECLARE price INT;
   	DECLARE ex_rate_id INT;
    DECLARE ex_rate INT;
    
    SET price = 
      (SELECT purchase_price_in_rub 
        FROM supplies
          WHERE id_supply = supply_id);
         
    SET ex_rate_id = 
      (SELECT exchange_rate 
        FROM supplies
          WHERE id_supply = supply_id);
    
    SET ex_rate = 
      (SELECT exchange_rate 
        FROM exchange_rates
          WHERE id_exchange_rate = ex_rate_id);
    
    RETURN price / ex_rate;
  END//
DELIMITER ;

SELECT price_in_dollars(1);
SELECT price_in_dollars(2);
SELECT price_in_dollars(3);

-- Триггер запрещающий добавлять NULL значения name или address в таблицу stores
DROP TRIGGER IF EXISTS check_stores_insert;
DELIMITER //

CREATE TRIGGER check_stores_insert BEFORE INSERT ON stores
FOR EACH ROW
BEGIN
  IF NEW.address IS NULL OR NEW.director_name IS NULL THEN
 	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bad insertion.Address or name can`t be NULL';
  END IF;
END//

DELIMITER ;
-- Пример неправильной вставки значений, тут выскочит ошибка
INSERT INTO stores (address,director_name) VALUES (NULL,NULL);
