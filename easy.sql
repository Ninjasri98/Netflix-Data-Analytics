/*
Easy Level
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.
*/

-- Q1. Retrieve the names of all tracks that have more than 1 billion streams.

select * from spotify
where stream > 1000000000;

-- Q2. List all albums along with their respective artists.

select 
	distinct album,
	artist
from spotify
order by 1;

-- Q3. Get the total number of comments for tracks where licensed = TRUE.

select
	sum(comments) as total_comments
from spotify
where licensed = 'true' ;

-- Q4. Find all tracks that belong to the album type single.

select track from spotify
where album_type = 'single';

-- Q5. Count the total number of tracks by each artist.

select
	artist,
	count(*) as total_tracks
from spotify
group by artist;
