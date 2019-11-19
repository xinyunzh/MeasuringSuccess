--financialsall
copy (select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, f.savings, f.creditscore, f.debt from records r 
join financials f on f.financialsid = r.financialsid) to 'C:\Users\Leah Zhang\Desktop\database\exports\financialsall.csv' csv header;


--wagesall
copy (select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, w.wages1, w.hours1, w.wages2, w.hours2 from records r 
join wages w on w.wagesid = r.wagesid) to 'C:\Users\Leah Zhang\Desktop\database\exports\wagesall.csv' csv header;


--employmentall
copy (select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, e.accessemployment, e.employmentstatus, e.employmentstartdate, e.employmentretention, 
e.jobtrainingenrolled,e.jobtrainingcompleted from records r 
join employment e on e.employmentid = r.employmentid) to 'C:\Users\Leah Zhang\Desktop\database\exports\employmentall.csv' csv header;


--bundledservices
copy (select r.recordid, r.clientid, r.quarter, r.date, r.baseline_baseline, b.accessincome, b.accessemployment, b.accessfinancialcoach, b.bundledservices
from records r 
join bundledservices_checkin b on b.bundledservicesid = r.bundledservicesid) to 'C:\Users\Leah Zhang\Desktop\database\exports\bundledservices.csv' csv header;

