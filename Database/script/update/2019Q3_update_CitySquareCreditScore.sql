---The purpose of this code is to have 
--find out CitySquare check-in recordid, financialsid, clientid, creditscore
create view cs_update_2019Q3_score as
select r.recordid, f.financialsid, r.clientid, r.quarter, f.creditscore from records r 
join financials f on f.financialsid = r.financialsid
join demographic d on d.clientid = r.clientid
where r.baseline_baseline is false and d.agency ='CitySquare' and r.quarter = '2019 Q3';

select count(*) from cs_update_2019Q3_score;    --424
select * from cs_update_2019Q3_score;


--find out CitySquare baseline financialsid, clientid before 2019Q1 that has returned in 2019Q1      ---299 rows
--find out those CitySquare's baselines that needs to be updated
create view cs_update_2019Q3_fid as
select f.financialsid, r.clientid from financials f
join records r on r.financialsid = f.financialsid
join cs_update_2019Q3_score score on score.clientid = r.clientid
where r.baseline_baseline is true and r.recordid <23664;

--299rows


create view cs_update_2019Q3 as 
select score.financialsid as checkin_fid, score.clientid as checkin_clientid, score.creditscore as checkin_creditscore, fid.financialsid as baseline_fid,
fid.clientid as baseline_clientid
from cs_update_2019Q3_score score
join cs_update_2019Q3_fid fid on score.clientid = fid.clientid;


select * from cs_update_2019Q3;      --299

update financials      --updated 299 rows
set creditscore = cs_score.checkin_creditscore
from cs_update_2019Q3 cs_score
where financialsid =baseline_fid;


drop view cs_update_2019Q3_score cascade;






