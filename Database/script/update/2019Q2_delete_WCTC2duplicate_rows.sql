--There are duplicates records for WCTC, choose the one with more info to delete them

select * from records r 
join financials f on f.financialsid = r.financialsid
join wages w on w.wagesid = r.wagesid
where r.clientid in ('1941636','1949962') and r.quarter = '2019 Q2' 
order by r.clientid;

--delete recordid 26794 for clientid 1941636
--delete recordid 26917 for clientid 1949962


delete from records where recordid in ('26794', '26917');


select * from records;    --27078