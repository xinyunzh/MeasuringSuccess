CREATE TABLE checkintime_Alltime(
clientid varchar(50) primary key,
checkintime smallint)

INSERT INTO TABLE checkintime_Alltime
SELECT distinct(clientid),count(clientid)-1 as checkintime 
FROM records
GROUP BY clientid;


SELECT clientid, quarter, baseline_baseline,count(*) over (PARTITION BY clientid ORDER BY baseline_baseline DESC,quarter ASC) -1 AS checkintimeth
FROM records
ORDER BY clientid ASC,baseline_baseline DESC;