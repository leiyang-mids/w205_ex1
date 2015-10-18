-- Note: the query structure is identical with the one for hospital,
-- only difference is the aggregation level (group by in ln 35) is changed to state

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
    -- step 2b: join with readmission table by measure_id and hospital id
    left join m_readmission r on r.m_id = e.m_id and r.h_id = e.h_id
    select
      -- step 2c: get join score if readmission rate is available
      case
        when r.score is null and e.score is null then null
        when r.score is null and e.score is not null then e.score/norm.max_score
        when r.score is not null and e.score is null then 1-r.score/100
        else ( (1-r.score/100) + e.score/norm.max_score ) / 2
      end as join_norm_score,
      e.h_id
  ) norm_score
  -- step 3: join with hospital table to get name, location etc.
  left join m_hospital h on norm_score.h_id = h.id
  select
    -- step 4: calculate the average join score for each hospital
    cast(avg(join_norm_score) AS DECIMAL(10,4)) as final_score,
    h.state
  group by h.state
) final
-- step 5: rank the final score, show top 10
select
  rank() OVER (
      ORDER by final_score desc
  ) as rank,
  state as state, final_score as score
limit 10;
