-- measure table

drop table m_measure;
create table m_measure as
  select distinct
    id, name, start_date, end_date
  from e_measure;
