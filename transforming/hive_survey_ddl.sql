-- survey table - use a UDF to normalize "x out y" to x/y

drop table m_survey;
create table m_survey as
  select distinct
    h.id as h_id,
    split(Com_Nur_Ach, ' ')[0]/split(Com_Nur_Ach, ' ')[3] as Com_Nur_Ach,
    split(Com_Nur_Imp, ' ')[0]/split(Com_Nur_Imp, ' ')[3] as Com_Nur_Imp,
    split(Com_Nur_Dim, ' ')[0]/split(Com_Nur_Dim, ' ')[3] as Com_Nur_Dim,
    split(Com_Doc_Ach, ' ')[0]/split(Com_Doc_Ach, ' ')[3] as Com_Doc_Ach,
    split(Com_Doc_Imp, ' ')[0]/split(Com_Doc_Imp, ' ')[3] as Com_Doc_Imp,
    split(Com_Doc_Dim, ' ')[0]/split(Com_Doc_Dim, ' ')[3] as Com_Doc_Dim,
    split(Res_Staff_Ach, ' ')[0]/split(Res_Staff_Ach, ' ')[3] as Res_Staff_Ach,
    split(Res_Staff_Imp, ' ')[0]/split(Res_Staff_Imp, ' ')[3] as Res_Staff_Imp,
    split(Res_Staff_Dim, ' ')[0]/split(Res_Staff_Dim, ' ')[3] as Res_Staff_Dim,
    split(Pain_Mgmt_Ach, ' ')[0]/split(Pain_Mgmt_Ach, ' ')[3] as Pain_Mgmt_Ach,
    split(Pain_Mgmt_Imp, ' ')[0]/split(Pain_Mgmt_Imp, ' ')[3] as Pain_Mgmt_Imp,
    split(Pain_Mgmt_Dim, ' ')[0]/split(Pain_Mgmt_Dim, ' ')[3] as Pain_Mgmt_Dim,
    split(Com_Meds_Ach, ' ')[0]/split(Com_Meds_Ach, ' ')[3] as Com_Meds_Ach,
    split(Com_Meds_Imp, ' ')[0]/split(Com_Meds_Imp, ' ')[3] as Com_Meds_Imp,
    split(Com_Meds_Dim, ' ')[0]/split(Com_Meds_Dim, ' ')[3] as Com_Meds_Dim,
    split(CQ_Env_Ach, ' ')[0]/split(CQ_Env_Ach, ' ')[3] as CQ_Env_Ach,
    split(CQ_Env_Imp, ' ')[0]/split(CQ_Env_Imp, ' ')[3] as CQ_Env_Imp,
    split(CQ_Env_Dim, ' ')[0]/split(CQ_Env_Dim, ' ')[3] as CQ_Env_Dim,
    split(Dis_Info_Ach, ' ')[0]/split(Dis_Info_Ach, ' ')[3] as Dis_Info_Ach,
    split(Dis_Info_Imp, ' ')[0]/split(Dis_Info_Imp, ' ')[3] as Dis_Info_Imp,
    split(Dis_Info_Dim, ' ')[0]/split(Dis_Info_Dim, ' ')[3] as Dis_Info_Dim,
    split(Overall_Ach_Pts, ' ')[0]/split(Overall_Ach_Pts, ' ')[3] as Overall_Ach_Pts,
    split(Overall_Imp_Pts, ' ')[0]/split(Overall_Imp_Pts, ' ')[3] as Overall_Imp_Pts,
    split(Overall_Dim_Score, ' ')[0]/split(Overall_Dim_Score, ' ')[3] as Overall_Dim_Score,
    cast(HCAHPS_Base_Score as int) as HCAHPS_Base_Score,
    cast(HCAHPS_Consistency_Score as int) as HCAHPS_Consistency_Score
  from e_hospital h inner join e_survey s on h.id = s.provider_id;