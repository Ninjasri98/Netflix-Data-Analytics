/*
Advanced Level
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
Find tracks where the energy-to-liveness ratio is greater than 1.2.
Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions
*/

-- Q1. Find the top 3 most-viewed tracks for each artist using window functions.

with rank_artist 
as
(select
	artist,
	track,
	sum(views) as total_views,
	dense_rank() over (partition by artist order by sum(views) desc ) as rank
from spotify
group by 1,2
order by 1,3 desc
)
select * from rank_artist
where rank <= 3;

-- Q2. Write a query to find tracks where the liveness score is above the average.

select 
	track,
	artist
from spotify
where liveness > (select avg(liveness) from spotify);

-- Q3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

with cte
as
(select
	album,
	max(energy) as highest,
	min(energy) as lowest
from spotify
group by 1)
select
	album,
	highest - lowest as diff
from cte
order by 2 desc;

-- Query Optimization

explain analyse
select
	artist,
	track,
	views
from spotify
where artist = 'Gorillaz'
	and
	most_played_on = 'Youtube'
order by stream desc limit 25;

create index artist_index on spotify (artist);