-- DATABASE DESIGN 1 3991 @ IUT
-- YOUR NAME: Marzieh Alidadi
-- YOUR STUDENT NUMBER: 9631983


---- Q9-A

select dept_name
from department
where budget > (select budget
				from department
				where dept_name = 'Psychology')
order by dept_name asc

---- Q9-B

select takes.id, takes.course_id
from takes
where 3 <= (select count(T.sec_id)
		    from takes as T
		    where (takes.id, takes.course_id) = (T.id, T.course_id))

---- Q9-C

select I.id, I.name
from instructor as I
where not exists ((select C.course_id
				  from course as C
				  where C.dept_name = I.dept_name)
				 except
				 (select T.course_id
				  from teaches as T
				  where T.id = I.id))

---- Q9-D

select name
from student 
where name like '___' and dept_name = 'History'

---- Q10-A

select first_name, last_name, city
from customer C, address A, city CT, country CN
where country = 'Iran' and first_name like '_____'
	  and (C.address_id, A.city_id, CT.country_id) = (A.address_id, CT.city_id, CN.country_id)

---- Q10-B

select title
from film, inventory, rental
where length < 100 and rental_rate < 2 and store_id = 2 and (return_date - rental_date) < '1 day' 
	  and (film.film_id, inventory.inventory_id) = (inventory.film_id, rental.inventory_id)

---- Q10-C

----(1)
(select first_name, last_name
 from actor A, film_actor FA, film F
 where rental_rate > 4
	   and (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id))
except
(select first_name, last_name
 from actor A, film_actor FA, film F
 where length > 180
	   and (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id))
order by last_name, first_name

----(2)
select distinct A.actor_id, first_name, last_name
 from actor A, film_actor FA, film F
 where rental_rate > 4
	   and (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id)
	   and not exists (select actor_id 
 				   	   from film_actor, film
                       where length > 180 
	   				         and (film_actor.actor_id, film_actor.film_id) = (A.actor_id, film.film_id))
order by last_name, first_name

---- Q10-D



---- Q10-E



---- Q10-F



---- Q10-G



---- Q10-H



---- Q10-I



---- Q10-J



---- Q10-K


