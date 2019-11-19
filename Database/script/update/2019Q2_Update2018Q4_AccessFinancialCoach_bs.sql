--to check if 2018Q4 accessfinancialcoach baseline data is missing
create view database_2018Q4 as 
select d.agency, r.clientid, r.quarter, bsc.bundledservicesid, bsc.accessincome, bsc.accessemployment, bsc.accessfinancialcoach, bsc.bundledservices from bundledservices_checkin bsc
join records r on r.bundledservicesid = bsc.bundledservicesid
join demographic d on d.clientid  = r.clientid
where r.quarter = '2018 Q4' and r.baseline_baseline is true;

--get the right data from previous data processing
--create temp table for 2018Q4 data
create table temp_2018Q4(
Agency_Baseline	varchar(50),
ClientID_Baseline	varchar(50),
QuarterBaselineSubmitted	varchar(50),
Baseline_Baseline	boolean,
AccessFinancialCoach_Baseline	varchar(10),
BundledServicesBaseline_Baseline  smallint
);

--copy data
copy temp_2018Q4 from 'C:\Users\Leah Zhang\Desktop\database\2018Q4baseline_update_8.1.csv' DELIMITER  ',' csv header;

--begin
--update clientid for CCD as they asked to update their clientID in 2019Q1
update temp_2018Q4 set ClientID_Baseline = case
when ClientID_Baseline = '1066313' then '1016728'
when ClientID_Baseline = '1066286' then '1018386'
when ClientID_Baseline = '1066176' then '1000051'
when ClientID_Baseline = '1066175' then '1000052'
when ClientID_Baseline = '1066152' then '1000075'
when ClientID_Baseline = '1066113' then '1000114'
when ClientID_Baseline = '1066112' then '1000115'
when ClientID_Baseline = '1065942' then '1000280'
when ClientID_Baseline = '1065938' then '1000284'
when ClientID_Baseline = '1064399' then '1001785'
when ClientID_Baseline = '1064209' then '1001971'
when ClientID_Baseline = '1063855' then '1002315'
when ClientID_Baseline = '1063141' then '1002981'
when ClientID_Baseline = '1062565' then '1003552'
when ClientID_Baseline = '1062300' then '1003173'
when ClientID_Baseline = '1060105' then '1000028'
when ClientID_Baseline = '1058246' then '1013538'
when ClientID_Baseline = '1057971' then '1010009'
when ClientID_Baseline = '1057892' then '1013877'
when ClientID_Baseline = '1056964' then '1004903'
when ClientID_Baseline = '1055886' then '1006814'
when ClientID_Baseline = '1038869' then '1016960'
when ClientID_Baseline = '1027494' then '1005953'
end
where ClientID_Baseline in ('1066313',
'1066286',
'1066176',
'1066175',
'1066152',
'1066113',
'1066112',
'1065942',
'1065938',
'1064399',
'1064209',
'1063855',
'1063141',
'1062565',
'1062300',
'1060105',
'1058246',
'1057971',
'1057892',
'1056964',
'1055886',
'1038869',
'1027494'
);
 
 --rollback;
--commit;
--to check
/**
copy
(select * from temp_2018Q4 t
join database_2018Q4 d on d.clientid = t.clientid_baseline) to 'C:\Users\Leah Zhang\Desktop\database\exports\to_match.csv' csv header;     --358  --368
**/

--create view to update accessfinancialcoach data
create view to_update_afinancialcoach as 
select * from temp_2018Q4 t
join database_2018Q4 d on d.clientid = t.clientid_baseline;

select * from to_update_afinancialcoach;

--begin;
update bundledservices_checkin bsc
set accessfinancialcoach = tua.accessfinancialcoach_baseline,
    bundledservices = tua.BundledServicesBaseline_Baseline
from to_update_afinancialcoach tua
where bsc.bundledservicesid = tua.bundledservicesid;

--rollback;

--to check
select d.agency, r.clientid, r.quarter, bsc.bundledservicesid, bsc.accessincome, bsc.accessemployment, bsc.accessfinancialcoach, bsc.bundledservices from bundledservices_checkin bsc
join records r on r.bundledservicesid = bsc.bundledservicesid
join demographic d on d.clientid  = r.clientid
where r.quarter = '2018 Q4' and r.baseline_baseline is true;

/**
copy
(select d.agency, r.clientid, r.quarter, bsc.bundledservicesid, bsc.accessincome, bsc.accessemployment, bsc.accessfinancialcoach, bsc.bundledservices from bundledservices_checkin bsc
join records r on r.bundledservicesid = bsc.bundledservicesid
join demographic d on d.clientid  = r.clientid
where d.agency = 'Metrocrest' and r.quarter = '2018 Q4' and r.baseline_baseline is true) to 'C:\Users\Leah Zhang\Desktop\database\exports\updated_2018Q4_metrocrest.csv' csv header; 

--commit;
**/