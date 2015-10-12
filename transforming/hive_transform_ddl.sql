-- hospital table
drop table m_hospital;
create table m_hospital as
  select distinct
    id, name, address, city, state, zip,
    county, phone, type, ownership, emergency
  from e_hospital;

-- measure table
drop table m_measure;
create table m_measure as
  select distinct
    id, name, start_date, end_date
  from e_measure;

-- for the 3 relation tables below, we inner join the tables from the relation in order for the foreign keys to be valid
-- readmission table
drop table m_readmission;
create table m_readmission as
  select distinct 
	h.id as h_id, 
	m.id as m_id, 	
	cast(r.denominator as int) as denominator,
    cast(r.score as double) as score,
    cast(r.low_est as double) as low_est,
    cast(r.high_est as double) as high_est,
    r.compared_national, 
	r.footnote
  from e_hospital h
  inner join e_readmission r on h.id = r.id
  inner join e_measure m on m.id = r.measure_id;

-- effective table
drop table m_effective;
create table m_effective as
  select distinct
    h.id as h_id,
    m.id as m_id,
    cast(e.score as double) as score,
    cast(e.sample as int) as sample,
    e.condition,
    e.footnote
  from e_hospital h
  inner join e_effective e on e.provider_id = h.id
  inner join e_measure m on e.measure_id = m.id;

-- survey table - use a UDF to normalize "x out y" to x/y
add file GetScore.py;
drop table m_survey;
create table m_survey as
  select distinct 
	h.id as h_id,
    transform(s.Com_Nur_Ach) using 'python GeScore.py' as (Com_Nur_Ach),
    transform(s.Com_Nur_Imp) using 'python GeScore.py' as (Com_Nur_Imp),
    transform(s.Com_Nur_Dim) using 'python GeScore.py' as (Com_Nur_Dim),
    transform(s.Com_Doc_Ach) using 'python GeScore.py' as (Com_Doc_Ach),
    transform(s.Com_Doc_Imp) using 'python GeScore.py' as (Com_Doc_Imp),
    transform(s.Com_Doc_Dim) using 'python GeScore.py' as (Com_Doc_Dim),
    transform(s.Res_Staff_Ach) using 'python GeScore.py' as (Res_Staff_Ach),
    transform(s.Res_Staff_Imp) using 'python GeScore.py' as (Res_Staff_Imp),
    transform(s.Res_Staff_Dim) using 'python GeScore.py' as (Res_Staff_Dim),
    transform(s.Pain_Mgmt_Ach) using 'python GeScore.py' as (Pain_Mgmt_Ach),
    transform(s.Pain_Mgmt_Imp) using 'python GeScore.py' as (Pain_Mgmt_Imp),
    transform(s.Pain_Mgmt_Dim) using 'python GeScore.py' as (Pain_Mgmt_Dim),
    transform(s.Com_Meds_Ach) using 'python GeScore.py' as (Com_Meds_Ach),
    transform(s.Com_Meds_Imp) using 'python GeScore.py' as (Com_Meds_Imp),
    transform(s.Com_Meds_Dim) using 'python GeScore.py' as (Com_Meds_Dim),
    transform(s.CQ_Env_Ach) using 'python GeScore.py' as (CQ_Env_Ach),
    transform(s.CQ_Env_Imp) using 'python GeScore.py' as (CQ_Env_Imp),
    transform(s.CQ_Env_Dim) using 'python GeScore.py' as (CQ_Env_Dim),
    transform(s.Dis_Info_Ach) using 'python GeScore.py' as (Dis_Info_Ach),
    transform(s.Dis_Info_Imp) using 'python GeScore.py' as (Dis_Info_Imp),
    transform(s.Dis_Info_Dim) using 'python GeScore.py' as (Dis_Info_Dim),
    transform(s.Overall_Ach_Pts) using 'python GeScore.py' as (Overall_Ach_Pts),
    transform(s.Overall_Imp_Pts) using 'python GeScore.py' as (Overall_Imp_Pts),
    transform(s.Overall_Dim_Score) using 'python GeScore.py' as (Overall_Dim_Score),
    transform(s.HCAHPS_Base_Score) using 'python GeScore.py' as (HCAHPS_Base_Score),
    transform(s.HCAHPS_Consistency_Score) using 'python GeScore.py' as (HCAHPS_Consistency_Score),
  from e_hospital h inner join e_survey s on h.id = s.provider_id;

-- another way is to stack the column of survey questions into one
-- but considering no update is required for the data, we won't do that
create table m_survey_2 as
  from (
	select s.*, h.id as h_id from e_hospital h inner join e_survey s on h.id = s.provider_id;
  ) sv
  select sv.h_id, 1 as q_id, sv.Com_Nur_Ach as response 
  union all
  select sv.h_id, 2 as q_id, sv.Com_Nur_Imp as response
  union all
  select sv.h_id, 3 as q_id, sv.Com_Nur_Dim as response  
  union all
  select sv.h_id, 4 as q_id, sv.Com_Doc_Ach as response
  union all
  select sv.h_id, 5 as q_id, sv.Com_Doc_Imp as response  
  union all
  select sv.h_id, 6 as q_id, sv.Com_Doc_Dim as response
  union all
  select sv.h_id, 7 as q_id, sv.Res_Staff_Ach as response  
  union all
  select sv.h_id, 8 as q_id, sv.Res_Staff_Imp as response 
  union all
  select sv.h_id, 9 as q_id, sv.Res_Staff_Dim as response
  union all
  select sv.h_id, 10 as q_id, sv.Pain_Mgmt_Ach as response  
  union all
  select sv.h_id, 11 as q_id, sv.Pain_Mgmt_Imp as response 
  union all
  select sv.h_id, 12 as q_id, sv.Pain_Mgmt_Dim as response
  union all
  select sv.h_id, 13 as q_id, sv.Com_Meds_Ach as response  
  union all
  select sv.h_id, 14 as q_id, sv.Com_Meds_Imp as response 
  union all
  select sv.h_id, 15 as q_id, sv.Com_Meds_Dim as response
  union all
  select sv.h_id, 16 as q_id, sv.CQ_Env_Ach as response  
  union all
  select sv.h_id, 17 as q_id, sv.CQ_Env_Imp as response 
  union all
  select sv.h_id, 18 as q_id, sv.CQ_Env_Dim as response
  union all
  select sv.h_id, 19 as q_id, sv.Dis_Info_Ach as response  
  union all
  select sv.h_id, 20 as q_id, sv.Dis_Info_Imp as response 
  union all
  select sv.h_id, 21 as q_id, sv.Dis_Info_Dim as response
  union all
  select sv.h_id, 22 as q_id, sv.Overall_Ach_Pts as response  
  union all
  select sv.h_id, 23 as q_id, sv.Overall_Imp_Pts as response 
  union all
  select sv.h_id, 24 as q_id, sv.Overall_Dim_Score as response
  union all
  select sv.h_id, 25 as q_id, sv.HCAHPS_Base_Score as response  
  union all
  select sv.h_id, 26 as q_id, sv.HCAHPS_Consistency_Score as response;  

	
