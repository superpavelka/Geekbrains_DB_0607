-- # �������� ����� ������
CREATE DATABASE IF NOT EXISTS example;
USE example;
CREATE TABLE IF NOT EXISTS users (
id INT NOT NULL PRIMARY KEY, 
name VARCHAR(30) NOT NULL);
--# ��������� ������� ��� �����������
INSERT INTO users VALUES(001, 'John Doe');
INSERT INTO users VALUES(002, 'Chris White');
INSERT INTO users VALUES(003, 'Sam Smith');
SELECT * FROM users;
quit
-- # ��� ��� ����� � �������
mysqldump example > dump_example.sql;
--# �������� ������� mysql
mysql
--# c����� ����� �� sample
CREATE DATABASE IF NOT EXISTS sample;
--# ������ �� mysql
quit
--# ������������ ���� ����
mysql sample < dump_example.sql;
--# ����� ���� ������� help_keyword �� mysql
mysqldump mysql help_keyword --where="true limit 100"> help_100.sql
--# ������ ��� ����������
cat help_100.sql