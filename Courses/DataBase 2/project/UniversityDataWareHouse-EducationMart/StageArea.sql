-- Marzieh Alidadi - 9631983

/********************************************Create Stage Area Tables********************************************/

drop database if exists UniversitySA
go

create database UniversitySA
go

use UniversitySA
go

create table classroom
	(building		varchar(15),
	 room_number	varchar(7),
	 capacity		numeric(4,0)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		    numeric(12,2)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0)
	);

create table instructor
	(ID			                    varchar(5), 
	 first_name			            varchar(20), 
	 last_name			            varchar(20), 
	 dept_name		                varchar(20),
	 salary			                numeric(8,2),
     national_code                  varchar(10),
     phone_number                   varchar(15),
     instructor_type                smallint,
     instructor_type_description    varchar(200)
	);

create table section
	(course_id		varchar(8), 
     sec_id			varchar(8),
	 semester		int,
     year			numeric(4,0), 
	 building		varchar(15),
	 room_number	varchar(7),
	 time_slot_id	varchar(4)
	);

create table teaches
	(ID			    varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0)
	);

create table student
	(ID			                varchar(5), 
	 first_name			        varchar(20), 
	 last_name			        varchar(20),      
	 dept_name		            varchar(20), 
     national_code              varchar(10),
     phone_number               varchar(15),
	 tot_cred		            numeric(3,0),
     student_type               bit,
     student_type_description   varchar(200),
     student_degree             smallint,
     student_degree_description varchar(200)
	);

create table takes
	(ID			    varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		    varchar(2)
	);

create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5)
	);

create table time_slot
	(time_slot_id	varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2),
	 start_min		numeric(2),
	 end_hr			numeric(2),
	 end_min		numeric(2)
	);

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8)
	);

/***Logs***/
create table Logs
    (date           datetime,
    table_name      varchar(50),
    status          tinyint,
    description     varchar(500),
    affected_rows   int
    );

go

/********************************************Create Stage Area Procedures********************************************/

create or alter procedure classroom_insert as
begin
	begin try
		truncate table classroom;
		insert into classroom
		select building, room_number, capacity
		from University.dbo.classroom; 
		insert into Logs values
		(GETDATE(),'classroom',1,'classroom inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'classroom',0,'ERROR : classroom may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure department_insert as
begin
	begin try
		truncate table department;
		insert into department
		select dept_name, building, budget
		from University.dbo.department; 
		insert into Logs values
		(GETDATE(),'department',1,'department inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'department',0,'ERROR : department may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure course_insert as
begin
	begin try
		truncate table course;
		insert into course
		select course_id, title, dept_name, credits        
		from University.dbo.course; 
		insert into Logs values
		(GETDATE(),'course',1,'course inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'course',0,'ERROR : course may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure instructor_insert as
begin
	begin try
		truncate table instructor;
		insert into instructor
		select ID, first_name, last_name, dept_name, salary, national_code, phone_number, instructor_type,
                case instructor_type																								   
                when 1 then 'Professor Emeritus'  
                when 2 then 'Administrator'
                when 3 then 'Distinguished Professor'
                when 4 then 'Endowed Professor'
                when 5 then 'Full Professor'
                when 6 then 'Associate Professor'
                when 7 then 'Assistant Professor'
                when 8 then 'Visiting Professor'
                when 9 then 'Graduate Teaching Assistant'
                when 10 then 'Adjunct Instructor'
                end as instructor_type_description
		from University.dbo.instructor; 
		insert into Logs values
		(GETDATE(),'instructor',1,'instructor inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'instructor',0,'ERROR : instructor may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure section_insert as
begin
	begin try
		truncate table section;
		insert into section
		select course_id, sec_id, case semester
                                  when 'Spring' then 1 
                                  when 'Summer' then 2 
                                  when 'Fall' then 3 
                                  when 'Winter' then 4 
                                  end as semester, student_degree,
                year, building, room_number, time_slot_id
		from University.dbo.section; 
		insert into Logs values
		(GETDATE(),'section',1,'section inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'section',0,'ERROR : section may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure teaches_insert as
begin
	begin try
		truncate table teaches;
		insert into teaches
		select ID, course_id, sec_id, case semester
                                      when 'Spring' then 1 
                                      when 'Summer' then 2 
                                      when 'Fall' then 3 
                                      when 'Winter' then 4 
                                      end as semester, year
		from University.dbo.teaches; 
		insert into Logs values
		(GETDATE(),'teaches',1,'teaches inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'teaches',0,'ERROR : teaches may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure student_insert as
begin
	begin try
		truncate table student;
		insert into student
		select ID, first_name, last_name, dept_name, national_code, phone_number, tot_cred, student_type,
                case student_type																								   
                when 1 then 'Scholarship Student'  
                else 'Tuition-Paying Student'
                end as student_type_description, student_degree,
                case student_degree																								   
                when 1 then 'Associate'  
                when 2 then 'Bachelor'  
                when 3 then 'master'  
                when 4 then 'doctoral'  
                end as student_degree_description
		from University.dbo.student; 
		insert into Logs values
		(GETDATE(),'student',1,'student inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'student',0,'ERROR : student may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure takes_insert as
begin
	begin try
		truncate table takes;
		insert into takes
		select ID, course_id, sec_id, case semester
                                      when 'Spring' then 1 
                                      when 'Summer' then 2 
                                      when 'Fall' then 3 
                                      when 'Winter' then 4 
                                      end as semester, year, grade                
		from University.dbo.takes; 
		insert into Logs values
		(GETDATE(),'takes',1,'takes inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'takes',0,'ERROR : takes may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure advisor_insert as
begin
	begin try
		truncate table advisor;
		insert into advisor
		select s_ID, i_ID	            
		from University.dbo.advisor; 
		insert into Logs values
		(GETDATE(),'advisor',1,'advisor inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'advisor',0,'ERROR : advisor may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure time_slot_insert as
begin
	begin try
		truncate table time_slot;
		insert into time_slot
		select time_slot_id, day, start_hr, start_min, end_hr, end_min        
		from University.dbo.time_slot; 
		insert into Logs values
		(GETDATE(),'time_slot',1,'time_slot inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'time_slot',0,'ERROR : time_slot may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure prereq_insert as
begin
	begin try
		truncate table prereq;
		insert into prereq
		select course_id, prereq_id
		from University.dbo.prereq; 
		insert into Logs values
		(GETDATE(),'prereq',1,'prereq inserted',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'prereq',0,'ERROR : prereq may not inserted',@@ROWCOUNT);
	end catch
end
go

create or alter procedure InsertToSA as
begin
	begin try
		exec classroom_insert;
		exec department_insert;
		exec course_insert;
		exec instructor_insert;
		exec section_insert;
		exec teaches_insert;
		exec student_insert;
		exec takes_insert;
		exec advisor_insert;
		exec time_slot_insert;
		exec prereq_insert;
		insert into Logs values
		(GETDATE(),'All Tables',1,'All insertions done!',@@ROWCOUNT);
	end try
	begin catch
		insert into Logs values
		(GETDATE(),'All Tables',0,'ERROR : All insertions may not done!',@@ROWCOUNT);
	end catch
end
go

-- exec InsertToSA;