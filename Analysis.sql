
---- Gender, Married, Dependents
with demographics_count as (
select Gender, Married, Dependents,Loan_Status, count(*) as [Count],
sum(count(*)) over() as [Total Applicant Count ]
from dbo.LoanPrediction
group by Gender, Married, Dependents,Loan_Status
)
select *, [Count]*100/[Total Applicant Count ] as [Percent of Loan Acceptance]
from demographics_count
where Loan_Status='Y'
and [Count]*100/[Total Applicant Count ]>0
order by [Count] desc


--Education, SElf_Employed
with profbg_count as (
	select Education,Self_Employed, Loan_Status, count(*) as [Count],
	sum(count(*)) over() as [Total Applicant Count ]
	from dbo.LoanPrediction
	group by Education,Self_Employed, Loan_Status
)
select *, [Count]*100/[Total Applicant Count ] as [Percent of Loan Acceptance]
from profbg_count
where Loan_Status='Y'
and [Count]*100/[Total Applicant Count ]>0
order by [Count] desc


---- ApplicantIncome, CoApplicantIncome
with income_count as (
	select min(cast(ApplicantIncome as int)) MinIncome, max(cast(ApplicantIncome as int)) MaxIncome, 
	Loan_Status, count(*) as [Count]
	,sum(count(*)) over() as [Total Applicant Count ]
	from dbo.LoanPrediction
	group by  Loan_Status
)
select *,
[Count]*100/[Total Applicant Count ] as [Percent of Loan Acceptance]
from income_count
where Loan_Status='Y'
and [Count]*100/[Total Applicant Count ]>0
order by [Count] desc


---- CreditHistory
with  CreditHistory_count as (
select Credit_History, Loan_Status, count(*) as [Count]
,sum(count(*)) over() as [Total Applicant Count ]
from dbo.LoanPrediction
group by Credit_History, Loan_Status
)
select *, [Count]*100/[Total Applicant Count ] as [Percent of Loan Acceptance]
from CreditHistory_count
where Loan_Status='Y'
and [Count]*100/[Total Applicant Count ] > 0
order by [Count] desc



-- PropertyArea
with property_count as (
	select Property_Area, Loan_Status, count(*) as [Count],sum(count(*)) over() as [Total Applicant Count ]
	from dbo.LoanPrediction
	group by Property_Area, Loan_Status
)
select *, [Count]*100/[Total Applicant Count ] as [Percent of Loan Acceptance]
from property_count
where Loan_Status='Y'
and [Count]*100/[Total Applicant Count ]>0
order by [Count] desc

