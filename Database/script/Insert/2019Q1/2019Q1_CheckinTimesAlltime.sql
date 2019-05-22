CREATE TABLE checkintime_Alltime_2019Q1(
clientid varchar(50) primary key,
checkintime smallint);

INSERT INTO checkintime_Alltime_2019Q1
SELECT distinct(clientid),count(clientid)-1 as checkintime 
FROM records
GROUP BY clientid;
									 
														 