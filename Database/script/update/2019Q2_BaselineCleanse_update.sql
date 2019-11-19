--update race data for WCTC
--affected rows = 20 rows
select * from demographic
where clientid in ('1943698','1945213','1947501','1947784','1948460','1949797','1950731','1943402',
				   '1946626','1949399','1950582','1950992','1951243','1951512','1952252','1952253',
				   '1952373','1952423','1952939','1950024'
);

--update race from null to Hispanic
update demographic
set race = 'Hispanic'
where clientid in ('1943402',
'1946626',
'1949399',
'1950582',
'1950992',
'1951243',
'1951512',
'1952252',
'1952253',
'1952373',
'1952423',
'1952939',
'1950024');       --updated 13

--update from null to Multiple
update demographic set race = 'Multiple'
where clientid in ('1943698',
'1945213',
'1947501',
'1947784',
'1948460',
'1949797',
'1950731');       --updated 7


-----------------------------------------------------------------------------------
---update marital status for WCTC
select * from demographic where clientid in ('1943402',
'1944645',
'1933676',
'1943539',
'1944662',
'1944700',
'1944759');


--Divorced
update demographic set maritalstatus = 'Divorced' where clientid ='1943402';
--Married or Domestic Partnership
update demographic set maritalstatus = 'Married or Domestic Partnership' where clientid in ('1943539',
'1944759');
--Separated
update demographic set maritalstatus = 'Separated' where clientid ='1944662';
--Single
update demographic set maritalstatus = 'Single' where clientid in ('1944645',
'1933676',
'1944700');

-----------------------------------------------------------------------------------
--highested
select * from demographic where clientid in ('1943402',
'1944662',
'1944700',
'1943541');

--bachelor's degree
update demographic set highested = 'Bachelor''s Degree' where clientid ='1943402';
--HS, GED, or equivalent
update demographic set highested = 'HS, GED, or equivalent' where clientid in ('1944662',
'1944700',
'1943541');

------------------------------------------------------------------------------------
--housingtype
--homeless
select * from demographic where clientid in ('1943402',
'1944662',
'1943541',
'1944645',
'1943539',
'1912672',
'1912680',
'1912886',
'1914325',
'1918783',
'1918885',
'1918900',
'1925953',
'1930541',
'1930582',
'1931589',
'1933003',
'1933436',
'1933732',
'1933790',
'1934553',
'1934558',
'1935329',
'1936243',
'1938146',
'1938457',
'1940563',
'1940717',
'1941367',
'1941490',
'1943532',
'1943537',
'1943727',
'1944501',
'1944701',
'1945069',
'1948371',
'1950156',
'1954441',
'1954595',
'1959793');

update demographic set housingtype ='Homeless' where clientid in ('1930582',
'1943727',
'1959793');
--Lives with Relstives/Friends
update demographic set housingtype = 'Lives with Relstives/Friends' where clientid in ('1944662',
'1914325',
'1930541',
'1933003',
'1933436',
'1933790',
'1934553',
'1934558',
'1940563',
'1943532',
'1943537',
'1944701',
'1954595');
--Owns
update demographic set housingtype = 'Owns' where clientid in ('1943539',
'1918783',
'1931589',
'1933732',
'1936243',
'1941490',
'1945069',
'1948371',
'1954441');

--Receives free or subsidized housing
update demographic set housingtype ='Receives free or subsidized housing' where clientid in ('1912672',
'1938146',
'1950156');

--Rents
update demographic set housingtype = 'Rents' where clientid in ('1943402',
'1943541',
'1944645',
'1912680',
'1912886',
'1918885',
'1918900',
'1925953',
'1935329',
'1938457',
'1940717',
'1941367',
'1944501');

--hhadults
select * from demographic where clientid in ('1943402',
'1944662',
'1943541',
'1944645',
'1943539',
'1912672',
'1912886',
'1914325',
'1918783',
'1918885',
'1918900',
'1925953',
'1930541',
'1930582',
'1931589',
'1933003',
'1933436',
'1933790',
'1934558',
'1935329',
'1936243',
'1938146',
'1938457',
'1940563',
'1940717',
'1941367',
'1941490',
'1943532',
'1943537',
'1943727',
'1944701',
'1945069',
'1948371',
'1950156',
'1954441',
'1954595',
'1959793',
'1931961',
'1933259',
'1933414',
'1938073',
'1939162',
'1939254',
'1939479',
'1943882',
'1954868');
--1 adult
update demographic set hhadults =1 where clientid in ('1943402',
'1944662',
'1943541',
'1944645',
'1912672',
'1918783',
'1918885',
'1918900',
'1925953',
'1930582',
'1933436',
'1935329',
'1936243',
'1941367',
'1941490',
'1943727',
'1945069',
'1950156',
'1954441',
'1959793',
'1933414',
'1939162',
'1939254',
'1939479'); 

--2 adults
update demographic set hhadults =2 where clientid in ('1943539',
'1914325',
'1931589',
'1933790',
'1934558',
'1938146',
'1938457',
'1940717',
'1943537',
'1931961',
'1933259',
'1938073',
'1943882');

--3 adults
update demographic set hhadults =3 where clientid in ('1912886',
'1930541',
'1933003',
'1940563',
'1944701',
'1948371',
'1954595');

--4 adults
update demographic set hhadults =4 where clientid in ('1943532',
'1954868');



--------------------------------------------------------------------------------------
--hhchildren
select * from demographic where clientid in ('1944662',
'1943541',
'1944645',
'1943539',
'1912672',
'1912886',
'1914325',
'1918783',
'1918885',
'1918900',
'1925953',
'1930541',
'1931589',
'1933003',
'1933436',
'1933790',
'1934558',
'1935329',
'1936243',
'1938146',
'1938457',
'1940563',
'1940717',
'1941367',
'1941490',
'1943532',
'1943537',
'1943727',
'1944701',
'1945069',
'1948371',
'1950156',
'1954441',
'1954595',
'1959793',
'1931961',
'1933259',
'1933414',
'1938073',
'1939162',
'1939254',
'1939479',
'1943882',
'1954868',
'1933005',
'1933145',
'1946621',
'1957300');

--0 child
update demographic set hhchildren =0 where clientid in ('1944662',
'1912672',
'1912886',
'1914325',
'1918783',
'1918900',
'1930541',
'1934558',
'1936243',
'1940563',
'1940717',
'1941367',
'1941490',
'1943532',
'1943537',
'1945069',
'1948371',
'1954441',
'1954595',
'1931961',
'1933259',
'1933414',
'1939162',
'1939254',
'1939479',
'1946621',
'1957300');

--1 child
update demographic set hhchildren =1 where clientid in ('1943541',
'1943539',
'1925953',
'1931589',
'1938146',
'1938073',
'1943882',
'1933145');
--2 children
update demographic set hhchildren =2 where clientid in ('1933003',
'1935329',
'1938457',
'1959793');
--3 children
update demographic set hhchildren =3 where clientid in ('1944645',
'1918885',
'1933790',
'1944701',
'1933005');
--4 children
update demographic set hhchildren =4 where clientid in ('1933436',
'1943727',
'1950156',
'1954868');

-------------------------------------------------------------------------------------
--criminalbackground
select * from demographic where clientid in ('1944701',
'1943402',
'1944700');

update demographic set criminalbackground ='No' where clientid in ('1944701',
'1943402',
'1944700');

-------------------------------------------------------------------------------------
--Finished demographic updates

select * from bundledservices_checkin;
select * from bundledservices_checkin bc 
join records r on r.bundledservicesid = bc.bundledservicesid 
where clientid in ('1954441',
'182953',
'1820428',
'1831519',
'1831613',
'1832043',
'1840748',
'1856454',
'1864220',
'18100478',
'18115110',
'18115332',
'18120455',
'18123992') and baseline_baseline is true;

update bundledservices_checkin set accessemployment ='Yes' where bundledservicesid in (
select bc.bundledservicesid from bundledservices_checkin bc 
join records r on r.bundledservicesid = bc.bundledservicesid 
where clientid in ('1954441',
'182953',
'1820428',
'1831519',
'1831613',
'1832043',
'1840748',
'1856454',
'1864220',
'18100478',
'18115110',
'18115332',
'18120455',
'18123992') and baseline_baseline is true);

------------------------------------------------------------------------
--employmentstatus
copy
(select * from employment e
join records r on e.employmentid = r.employmentid
where r.clientid in ('1944701',
'1943402',
'1944700',
'1943541',
'1943539',
'1914325',
'1918783',
'1918900',
'1925953',
'1930541',
'1931589',
'1933790',
'1938146',
'1940717',
'1941367',
'1941490',
'1943532',
'1943537',
'1945069',
'1948371',
'1950156',
'1933259',
'1938073',
'1939162',
'1939254',
'1939479',
'1933005',
'1946621',
'1930582',
'1912680',
'1933732',
'1934553',
'1933676',
'1948460',
'1949797',
'1950731',
'1938467',
'1940317',
'1911051',
'1911918',
'1914339',
'1914799',
'1916740',
'1918262',
'1923970',
'1929003',
'1929937',
'1930984',
'1931641',
'1931886',
'1932209',
'1932502',
'1932968',
'1933001',
'1933247',
'1934355',
'1934369',
'1934609',
'1935132',
'1935611',
'1935886',
'1936074',
'1936149',
'1936226',
'1936286',
'1936441',
'1936737',
'1936847',
'1937030',
'1937187',
'1937419',
'1937541',
'1938104',
'1938322',
'1938405',
'1938468',
'1938571',
'1938619',
'1938686',
'1938760',
'1938990',
'1938998',
'1939009',
'1939098',
'1939439',
'1939477',
'1939489',
'1939601',
'1940178',
'1940184',
'1940200',
'1940341',
'1940448',
'1940450',
'1940508',
'1940764',
'1940851',
'1940852',
'1941278',
'1941322',
'1941324',
'1941479',
'1941530',
'1941636',
'1941700',
'1941783',
'1941795',
'1941821',
'1942007',
'1942064',
'1942065',
'1942079',
'1942194',
'1942403',
'1942536',
'1942629',
'1942708',
'1942855',
'1943514',
'1943763',
'1944247',
'1944315',
'1944529',
'1944665',
'1944697',
'1944789',
'1945486',
'1945590',
'1945660',
'1945845',
'1945872',
'1945911',
'1945980',
'1946024',
'1946039',
'1946082',
'1946097',
'1946244',
'1946306',
'1946310',
'1946586',
'1946599',
'1946618',
'1946619',
'1946623',
'1946624',
'1946625',
'1946696',
'1946699',
'1946742',
'1947428',
'1947490',
'1947495',
'1947521',
'1947548',
'1947553',
'1947556',
'1947595',
'1947655',
'1947713',
'1947757',
'1947760',
'1947888',
'1947891',
'1947894',
'1947907',
'1947937',
'1947957',
'1948033',
'1948129',
'1948157',
'1948171',
'1948201',
'1948204',
'1948229',
'1948230',
'1948234',
'1948276',
'1948277',
'1948321',
'1948344',
'1948388',
'1948472',
'1948474',
'1948552',
'1948698',
'1948699',
'1948896',
'1948933',
'1948950',
'1948951',
'1949013',
'1949069',
'1949081',
'1949165',
'1949187',
'1949188',
'1949279',
'1949285',
'1949291',
'1949354',
'1949396',
'1949401',
'1949448',
'1949451',
'1949548',
'1949624',
'1949656',
'1949681',
'1949777',
'1949806',
'1949856',
'1949894',
'1950021',
'1950027',
'1950152',
'1950153',
'1950180',
'1950255',
'1950288',
'1950290',
'1950296',
'1950337',
'1950399',
'1950402',
'1950436',
'1950532',
'1950600',
'1950689',
'1950725',
'1950756',
'1950944',
'1950995',
'1951015',
'1951018',
'1951408') and r.baseline_baseline is true) to 'C:\Users\Leah Zhang\Desktop\database\exports\empstatus_baseline.csv' header csv;

--found out that clientid 1923970, 1930984 not exist in the database, need to check with WCTC if they want to insert baseline data for those two
select * from records where clientid in ('1923970', '1930984');

begin;
--Employed Full Time
update employment set employmentstatus='Employed Full Time' where employmentid in 
(select e.employmentid from employment e join records r on r.employmentid = e.employmentid
where clientid in ('1930582',
'1932209',
'1933259',
'1935886',
'1937187',
'1938571',
'1940717',
'1940764',
'1941479',
'1941636',
'1942064',
'1943514',
'1949069',
'1950288',
'1950600',
'1950995') and baseline_baseline is true);

--Employed Part Time
update employment set employmentstatus='Employed Part Time' where employmentid in 
(select e.employmentid from employment e join records r on r.employmentid = e.employmentid
where clientid in ('1938104',
'1938619',
'1941322',
'1941490',
'1945980') and baseline_baseline is true);

--Not employed
update employment set employmentstatus ='Not employed' where employmentid in 
(select e.employmentid from employment e join records r on r.employmentid = e.employmentid
where clientid in ('1911051',
'1911918',
'1912680',
'1914325',
'1914339',
'1914799',
'1916740',
'1918262',
'1918783',
'1918900',
'1925953',
'1929003',
'1929937',
'1930541',
'1931589',
'1931641',
'1931886',
'1932502',
'1932968',
'1933001',
'1933005',
'1933247',
'1933676',
'1933732',
'1933790',
'1934355',
'1934369',
'1934553',
'1934609',
'1935132',
'1935611',
'1936074',
'1936149',
'1936226',
'1936286',
'1936441',
'1936737',
'1936847',
'1937030',
'1937419',
'1937541',
'1938073',
'1938146',
'1938322',
'1938405',
'1938467',
'1938468',
'1938686',
'1938760',
'1938990',
'1938998',
'1939009',
'1939098',
'1939162',
'1939254',
'1939439',
'1939477',
'1939479',
'1939489',
'1939601',
'1940178',
'1940184',
'1940200',
'1940317',
'1940341',
'1940448',
'1940450',
'1940508',
'1940851',
'1940852',
'1941278',
'1941324',
'1941367',
'1941530',
'1941700',
'1941783',
'1941795',
'1941821',
'1942007',
'1942065',
'1942079',
'1942194',
'1942403',
'1942536',
'1942629',
'1942708',
'1942855',
'1943402',
'1943532',
'1943537',
'1943539',
'1943541',
'1943763',
'1944247',
'1944315',
'1944529',
'1944665',
'1944697',
'1944700',
'1944701',
'1944789',
'1945069',
'1945486',
'1945590',
'1945660',
'1945845',
'1945872',
'1945911',
'1946024',
'1946039',
'1946082',
'1946097',
'1946244',
'1946306',
'1946310',
'1946586',
'1946599',
'1946618',
'1946619',
'1946621',
'1946623',
'1946624',
'1946625',
'1946696',
'1946699',
'1946742',
'1947428',
'1947490',
'1947495',
'1947521',
'1947548',
'1947553',
'1947556',
'1947595',
'1947655',
'1947713',
'1947757',
'1947760',
'1947888',
'1947891',
'1947894',
'1947907',
'1947937',
'1947957',
'1948033',
'1948129',
'1948157',
'1948171',
'1948201',
'1948204',
'1948229',
'1948230',
'1948234',
'1948276',
'1948277',
'1948321',
'1948344',
'1948371',
'1948388',
'1948460',
'1948472',
'1948474',
'1948552',
'1948698',
'1948699',
'1948896',
'1948933',
'1948950',
'1948951',
'1949013',
'1949081',
'1949165',
'1949187',
'1949188',
'1949279',
'1949285',
'1949291',
'1949354',
'1949396',
'1949401',
'1949448',
'1949451',
'1949548',
'1949624',
'1949656',
'1949681',
'1949777',
'1949797',
'1949806',
'1949856',
'1949894',
'1950021',
'1950027',
'1950152',
'1950153',
'1950156',
'1950180',
'1950255',
'1950290',
'1950296',
'1950337',
'1950399',
'1950402',
'1950436',
'1950532',
'1950689',
'1950725',
'1950731',
'1950756',
'1950944',
'1951015',
'1951018',
'1951408') and baseline_baseline is true);

--------------------------------------------------------------------------------------------
---employmentstartdate
select * from employment e
join records r on e.employmentid = r.employmentid
where r.clientid in ('1940717',
'1941490',
'1930582',
'1932209',
'1937187',
'1938571',
'1938619',
'1940764',
'1941322',
'1941479',
'1941636',
'1942064',
'1943514',
'1945980',
'1949069',
'1950288',
'1950600',
'1950995') and baseline_baseline is true;

create temporary table empstartdate(
agency varchar(50),
clientid varchar(50),
empdate timestamp);

copy empstartdate from 'C:\Users\Leah Zhang\Desktop\database\empstartdate_WCTC.csv' delimiter ',' csv header;

create view empdate_update as 
select es.*,r.employmentid  from empstartdate es
join records r on r.clientid = es.clientid and baseline_baseline is true;

update employment e
set employmentstartdate = es.empdate
from empdate_update es
where e.employmentid = es.employmentid;

drop view empdate_update;

-------------------------------------------------------------------------------------
--savings
select * from financials f join records r on f.financialsid = r.financialsid 
where r.clientid in ('1941490',
'1930582',
'1938619',
'1941479',
'1941636',
'1925953',
'1931589',
'1941367',
'1938073',
'1939162',
'1932968',
'1938990',
'1940184',
'1942079',
'1912886',
'1918885',
'1934558',
'1935329',
'1940563',
'1959793',
'1950024',
'1934174',
'1934799',
'1936827',
'1937432',
'1939157',
'1939845',
'1941519',
'1942971',
'1944718',
'18123693')
and baseline_baseline is true;


create temporary table savings_update_2(
agency varchar(50),
clientid varchar(50),
savings numeric);

copy savings_update_2 from 'C:\Users\Leah Zhang\Desktop\database\savings_update.csv' delimiter ',' csv header;

create view savings_update_view as 
select s2.*, r.financialsid from savings_update_2 s2 join records r on r.clientid =s2.clientid and baseline_baseline is true;

begin;
update financials f
set savings = s2.savings
from savings_update_view s2
where f.financialsid = s2.financialsid;
commit;

--------------------------------------------------------------------------------------------------
--creditscore
select * from financials f join records r on r.financialsid = f.financialsid
where clientid in ('1937432',
'1944718',
'1942855',
'1941550',
'1943078',
'1936084',
'1936976',
'1951767') and baseline_baseline is true;

create temporary table cs_update_2(
agency varchar(50),
clientid varchar(50),
creditscore int);

copy cs_update_2 from 'C:\Users\Leah Zhang\Desktop\database\creditscore_update.csv' delimiter ',' csv header;

create view cs_update_view as 
select s2.*, r.financialsid from cs_update_2 s2 join records r on r.clientid =s2.clientid and baseline_baseline is true;

begin;

update financials f
set creditscore = s2.creditscore
from cs_update_view s2
where f.financialsid = s2.financialsid;
commit;

-------------------------------------------------------------------------------------
--debt
select * from financials f join records r on r.financialsid = f.financialsid
where clientid in ('1936976',
'1941490',
'1941636',
'1941367',
'1938073',
'1939162',
'1940184',
'1942079',
'1934558',
'1935329',
'1940563',
'1959793',
'1934174',
'1934799',
'1939845',
'1941519',
'1940717',
'1937419',
'1939601',
'1941700',
'1938115',
'1938454',
'1938871',
'1939363',
'1939608',
'1942166',
'1943208',
'1945742',
'1953422') and baseline_baseline is true;

create temporary table debt_update_2(
agency varchar(50),
clientid varchar(50),
debt numeric);

copy debt_update_2 from 'C:\Users\Leah Zhang\Desktop\database\debt_update.csv' delimiter ',' csv header;

create view debt_update_view as 
select s2.*, r.financialsid from debt_update_2 s2 join records r on r.clientid =s2.clientid and baseline_baseline is true;

begin;

update financials f
set debt = s2.debt
from debt_update_view s2
where f.financialsid = s2.financialsid;
commit;

----------------------------------------------------------------------
--wages2

select * from wages w join records r on r.wagesid = w.wagesid where clientid = '1938619' and baseline_baseline is true;
--wagesid =3707

begin;
update wages
set wages2 = 25 where wagesid =3707;
commit;

-------------------------------------------------------------------------
--accessincome
select * from bundledservices_checkin bc join records r on r.bundledservicesid = bc.bundledservicesid
where clientid in ('1831519',
'18100478',
'18123992',
'189643',
'1827748',
'1831906',
'1833071',
'1833307',
'1833617',
'1833854',
'1865856',
'18101081',
'18102146',
'1866125',
'18123820',
'18124396') and baseline_baseline is true;

begin;
update bundledservices_checkin 
set accessincome = 'Yes'
where bundledservicesid in(
select bc.bundledservicesid from bundledservices_checkin bc join records r on r.bundledservicesid = bc.bundledservicesid
where clientid in ('1831519',
'18100478',
'18123992',
'189643',
'1827748',
'1831906',
'1833071',
'1833307',
'1833617',
'1833854',
'1865856',
'18101081',
'18102146',
'1866125',
'18123820',
'18124396') and baseline_baseline is true);
commit;

------------------------------------------------------------------
--accessfinancialcoach
select * from bundledservices_checkin bc join records r on r.bundledservicesid = bc.bundledservicesid
where clientid in ('18100478',
'1831906',
'1833307',
'18101081',
'18102146',
'18123820',
'18124396',
'18123693',
'182953',
'1820428',
'1831613',
'1840748',
'1856454',
'1864220',
'18120455',
'181652',
'183433',
'1815572',
'1831721',
'1832351',
'1832403',
'1832439',
'1832713',
'1833572',
'1843764',
'1857409',
'18101059',
'18104912',
'18110218',
'18116966',
'18116983',
'1843538',
'1845793') and baseline_baseline is true;


begin;

update bundledservices_checkin 
set accessfinancialcoach = 'Yes'
where bundledservicesid in(
select bc.bundledservicesid from bundledservices_checkin bc join records r on r.bundledservicesid = bc.bundledservicesid
where clientid in ('18100478',
'1831906',
'1833307',
'18101081',
'18102146',
'18123820',
'18124396',
'18123693',
'182953',
'1820428',
'1831613',
'1840748',
'1856454',
'1864220',
'18120455',
'181652',
'183433',
'1815572',
'1831721',
'1832351',
'1832403',
'1832439',
'1832713',
'1833572',
'1843764',
'1857409',
'18101059',
'18104912',
'18110218',
'18116966',
'18116983',
'1843538',
'1845793') and baseline_baseline is true);

commit;


-----------------------------------------------------------------
--bundledservices 

select * from bundledservices_checkin bc
join records r on r.bundledservicesid = bc.bundledservicesid
where clientid in ('18100478',
'1831906',
'1833307',
'18101081',
'18102146',
'18123820',
'18124396',
'18123693',
'182953',
'1820428',
'1831613',
'1840748',
'1856454',
'1864220',
'18120455',
'181652',
'183433',
'1815572',
'1831721',
'1832351',
'1832403',
'1832439',
'1832713',
'1833572',
'1843764',
'1857409',
'18101059',
'18104912',
'18110218',
'18116966',
'18116983',
'1843538',
'1845793',
'1831519',
'18123992',
'189643',
'1827748',
'1833071',
'1833617',
'1833854',
'1865856',
'1866125',
'1832043',
'18115110',
'18115332') and baseline_baseline is true;

create temporary table bundling_update_2(
agency varchar(50),
clientid varchar(50),
bs int);

copy bundling_update_2 from 'C:\Users\Leah Zhang\Desktop\database\bundling_update.csv' delimiter ',' csv header;

create view bs_update_view as 
select s2.*, r.bundledservicesid from bundling_update_2 s2 join records r on r.clientid =s2.clientid and baseline_baseline is true;


begin;
rollback;
update bundledservices_checkin bc
set bundledservices = s2.bs
from bs_update_view s2
where bc.bundledservicesid = s2.bundledservicesid;
commit;


