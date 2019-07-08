USE clothing_store;

-- Показать (упорядочено по номеру магазина) какой магазин в какой день по какому курсу делал закупку
SELECT supplies.store, exchange_rates.`data`, exchange_rates.exchange_rate 
 FROM supplies
   JOIN exchange_rates
 ON supplies.exchange_rate = exchange_rates.id_exchange_rate
 ORDER BY supplies.store;