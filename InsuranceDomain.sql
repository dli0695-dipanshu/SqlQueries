

-----Creating the Required Tables-------------
 
create table customers

(

	customer_id serial primary key,

	first_name varChar(50) not null,

	last_name varChar(50) not null,

	DOB date,

	gender varChar(10),

	contact_number varChar(10),

	email varChar(20),

	address varChar(50)

);
 
create table policies

(

	policy_id int primary key,

	policy_name varChar(20),

	policy_type varChar(10),

	coverage_details varChar(50),

	permium int,

	start_date date,

	end_date date

);
 
create table claims

(

	claim_id int primary key,

	claim_date date,

	claim_amount int,

	approved_amount int,

	claim_status varChar(20)

);
 
create table agents

(

	agent_id int primary key,

	first_name varChar(50) not  null,

	last_name varChar(50) not null,

	contact_number varChar(10) ,

	email varChar(20),

	hire_date date

);
 
create table PolicyAssignments

(

	assignment_id int primary key,

	start_date date,

	end_date date

);
 
create table ClaimProcessing

(

	processing_id int primary key,

	processing_date date,

	payment_amount int,

	payment_date date

);
 
-----Relationships and Use cases--------
 
----1.Customers and policies------
 
alter table PolicyAssignments

add column customer_id int ,

add column policy_id int;
 
alter table PolicyAssignments

add constraint fk_contraintc

foreign key (customer_id)

references customers(customer_id);
 
alter table PolicyAssignments

add constraint fk_contraintp

foreign key (policy_id)

references policies(policy_id);
 
 
-----2.Policies and Claims-------
 
alter table claims

add column policy_id int;
 
alter table claims

add constraint fk_contraintp

foreign key (policy_id)

references policies(policy_id);
 
------3.Customers and Claims-------
 
alter table claims

add column customer_id int;
 
alter table claims

add constraint fk_contraintc

foreign key (customer_id)

references customers(customer_id);
 
 
------4.Claims and Claim Processing -------
 
alter table claimprocessing

add column claim_id int;
 
alter table claimprocessing

add constraint fk_contraintc

foreign key (claim_id)

references claims(claim_id);
 
 
------5.Agents and policies--------
 
alter table agents

add column policy_id int;
 
alter table agents

add constraint fk_contraintp

foreign key (policy_id)

references policies(policy_id);
 
 
-------DDL Queries--------
 
-----1.Add new column to the agents table-----
 
alter table agents

add column age int;
 
------2.rename policy_name to policy_title-----
 
alter table policies 

rename column policy_name to policy_title;
 
-----3.drop the adress column from table customers------
 
alter table customers

Drop column address;
 
 
----------DML Queries----------------
 
Insert into policies 

(policy_id,policy_title,policy_type,coverage_details,permium,start_date,end_date) values

(123,'Life time Cover','Life','claim on death',400000,'2020-01-01','2065-01-01'),

(124,'Health Cover','Health','claim on hospital charges',350000,'2020-01-01','2021-01-01'),

(125,'automobile Cover','auto','claim on accident',20000,'2019-01-01','2020-01-01');
 
------1.Update policy permium amount------------
 
update policies

set permium = 50000

where policy_id = 125;
 
------2.Delete a specific claim-------------
 
insert into claims

(claim_id,claim_date,claim_amount,approved_amount,claim_status,policy_id) values

(2345,'2024-07-01',40000,30000,'Approved',125),

(2134,'2024-01-01',350000,200000,'Denied',124);
 
 
-----deleteing-----

delete from claims

where claim_id = 2134;
 
 
------3.Insert a new policy assignment-----------
 
insert into policyassignments

(assignment_id,start_date,end_date) values

(34,'2020-01-01','2024-05-01');
 
select * from policyassignments;
 
 
--------------Join Queries---------------------
 
-----2.Find all the claims and associate policy-------
 
SELECT * FROM claims c JOIN policies p ON c.policy_id = p.policy_id;
 
 
-------3.List all the claims along with their customers
 
Select * from claims c join customers ct

on c.customer_id = ct.customer_id;
 
------------4.toatal cliam amount and number of claims per policy ---------
 
SELECT SUM(claim_amount) AS total_claim_amount,

COUNT(*) AS number_of_claims FROM claims

c JOIN policies p ON c.policy_id = p.policy_id;
 