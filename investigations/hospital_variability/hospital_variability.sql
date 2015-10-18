-- Similar with previous evaluation, it doesn't make sense to compare
-- the absolute variance value between the measure (procedure),
-- therefore we still normalize each measure before ranking the variance.
-- And here we focus on effective score and don't consider readmission rate

-- SQL statement:
from(
  from(
    -- step 1: get max effective score for each measure item for normalization
    from(
      select
        e.m_id,
        max(e.score) as max_score
      from m_effective e
      group by e.m_id
    ) norm
    -- step 2a: join with effective table by measure_id and
    right join m_effective e on e.m_id = norm.m_id
    select
      -- step 2b: get normalized score
      e.score/norm.max_score as norm_score,
      e.m_id
  ) norm_score
  select
    -- step 4: calculate the average join score for each hospital
    cast(variance(norm_score) AS DECIMAL(10,4)) as final_score,
    m_id
  group by m_id
) final
left join m_measure m on final.m_id = m.id
-- step 5: rank the final score, there are a bunch ties, so we show the top 100
select
  rank() OVER (
      ORDER by final_score desc
  ) as rank,
  final_score as score, m_id as measure_id, m.name as name
limit 10;
