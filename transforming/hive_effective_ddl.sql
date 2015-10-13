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