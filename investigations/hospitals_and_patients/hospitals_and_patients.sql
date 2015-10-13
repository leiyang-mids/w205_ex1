from (
  select
    avg(e.score) as avg_score,
    h.name, h.city, h.state, h.id as h_id
  from m_effective e left join m_hospital h
  on e.h_id = h.id
  group by h.name, h.city, h.state, h.id
) score
join m_survey s on s.h_id = score.h_id
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
