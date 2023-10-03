use sakila;
# ===========================================================================================================================================
# ===========================================================================================================================================
# PROJECT QUERY
# ===========================================================================================================================================
# ===========================================================================================================================================

#TASK1:: Display the full names of actors available in the database.
Select concat(first_name," ",last_name) as "ACTOR'S FULL NAME" From actor;

# ===========================================================================================================================================
# ===========================================================================================================================================

#Task 2: Management wants to know if there are any names of the actors appearing frequently.
#i.Display the number of times each first name appears in the database.
#ii.What is the count of actors that have unique first names in the database? Display the first names of all these actors.

#1.
Select first_name, count(first_name) as "COUNT OF FIRST NAME" From actor 
group by first_name order by count(first_name) desc;
#2.
Select first_name, count(first_name) as "UNIQUE FIRST NAME" From actor 
group by first_name having count(first_name)=1 order by count(first_name);

# ===========================================================================================================================================
# =========================================================================================================================================

#Task 3: The management is interested to analyze the similiarity in the last names of the actors.
#i.Display the number of times each last name appears in the database.
#ii.Display all unique last names in the database.

#1.
Select last_name, count(last_name) as "COUNT OF LAST NAME" From actor 
group by last_name order by count(last_name) desc;
#2.
Select last_name, count(last_name) as "UNIQUE LAST NAME" From actor 
group by last_name having count(last_name)=1 order by count(last_name);

# =========================================================================================================================================
# =========================================================================================================================================
#Task 4: The management wants to analyze the movies based on their ratings to determine if they are suitable for kids or some parental 
#assistance is required. Perform the following tasks to perform the required analysis.
#i. Display the list of records for the movies with the rating "R". (The movies with the rating "R" are not suitable for audience under 
#17 years of age).
#ii.Display the list of records for the movies that are not rated "R".
#iii. Display the list of records for the movies that are suitable for audience below 13 years of age.

#1.
Select film_id,title,description,rating from film where rating="R";
#2.
Select film_id,title,description,rating from film where rating!="R";
#3.
Select film_id,title,description,rating from film where rating="PG-13";

# =========================================================================================================================================
# =========================================================================================================================================
#Task 5: The board members want to understand the replacement cost of a movie copy(disc - DVD/Blue Ray). 
#The replacement cost refers to the amount charged to the customer if the movie disc is not returned or is returned in a damaged state.
#i. Display the list of records for the movies where the replacement cost is up to $11.
#ii. Display the list of records for the movies where the replacement cost is between $11 and $20.
#iii. Display the list of records for the all movies in descending order of their replacement costs.

#1.
Select *from film where replacement_cost<=11;
#2.
Select *from film where replacement_cost between 11 and 20 ;
#3.
Select *from film order by replacement_cost desc;

# =========================================================================================================================================
# =========================================================================================================================================
#Task 6: Display the names of the top 3 movies with the greatest number of actors.

CREATE VIEW COUNT_OF_ACTOR AS 
Select title as "MOVIE TITLE",Count(actor_id) from film 
inner join film_actor on film_actor.film_id=film.film_id
group by title order by count(actor_id) desc ;

SELECT *FROM COUNT_OF_ACTOR;

# =========================================================================================================================================
# =========================================================================================================================================
#Task 7: 'Music of Queen' and 'Kris Kristofferson' have seen an unlikely resurgence. As an unintended consequence, films starting with 
#the letters 'K' and 'Q' have also soared in popularity. Display the titles of the movies starting with the letters 'K' and 'Q.

select title from  film where title like "K%" or title like "Q%" ;

# =========================================================================================================================================
# =========================================================================================================================================
#Task 8:The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film.
CREATE VIEW SEARCH_AGENT_TRUMAN AS 
Select first_name,last_name from film 
inner join film_actor on film_actor.film_id=film.film_id
inner join actor on actor.actor_id=film_actor.actor_id
where title="AGENT TRUMAN";

SELECT *FROM SEARCH_AGENT_TRUMAN;

# =========================================================================================================================================
# =========================================================================================================================================
#Task 9: Sales have been lagging among young families, so the management wants to promote family movies. Identify all the movies 
#categorized as family films.

CREATE VIEW FAMILY_MOVIES AS 
select  title  from film 
inner join film_category on film_category.film_id=film.film_id 
inner join category on film_category.category_id=category.category_id where name='family';

SELECT *FROM FAMILY_MOVIES;
# =========================================================================================================================================
# =========================================================================================================================================

#Task 10: The management wants to observe the rental rates and rental frequencies (Number of time the movie disc is rented).
#i.Display the maximum, minimum, and average rental rates of movies based on their ratings. The output must be sorted in descending order of the average rental rates.
#ii. Display the movies in descending order of their rental frequencies, so the management can maintain more copies of those movies.

#1.
CREATE VIEW RATING AS 
Select rating,max(rental_rate),min(rental_rate),avg(rental_rate) from film 
group by rating;
SELECT *FROM RATING;
#2.
CREATE VIEW FREQUENCY_RENTED AS 
select film_id,title,count(inventory_id) as 'FREQUENTLY RENTED' from film  
join inventory using (film_id)
join rental using (inventory_id) 
group by film_id order by count(inventory_id) desc ;  

SELECT *FROM FREQUENCY_RENTED;

# =========================================================================================================================================
# =========================================================================================================================================
#TASK 11:In how many film categories, the difference between the average film replacement cost ((disc-DVD/Blue Ray) and the average 
#film rental rate is greater than $15?
#Display the list of all film categories identified above, along with the corresponding average film replacement cost and average film 
#rental rate.

CREATE VIEW AVERAGE AS 
select name , avg((replacement_cost)-(rental_rate)) as 'GREATER THAN 15' , 
count(title) as "NO OF MOVIES" from film
inner join film_category on film_category.film_id=film.film_id 
inner join category on category.category_id=film_category.category_id 
group by name having avg((replacement_cost)-(rental_rate)) >=15 
order by count(title) desc;

SELECT *FROM AVERAGE;

CREATE VIEW ALL_AVERAGE AS 
select name , avg(replacement_cost),AVG(rental_rate), 
count(title) as "NO OF MOVIES" from film
inner join film_category on film_category.film_id=film.film_id 
inner join category on category.category_id=film_category.category_id 
group by name order by count(title) desc;

Select *from ALL_AVERAGE;

# =========================================================================================================================================
# =========================================================================================================================================

#TASK12: Display the film categories in which the number of movies is greater than 70.

CREATE VIEW COUNT_OF_MOVIES AS 
select name , count(film_id) as 'NO OF FILMS BETWEEN 60 AND 70' from film_category 
inner join category on category.category_id=film_category.category_id 
group by name having count(film_id) between 60 and 70
ORDER BY count(film_id) desc ;

SELECT *FROM COUNT_OF_MOVIES;

# =========================================================================================================================================
# =======================================================================================================================================
/***============================================================= THE END ===========================================================***/