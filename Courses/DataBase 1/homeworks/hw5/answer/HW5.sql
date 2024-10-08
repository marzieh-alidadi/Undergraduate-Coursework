-- HOMEWORK 5
-- YOUR NAME: Marzieh Alidadi
-- YOUR STUDENT NUMBER: 9631983


---- Q1a

WITH ordered AS(
	SELECT id, name, dept_name, salary
	FROM instructor
	ORDER BY salary) 
SELECT id, name, dept_name, salary,
       LAG(salary,1) OVER (PARTITION BY dept_name ORDER BY salary) previous_salary
FROM ordered;

---- Q1b

select id, name, rank() over (order by tot_cred DESC) s_rank
from student
order by s_rank ASC;

---- Q2

-- table Turn_over

create table Turn_over(
	dep_id integer,
	trn_time timestamp,
	trn_over integer 
);

insert into Turn_over values(1000, current_timestamp, 1000);
insert into Turn_over values(1001, current_timestamp, 100);
insert into Turn_over values(1002, current_timestamp, -20);
insert into Turn_over values(1000, current_timestamp, -20);
insert into Turn_over values(1002, current_timestamp, 1000);
insert into Turn_over values(1001, current_timestamp, 80);
insert into Turn_over values(1001, current_timestamp, -500);

-- table factdeptrn

create table factdeptrn(
	dep_id integer,
	trn_time timestamp,
	trn_over integer,
	balance integer
);

insert into factdeptrn(select *
					   from (select dep_id, trn_time, trn_over,
	   								sum(trn_over) over (order by trn_time
						   								range between unbounded preceding and current row)
					   from Turn_over) as Tmp);

---- Q3a

select distinct payment_id, customer_id, amount, payment_date,
	   avg(amount) over (partition by customer_id order by payment_date range between unbounded preceding and current row),
	   sum(amount) over (partition by customer_id order by payment_date range between unbounded preceding and current row)
from payment
order by customer_id, payment_date;

---- Q3b

with c_pay_sum as(
	select distinct customer_id,
		   sum(amount) over (partition by customer_id 
							 order by payment_date 
							 range between unbounded preceding and unbounded following) as pay_sum
	from payment),
	 c_pay_ntile as(
	select customer_id, pay_sum,
		   ntile(4) over (order by pay_sum DESC) as quartile
	from c_pay_sum)
select customer_id, pay_sum
from c_pay_ntile
where quartile = 1;

---- Q3c

with c_pay(payment_id, customer_id, amount, payment_date) as(
	select distinct payment_id, customer_id, amount, payment_date
	from payment
	order by customer_id, payment_date),
	 c_pre_pay(payment_id, customer_id, amount, payment_date,
			   pre_payment_id, pre_customer_id, pre_amount, pre_payment_date) as(
	select distinct payment.payment_id, payment.customer_id, payment.amount, payment.payment_date,
		   c_pay.payment_id, c_pay.customer_id, c_pay.amount, c_pay.payment_date
	from payment, c_pay
	where c_pay.payment_date <= payment.payment_date
	      and c_pay.customer_id = payment.customer_id)
select c_pre_pay.payment_id, c_pre_pay.customer_id, c_pre_pay.amount,
	   c_pre_pay.payment_date, sum(c_pre_pay.pre_amount)
from c_pre_pay
group by c_pre_pay.payment_id, c_pre_pay.customer_id, c_pre_pay.amount, c_pre_pay.payment_date
order by c_pre_pay.customer_id, c_pre_pay.payment_date;	

---- Q3d

select distinct country_id, city_id, 
	   count(distinct customer_id) customer_num, count(distinct rental_id) rental_num
from rental inner join customer using(customer_id)
	 inner join address using(address_id)
     inner join city using(city_id)
	 inner join country using(country_id)
group by cube(city_id, country_id)
order by country_id, city_id;

---- Q3e

select rental_rate, category_id, count(film_id) as film_number
from film_category inner join film using(film_id)
group by rollup(rental_rate, category_id)
order by rental_rate, category_id;

---- Q3f

select city, payment_date, sum(amount) tot_amount
from payment inner join customer using(customer_id)
	 inner join address using(address_id)
	      inner join city using(city_id)
group by cube(city, payment_date)
order by city, payment_date;
