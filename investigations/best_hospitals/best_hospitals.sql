-- join readmission, effective, hospital table, calculate average score
select
   avg(e.score) as avg_score,
   h.name, h.city, h.state
from m_effective e left join m_hospital h
on e.h_id = h.id
group by h.name, h.city, h.state
order by avg_score desc
limit 20; 

select
  avg(r.score) as avg_score,
  h.name, h.city, h.state
from m_readmission r left join m_hospital h
on r.h_id = h.id
group by h.state, h.city, h.name
having avg_score is not null
order by avg_score
limit 20;

