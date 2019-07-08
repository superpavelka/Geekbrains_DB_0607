USE clothing_store;

-- Показать (упорядочено по номеру магазина) какой магазин(по номеру) в какой день по какому курсу делал закупку
SELECT supplies.store, exchange_rates.`data`, exchange_rates.exchange_rate 
 FROM supplies
   JOIN exchange_rates
 ON supplies.exchange_rate = exchange_rates.id_exchange_rate
 ORDER BY supplies.store;
 
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