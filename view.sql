create or replace view result as
select t1.candidate_id, t2.name, t1.total_vote
from
(select candidate_id , count(vote_id) as total_vote
from vote
group by candidate_id
order by total_vote desc) t1
join 
(select c.candidate_id, v.name
from candidates c natural join voters v) t2
on t1.candidate_id = t2.candidate_id;
