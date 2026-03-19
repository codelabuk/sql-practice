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

-- rank example  - rank are skipped if multiple values
-- dense rank example - rank are not skipped
-- row_number follows the ordering

SELECT emp_id, emp_name, department_id, salary,
rank() over (order  by salary desc)  as rnk,
dense_rank() over (order by salary desc) as dense_rnk,
row_number() over (order by salary desc) as rn
from emp
order by rnk asc;


-- department specific partition

SELECT emp_id, emp_name, department_id, salary,
rank() over (partition by department_id order  by salary desc)  as rnk,
dense_rank() over (partition by department_id order by salary desc) as dense_rnk,
row_number() over (partition by department_id order by salary desc) as rn
from emp
order by  department_id asc;


with cte as (
select emp_id, emp_name, department_id, salary,
rank() over (partition by department_id order  by salary desc)  as rnk
from emp
) select * from cte where rnk = 1;

select * from (
select emp_id, emp_name, department_id, salary,
rank() over (partition by department_id order  by salary desc)  as rnk
from emp
)  where rnk = 1;


