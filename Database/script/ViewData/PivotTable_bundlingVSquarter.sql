select quarter, bundledservices, count(bundledservices)
from bundledservices_all
where baseline_baseline is false
group by bundledservices, quarter
order by 1,2;

create extension tablefunc;

create view checkin_bc_pivot_Quarter as
select * from crosstab(
'select quarter, bundledservices, count(bundledservices)
from bundledservices_all
where baseline_baseline is false
group by bundledservices, quarter
order by 1,2 ' 
)	as final_result (quarter varchar, bc0 bigint, bc1 bigint, bc2 bigint, bc3 bigint);

select * from checkin_bc_pivot_Quarter;