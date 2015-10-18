-- 0). get the maximum value of score in effective care, for later normalization
select max(score) from m_effective;

-- 1). evaluate based on effective care
select
   h.state, h.city, h.name,
   avg(e.score) as avg_score
from m_effective e left join m_hospital h
on e.h_id = h.id
group by h.name, h.city, h.state
order by avg_score desc
limit 10;

-- 2). evaluate based on readmission
select
  h.state, h.city, h.name,
  avg(r.score) as avg_score
from m_readmission r left join m_hospital h
on r.h_id = h.id
group by h.state, h.city, h.name
having avg_score is not null
order by avg_score
limit 10;

-- 3). evaluate based on combination of readmission and effective care
-- Note: the column maximum (1180) for normalization is obtained from query #0,
-- there is some syntax issue I need to figure out in order to write everything into one query.
-- here we take the average between normalized score effective and reverse score of readmission.
from (
select
  h.state, h.city, h.name,
  case
    when r.score is null and e.score is null then null
    when r.score is null and e.score is not null then 100*e.score/1180
    when r.score is not null and e.score is null then 100-r.score
    else ( (100-r.score) + 100*e.score/1180 ) / 2
  end as overall_score
  from
    m_hospital h right join m_effective e on h.id = e.h_id
    left join m_readmission r on e.h_id=r.h_id and e.m_id=r.m_id
) m
select m.state, m.city, m.name, avg(m.overall_score) as avg_score
group by m.state, m.city, m.name
order by avg_score desc
limit 10;
