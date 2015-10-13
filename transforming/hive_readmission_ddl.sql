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
