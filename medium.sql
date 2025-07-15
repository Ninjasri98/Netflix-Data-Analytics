/*
Medium Level
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- Q1. Calculate the average danceability of tracks in each album.

select 
	album,
	avg(danceability) as avg_dance
from spotify
group by 1
order by 2 desc;

-- Q2. Find the top 5 tracks with the highest energy values.

select
	track,
	max(energy)
from spotify
group by 1
order by 2 desc
limit 5;

-- Q3. List all tracks along with their views and likes where official_video = TRUE.

select
	track,
	sum(views) as total_views,
	sum(likes) as total_likes
from spotify
where official_video = 'true'
group by 1
order by 2;

-- Q4. For each album, calculate the total views of all associated tracks.

select 
	album,
	track,
	sum(views)
from spotify
group by 1, 2;

-- Q5. Retrieve the track names that have been streamed on Spotify more than YouTube.

select * from
(select 
	track,
	--most_played_on,
	coalesce(sum(case when most_played_on = 'Youtube' then stream end),0) as youtube,
	coalesce(sum(case when most_played_on = 'Spotify' then stream end),0) as spotify
from spotify
group by 1
) as t1
where spotify > youtube
	and
	youtube <> 0;
	

	





