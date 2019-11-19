SHOW search_path;
SET search_path TO newcohort;

create view for_q as
select s1.*,s2.* from														 
(select d.*, e.accessemployment as accessemployment_baseline, e.employmentstatus as employmentstatus_baseline, e.employmentstartdate as employmentstartdate_baseline,
 e.employmentretention as employmentretention_baseline, e.jobtrainingenrolled as jobtrainingenrolled_baseline, e.jobtrainingcompleted as jobtrainingcompleted_baseline,
 f.savings as savings_baseline, f.creditscore as creditscore_baseline, f.debt as debt_baseline,
 w.wages1 as wages1_baseline, w.hours1 as hours1_baseline, w.wages2 as wages2_baseline, w.hours2 as hours2_baseline,
 i.incomeclient as incomeclient_baseline, i.incomehh as incomehh_baseline,
 i.publicbenefits as publicbenefits_baseline, i.expenseshh as expenseshh_baseline, bc.accessincome as accessincome_baseline, 
 bc.accessfinancialcoach as accessfinancialcoach_baseline, bc.bundledservices as bundledservices_baseline, fc.fincap_budget as fincap_budget_baseline, fc.fincap_goals as fincap_goals_baseline,
 fc.fincap_emergencyfund as fincap_emergencyfund_baseline, fc.fincap_autodeposit as fincap_autodeposit_baseline, fc.fincap_incomeexpenses as fincap_incomeexpenses_baseline, 
 fc.fincap_latefee as fincap_latefee_baseline
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid	
left join wages w on w.wagesid = r.wagesid
where r.baseline_baseline is true) s1											 
right join														 
(select d.clientid as clientid_checkin,r.quarter as quarter_checkin, e.accessemployment as accessemployment_checkin, e.employmentstatus as employmentstatus_checkin, e.employmentstartdate as employmentstartdate_checkin,
 e.employmentretention as employmentretention_checkin, e.jobtrainingenrolled as jobtrainingenrolled_checkin, e.jobtrainingcompleted as jobtrainingcompleted_checkin,
 f.savings as savings_checkin, f.creditscore as creditscore_checkin, f.debt as debt_checkin, 
  w.wages1 as wages1_checkin, w.hours1 as hours1_checkin, w.wages2 as wages2_checkin, w.hours2 as hours2_checkin,
 i.incomeclient as incomeclient_checkin, i.incomehh as incomehh_checkin,
 i.publicbenefits as publicbenefits_checkin, i.expenseshh as expenseshh_checkin, bc.accessincome as accessincome_checkin, 
 bc.accessfinancialcoach as accessfinancialcoach_checkin, bc.bundledservices as bundledservices_checkin, fc.fincap_budget as fincap_budget_checkin, fc.fincap_goals as fincap_goals_checkin,
 fc.fincap_emergencyfund as fincap_emergencyfund_checkin, fc.fincap_autodeposit as fincap_autodeposit_checkin, fc.fincap_incomeexpenses as fincap_incomeexpenses_checkin, 
 fc.fincap_latefee as fincap_latefee_checkin,
 bca.accessincome as accessincome_alltime, bca.accessemployment as accessemployment_alltime, bca.accessfinancialcoach as accessfinancialcoach_alltime,
 bca.bundledservices as bundledservices_alltime, ea.emp_quarter, ea.emp_recent, ea.emp_date, ea.months, ea.monthsbin
from demographic d join records r on r.clientid = d.clientid
left join employment e on e.employmentid = r.employmentid
left join financials f on f.financialsid=r.financialsid
left join fincap fc on fc.fincapid=r.fincapid														 
left join incomeexpenses i on i.incomeexpensesid=r.incomeexpensesid														 
left join bundledservices_checkin bc on bc.bundledservicesid=r.bundledservicesid
left join wages w on w.wagesid = r.wagesid
left join bundledservices_alltime_2019q2 bca on bca.clientid = d.clientid
left join employment_alltime_2019q2 ea on ea.clientid = d.clientid
where r.date = (select date from records
order by date desc
limit 1) and r.baseline_baseline is false) s2
on s1.clientid = s2.clientid_checkin;

