--This is to delete SL's data 

--First find recordid for SL's data in the records table
select * from records r 
join demographic d on d.clientid = r.clientid
where d.agency = 'SharingLife';
--recordid between 25155 and 25166;

begin;

delete from records where recordid between 25155 and 25166;       --12 rows affected

---Find SL's data in demographic table
select * from demographic
where agency = 'SharingLife';

delete from demographic
where agency = 'SharingLife';               --12 rows affected

commit;
