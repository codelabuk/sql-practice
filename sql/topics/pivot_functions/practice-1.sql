DROP TABLE IF EXISTS emp_compensation;

CREATE TABLE emp_compensation(emp_id INT, salary_component_type VARCHAR(200), val INT);

insert into emp_compensation values(1,'salary', 10000);
insert into emp_compensation values(1,'bonus', 5000);
insert into emp_compensation values(1,'hike_percent', 10);
insert into emp_compensation values(2,'salary', 15000);
insert into emp_compensation values(2,'bonus', 7000);
insert into emp_compensation values(2,'hike_percent', 8);
insert into emp_compensation values(3,'salary', 12000);
insert into emp_compensation values(3,'bonus', 4000);
insert into emp_compensation values(3,'hike_percent', 6);


select * from emp_compensation;

select
  emp_id,
  sum(case when salary_component_type='salary' then val end) as salary,
  sum(case when salary_component_type='bonus' then val end) as bonus,
  sum(case when salary_component_type='hike_percent' then val end) as bonus
from emp_compensation
group by emp_id;

-- pivot

select
  emp_id,
  sum(case when salary_component_type='salary' then val end) as salary,
  sum(case when salary_component_type='bonus' then val end) as bonus,
  sum(case when salary_component_type='hike_percent' then val end) as bonus
from emp_compensation
group by emp_id;

-- make a view table & unpivot
drop table if exists  emp_compensation_pivot;

create table emp_compensation_pivot AS
select
  emp_id,
  sum(case when salary_component_type='salary' then val end) as salary,
  sum(case when salary_component_type='bonus' then val end) as bonus,
  sum(case when salary_component_type='hike_percent' then val end) as hike_percent
from emp_compensation
group by emp_id;

select * from (
select emp_id, 'salary' as salary_component_type, salary as val from emp_compensation_pivot
union all
select emp_id, 'bonus' as salary_component_type, bonus as val from emp_compensation_pivot
union all
select emp_id, 'hike_percent' as salary_component_type, hike_percent as val from emp_compensation_pivot
) a
order by emp_id;




