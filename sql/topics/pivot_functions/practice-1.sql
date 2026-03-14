DROP TABLE IF EXISTS emp_compensation;

CREATE TABLE emp_compensation(emp_id INT, salary_component_type VARCHAR(200), val INT);

insert into emp_compensation values(1,'salary', 10000);

select * from emp_compensation;