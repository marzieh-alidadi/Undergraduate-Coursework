-- Marzieh Alidadi - 9631983

/********************************************Create Data Warehouse Tables********************************************/
          /**********************************************************************************************/
                  /**************(By getting bigger storage for different values)**************/
                                     /************************************/

/***DataBase***/
drop database if exists UniversityDW
go

create database UniversityDW
go 

use UniversityDW
go

/***Schema***/
create schema Education
go

/***************Dimensions***************/

create table Education.dimDate (
    TimeKey									int primary key,
    FullDateAlternateKey					varchar(60),
    PersianFullDateAlternateKey		        varchar(60),
    DayNumberOfWeek					        int,
    PersianDayNumberOfWeek			        int,
    EnglishDayNameOfWeek			        varchar(20),
    PersianDayNameOfWeek			        nvarchar(20),
    DayNumberOfMonth					    int,
    PersianDayNumberOfMonth		            int,
    DayNumberOfYear						    int,
    PersianDayNumberOfYear			        int,
    WeekNumberOfYear					    int,
    PersianWeekNumberOfYear		            int,
    EnglishMonthName						varchar(60),
    PersianMonthName					    nvarchar(60),
    MonthNumberOfYear					    int,
    PersianMonthNumberOfYear		        int,
    CalendarQuarter							int,
    PersianCalendarQuarter				    int,
    CalendarYear							int,
    PersianCalendarYear					    int,
    CalendarSemester						int,
    PersianCalendarSemester			        int
);
go

create table Education.dimStudent
	(student_code		  	    int IDENTITY(1,1) primary key, -- Surrogate Key(To have an int value as a primary key)
     ID			                varchar(15), 
	 first_name			        varchar(30), 
	 last_name			        varchar(30),      
	 dept_name		            varchar(30), 
     national_code              varchar(20),
     previous_phone_number      varchar(25),
     phone_number_change_date   date,
     current_phone_number       varchar(25),        -- SCD3
	 tot_cred		            numeric(13,10),
     student_type               bit,         
     student_type_description   varchar(250), 
     student_degree             smallint,      
     student_degree_description varchar(250) 
	);
go

create table Education.dimInstructor
	(instructor_code				int IDENTITY(1,1) primary key, -- Surrogate Key(Because of having SCD2)
     ID			                    varchar(15), 
	 first_name			            varchar(30), 
	 last_name			            varchar(30), 
	 dept_name		                varchar(30),
     salary_start_date				date,
     salary_end_date				date,
     salary_change_flag				int,
	 salary			                numeric(18,12),   -- SCD2
     national_code                  varchar(20),
     previous_phone_number          varchar(25),
     phone_number_change_date       date,
     current_phone_number           varchar(25),    -- SCD3
     instructor_type                smallint,       -- SCD1
     instructor_type_description    varchar(250)    -- (changing with instructor_type field - SCD1)
	);
go

create table Education.dimCourse
	(course_code				    int IDENTITY(1,1) primary key, -- Surrogate Key(Because of having SCD2)
     course_id		                varchar(18), 
     title			                varchar(60), 
	 dept_name		                varchar(30),
     credits_start_date				date,
     credits_end_date				date,
     credits_change_flag			int,
     credits		                numeric(12,10)    -- SCD2
	);
go

create table Education.dimClass
	(class_code                    int IDENTITY(1,1) primary key, -- Surrogate Key
     building		               varchar(25),
	 room_number	               varchar(17),
     capacity		               numeric(4,0)     -- SCD1
	);
go

create table Education.dimTerm
	(semester_code                 int IDENTITY(1,1) primary key, -- Surrogate Key
     semester		               int,
	 year			               numeric(14,10)
	);
go

create table Education.dimTimeSlot
	(timeSlot_code                 int IDENTITY(1,1) primary key, -- Surrogate Key(To have an int value as a primary key)
     time_slot_id	               varchar(14),
	 day			               varchar(11),
	 start_hr		               numeric(12),
	 start_min		               numeric(12),
	 end_hr			               numeric(12),
	 end_min		               numeric(12)
	);
go

/*****************Facts*****************/

create table factlessPrereq
	(-- foreign keys referencing dimentions:
     course_id		varchar(18),
	 prereq_id		varchar(18)
	);
go

create table factlessAvailableCorses
	(-- foreign keys referencing dimentions:
     TimeKey					int,
     instructor_code			int,
     instructor_ID			    varchar(15), -- natural key(for caution)
     course_code				int,
     course_id		            varchar(18), -- natural key(for caution)
     class_code                 int,
     semester_code              int 
	);
go

create table factTransactionTakeCorse
	(-- foreign keys referencing dimentions:
     TimeKey					int,
     student_code				int,
     student_ID			        varchar(15), -- natural key(for caution)
     instructor_code			int,
     instructor_ID			    varchar(15), -- natural key(for caution)
     course_code				int,
     course_id		            varchar(18), -- natural key(for caution)
     class_code                 int,
     semester_code              int,
     timeSlot_code              int,
     time_slot_id	            varchar(14), -- [somehow] natural key(for caution)
     -- measures:
     grade                      varchar(12),
     grade_description          varchar(30)     
	);
go

create table factTermicReportCard
	(-- foreign keys referencing dimentions:
     TimeKey					int,
     student_code				int,
     student_ID			        varchar(15), -- natural key(for caution)
     semester_code              int,
     -- measures:
     average                    varchar(12),
     max_grade                  varchar(12),
     min_grade                  varchar(12),
     probation                  bit,
     total_credits              numeric(13,10),
     total_passed_credits       numeric(13,10),
     total_failed_credits       numeric(13,10)
	);
go

create table factAccumulativeReportCard
	(-- foreign keys referencing dimentions:
     student_code				int,
     student_ID			        varchar(15), -- natural key(for caution)
     -- measures:
     average                    varchar(12),
     max_grade                  varchar(12),
     min_grade                  varchar(12),
     probation_num              numeric(13,10),
     total_credits              numeric(13,10),
     total_passed_credits       numeric(13,10),
     total_failed_credits       numeric(13,10)
	);
go

/******************Logs******************/

create table Logs
    (date           datetime,
    table_name      varchar(50),
    status          tinyint,
    description     varchar(500),
    affected_rows   int
    );
go

/*************Insertion To dimDate*************/

bulk insert Education.dimDate
from 'Date.txt'
with
(fieldterminator = '\t',
 CODEPAGE = '65001'
);
go

/********************************************Create Data Warehouse Procedures********************************************/
            /**********************************************************************************************/
                                  /**************(FirstLoad & NextLoad)**************/
                                               /************************/

/***************Dimensions***************/

/***FirstLoads***/

create or alter procedure Education.dimStudent_firstLoad @current_date date
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimStudent
            /*********/
			insert into UniversityDW.Education.dimStudent
                (ID, first_name, last_name, dept_name, national_code, previous_phone_number,
                 phone_number_change_date, current_phone_number, tot_cred, student_type,
                 student_type_description, student_degree, student_degree_description
                )
			SELECT ID, first_name, last_name, dept_name, national_code, NULL, @current_date,
                     phone_number, tot_cred, student_type, student_type_description,
                     student_degree, student_degree_description
			FROM UniversitySA.dbo.student
            /*********/
			insert into UniversityDW.Education.dimStudent
			values(-1, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
                   '0001-01-01', 'Unknown', 0, NULL, 'Unknown', 0, 'Unknown');
			/*********/
            insert into Logs values
		    (GETDATE(),'dimStudent',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimStudent',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

create or alter procedure Education.dimInstructor_firstLoad @current_date date
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimInstructor
            /*********/
			insert into UniversityDW.Education.dimInstructor
                (ID, first_name, last_name, dept_name, salary_start_date,
                 salary_end_date, salary_change_flag, salary, national_code,
                 previous_phone_number, phone_number_change_date, current_phone_number,
                 instructor_type, instructor_type_description
                )
			SELECT ID, first_name, last_name, dept_name, @current_date,
                    NULL, 1, salary, national_code, NULL, @current_date,
                    phone_number, instructor_type, instructor_type_description
			FROM UniversitySA.dbo.instructor
            /*********/
			insert into UniversityDW.Education.dimInstructor
			values(-1, 'Unknown', 'Unknown', 'Unknown', 'Unknown', '0001-01-01', '0001-01-01',
                   0, 0, 'Unknown', 'Unknown', '0001-01-01', 'Unknown', NULL, 'Unknown');
			/*********/
            insert into Logs values
		    (GETDATE(),'dimInstructor',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimInstructor',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

create or alter procedure Education.dimCourse_firstLoad @current_date date
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimCourse
            /*********/
			insert into UniversityDW.Education.dimCourse
                (course_id, title, dept_name, credits_start_date, credits_end_date,
                 credits_change_flag, credits
                )
			SELECT course_id, title, dept_name, @current_date, NULL, 1, credits
			FROM UniversitySA.dbo.course
            /*********/
			insert into UniversityDW.Education.dimCourse
			values(-1, 'Unknown', 'Unknown', 'Unknown', '0001-01-01', '0001-01-01', 0, 0);
			/*********/
            insert into Logs values
		    (GETDATE(),'dimCourse',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimCourse',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

create or alter procedure Education.dimClass_firstLoad
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimClass
            /*********/
			insert into UniversityDW.Education.dimClass
                (building, room_number, capacity
                )
			SELECT building, room_number, capacity
			FROM UniversitySA.dbo.classroom
            /*********/
			insert into UniversityDW.Education.dimClass
			values(-1, 'Unknown', 'Unknown', 0);
			/*********/
            insert into Logs values
		    (GETDATE(),'dimClass',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimClass',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

create or alter procedure Education.dimTerm_firstLoad
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimTerm
            /*********/
			insert into UniversityDW.Education.dimTerm
                (semester, year
                )
			SELECT semester, year
			FROM UniversitySA.dbo.section
            /*********/
			insert into UniversityDW.Education.dimTerm
			values(-1, 'Unknown', 0);
			/*********/
            insert into Logs values
		    (GETDATE(),'dimTerm',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimTerm',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

create or alter procedure Education.dimTimeSlot_firstLoad
	as
	begin
		begin try 
			truncate table UniversityDW.Education.dimTimeSlot
            /*********/
			insert into UniversityDW.Education.dimTimeSlot
                (time_slot_id, day, start_hr, start_min, end_hr, end_min
                )
			SELECT time_slot_id, day, start_hr, start_min, end_hr, end_min
			FROM UniversitySA.dbo.time_slot
            /*********/
			insert into UniversityDW.Education.dimTimeSlot
			values(-1, 'Unknown', 'Unknown', 0, 0, 0, 0);
			/*********/
            insert into Logs values
		    (GETDATE(),'dimTimeSlot',1,'FirstLoad inserted successfully',@@ROWCOUNT);
		end try
		begin catch
            /*********/
            insert into Logs values
		    (GETDATE(),'dimTimeSlot',0,'ERROR : FirstLoad may not inserted',@@ROWCOUNT);
		end catch
	end
go

/***NextLoads***/

create or alter procedure dimStudent_NextLoad @current_date Date
	as 
	begin
	   begin try
		  merge UniversityDW.Education.dimStudent as dim
		  using UniversitySA.dbo.student as SA
            on dim.ID = SA.ID
            /*********/
		  when not matched by dim
            then
                insert
                    (ID, first_name, last_name, dept_name, national_code, previous_phone_number,
                     phone_number_change_date, current_phone_number, tot_cred, student_type,
                     student_type_description, student_degree, student_degree_description
                    )
			    values
                    (ID, first_name, last_name, dept_name, national_code, NULL, @current_date,
                     phone_number, tot_cred, student_type, student_type_description,
                     student_degree, student_degree_description
                    )
            /*********/ 
		  when matched and (dim.current_phone_number <> SA.phone_number)
            then update set 
                -- SCD3
                dim.previous_phone_number = dim.current_phone_number,
			    dim.phone_number_change_date = @current_date,
                dim.current_phone_number = SA.phone_number
		  ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimStudent',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimStudent',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure dimInstructor_NextLoad @current_date Date
	as 
	begin
	   begin try
          DECLARE @rCount INT;
		  merge UniversityDW.Education.dimInstructor as dim
		  using UniversitySA.dbo.instructor as SA
            on dim.ID = SA.ID
            /*********/
		  when not matched by dim
            then
                insert
                    (ID, first_name, last_name, dept_name, salary_start_date,
                     salary_end_date, salary_change_flag, salary, national_code,
                     previous_phone_number, phone_number_change_date, current_phone_number,
                     instructor_type, instructor_type_description
                    )
			    values
                    (ID, first_name, last_name, dept_name, @current_date,
                     NULL, 1, salary, national_code, NULL, @current_date,
                     phone_number, instructor_type, instructor_type_description
                    )
            /*********/
		  when matched and (dim.current_phone_number <> SA.phone_number or 
                            dim.instructor_type <> SA.instructor_type or
                            dim.salary <> SA.salary)
            then update set 
                -- SCD3
                dim.previous_phone_number = case
                                            when dim.current_phone_number <> SA.phone_number
                                            then dim.current_phone_number
                                            else dim.previous_phone_number
                                            end,
			    dim.phone_number_change_date = case
                                               when dim.current_phone_number <> SA.phone_number
                                               then @current_date
                                               else dim.phone_number_change_date
                                               end,
                dim.current_phone_number = case
                                           when dim.current_phone_number <> SA.phone_number
                                           then SA.phone_number
                                           else dim.current_phone_number
                                           end,
                -- SCD1                            
                dim.instructor_type = SA.instructor_type,
                -- SCD2(part1)
                dim.salary_end_date = case
                                      when (dim.salary <> SA.salary and salary_change_flag = 1)
                                      then @current_date
                                      else dim.salary_end_date
                                      end,
                dim.salary_change_flag = case
                                         when dim.salary <> SA.salary
                                         then 0
                                         else dim.salary_change_flag
                                         end
          ;
          SET @rCount = @@ROWCOUNT;
            /*********/ -- SCD2(part2)
          insert into UniversityDW.Education.dimInstructor
             (ID, first_name, last_name, dept_name, salary_start_date,
              salary_end_date, salary_change_flag, salary, national_code,
              previous_phone_number, phone_number_change_date, current_phone_number,
               instructor_type, instructor_type_description
             )
          SELECT dIns.ID, dIns.first_name, dIns.last_name, dIns.dept_name, @current_date,
                  NULL, 1, ins.salary, dIns.national_code, dIns.previous_phone_number,
                  dIns.phone_number_change_date, dIns.current_phone_number,
                  dIns.instructor_type, dIns.instructor_type_description
          FROM UniversitySA.dbo.instructor AS ins
          INNER JOIN Education.dimInstructor AS dIns
          ON ins.ID = dIns.ID
          WHERE dIns.salary_end_date = @current_date
          ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimInstructor',1,'NextLoad inserted successfully',@@ROWCOUNT + @rCount);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimInstructor',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT + @rCount);
	   end catch
	end
go

create or alter procedure dimCourse_NextLoad @current_date Date
	as 
	begin
	   begin try
          DECLARE @rCount INT;
		  merge UniversityDW.Education.dimCourse as dim
		  using UniversitySA.dbo.course as SA
          on dim.course_id = SA.course_id
            /*********/
		  when not matched by dim
            then
                insert
                (course_id, title, dept_name, credits_start_date, credits_end_date,
                 credits_change_flag, credits
                )
			    values
                (course_id, title, dept_name, @current_date, NULL, 1, credits
                )
            /*********/
		  when matched and (dim.credits <> SA.credits)
            then update set 
                -- SCD2(part1)
                dim.credits_end_date = case
                                       when (dim.credits <> SA.credits and credits_change_flag = 1)
                                       then @current_date
                                       else dim.credits_end_date
                                       end,
                dim.credits_change_flag = case
                                          when dim.credits <> SA.credits
                                          then 0
                                          else dim.credits_change_flag
                                          end
          ;
          SET @rCount = @@ROWCOUNT;
            /*********/ -- SCD2(part2)
          insert into UniversityDW.Education.dimCourse
             (course_id, title, dept_name, credits_start_date, credits_end_date,
              credits_change_flag, credits
             )
          SELECT dCrs.course_id, dCrs.title, dCrs.dept_name, @current_date, NULL, 1, crs.credits
          FROM UniversitySA.dbo.course AS crs
          INNER JOIN Education.dimCourse AS dCrs
          ON dCrs.course_id = crs.course_id
          WHERE dCrs.credits_end_date = @current_date
          ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimCourse',1,'NextLoad inserted successfully',@@ROWCOUNT + @rCount);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimCourse',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT + @rCount);
	   end catch
	end
go

create or alter procedure dimClass_NextLoad
	as 
	begin
	   begin try
		  merge UniversityDW.Education.dimClass as dim
		  using UniversitySA.dbo.classroom as SA
            on dim.building = SA.building and dim.room_number = SA.room_number
            /*********/
		  when not matched by dim
            then
                insert
                    (building, room_number, capacity
                    )
			    values
                    (building, room_number, capacity
                    )
            /*********/
		  when matched and (dim.capacity <> SA.capacity)
            then update set 
                -- SCD1                            
                dim.capacity = SA.capacity
          ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimClass',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimClass',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure dimTerm_NextLoad
	as 
	begin
	   begin try
		  merge UniversityDW.Education.dimTerm as dim
		  using UniversitySA.dbo.section as SA
            on dim.semester = SA.semester and dim.year = SA.year
            /*********/
		  when not matched by dim
            then
                insert
                    (semester, year
                    )
			    values
                    (semester, year
                    )
          ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimTerm',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimTerm',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure dimTimeSlot_NextLoad
	as 
	begin
	   begin try
		  merge UniversityDW.Education.dimTimeSlot as dim
		  using UniversitySA.dbo.time_slot as SA
            on dim.time_slot_id = SA.time_slot_id and dim.day = SA.day and
               dim.start_hr = SA.start_hr and dim.start_min = SA.start_min
            /*********/
		  when not matched by dim
            then
                insert
                    (time_slot_id, day, start_hr, start_min, end_hr, end_min
                    )
			    values
                    (time_slot_id, day, start_hr, start_min, end_hr, end_min
                    )
          ;
		  /*********/
          insert into Logs values
		      (GETDATE(),'dimTimeSlot',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
          /*********/
          insert into Logs values
		      (GETDATE(),'dimTimeSlot',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

/*****************Facts*****************/

/***FirstLoads***/

create or alter procedure factlessPrereq_firstLoad
	as 
	begin
	   begin try
            /*********/
		  insert into Education.factlessPrereq
          SELECT course_id, prereq_id
          FROM prereq
		    /*********/
          insert into Logs values
		      (GETDATE(),'factlessPrereq',1,'firstLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factlessPrereq',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factlessAvailableCorses_firstLoad
	as 
	begin
	   begin try
            /*********/
		  insert into Education.factlessAvailableCorses
          SELECT TimeKey, dInstructor.instructor_code AS instructor_code,
                 dInstructor.ID AS instructor_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.teaches AS tcs
          ON sec.course_id = tcs.course_id and sec.sec_id = tcs.sec_id and
             sec.semester = tcs.semester and sec.year = tcs.year
          INNER JOIN Education.dimInstructor AS dInstructor
          ON tcs.ID = dInstructor.ID and dInstructor.salary_change_flag = 1
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester
		    /*********/
          insert into Logs values
		      (GETDATE(),'factlessAvailableCorses',1,'firstLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factlessAvailableCorses',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factTransactionTakeCorse_firstLoad
	as 
	begin
	   begin try
            /*********/
          insert into Education.factTransactionTakeCorse
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dInstructor.instructor_code AS instructor_code,
                 dInstructor.ID AS instructor_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, dTimeSlot.timeSlot_code AS timeSlot_code,
                 dTimeSlot.time_slot_id AS time_slot_id, tks.grade AS grade, case
                                                                             when tks.grade < 10
                                                                             then 'Fail'
                                                                             else 'Pass'
                                                                             end AS grade_description
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester
          INNER JOIN UniversitySA.dbo.teaches AS tcs
          ON sec.course_id = tcs.course_id and sec.sec_id = tcs.sec_id and
             sec.semester = tcs.semester and sec.year = tcs.year
          INNER JOIN Education.dimInstructor AS dInstructor
          ON tcs.ID = dInstructor.ID and dInstructor.salary_change_flag = 1
          INNER JOIN UniversitySA.dbo.time_slot AS tst
          ON sec.time_slot_id = tst.time_slot_id
          INNER JOIN Education.dimTimeSlot AS dTimeSlot
          ON tst.time_slot_id = dTimeSlot.time_slot_id and tst.day = dTimeSlot.day and
             tst.start_hr = dTimeSlot.start_hr and tst.start_min = dTimeSlot.start_min
		    /*********/
          insert into Logs values
		      (GETDATE(),'factTransactionTakeCorse',1,'firstLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factTransactionTakeCorse',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factTermicReportCard_firstLoad
	as 
	begin
	   begin try
            /*********/
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, tks.grade AS grade,
                 case
                 when tks.grade < 10
                 then 0
                 else dcourse.credits
                 end AS passedCredits, dcourse.credits AS credits,
                 case
                 when tks.grade < 10
                 then dcourse.credits
                 else 0
                 end AS failedCredits
          into #Temp1
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester;
            /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp2
          FROM #Temp1
          GROUP BY TimeKey, student_code, student_ID, semester_code;
          /*********/
          drop table #Temp1;
		    /*********/
          insert into Education.factTermicReportCard
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 average, max_grade, min_grade, case
                                                when average < 12
                                                then 1
                                                else 0
                                                end AS probation,
                 total_credits, passedCredits, failedCredits
          FROM #Temp2;
            /*********/
          drop table #Temp2;
            /*********/
          insert into Logs values
		      (GETDATE(),'factTermicReportCard',1,'firstLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factTermicReportCard',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factAccumulativeReportCard_firstLoad
	as 
	begin
	   begin try
            /*********/
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, tks.grade AS grade,
                 case
                 when tks.grade < 10
                 then 0
                 else dcourse.credits
                 end AS passedCredits, dcourse.credits AS credits,
                 case
                 when tks.grade < 10
                 then dcourse.credits
                 else 0
                 end AS failedCredits
          into #Temp1
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester;
            /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp2
          FROM #Temp1
          GROUP BY TimeKey, student_code, student_ID, semester_code;
		    /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 average, max_grade, min_grade, case
                                                when average < 12
                                                then 1
                                                else 0
                                                end AS probation,
                 total_credits, passedCredits, failedCredits
          into #Temp3
          FROM #Temp2;
            /*********/
          drop table #Temp2;
		    /*********/
          SELECT student_code, student_ID,
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp4
          FROM #Temp1
          GROUP BY student_code, student_ID;
            /*********/
          drop table #Temp1;
		    /*********/
          insert into Education.factAccumulativeReportCard
          SELECT T4.student_code, T4.student_ID, T4.average, T4.max_grade, T4.min_grade,
                 SUM(T3.probation), T4.total_credits, T4.passedCredits, T4.failedCredits
          FROM #Temp4 T4
          INNER JOIN #Temp3 T3
          ON T4.student_code = T3.student_code and T4.student_ID = T3.student_ID;
            /*********/
          drop table #Temp3;
          drop table #Temp4;
            /*********/
          insert into Logs values
		      (GETDATE(),'factAccumulativeReportCard',1,'firstLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factAccumulativeReportCard',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
	   end catch
	end
go

/***NextLoads***/

create or alter procedure factlessPrereq_NextLoad
	as 
	begin
	   begin try
            /*********/
		  insert into Education.factlessPrereq
          SELECT course_id, prereq_id
          FROM prereq
		    /*********/
          insert into Logs values
		      (GETDATE(),'factlessPrereq',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factlessPrereq',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factlessAvailableCorses_NextLoad
	as 
	begin
	   begin try
            /*********/
		  insert into Education.factlessAvailableCorses
          SELECT TimeKey, dInstructor.instructor_code AS instructor_code,
                 dInstructor.ID AS instructor_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.teaches AS tcs
          ON sec.course_id = tcs.course_id and sec.sec_id = tcs.sec_id and
             sec.semester = tcs.semester and sec.year = tcs.year
          INNER JOIN Education.dimInstructor AS dInstructor
          ON tcs.ID = dInstructor.ID and dInstructor.salary_change_flag = 1
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester
		    /*********/
          insert into Logs values
		      (GETDATE(),'factlessAvailableCorses',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factlessAvailableCorses',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factTransactionTakeCorse_NextLoad
	as 
	begin
	   begin try
            /*********/
          insert into Education.factTransactionTakeCorse
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dInstructor.instructor_code AS instructor_code,
                 dInstructor.ID AS instructor_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, dTimeSlot.timeSlot_code AS timeSlot_code,
                 dTimeSlot.time_slot_id AS time_slot_id, tks.grade AS grade, case
                                                                             when tks.grade < 10
                                                                             then 'Fail'
                                                                             else 'Pass'
                                                                             end AS grade_description
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester
          INNER JOIN UniversitySA.dbo.teaches AS tcs
          ON sec.course_id = tcs.course_id and sec.sec_id = tcs.sec_id and
             sec.semester = tcs.semester and sec.year = tcs.year
          INNER JOIN Education.dimInstructor AS dInstructor
          ON tcs.ID = dInstructor.ID and dInstructor.salary_change_flag = 1
          INNER JOIN UniversitySA.dbo.time_slot AS tst
          ON sec.time_slot_id = tst.time_slot_id
          INNER JOIN Education.dimTimeSlot AS dTimeSlot
          ON tst.time_slot_id = dTimeSlot.time_slot_id and tst.day = dTimeSlot.day and
             tst.start_hr = dTimeSlot.start_hr and tst.start_min = dTimeSlot.start_min
		    /*********/
          insert into Logs values
		      (GETDATE(),'factTransactionTakeCorse',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factTransactionTakeCorse',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factTermicReportCard_NextLoad
	as 
	begin
	   begin try
            /*********/
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, tks.grade AS grade,
                 case
                 when tks.grade < 10
                 then 0
                 else dcourse.credits
                 end AS passedCredits, dcourse.credits AS credits,
                 case
                 when tks.grade < 10
                 then dcourse.credits
                 else 0
                 end AS failedCredits
          into #Temp1
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester;
            /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp2
          FROM #Temp1
          GROUP BY TimeKey, student_code, student_ID, semester_code;
          /*********/
          drop table #Temp1;
		    /*********/
          insert into Education.factTermicReportCard
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 average, max_grade, min_grade, case
                                                when average < 12
                                                then 1
                                                else 0
                                                end AS probation,
                 total_credits, passedCredits, failedCredits
          FROM #Temp2;
            /*********/
          drop table #Temp2;
            /*********/
          insert into Logs values
		      (GETDATE(),'factTermicReportCard',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factTermicReportCard',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

create or alter procedure factAccumulativeReportCard_NextLoad
	as 
	begin
	   begin try
            /*********/
          SELECT TimeKey, dStudent.student_code AS student_code,
                 dStudent.ID AS student_ID, dcourse.course_code AS course_code,
                 dcourse.course_id AS course_id, dclass.class_code AS class_code,
                 dTerm.semester_code AS semester_code, tks.grade AS grade,
                 case
                 when tks.grade < 10
                 then 0
                 else dcourse.credits
                 end AS passedCredits, dcourse.credits AS credits,
                 case
                 when tks.grade < 10
                 then dcourse.credits
                 else 0
                 end AS failedCredits
          into #Temp1
          FROM Education.dimDate AS dDate
          INNER JOIN UniversitySA.dbo.section AS sec
          ON dDate.year = sec.year and dDate.semester = sec.semester
          INNER JOIN Education.dimClass AS dclass
          ON sec.building = dclass.building and sec.room_number = dclass.room_number
          INNER JOIN Education.dimCourse AS dcourse
          ON sec.course_id = dcourse.course_id and dcourse.credits_change_flag = 1
          INNER JOIN UniversitySA.dbo.takes AS tks
          ON sec.course_id = tks.course_id and sec.sec_id = tks.sec_id and
             sec.semester = tks.semester and sec.year = tks.year
          INNER JOIN Education.dimStudent AS dStudent
          ON tks.ID = dStudent.ID
          INNER JOIN Education.dimTerm AS dTerm
          ON dDate.year = dTerm.year and dDate.semester = dTerm.semester;
            /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp2
          FROM #Temp1
          GROUP BY TimeKey, student_code, student_ID, semester_code;
		    /*********/
          SELECT TimeKey, student_code, student_ID, semester_code, 
                 average, max_grade, min_grade, case
                                                when average < 12
                                                then 1
                                                else 0
                                                end AS probation,
                 total_credits, passedCredits, failedCredits
          into #Temp3
          FROM #Temp2;
            /*********/
          drop table #Temp2;
		    /*********/
          SELECT student_code, student_ID,
                 AVG(grade) AS average, MAX(grade) AS max_grade, MIN(grade) AS min_grade,
                 SUM(credits) AS total_credits, SUM(passedCredits) AS passedCredits,
                 SUM(failedCredits) AS failedCredits
          into #Temp4
          FROM #Temp1
          GROUP BY student_code, student_ID;
            /*********/
          drop table #Temp1;
		    /*********/
          insert into Education.factAccumulativeReportCard
          SELECT T4.student_code, T4.student_ID, T4.average, T4.max_grade, T4.min_grade,
                 SUM(T3.probation), T4.total_credits, T4.passedCredits, T4.failedCredits
          FROM #Temp4 T4
          INNER JOIN #Temp3 T3
          ON T4.student_code = T3.student_code and T4.student_ID = T3.student_ID;
            /*********/
          drop table #Temp3;
          drop table #Temp4;
            /*********/
          insert into Logs values
		      (GETDATE(),'factAccumulativeReportCard',1,'NextLoad inserted successfully',@@ROWCOUNT);
	   end try
	   begin catch
            /*********/
          insert into Logs values
		      (GETDATE(),'factAccumulativeReportCard',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
	   end catch
	end
go

/*****************To Execute all procedures*****************/

/***firstLoads***/

CREATE OR ALTER PROCEDURE firstLoad_proc @current_date date
	AS
	BEGIN
		BEGIN TRY
              /*********/
            EXEC Education.dimStudent_firstLoad @current_date date
            EXEC Education.dimInstructor_firstLoad @current_date date
            EXEC Education.dimCourse_firstLoad @current_date date
            EXEC Education.dimClass_firstLoad
            EXEC Education.dimTerm_firstLoad
            EXEC Education.dimTimeSlot_firstLoad
              /*********/
            EXEC factlessPrereq_firstLoad
            EXEC factlessAvailableCorses_firstLoad
            EXEC factTransactionTakeCorse_firstLoad
            EXEC factTermicReportCard_firstLoad
            EXEC factAccumulativeReportCard_firstLoad
			  /*********/
            insert into Logs values
		      (GETDATE(),'Education Mart',1,'firstLoad inserted successfully',@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			  /*********/
            insert into Logs values
		      (GETDATE(),'Education Mart',0,'ERROR : firstLoad may not inserted',@@ROWCOUNT);
		END CATCH
	END
GO

/***NextLoads***/

CREATE OR ALTER PROCEDURE NextLoad_proc @current_date date
	AS
	BEGIN
		BEGIN TRY
              /*********/
            EXEC Education.dimStudent_NextLoad @current_date date
            EXEC Education.dimInstructor_NextLoad @current_date date
            EXEC Education.dimCourse_NextLoad @current_date date
            EXEC Education.dimClass_NextLoad
            EXEC Education.dimTerm_NextLoad
            EXEC Education.dimTimeSlot_NextLoad
              /*********/
            EXEC factlessPrereq_NextLoad
            EXEC factlessAvailableCorses_NextLoad
            EXEC factTransactionTakeCorse_NextLoad
            EXEC factTermicReportCard_NextLoad
            EXEC factAccumulativeReportCard_NextLoad
			  /*********/
            insert into Logs values
		      (GETDATE(),'Education Mart',1,'NextLoad inserted successfully',@@ROWCOUNT);
		END TRY
		BEGIN CATCH
			  /*********/
            insert into Logs values
		      (GETDATE(),'Education Mart',0,'ERROR : NextLoad may not inserted or updated',@@ROWCOUNT);
		END CATCH
	END
GO

/********************************************Running All Procedures********************************************/
            /**********************************************************************************************/
                                  /**************(FirstLoad & NextLoad)**************/
                                               /************************/

/***firstLoads***/
EXEC firstLoad_proc;
select * from Logs;

/***NextLoads***/
EXEC NextLoad_proc;
select * from Logs;