--update something they messed up
--IRC

update records set clientid = case
when clientid = '160172' then '160171'
end
where clientid in ('160172');

update records set clientid = '160171'
where recordid in (26209);


select * from records where recordid in (26208, 26209,26210,26211);

select * from demographic where clientid in ('160172', '160171');

