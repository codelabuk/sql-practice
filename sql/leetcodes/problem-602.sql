create table RequestAccepted(requester_id int, accepter_id int, accept_date date, primary key (requester_id, accepter_id));

insert into RequestAccepted values(1,2,'2016-06-03');
insert into RequestAccepted values(1,3,'2016-06-08');
insert into RequestAccepted values(2,3,'2016-06-08');
insert into RequestAccepted values(3,4,'2016-06-09');

select * from RequestAccepted;



select first.id , count(*) as num from
(select requester_id as id from RequestAccepted
union  all
select accepter_id from RequestAccepted
) first
group by first.id
order by num desc
limit 1;
