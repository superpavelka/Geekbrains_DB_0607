DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;
CREATE TABLE users (
id INT NOT NULL , 
name VARCHAR(30) NOT NULL);

INSERT INTO users VALUES(001, 'John Doe');
INSERT INTO users VALUES(002, 'Chris White');
INSERT INTO users VALUES(003, 'Sam Smith');
SELECT * FROM users;
