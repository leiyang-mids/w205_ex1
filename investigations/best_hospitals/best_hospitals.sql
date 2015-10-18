-- Assumptions:
-- Since different measure has different scales in score in effective table,
-- we naively assume, for all measures, higher score indicates better quality.
-- In addition, for each measure where its readmission rate is available,
-- we take the mean between the normalized inverse readmission score and effective score as the final score.
-- Fianlly for each hospital we take the average over the final scores of each meausre,
-- based on which hospital overall quality is ranked.

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
    h.id, h.state, h.city, h.name
  group by h.id, h.state, h.city, h.name
) final
-- step 5: rank the final score, there a bunch ties, so we show the top 100
select
  rank() OVER (
      ORDER by final_score desc
  ) as rank,
  final_score as score, id as id, state as state,
  city as city, name as name
limit 100;
