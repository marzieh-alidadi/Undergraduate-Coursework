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
select distinct first_name, last_name
 from actor A, film_actor FA, film F
 where rental_rate > 4
	   and (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id)
	   and not exists (select actor_id 
 				   	   from film_actor, film
                       where length > 180 
	   				         and (film_actor.actor_id, film_actor.film_id) = (A.actor_id, film.film_id))
order by last_name, first_name

---- Q10-D

(select distinct first_name, last_name
 from actor A, film_actor FA, film F
 where rental_rate > 4
	   and (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id))
union
(select distinct first_name, last_name
 from customer C, film F, inventory I, rental R
 where rental_rate < 1 and (return_date - rental_date) < '1 day'
	   and (F.film_id, I.inventory_id, R.customer_id) = (I.film_id, R.inventory_id, C.customer_id))

---- Q10-E

select distinct first_name, last_name
from actor A, film_actor FA, film F
where (FA.actor_id, FA.film_id) = (A.actor_id, F.film_id)
      and rental_rate < all(select rental_rate
						    from film
						    where length > 184)

---- Q10-F

with T(id, tot_amount, order_num) as
(select customer.customer_id, sum(amount), count(payment_id)
 from customer, payment
 where payment.customer_id = customer.customer_id
 group by customer.customer_id)
select id, tot_amount, order_num
from T
where order_num < 15

---- Q10-G

with tot_order(first_name, last_name, order_num) as
(select customer.first_name, customer.last_name, count(payment_id)
 from customer, payment
 where payment.customer_id = customer.customer_id
 group by customer.first_name, customer.last_name),
     avg_tot_order(avg_order_num) as
(select avg(order_num)
 from tot_order)
select first_name, last_name
from tot_order, avg_tot_order
where order_num > avg_order_num

---- Q10-H

with max_of_genre(name, max_rate, max_len) as
(select name, max(rental_rate), max(length)
 from film F, category C, film_category FC
 where (F.film_id, FC.category_id) = (FC.film_id, C.category_id)
 group by name)
select distinct C.name, title
from film F, category C, film_category FC, max_of_genre
where (F.film_id, FC.category_id) = (FC.film_id, C.category_id)
	  and C.name = max_of_genre.name
      and (F.rental_rate,F.length) = (max_rate, max_len)

---- Q10-I

 select name, count(rental_id)
 from category C, film_category FC, film F, inventory I, rental R
 where (C.category_id, FC.film_id) = (FC.category_id, F.film_id)
        and (F.film_id, I.inventory_id) = (I.film_id, R.inventory_id)
group by name

---- Q10-J

with count_film(rating, name, count_f) as
(select rating, name, count(F.film_id)
 from film F, category C, film_category FC
 where (F.film_id, FC.category_id) = (FC.film_id, C.category_id)
 group by rating, name),
     max_film(rating, max_f) as
(select rating, max(count_f)
 from count_film
 group by rating)
select count_film.rating as rating, count_film.name as favorite_genre
from count_film, max_film
where count_film.rating = max_film.rating
      and count_film.count_f = max_film.max_f
order by count_film.rating

---- Q10-K

with duration(title, rental_duration) as
(select title, concat(rental_duration,' ', 'day')
 from film),
     later(name, count_late) as
(select name, count(R.rental_id)
 from category C, film_category FC, film F, inventory I, rental R, duration
 where (C.category_id, FC.film_id) = (FC.category_id, F.film_id)
       and (F.film_id, I.inventory_id) = (I.film_id, R.inventory_id)
       and (return_date - rental_date) > cast(duration.rental_duration as interval)
 group by name),
     sooner(name, count_soon) as
(select name, count(R.rental_id)
 from category C, film_category FC, film F, inventory I, rental R, duration
 where (C.category_id, FC.film_id) = (FC.category_id, F.film_id)
       and (F.film_id, I.inventory_id) = (I.film_id, R.inventory_id)
       and (return_date - rental_date) < cast(duration.rental_duration as interval)
 group by name),
     on_time(name, count_on_time) as
(select name, count(R.rental_id)
 from category C, film_category FC, film F, inventory I, rental R, duration
 where (C.category_id, FC.film_id) = (FC.category_id, F.film_id)
       and (F.film_id, I.inventory_id) = (I.film_id, R.inventory_id)
       and (return_date - rental_date) = cast(duration.rental_duration as interval)
 group by name)
select category.name, count_late, count_soon, count_on_time
from later, sooner, on_time, category
where category.name = later.name and later.name = sooner.name and sooner.name = on_time.name
