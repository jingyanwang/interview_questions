
--create the test data tabel
create table test_data (
  Fill_day int,
  Amount_of_pills int
  );

--insert the data to the table
INSERT INTO test_data (Fill_day, Amount_of_pills)
VALUES
(0, 30),
(40, 30),
(60, 30),
(85, 30);

--build the table of windows, each window is between the two neighoring days
drop table if exists period_windows;
create table period_windows as 
with w as (
	select 
	row_number() over (order by Fill_day) as window_id,
	Fill_day as start_fill_day,
	lead(Fill_day) over (order by Fill_day) as end_fill_day,
	Amount_of_pills as received_pills
	from test_data
) 
select *,
(end_fill_day-start_fill_day) as needed_pills
from w where end_fill_day is not null;

--using the recursive sql to build the table of days without pills for each window
drop table if exists days_without_pills;
create table days_without_pills as 

with remaining_pills as (
	--the base case, the first window
	select 
	window_id, 
	start_fill_day,
	end_fill_day,
	needed_pills,
	received_pills,
	--the initial remaining pills 
	case 
		when received_pills > needed_pills
		then received_pills - needed_pills
		else 0
	end as remaining_pills,
	--the initial days without pills
	case 
		when received_pills < needed_pills
		then needed_pills - received_pills
		else 0
	end as days_without_pills
	from period_windows 
	--the first day is the base case
	where window_id = 1
	union all 
	--the following is the recursive sql 
	select 
	p.window_id,
	p.start_fill_day,
	p.end_fill_day,
	p.needed_pills,
	p.received_pills,
	-- the remaining pills is the previouse remaining + new supply - new comsumption
	case 
		when (r.remaining_pills + p.received_pills) > p.needed_pills
		then (r.remaining_pills + p.received_pills - p.needed_pills)
		else 0
	end as remaining_pills,
	-- if previouse remaining + new supply is less than the new comsuption, then the days without pills for this window is > 0
	case 
		when (r.remaining_pills + p.received_pills) < p.needed_pills
		then p.needed_pills - (r.remaining_pills + p.received_pills)
		else 0
	end as days_without_pills
	from remaining_pills as r
	join period_windows as p
	--previouse records of remaining will be joined with current supply and comsumption to update the current remaining
	on r.window_id+1 = p.window_id
	)
select * from remaining_pills;

--sum over all windows
select sum(days_without_pills) from days_without_pills;

/*

Query results
sum(days_without_pills)
10

*/


Question 1:

;WITH non_21_patient 
AS 
(
	SELECT PatientID,PharmacyStoreID
	FROM Rxclaim (NOLOCK)
	WHERE PatientID not in (select PatientID from Patient (NOLOCK) where ClientKey=21)
)
select I.PatientID,
	I.state,
			ROW_NUMBER() OVER (partition by I.state ORDER BY I.PatientID) rnb, 
DENSE_RANK() OVER (ORDER BY I.state) dnb
FROM Prescription I (NOLOCK) INNER JOIN non_21_patient N
	ON I.PatientID=N.PatientID 
  and I.PharmacyStoreID=N.PharmacyStoreID


concat(PatientID, PharmacyStoreID)

california	1	1
california	2	2
california	3	3
texas				4	1
texas				5	2
texas				6	3

a. Above query uses the CTE method. What other methods that we can use to re-write the query?

b. What will be the RNB and DNB values for the above query?

c. If the performance of the above query is not sufficient, how can we improve?


Question 2:

patientidentifier	                          filldate	NDCNumber
0x023FFB679CD962436497372794BCDA30	        20201007	00023320508
0x023FFB679CD962436497372794BCDA30	        20200707	00023320508
0x04AC71FC02E62CBA46C1F9C3BAC43BED	        20190115	00093500356
0x0592AEC4318F09C40BC368E87C8C4F89	        20200714	64980051415
0x06D1B7E920864707DF420EE5695D1A6D	        20200612	00065427325
0x06D1B7E920864707DF420EE5695D1A6D	        20191230	00065427325
0x0CD11C6E65765438F25423B23D07DE1A	        20190116	16729000301
0x0E07EF2CFCBC1FF58944F87D02BFF9CD	        20200306	00310110530
0x0E07EF2CFCBC1FF58944F87D02BFF9CD	        20200325	00378395205
0x0E07EF2CFCBC1FF58944F87D02BFF9CD	        20190000  00378395205

Please write a query to show the patients who have fills in both 2020 and 2019 
(patients should have at least 1 fill in 2019 and at least one fill in 2020)

create table patients_fills_in_2020 as 
select distinct patientidentifier from data where substring(string(filldate), 1, 4) = '2020';

create table patients_fills_in_2019 as 
select distinct patientidentifier from data where substring(string(filldate), 1, 4) = '2019';

select a.patientidentifier
from patients_fills_in_2020 as a
join patients_fills_in_2019 as b 
on a.patientidentifier = b.patientidentifier;