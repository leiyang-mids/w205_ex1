-- the first half is identical with best hospital evaluation
-- in second half from step 5, we evaluate the correlation between hospital
-- average score and every survey responses.

from (
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
    cast(avg(join_norm_score) as decimal(10,4)) as avg_score,
    h.id as h_id, h.state, h.city, h.name
  group by h.id, h.state, h.city, h.name
) score
-- step 5: join with survey table and evaluate correlations
inner join m_survey s on s.h_id = score.h_id
select
  corr(score.avg_score, s.Com_Nur_Ach) as Com_Nur_Ach,
  corr(score.avg_score, s.Com_Nur_Imp) as Com_Nur_Imp,
  corr(score.avg_score, s.Com_Nur_Dim) as Com_Nur_Dim,
  corr(score.avg_score, s.Com_Doc_Ach) as Com_Doc_Ach,
  corr(score.avg_score, s.Com_Doc_Imp) as Com_Doc_Imp,
  corr(score.avg_score, s.Com_Doc_Dim) as Com_Doc_Dim,
  corr(score.avg_score, s.Res_Staff_Ach) as Res_Staff_Ach,
  corr(score.avg_score, s.Res_Staff_Imp) as Res_Staff_Imp,
  corr(score.avg_score, s.Res_Staff_Dim) as Res_Staff_Dim,
  corr(score.avg_score, s.Pain_Mgmt_Ach) as Pain_Mgmt_Ach,
  corr(score.avg_score, s.Pain_Mgmt_Imp) as Pain_Mgmt_Imp,
  corr(score.avg_score, s.Pain_Mgmt_Dim) as Pain_Mgmt_Dim,
  corr(score.avg_score, s.Com_Meds_Ach) as Com_Meds_Ach,
  corr(score.avg_score, s.Com_Meds_Imp) as Com_Meds_Imp,
  corr(score.avg_score, s.Com_Meds_Dim) as Com_Meds_Dim,
  corr(score.avg_score, s.CQ_Env_Ach) as CQ_Env_Ach,
  corr(score.avg_score, s.CQ_Env_Imp) as CQ_Env_Imp,
  corr(score.avg_score, s.CQ_Env_Dim) as CQ_Env_Dim,
  corr(score.avg_score, s.Dis_Info_Ach) as Dis_Info_Ach,
  corr(score.avg_score, s.Dis_Info_Imp) as Dis_Info_Imp,
  corr(score.avg_score, s.Dis_Info_Dim) as Dis_Info_Dim,
  corr(score.avg_score, s.Overall_Ach_Pts) as Overall_Ach_Pts,
  corr(score.avg_score, s.Overall_Imp_Pts) as Overall_Imp_Pts,
  corr(score.avg_score, s.Overall_Dim_Score) as Overall_Dim_Score,
  corr(score.avg_score, s.HCAHPS_Base_Score) as HCAHPS_Base_Score,
  corr(score.avg_score, s.HCAHPS_Consistency_Score) as HCAHPS_Consistency_Score;
