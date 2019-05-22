------updating CCD's clientid-------------
select * from records where clientid ='1016728';

select * from records where clientid ='1066313';

begin;
-----update records first------------
update records set clientid = case
when clientid = '1066313' then '1016728'
when clientid = '1066286' then '1018386'
when clientid = '1066176' then '1000051'
when clientid = '1066175' then '1000052'
when clientid = '1066152' then '1000075'
when clientid = '1066113' then '1000114'
when clientid = '1066112' then '1000115'
when clientid = '1065942' then '1000280'
when clientid = '1065938' then '1000284'
when clientid = '1064399' then '1001785'
when clientid = '1064209' then '1001971'
when clientid = '1063855' then '1002315'
when clientid = '1063141' then '1002981'
when clientid = '1062565' then '1003552'
when clientid = '1062300' then '1003173'
when clientid = '1060105' then '1000028'
when clientid = '1058246' then '1013538'
when clientid = '1057971' then '1010009'
when clientid = '1057892' then '1013877'
when clientid = '1056964' then '1004903'
when clientid = '1055886' then '1006814'
when clientid = '1038869' then '1016960'
when clientid = '1027494' then '1005953'
end
where clientid in ('1066313',
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
 
 
 
-----update demographic later----------
update demographic set clientid = case
when clientid = '1066313' then '1016728'
when clientid = '1066286' then '1018386'
when clientid = '1066176' then '1000051'
when clientid = '1066175' then '1000052'
when clientid = '1066152' then '1000075'
when clientid = '1066113' then '1000114'
when clientid = '1066112' then '1000115'
when clientid = '1065942' then '1000280'
when clientid = '1065938' then '1000284'
when clientid = '1064399' then '1001785'
when clientid = '1064209' then '1001971'
when clientid = '1063855' then '1002315'
when clientid = '1063141' then '1002981'
when clientid = '1062565' then '1003552'
when clientid = '1062300' then '1003173'
when clientid = '1060105' then '1000028'
when clientid = '1058246' then '1013538'
when clientid = '1057971' then '1010009'
when clientid = '1057892' then '1013877'
when clientid = '1056964' then '1004903'
when clientid = '1055886' then '1006814'
when clientid = '1038869' then '1016960'
when clientid = '1027494' then '1005953'
end
where clientid in ('1066313',
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


select * from records where clientid in ('1066313',
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

select * from records where clientid in ('1016728',
'1018386',
'1000051',
'1000052',
'1000075',
'1000114',
'1000115',
'1000280',
'1000284',
'1001785',
'1001971',
'1002315',
'1002981',
'1003552',
'1003173',
'1000028',
'1013538',
'1010009',
'1013877',
'1004903',
'1006814',
'1016960',
'1005953'
)
order by clientid;


---after checking is fine----
commit;