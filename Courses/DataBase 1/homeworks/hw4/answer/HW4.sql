-- HOMEWORK 4
-- YOUR NAME: Marzieh Alidadi
-- YOUR STUDENT NUMBER: 9631983


---- Q1a

create view sales.order_view as
(select oDetail.salesorderdetailid, oDetail.carriertrackingnumber, oDetail.orderqty,
        oDetail.productid, oDetail.specialofferid, oDetail.unitprice, oDetail.unitpricediscount,
        oDetail.rowguid as oDetail_rowguid, oDetail.modifieddate as oDetail_modifieddate, oHeader.*
 from sales.salesorderdetail oDetail inner join sales.salesorderheader oHeader 
      on(oDetail.salesorderid = oHeader.salesorderid)
  where oHeader.customerid = 1
        and current_date - oHeader.orderdate <= interval '1' day)
        
CREATE RULE order_view_update_oHeader AS ON UPDATE TO sales.order_view 
	DO INSTEAD
    UPDATE sales.salesorderheader SET
	    salesorderid = NEW.salesorderid,
		revisionnumber = NEW.revisionnumber,
		duedate = NEW.duedate,
		totaldue = NEW.totaldue,
		orderdate = NEW.orderdate
	WHERE salesorderid = OLD.salesorderid; 
    
CREATE RULE order_view_update_oDetail AS ON UPDATE TO sales.order_view 
	DO INSTEAD		 
	UPDATE sales.salesorderdetail SET
		orderqty = NEW.orderqty,
		unitprice = NEW.unitprice
	WHERE salesorderid = OLD.salesorderid;
    
create role customer1
login 
password '1';

grant usage on schema sales to customer1;

grant select, update on sales.order_view to customer1;

SET SESSION AUTHORIZATION customer1;

-- permission granted:

select * from sales.order_view;

-- permission denied:

select * from sales.salesorderdetail;

---- Q1b

create table production.InventoryDefaults(
	locationid smallint primary key,
	shelf VARCHAR(10),
	bin SMALLINT 
);

insert into production.InventoryDefaults(locationid, shelf, bin)
values (1,'A',1) , (2,'B',2) , (3,'C',3) , (4,'D',4);

create or replace procedure production.transfer_proc(
	proc_product_id integer,
    proc_source smallint,
    proc_destination smallint,
    proc_product_num integer)
language plpgsql    
as $$
begin
	update production.productinventory as PI1
	set quantity = quantity - proc_product_num
	where PI1.productid = proc_product_id
	      and PI1.locationid = proc_source;
	IF proc_product_id in (select PI2.productid
					  	   from production.productinventory PI2
					  	   where PI2.locationid = proc_destination) THEN
		update production.productinventory as PI3
		set quantity = quantity + final_amount, bin = bin + 1
		where PI3.productid = proc_product_id
	          and PI3.locationid = proc_destination;
	ELSE
		insert into production.productinventory
		            (productid, locationid, shelf, bin, quantity, rowguid, modifieddate)
		values(proc_product_id, proc_destination, 
			   (select PD1.shelf 
			   from production.InventoryDefaults PD1 
			   where PD1.locationid = proc_destination),
			   (select PD2.bin 
			   from production.InventoryDefaults PD2
			   where PD2.locationid = proc_destination),
			   proc_product_num, (select uuid_generate_v1()), current_date);
	END IF;
	commit;
end; $$

call production.transfer_proc(1, smallint '1', smallint '2', 8);

select * from production.productinventory
where locationid = 1 and productid = 1ک

select * from production.productinventory
where locationid = 2 and productid = 1

---- Q2a

create table RegistrationLog(
	studentID varchar(5) not null,
	semester varchar(6),
	year numeric(4,0),
	status varchar(10) default 'NotReg', 
	overAttempts numeric(3,0) default 0,
	primary key (studentID, semester, year),
	foreign key (studentID) references student(ID),
	check (semester in('Fall', 'Winter', 'Spring', 'Summer')),
	check (status in('Normal', 'NotReg', 'CheckUnder', 'CheckOver'))
)

---- Q2b

create or replace procedure register_proc(
	proc_id varchar(5),
    proc_course_id varchar(8),
    proc_sec_id varchar(8),
    proc_semester varchar(6),
    proc_year numeric(4,0))
language plpgsql    
as $$
begin
	 insert into registrationLog
	 select *
     from (select proc_id, proc_semester, proc_year) as tmp1
	 where not exists(select studentID
		  			  from registrationLog
					  where registrationLog.studentID = tmp1.proc_id
                            and registrationLog.semester = tmp1.proc_semester
                            and registrationLog.year = tmp1.proc_year);
	 update registrationLog
	 set overAttempts = overAttempts + 1
	 where registrationLog.studentID = proc_id
	 	   and 20 < (select count(credits)
			 		 from course, takes, student
			 		 where course.course_id = takes.course_id
			 	           and takes.id = student.id
			 	           and student.id = proc_id
					       and sec_id = proc_sec_id
					       and semester = proc_semester
						   and year = proc_year);
	 update registrationLog
	 set status = 'Normal'
	 where registrationLog.studentID = proc_id
	 	   and 20 >= (select count(credits)
			 		  from course, takes, student
			 		  where course.course_id = takes.course_id
			 	            and takes.id = student.id
			 	            and student.id = proc_id
					        and sec_id = proc_sec_id
					        and semester = proc_semester
						    and year = proc_year);					 
	 insert into takes
	 select *
	 from (select proc_id, proc_course_id, proc_sec_id, proc_semester, proc_year) as tmp2
	 where 20 >= (select count(credits)
			 		 from course, takes, student
			 		 where course.course_id = takes.course_id
			 	           and takes.id = student.id
			 	           and student.id = tmp2.proc_id
					       and sec_id = tmp2.proc_sec_id
					       and semester = tmp2.proc_semester
						   and year = tmp2.proc_year);
	commit;
end; $$

call register_proc('10033', '663', '1', 'Spring', '2005')

---- Q2c

CREATE OR REPLACE FUNCTION set_status_function() RETURNS trigger AS $$
    BEGIN
        IF 12 > (select count(credits)
			     from course, takes, student
			     where course.course_id = takes.course_id
			 	  	   and takes.id = student.id
			 	   	   and new.id = student.id
				   	   and new.semester = takes.semester
				       and new.year = takes.year) THEN
			update registrationLog
	 		set status = 'CheckUnder'
			where registrationLog.studentID = new.id
			      and registrationLog.semester = new.semester
				  and registrationLog.year = new.year;
        END IF;
		IF 18 < (select count(credits)
			     from course, takes, student
			     where course.course_id = takes.course_id
			 	  	   and takes.id = student.id
			 	   	   and new.id = student.id
				   	   and new.semester = takes.semester
				       and new.year = takes.year) THEN
			update registrationLog
	 		set status = 'CheckOver'
			where registrationLog.studentID = new.id
			      and registrationLog.semester = new.semester
				  and registrationLog.year = new.year;
        END IF;
   		RETURN NEW;
    END;
$$ LANGUAGE plpgsql;     
CREATE TRIGGER set_status AFTER INSERT ON takes
    FOR EACH ROW EXECUTE FUNCTION set_status_function();

---- Q3a

create table category_rating(
	category_id smallint,
	category_name varchar(25),
	avg_rate numeric(4,2),
	max_length smallint,
	foreign key (category_id) references category(category_id),
	primary key (category_id, avg_rate, max_length)
)

insert into category_rating
	select category.category_id, name, avg(rental_rate), max(length)
 	from film_category, film, category
 	where film_category.film_id = film.film_id
		  and film_category.category_id = category.category_id
 	group by category.category_id, name

create or replace procedure category_length_remove_proc()
language plpgsql    
as $$
begin
	with category_avg_rate(category_id, avg_rate) as
	(select category_id, avg(rental_rate)
	 from film_category, film
	 where film_category.film_id = film.film_id
	 group by category_id),
	three_max_rate(category_id, avg_rate) as
	(select category_id, avg_rate
	 from category_avg_rate
	 order by avg_rate DESC
	 limit 3),
	category_avg_length(category_id, avg_length) as
	(select category_id, avg(length)
	 from film_category, film
	 where film_category.film_id = film.film_id
	 group by category_id),
	three_max_rate_length(category_id, avg_length) as
	(select category_avg_length.category_id, category_avg_length.avg_length
	 from category_avg_length, three_max_rate
	 where category_avg_length.category_id = three_max_rate.category_id),
    final_three_avg_length (final_avg_length) as
	(select avg(avg_length)
	 from category_avg_length)
	delete from category_rating
	where category_id in (select category_id
						  from category_avg_length
						  where avg_length > (select *
											  from final_three_avg_length));
end; $$

---- Q3b

create or replace function film_availability_func(
	func_film_name varchar(255),
	func_date date) 
returns table(
	film_id integer,
	film_name varchar(255),
	not_exist text,
	exist text) 
language plpgsql
as $$
begin
	return query
		with film_info(film_id, film_name, film_num) as
		(select film.film_id, title, count(distinct inventory.inventory_id)
		 from film, inventory, rental
		 where film.film_id = inventory.film_id
		       and inventory.inventory_id = rental.inventory_id
		 group by film.film_id, title),
		state(not_exist, exist) as
		(select 'Finished!', 'Still available!'),
		not_exist_films(film_id, film_name, state) as
		(select film_info.film_id, film_info.film_name, state.not_exist
		 from film_info, state
		 where film_num = (select count(distinct rental_id)
					   	   from film_info, rental, inventory
					   	   where inventory.inventory_id = rental.inventory_id
					      		 and inventory.film_id = film_info.film_id
					      		 and film_info.film_name = func_film_name
			              		 and rental_date < func_date
				   		  		 and (return_date > func_date or return_date is null))),
		exist_films(film_id, film_name, state) as
		(select film_info.film_id, film_info.film_name, state.exist
		 from film_info, state
		 where film_num > (select count(distinct rental_id)
					   	   from film_info, rental, inventory
			   	    	   where inventory.inventory_id = rental.inventory_id
					     		 and inventory.film_id = film_info.film_id
					      		 and film_info.film_name = func_film_name
			              		 and rental_date < func_date
				   		  		 and (return_date > func_date or return_date is null)))
		select film_info.film_id, film_info.film_name, not_exist_films.state, exist_films.state
		from film_info full outer join not_exist_films on (film_info.film_id = not_exist_films.film_id)
	 		 full outer join exist_films on (film_info.film_id = exist_films.film_id)
		where film_info.film_name = func_film_name;
end; $$

select film_availability_func('Academy Dinosaur', '2005-09-12')

---- Q3c

CREATE OR REPLACE FUNCTION rent_free_film_function() RETURNS trigger AS $$
    BEGIN
		IF new.amount > 7 THEN
			insert into rental
			select new.rental_id + 1, current_timestamp,
				   (with a(store_id, inventory_id) as
				   (select store_id, rental.inventory_id
					from rental, payment, inventory
					where rental.rental_id = payment.rental_id
	      				  and rental.inventory_id = inventory.inventory_id
				          and rental.rental_id = new.rental_id)
				   select distinct rental.inventory_id
				   from rental, payment, inventory, a
				   where rental.rental_id = payment.rental_id
	      			     and rental.inventory_id = inventory.inventory_id
		  			     and inventory.store_id = a.store_id
		  			     and rental.inventory_id != a.inventory_id
				   limit 1),
				   new.customer_id, current_timestamp + interval '1' day, new.staff_id, current_timestamp;
			insert into payment
			select new.payment_id + 1, new.customer_id, new.staff_id, new.rental_id + 1, 0, current_timestamp;
		END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;     
CREATE TRIGGER rent_free_film AFTER INSERT ON payment
    FOR EACH ROW EXECUTE FUNCTION rent_free_film_function();
    
-- checking the trigger:

insert into rental
 values(16052, '2020-07-07 13:55:32.996577', 2666, 264, '2020-07-19 13:55:32.996577', 2, '2020-07-09 13:55:32.996577');
 
insert into payment
 values(32099, 264, 2, 16052, 8, '2020-07-07 13:55:32.996577');

select * from payment
order by payment_id DESC;

select * from rental
order by rental_id DESC

---- Q3d

create role sell_employee
login 
password 'employee';

grant select 
on inventory
to sell_employee

create role store_manager
login 
password 'manager';

grant sell_employee to store_manager;

grant select, delete, insert, update
on inventory, staff
to store_manager
