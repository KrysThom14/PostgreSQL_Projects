
--Quick View of Table--
select *
from us_simplified_csv
limit 10;

--Which States Had The Most Cases--
select state, max(confirmed) as total_cases
from us_simplified_csv
group by state
order by max(confirmed) desc;

--Which States Had The Highest Death Rate--
select state, cast(max(deaths) as decimal) / cast(max(confirmed) as decimal) as confirmed_death_ratio
from us_simplified_csv
group by state
order by confirmed_death_ratio desc;

--Counties In Georgia With The Most Cases--
select max(date), 
	 county as ga_counties, 
	 max(confirmed) as total_confirmed, 
	 max(deaths) as total_deaths
from us_simplified_csv
where state = 'Georgia'
group by county
order by max(confirmed) desc;
