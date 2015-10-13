-- hospital table

drop table m_hospital;
create table m_hospital as
  select distinct
    id, name, address, city, state, zip,
    county, phone, type, ownership, emergency
  from e_hospital;