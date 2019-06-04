select emp.monthsbin, q.agency, count(monthsbin) from employment_alltime_2019q1 emp
join for_q q on q.clientid = emp.clientid
where employmentstatus_baseline = 'Not employed'
group by emp.monthsbin, q.agency
order by 1,2;

---Notice there might be something wrong--
select * from crosstab(
$$
	select emp.monthsbin, q.agency, count(monthsbin) from employment_alltime_2019q1 emp
join for_q q on q.clientid = emp.clientid
where employmentstatus_baseline = 'Not employed'
group by emp.monthsbin, q.agency
order by 1,2;  $$
)	as final_result (monthsbin text, ccd bigint, citysquare bigint, hcc bigint, interfaith bigint, jfs bigint, metrocrest bigint, wctc bigint);
