create view cs_update_2019Q1_score as
select r.recordid, f.financialsid, r.clientid, r.quarter, f.creditscore from records r 
join financials f on f.financialsid = r.financialsid
join demographic d on d.clientid = r.clientid
where r.baseline_baseline is false and d.agency ='CitySquare' and r.quarter = '2019 Q1';

create view cs_update_2019Q1_fid as
select f.financialsid, r.clientid from financials f
join records r on r.financialsid = f.financialsid
join cs_update_2019Q1_score score on score.clientid = r.clientid
where r.baseline_baseline is true and r.recordid <23664;

--411rows

create view cs_update_2019Q1 as 
select score.financialsid as checkin_fid, score.clientid as checkin_clientid, score.creditscore as checkin_creditscore, fid.financialsid as baseline_fid,
fid.clientid as baseline_clientid
from cs_update_2019Q1_score score
join cs_update_2019Q1_fid fid on score.clientid = fid.clientid;


select * from cs_update_2019Q1;

update financials      --updated 411 rows
set creditscore = cs_score.checkin_creditscore
from cs_update_2019Q1 cs_score
where financialsid =baseline_fid;


drop view cs_update_2019Q1_score cascade;


copy (select * from for_q) to 'C:\Users\Leah Zhang\Desktop\database\exports\forQ_2019Q1_5_22.csv' csv header;



