
select top 100 *
from dbo.LoanPrediction

-- 1] What is the distribution of applicants by gender?
DECLARE @Total_Applicants int = 0;
select @Total_Applicants=count(*)
from dbo.LoanPrediction

select Gender,Count(*) AS [Gender Count], (Count(*)*100/@Total_Applicants) AS [Proportion (in %)]
from dbo.LoanPrediction
group by Gender


-- 2] How many applicants are married vs. unmarried?
select Married, Count(*) AS [Married Applicant Count], (Count(*)*100/@Total_Applicants) AS [Proportion (in %)] 
from dbo.LoanPrediction
group by Married


-- 3] What is the distribution of dependents among the applicants?
select Dependents, count(*) AS [Applicant Count],(Count(*)*100/@Total_Applicants) AS [Proportion (in %)] 
from dbo.LoanPrediction
group by Dependents


-- 4] How does education level vary among the applicants?
select Education, Count(*) AS [Applicant Count], count(*)*100/@Total_Applicants AS [Proportion (in %)]
from dbo.LoanPrediction
group by Education

-- 5] What is the proportion of self-employed individuals in the dataset?
select Self_Employed, count(*) AS [Applicant Count], count(*)*100/@Total_Applicants AS [Proportion (in %)]
from dbo.LoanPrediction
group by Self_Employed

-- 6] What is the range of applicant income?
select min(cast(ApplicantIncome as int)) AS [Min Applicant Income], 
max(cast(ApplicantIncome as int))  AS [Max Applicant Income], 
avg(cast(ApplicantIncome as int))  AS [Avg Applicant Income],min(cast(CoApplicantIncome as float)) AS [Min CoApplicant Income], 
max(cast(CoApplicantIncome as float))  AS [Max CoApplicant Income], 
avg(cast(CoApplicantIncome as float))  AS [Avg CoApplicant Income]
from dbo.LoanPrediction

select min(cast(ApplicantIncome as int)) AS [Min Applicant Income], 
max(cast(ApplicantIncome as int))  AS [Max Applicant Income], 
avg(cast(ApplicantIncome as int))  AS [Avg Applicant Income]
from dbo.LoanPrediction
where Loan_Status='Y'

select min(cast(CoApplicantIncome as float)) AS [Min CoApplicant Income], 
max(cast(CoApplicantIncome as float))  AS [Max CoApplicant Income], 
avg(cast(CoApplicantIncome as float))  AS [Avg CoApplicant Income]
from dbo.LoanPrediction
where Loan_Status='Y'

select min(cast(ApplicantIncome as int))+min(cast(CoApplicantIncome as float)) AS [Min Total Income], 
max(cast(ApplicantIncome as int))+max(cast(CoApplicantIncome as float))  AS [Max Total Income] 
from dbo.LoanPrediction

-- 7] What is the average loan amount requested by applicants?
select avg(cast(LoanAmount as int))
from dbo.LoanPrediction


-- 8] How many different loan amount terms are there in the dataset?
select distinct Loan_Amount_Term
from dbo.LoanPrediction


-- 9] What is the most common credit history status among applicants?
select top 1 Credit_History, count(*) AS [Count of CreditHistory Status]
from dbo.LoanPrediction
group by Credit_History
order by 2 desc

-- 10] What is the proportion of approved vs. rejected loan applications (loan status)?
select Loan_Status, count(*)
from dbo.LoanPrediction
group by Loan_Status

--===============================================================================================================================

-- 11]
select distinct Gender, Married, Dependents, Education,Self_Employed,Cast(ApplicantIncome as float), cast(CoapplicantIncome as float), 
cast(LoanAmount as float), cast(isnull(Loan_Amount_Term,0) as int), Credit_History, Property_Area, Loan_Status
from dbo.LoanPrediction
where Loan_Status= 'Y'

-- Gender, Married, Dependents
select Gender, Married, Dependents,Loan_Status, count(*) as [Count]
from dbo.LoanPrediction
--where Loan_Status= 'Y'
group by Gender, Married, Dependents,Loan_Status
order by [Count] desc


-- Education, SElf_Employed
select Education,Self_Employed, Loan_Status, count(*) as [Count]
from dbo.LoanPrediction
where Loan_Status= 'Y'
group by Education,Self_Employed, Loan_Status
order by [Count] desc



-- ApplicantIncome, CoApplicantIncome
select Cast(ApplicantIncome as float), cast(CoapplicantIncome as float), Loan_Status, count(*) as [Count]
from dbo.LoanPrediction
where Loan_Status= 'Y'
group by Cast(ApplicantIncome as float), cast(CoapplicantIncome as float), Loan_Status
order by [Count] desc




-- LoanAmount, LoanAmountTerm, CreditHistory
select cast(LoanAmount as float), cast(isnull(Loan_Amount_Term,0) as int), Credit_History, Loan_Status, count(*) as [Count]
from dbo.LoanPrediction
--where Loan_Status= 'Y'
group by cast(LoanAmount as float), cast(isnull(Loan_Amount_Term,0) as int), Credit_History, Loan_Status
order by [Count] desc



-- PropertyArea
select Property_Area, Loan_Status, count(*) as [Count]
from dbo.LoanPrediction
where Loan_Status= 'Y'
group by Property_Area, Loan_Status
order by [Count] desc




