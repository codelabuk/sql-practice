DROP TABLE IF EXISTS emp_compensation;

CREATE TABLE emp_compensation(emp_id INT, salary_component_type VARCHAR(200), val INT);

insert into emp_compensation values(1,'salary', 10000);
insert into emp_compensation values(1,'bonus', 5000);
insert into emp_compensation values(1,'hike_percent', 10);
insert into emp_compensation values(1,'salary', 15000);
insert into emp_compensation values(1,'bonus', 7000);
insert into emp_compensation values(1,'hike_percent', 8);

select * from emp_compensation;