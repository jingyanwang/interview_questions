--you can test the code here: https://sql-playground.wizardzines.com/

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