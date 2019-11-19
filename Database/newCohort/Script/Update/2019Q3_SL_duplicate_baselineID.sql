select d.agency,d.DOB, r.* from records r 
join demographic d on d.clientid =r.clientid
where r.clientid in ('2093127', '2092146');

begin;
--need to change recordid 315 clientid from 2093127 to 2092146. Only changed demographic clientid, forgot about the record table while inserting data.
update records
set clientid ='2092146'
where recordid = 315;

commit;

select * from demographic where clientid ='2092146';
