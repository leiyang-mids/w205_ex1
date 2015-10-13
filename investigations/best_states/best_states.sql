select
   h.state,
   avg(e.score) as avg_score
from m_effective e left join m_hospital h
on e.h_id = h.id
group by h.state
order by avg_score desc
limit 20; 

select
   h.state,
   avg(r.score) as avg_score
from m_readmission r left join m_hospital h
on e.h_id = h.id
group by h.state
having avg_sore is not null
order by avg_score desc
limit 20;