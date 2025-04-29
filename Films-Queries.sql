-- Disable foreign key checks to prevent constraint errors
SET FOREIGN_KEY_CHECKS = 0;

-- Truncate all tables (faster than DELETE)
TRUNCATE TABLE Films.studios;
TRUNCATE TABLE Films.producers;
TRUNCATE TABLE Films.movies;
TRUNCATE TABLE Films.actors;
TRUNCATE TABLE Films.movies_actors;

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO studios (name, address, bulstat)
VALUES
    ('IFS-200', 'Sofia, 10 Vitosha Blvd', '123456789012'),
    ('MGM Studios', 'Los Angeles, 300 Sunset Blvd', '987654321012'),
    ('Universal Studios', 'Hollywood, 1000 Universal City Blvd', '543216789012');


INSERT INTO producers (name, address, bulstat)
VALUES
    ('John Smith', 'Sofia, 15 Rakovski St', '135792468012'),
    ('Jane Doe', 'New York, 100 Broadway St', '246813579013'),
    ('George Lucas', 'Los Angeles, 500 Hollywood Blvd', '112233445566');


INSERT INTO movies (title, release_year, duration, studio_id, producer_id, budget)
VALUES
    ('Star Wars', 1977, 121, 3, 3, 11000000),
    ('MGM Movie', 1995, 105, 2, 1, 5000000),
    ('Jurassic Park', 1993, 127, 3, 2, 63000000);


INSERT INTO actors (name, address, gender, birthdate)
VALUES
    ('Mark Hamill', 'Sofia, 123 Hollywood Blvd', 'M', '1951-09-25'),
    ('Carrie Fisher', 'Sofia, 456 Sunset Blvd', 'F', '1956-10-21'),
    ('Harrison Ford', 'Los Angeles, 789 Beverly Hills Blvd', 'M', '1942-07-13'),
    ('Sam Neill', 'New Zealand, 123 Ocean View St', 'M', '1947-09-14'),
    ('Laura Dern', 'Sofia, 101 Beach St', 'F', '1967-02-10');


INSERT INTO movies_actors (movie_id, actor_id)
VALUES
    (1, 1), -- Mark Hamill участва в Star Wars
    (1, 2), -- Carrie Fisher участва в Star Wars
    (1, 3), -- Harrison Ford участва в Star Wars
    (2, 4), -- Sam Neill участва в MGM Movie
    (2, 5), -- Laura Dern участва в MGM Movie
    (3, 4), -- Sam Neill участва в Jurassic Park
    (3, 5); -- Laura Dern участва в Jurassic Park

select * from actors where address = '%Sofia%' or gender = 'M';
select * from movies where release_year > 1990 and release_year < 2000 order by budget desc limit 3;



select movies.title, actors.name 
from movies_actors
inner join movies on movies.movie_id = movies_actors.movie_id
inner join actors on actors.actor_id = movies_actors.actor_id
inner join studios on studios.studio_id = movies.studio_id
where studios.name = 'MGM Studios';

select movies.title as MovieTitle, studios.name as StudioNmae, producers.name as ProducerName
from movies
inner join studios on studios.studio_id = movies.studio_id
inner join producers on producers.producer_id = movies.producer_id;



select actors.name, movies.title, movies.budget
from movies_actors
inner join actors on actors.actor_id = movies_actors.actor_id
inner join movies on movies.movie_id = movies_actors.movie_id
where budget = (
	select min(budget)
	from movies_actors
	inner join actors on actors.actor_id = movies_actors.actor_id
	inner join movies on movies.movie_id = movies_actors.movie_id
)
order by budget asc;

with avg_duration as(
	select avg(duration) as avg_duration
    from movies
    where release_year < 2000
)
select actors.name, avg(movies.duration)
from movies_actors
inner join actors on actors.actor_id = movies_actors.actor_id
inner join movies on movies.movie_id = movies_actors.movie_id
where duration > (select avg_duration from avg_duration)
group by actors.actor_id, actors.name;



select actors.name
from movies_actors
inner join actors on actors.actor_id = movies_actors.actor_id
inner join movies on movies.movie_id = movies_actors.movie_id
where actors.gender = 'F' and movies.title = 'MGM Movie';

select producers.name, movies.title
from movies
inner join producers on movies.producer_id = producers.producer_id
where movies.title = 'Star Wars';

select actors.name 
from actors 
left join movies_actors on actors.actor_id = movies_actors.actor_id
where movies_actors.actor_id is null;

SELECT actors.name 
FROM actors 
JOIN movies_actors ON actors.actor_id = movies_actors.actor_id
GROUP BY actors.actor_id
ORDER BY COUNT(movies_actors.movie_id) ASC
LIMIT 1;

SELECT actors.name, actors.birthdate 
FROM actors
JOIN movies_actors ON actors.actor_id = movies_actors.actor_id
WHERE actors.gender = 'M'
GROUP BY actors.actor_id
ORDER BY COUNT(movies_actors.movie_id) DESC, actors.birthdate ASC
LIMIT 1;



