--Turned "hours_streamed" column into integer--
update twitch_game_data_csv
set hours_streamed = left(hours_streamed, -6)
where hours_streamed like '%hours';

--Turned The Month Column Into Varchar--
update twitch_game_data_csv
set month = 'January'
where month = '1';

--Most Streamed Games on Twitch in 2016--
select game, max(hours_streamed) as hours_streamed
from twitch_game_data_csv
where year = 2016
group by game
order by max(hours_streamed) desc;

--Most Streamed Games on Twitch in 2021--
select game, max(hours_streamed) as hours_streamed
from twitch_game_data_csv
where year = 2021
group by game
order by max(hours_streamed) desc;

--Look Up Stats on Favorite Game--
select *
from twitch_game_data_csv
where game like '%Rocket League%'
order by year;

--Joined Twitch & Steam Tables to Compare Popular Games--
select rank, game, categories, user_reviews, date as year_released, year, hours_streamed
from steam_game_data_csv
left join twitch_game_data_csv
on steam_game_data_csv.name = twitch_game_data_csv.game
where hours_streamed is not null
order by hours_streamed desc;

--Joined Twitch & Steam Tables to Compare Disliked Games--
select rank, game, categories, user_reviews, hours_streamed
from steam_game_data_csv
left join twitch_game_data_csv
on steam_game_data_csv.name = twitch_game_data_csv.game
where user_reviews like '%Negative%' and hours_streamed is not null
order by hours_streamed;
