--Deleted Rows Without Any Info--
delete from steam_game_data_csv 
where id not in 
(select max(id)
FROM steam_game_data_csv
group by name, categories, user_reviews);

--Deleted Rows Without A Name--
delete
from steam_game_data_csv
where name = '-';

--Made Sure Columns ONLY Showed Relevant Info--
update steam_game_data_csv
set price = '$19.99'
where price like'%$19.99%';

delete from steam_game_data_csv
where price = any(select price
from steam_game_data_csv
where length(price) > 7);

update steam_game_data_csv
set date = '2017'
where date like '%17';

update steam_game_data_csv
set categories = 'Online PvP'
where categories like '%Online PvP%';

update steam_game_data_csv
set user_reviews = 'Mostly Negative'
where user_reviews like 'Mostly Negative%';

update steam_game_data_csv
set all_reviews = 'Mostly Negative'
where all_reviews like 'Mostly Negative%';

update steam_game_data_csv
set all_reviews = Null
where not ( all_reviews = 'Positive' or all_reviews = 'Very Positive'
or all_reviews = 'Mostly Positive' or all_reviews = 'Mixed'
or all_reviews = 'Overwhelmingly Positive'
or all_reviews = 'Overwhelmingly Negative'
or all_reviews = 'Very Negative' or all_reviews = 'Negative'
or all_reviews = 'Mostly Negative');

--Most Expensive But Highly Rated Games--
select name, categories, user_reviews, price
from steam_game_data_csv
where user_reviews = 'Overwhelmingly Positive'
order by price desc;

--Highest Rated Free Games--
select name, categories, user_reviews, price
from steam_game_data_csv
where user_reviews = 'Overwhelmingly Positive'
order by price asc;

--Number of Highest Rated Games vs. Price--
select price, count(name) as num_games
from steam_game_data_csv
where user_reviews = 'Overwhelmingly Positive'
group by price;

--Number of Games per Ranking; Grouped By Year--
select user_reviews, count(*) as num_games, date
from steam_game_data_csv
group by date, user_reviews
order by date;



