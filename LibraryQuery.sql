

------Creating the table for the library management ------
 
 
create table books

(

	book_id  serial primary key,

	title varChar(50),

	publication_year varChar(4),

	genre varChar(20),

	isbn int,

	aviable_copies int

);
 
create table Authors

(

	author_id int  primary key,

	first_name varChar(50),

	last_name varChar(50),

	dob date,

	nationality varChar(50)

);
 
create table members

(

	member_id int primary key,

	first_name varChar(50),

	last_name varChar(50),

	dob date,

	contact_number varChar(10),

	email varChar(50),

	membership_date date

);
 
create table loans

(

	loan_id int primary key,

	loan_date date,

	return_date date,

	actual_return_date date

);
 
create table staff

(

	staff_id int primary key,

	first_name varChar(50),

	last_name varChar(50),

	position_type varChar(50),

	contact_number varChar(10),

	email varChar(50),

	hire_date date

);
 
---DDL Queries------
 
---1. adding new column---
 
alter table books 

add column author_id int;
 
----2.renameing the column name ------
 
alter table staff 

rename column position_type to job_title;
 
----3.Drop the email column from the member table-----
 
alter table members 

drop column email;
 
 
-------DML Queries-----------
 
----1.Inserting the values---------
 
insert into books (title,publication_year,genre,isbn,aviable_copies) values

('The Hobbit','1999','Fiction',23451,100),

	('Raag Darbari','1965','Fiction',12243,70),

('Out of Africa','1985','Non-Fiction',3214,50);
 
 
-----2. Update the members contact number---------
 
insert into members 

(member_id , first_name,last_name,dob,contact_number,membership_date) values

(23,'Mukesh','Dev','1999-01-08','8319505281','2024-05-23'),

(12,'Ankit','kumar','2000-01-01','9691112375','2020-01-01'),

(43,'Yogesh','jyoti','2002-03-12','1234567890','2015-03-31');
 
--to update---
 
update members

set contact_number = '2345618970'

where member_id = 12;

select * from members;
 
----3.Delete a specific loan 4.Insert new loan-----
 
insert into loans

(loan_id,loan_date,return_date,actual_return_date) values 

(211,'2020-01-01','2024-01-01','2023-01-01'),

(235,'2024-01-09','2025-06-17','2024-07-08'),

(111,'1999-01-01','2005-01-01','2000-01-01');
 
----delete----

delete from loans

where loan_id = 235;
 
-----table relation----
 
alter table books 

add constraint fk_contraint

foreign key (author_id)

references authors(author_id);
 
alter table loans

add column book_id int,

add column member_id int;
 
alter table loans 

add constraint fk_contraintb

foreign key (book_id)

references books(book_id);
 
alter table loans 

add constraint fk_contraintm

foreign key (member_id)

references members(member_id);
 
select * from books;
 
update books 

set author_id = 12

where book_id = 1;

update books 

set author_id = 10

where book_id = 2;

update books 

set author_id = 11

where book_id = 3;
 
Insert into authors 

(author_id,first_name,last_name,dob,nationality) values 

(12,'john','deo','1985-05-01','Japnese'),

(11,'Alen','max','1901-11-11','American'),

(10,'Kabir','dev','1770-01-01','Indian');

select * from authors;
 
-----join quries--------
 
----1.Retrieve all books along with their authors-----
 
select * from books b join 

authors a on b.author_id = a.author_id;
 
 
------2.Find all books currently on loans along with the member details-----
 
select * from books b 

join loans l on b.book_id = l.book_id

join members m on l.member_id = m.member_id;
 
-----3.List all books borrowed by a specific member:------
 
SELECT * FROM books b

JOIN loans l ON b.book_id = l.book_id

JOIN members m ON l.member_id = m.member_id

WHERE m.member_id = 43;
 
 
-----4.Get the total number of books and the total available copies for each genre:------
 
SELECT COUNT(*) AS number_of_books FROM books b;

SELECT b.genre, SUM(aviable_copies) AS total_available_copies FROM books b GROUP BY b.genre;
 
 
----5.Find all staff members who are librarians and their hire dates:------
 
insert into staff

(staff_id,first_name,last_name,job_title,contact_number,email,hire_date) values	

(11,'Dipanshu','kumar','Librarians','2341567890','dipanshu@gmail.com','2024-01-01'),

(12,'Amit','kumar','Sercuirty','2346517890','amit@gmail.com','2024-05-01'),

(13,'Rohit','kumar','Librarians','2341567231','rohit@gmail.com','2022-01-01'),

(14,'Deep','kumar','Lab Assistent','2341567098','deep@gmail.com','2014-01-01');
 
 
select * from staff 

where job_title = 'Librarians';
 