begin;
delete from records
where clientid in ('1958934',
'1939471',
'1957245',
'1954652',
'1956438',
'1949333',
'1959057'
);                   ---19 rows affected

select count(*) from records;       ----25397

delete from demographic
where clientid in ('1958934',
'1939471',
'1957245',
'1954652',
'1956438',
'1949333',
'1959057'
);                ----7rows affected

---to check the numbers
select count(*)-12 as baseline_num from demographic;

select count(*) from demographic 
where quarter = '2019 Q1' and agency = 'WCTC';

select count(*) from records r 
join demographic d on d.clientid = r.clientid
where r.quarter = '2019 Q1' and r.baseline_baseline is false;


commit;

