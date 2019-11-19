SHOW search_path;
SET search_path TO newcohort;

create view records_all_2019q2_tableau as 
select s1.*, q.clientid as checkin_mark from
(select d.agency, r.recordid, r.clientid, r.baseline_baseline, r.quarter, r.date, d.dob, d.dob_cat, d.gender, d.race, d.maritalstatus, d.highested, d.housingtype, d.hhadults, d.hhchildren, d.criminalbackground,
d.zipcode, d.tanf, d.residential, e.employmentstatus, e.employmentstartdate, e.employmentretention, e.JobTrainingEnrolled,	e.JobTrainingCompleted, f.Savings,f.CreditScore,
f.Debt, w.wages1, w.hours1, w.wages2, w.hours2, i.incomeclient, i.incomehh, i.publicbenefits, i.expenseshh, bc.benefitsscreening, bc.benefitsaccess,
bc.agencyprovidedsupport, bc.accessincome, bc.accessemployment, bc.accessfinancialcoach, bc.bundledservices, fc.FinCap_Budget, fc.FinCap_Goals, fc.FinCap_EmergencyFund, fc.FinCap_AutoDeposit, fc.FinCap_IncomeExpenses, 
fc.FinCap_LateFee, bca.accessincome as accessincome_alltime, bca.accessemployment as accessemployment_alltime, bca.accessfinancialcoach as accessfinancialcoach_alltime, 
bca.bundledservices as bundledservices_alltime, ea.emp_recent, ea.emp_date, ea.months, ea.monthsbin, csr.creditscore_baseline, csr.creditscore_recent,
wr.wages_baseline, wr.wages_recent
from records r 
join demographic d on d.clientid = r.clientid
join employment e on e.employmentid = r.employmentid
join financials f on f.financialsid = r.financialsid
join bundledservices_checkin bc on bc.bundledservicesid = r.bundledservicesid
join wages w on w.wagesid = r.wagesid
join incomeexpenses i on i.incomeexpensesid = r.incomeexpensesid
join fincap fc on fc.fincapid = r.fincapid
join bundledservices_alltime_2019Q2 bca on bca.clientid = r.clientid
join employment_alltime_2019q2 ea on ea.clientid = r.clientid
join creditscore_recent_2019q2 csr on csr.clientid = r.clientid
join wages_recent_2019q2 wr on wr.clientid = r.clientid)s1
left join for_q q on q.clientid = s1.clientid;



copy (select * from records_all_2019q2_tableau) to 'C:\Users\Leah Zhang\Desktop\database\newCohort\Export\records_all_2019q2_tableau_cohort.csv' csv header;