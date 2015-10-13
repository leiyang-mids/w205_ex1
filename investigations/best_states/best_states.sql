select
   h.state,
   avg(e.score) as avg_score
from m_effective e left join m_hospital h
on e.h_id = h.id
group by h.state
order by avg_score desc
limit 20; 