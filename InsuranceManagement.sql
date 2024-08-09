CREATE TABLE Customers (
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
contact_number VARCHAR(15),
date_of_birth DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Agents (
agent_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
contact_number VARCHAR(15),
hire_date DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Policies (
policy_id SERIAL PRIMARY KEY,
policy_name VARCHAR(100) NOT NULL,
coverage_details TEXT,
premium NUMERIC(10, 2) NOT NULL,
policy_type VARCHAR(50),
start_date DATE,
end_date DATE,
customer_id INT REFERENCES Customers(customer_id),
agent_id INT REFERENCES Agents(agent_id),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Claims (
claim_id SERIAL PRIMARY KEY,
claim_date DATE NOT NULL,
claim_amount NUMERIC(10, 2) NOT NULL,
status VARCHAR(50) DEFAULT 'Pending',
policy_id INT REFERENCES Policies(policy_id),
description TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- This table manages the many-to-many relationship between Customers and Policies.
CREATE TABLE PolicyAssignments (
assignment_id SERIAL PRIMARY KEY,
customer_id INT REFERENCES Customers(customer_id),
policy_id INT REFERENCES Policies(policy_id),
start_date DATE,
end_date DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Customers (first_name, last_name, email, contact_number,
date_of_birth) VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '1985-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '1990-07-22'),
('Michael', 'Johnson', 'michael.johnson@example.com', '555-9876', '1983-02-14'),
('Emily', 'Davis', 'emily.davis@example.com', '555-4321', '1975-12-30'),
('David', 'Wilson', 'david.wilson@example.com', '555-6789', '1988-05-20'),
('Olivia', 'Brown', 'olivia.brown@example.com', '555-3456', '1995-09-15'),
('James', 'Jones', 'james.jones@example.com', '555-6543', '1982-11-25'),
('Sophia', 'Garcia', 'sophia.garcia@example.com', '555-8765', '1993-03-10'),
('Robert', 'Martinez', 'robert.martinez@example.com', '555-3456', '1979-06-14'),
('Isabella', 'Lopez', 'isabella.lopez@example.com', '555-6543', '1992-08-24');
INSERT INTO Agents (first_name, last_name, email, contact_number, hire_date)
VALUES
('Alice', 'Green', 'alice.green@example.com', '555-1111', '2010-06-01'),
('Bob', 'White', 'bob.white@example.com', '555-2222', '2012-07-15'),
('Charlie', 'Black', 'charlie.black@example.com', '555-3333', '2014-09-10'),
('Diana', 'Red', 'diana.red@example.com', '555-4444', '2011-03-21'),
('Edward', 'Blue', 'edward.blue@example.com', '555-5555', '2013-11-05');
INSERT INTO Policies (policy_name, coverage_details, premium, policy_type,
start_date, end_date, customer_id, agent_id) VALUES
('Health Protect', 'Comprehensive health coverage', 500.00, 'Health', '2024-01-01', '2025-01-01',
1, 1),
('Auto Secure', 'Car insurance with full coverage', 800.00, 'Auto', '2024-02-01', '2025-02-01', 2,
2),
('Home Shield', 'Home insurance against fire and theft', 1200.00, 'Home', '2024-03-01',
'2025-03-01', 3, 3),
('Life Guard', 'Life insurance with critical illness rider', 1500.00, 'Life', '2024-04-01', '2025-04-01',
4, 4),
('Travel Safe', 'Travel insurance with medical and baggage cover', 200.00, 'Travel', '2024-05-01',
'2025-05-01', 5, 5),
('Pet Protect', 'Insurance for pets against illness and injury', 300.00, 'Pet', '2024-06-01',
'2025-06-01', 6, 1),
('Health Shield', 'Basic health insurance coverage', 400.00, 'Health', '2024-07-01', '2025-07-01',
7, 2),
('Auto Protect', 'Car insurance with theft protection', 600.00, 'Auto', '2024-08-01', '2025-08-01', 8,
3),
('Home Secure', 'Home insurance with earthquake coverage', 1400.00, 'Home', '2024-09-01',
'2025-09-01', 9, 4),
('Life Secure', 'Life insurance with accidental death cover', 1300.00, 'Life', '2024-10-01',
'2025-10-01', 10, 5);
INSERT INTO Claims (claim_date, claim_amount, status, policy_id, description)
VALUES
('2024-07-15', 2500.00, 'Processed', 1, 'Medical expenses for surgery'),
('2024-08-05', 1500.00, 'Pending', 2, 'Car damage due to accident'),
('2024-09-10', 3500.00, 'Rejected', 3, 'Fire damage to home'),
('2024-10-20', 2000.00, 'Processed', 4, 'Critical illness treatment'),
('2024-11-25', 500.00, 'Pending', 5, 'Lost luggage during travel'),
('2024-12-12', 700.00, 'Processed', 6, 'Vet bills for pet injury'),
('2024-01-03', 400.00, 'Pending', 7, 'Outpatient treatment'),
('2024-02-15', 1000.00, 'Processed', 8, 'Car theft'),
('2024-03-22', 2500.00, 'Rejected', 9, 'Home repairs after earthquake'),
('2024-04-18', 1200.00, 'Pending', 10, 'Accidental death claim');
INSERT INTO PolicyAssignments (customer_id, policy_id, start_date, end_date)
VALUES
(1, 1, '2024-01-01', '2025-01-01'),
(2, 2, '2024-02-01', '2025-02-01'),
(3, 3, '2024-03-01', '2025-03-01'),
(4, 4, '2024-04-01', '2025-04-01'),
(5, 5, '2024-05-01', '2025-05-01'),
(6, 6, '2024-06-01', '2025-06-01'),
(7, 7, '2024-07-01', '2025-07-01'),
(8, 8, '2024-08-01', '2025-08-01'),
(9, 9, '2024-09-01', '2025-09-01'),
(10,10,'2024-10-01', '2025-10-01');

-- Problem 1: Clean Up Old Data Using TRUNCATE and DELETE
-- Scenario: The insurance company wants to clean up old and irrelevant data from their
-- database to improve performance.
-- Problem Statement:
-- ● Task 1: Use the TRUNCATE command to remove all data from a temporary table named
-- Temp_Claims that was used for testing and no longer needed.
-- ● Task 2: Use the DELETE command to remove all records from the Claims table where
-- the claim date is older than 5 years.

Create table temp_claims as select * from claims;

truncate temp_claims
insert into temp_claims select * from claims;

select * from temp_claims
delete from temp_claims 

delete from temp_claims where claim_date < '2024-03-14';

-- Problem 2: Drop a Table No Longer Needed
-- Scenario: The insurance company has decided to retire an old version of the Agents table
-- after migrating all the data to a new table.
-- Problem Statement:
-- ● Task 1: Use the DROP command to permanently delete the Old_Agents table from the
-- database.
-- ● Task 2: Verify that the Old_Agents table is completely removed and no longer
-- accessible.

create table old_agents as select * from agents;
select*from old_agents
drop table old_agents;

-- Problem 3: Retrieve Policy and Customer Information Using Different Joins
-- Scenario: You need to generate reports that show various combinations of customer and policy
-- data.
-- Problem Statement:
-- Task 1: Write a query using INNER JOIN to retrieve a list of all customers who have at least
-- one policy, including their names and the names of the policies they hold.
-- Task 2: Write a query using LEFT JOIN to retrieve a list of all customers and the policies they
-- hold. Include customers who do not currently have any policies.

select c.* from customers c inner join policies p on p.customer_id=c.customer_id; 

select c.* from customers c left join policies p on p.customer_id=c.customer_id; 

-- Problem 4: Complex Query with Multiple Joins
-- Scenario: The management wants to generate a report that includes details of customers, the
-- policies they hold, the agents managing these policies, and any claims filed against these
-- policies.
-- Problem Statement:
-- ● Task: Write a complex SQL query that uses INNER JOIN, LEFT JOIN, and RIGHT
-- JOIN to retrieve the following information:
-- ○ Customer name
-- ○ Policy name
-- ○ Agent name
-- ○ Claim details (if any)


-- select c.* from customer c outer join (select * from agents outer join policies) as ee on ee.customer_id=c.customer_id;
SELECT
    C.first_name AS CustomerName,
    P.policy_name AS PolicyName,
    A.first_name AS AgentName,
    CL.description AS ClaimDetails
FROM
    Customers C
    INNER JOIN Policies P ON C.customer_id = P.customer_id
    LEFT JOIN Agents A ON P.agent_id = A.agent_id
    LEFT JOIN Claims CL ON P.policy_id = CL.policy_id;

-- Problem 5: Combined Data Cleanup and Reporting
-- Scenario: After cleaning up old claims data, the company wants to drop certain tables and
-- generate a report on the remaining data.
-- Problem Statement:
-- ● Task 1: Write a query to DELETE all claims from the Claims table where the status is
-- 'Closed' and the claim amount is zero.
-- ● Task 2: Use the DROP command to remove a temporary table named Temp_Policies.
-- ● Task 3: Write a query that uses LEFT JOIN to retrieve all agents and the policies they
-- manage, even if some agents are not managing any policies.

select * from claims
delete from claims where status='Rejected' or claim_amount=500;

select 
	a.first_name as Agents,
	p.policy_name as Policies
	from 
		agents a
		left join policies p on a.agent_id=p.agent_id;


