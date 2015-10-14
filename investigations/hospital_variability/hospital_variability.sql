-- evaluate bsed on effective care
select
  m.id, m.name,
  variance(e.score) as var_score
from m_effective e left join m_measure m
on e.m_id = m.id
group by m.id, m.name
order by var_score desc
limit 10;
