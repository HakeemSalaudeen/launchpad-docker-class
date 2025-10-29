create table faruk (
id SERIAL primary KEY,
name VARCHAR(100),
age int);

insert into faruk (name, age ) values ('abdulrahman ibrahim', 15), ('kate chisom', 10);
-- (age) values (15), (10);

select * from faruk;