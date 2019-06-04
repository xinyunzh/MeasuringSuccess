update demographic set clientid = case
when clientid = '1.66822E+11' then '166822050356'
when clientid = '1.66166E+11' then '166166347019'
end
where clientid in ('1.66822E+11','1.66166E+11');														 

update records set clientid = case 
when clientid = '1.66822E+11' then '166822050356'
when clientid = '1.66166E+11' then '166166347019'
end
where clientid in ('1.66822E+11','1.66166E+11');


select * from records where clientid in ('166822050356','166166347019');
select * from demographic where clientid in ('166822050356','166166347019');