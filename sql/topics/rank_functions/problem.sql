
create table emp(emp_id int, emp_name varchar(200), department_id int, salary double, manager_id int);


insert into emp values(1,'Ankit', 100, 10000, 4);
insert into emp values(2,'Mohit', 100, 15000, 5);
insert into emp values(3,'Vikas', 100, 10000, 4);
insert into emp values(4,'Rohit', 100, 5000, 2);
insert into emp values(5,'Mudit', 200, 12000, 6);
insert into emp values(6,'Agam', 200, 12000, 2);
insert into emp values(7,'Sanjay', 200, 9000, 2);
insert into emp values(8,'Ashish', 200, 5000, 2);
insert into emp values(1,'Saurabh', 900, 12000, 2);


--1. How to find duplicates in a give table

select emp_id , count(1) from emp
group by emp_id having count(1) > 1;


--2.  How to delete duplicates
-- Non H2 SPECIFIC - delete from CTE not supported in H2
--with cte as (
--select *, row_number() over (partition by emp_id order by emp_id)
-- as rank from emp)
-- delete from cte where rank > 1;

-- h2 specific
with cte as (
    select emp_id, emp_name,
    row_number() over(partition by emp_id order by emp_id) as rnk
    from emp
) select * from cte where rnk > 1;


delete from emp where _rowid_ not in (
    select min(_rowid_) from emp group by emp_id
);

select * from emp;

