select * from records r
join financials f on f.financialsid = r.financialsid
join incomeexpenses i on i.incomeexpensesid = r.incomeexpensesid
where clientid = '160060';

--update clientid = 160060 check-in financialsid = 24516 200,0,900
--update clientid = 160060 check-in incomeexpensesid = 24516 1600,3680,0,2206

select * from financials where financialsid = 24516;
select * from incomeexpenses where incomeexpensesid = 24516;

begin;
update financials
set savings = 200,
creditscore = 0,
debt = 900
where financialsid =24516;

update incomeexpenses
set incomeclient = 1600,
incomehh = 3680,
publicbenefits = 0,
expenseshh = 2206
where incomeexpensesid = 24516;

commit;