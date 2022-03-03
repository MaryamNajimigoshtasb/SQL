use excercise;
select * from departments;
select * from employees;
select * from regions;

#Filtering data


select first_name, last_name,salary,department from employees
where department like 'C%t%g';
select * from employees where last_name like '%mo%' and department='Clothing';
select * from employees where salary<>10000 and (gender='F' and department='Music');
select * from employees where (salary<>10000)  and gender='F';
select * from employees where salary != 10000 and gender='F';
select * from employees where not salary=10000 and gender='F';
select * from employees where not department <> 'Sports';

# working with NULL;

SELECT * FROM employees WHERE NULL!=NULL;
select * from employees where email is NULL;
select * from employees where email is not NULL;
select * from employees where not email is  NULL;

#Selecting range for characters and integers
SELECT *
 FROM employees 
 WHERE department='Sports' or
 department='Toys'or
 department='Garden';
 SELECT *
 FROM employees
 WHERE department in ('Sport', 'Toy', 'Garden');

SELECT * 
FROM employees 
WHERE salary between 8000 and 10000;

SELECT first_name, email
FROM employees 
WHERE gender='F' 
AND department='Tools' 
AND salary >11000;

SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2002-01-01' AND '2004-01-01';

SELECT first_name, hire_date
FROM employees
WHERE hire_date < '2002-01-01' OR  hire_date>'2004-01-01';

#Sorting : using order by by default is ascending 

SELECT * FROM employees 
order by department;

#Distinct Clause : Unique values
SELECT  distinct department From employees;#how we can label the rows ?
SELECT distinct department FROM employees ORDER BY department desc;
SELECT distinct department FROM employees ORDER BY 1 ;
#SELECT distinct department FROM employees ORDER BY 0 ; we dont have

#TOP 10;
SELECT distinct department FROM employees order by 1 limit 10;
#SELECT distinct department FROM employees order by 1 Fetch first 10 rows; we have in postgres , pgAdmin

# Defining Name for a coulumn , formating like uppercase, combining  columns, taking part of data, lenght of the data

Select upper(first_name) as Surname, 
Concat(upper(substring(last_name,1,1)),lower(substring(last_name,2))) as Furname,
 length(department) as Department_code
FROM employees;

# working with functions
SELECT ' HEllo world     'as afterspace, '        HEllo world' as beforespace, ' Hello       world' as betweenscapse;
SELECT trim(' HEllo worlds     ')as afterspace,
 Trim('        HEllo worlds') as beforespace
 ,trim(' Hello       world') as betweenscapse;
 SELECT trim(' HEllo world     ')as afterspace,
 Trim('        HEllo world') as beforespace
 ,replace(' Hello       world','       ',' ') as betweenscapse;
 
 
 #SELECT first_name || ' ' || last_name as fullname FROM employees;# this does not work here like + sign;
 SELECT concat(first_name,' ',last_name) as fullname FROM employees;
 
 #create Boolean column by defining an condition
 Select first_name, 
('Clothing' in (department)) as department_of_Clothing
FROM  employees;

select first_name, (hire_date>'2004-01-01') as ondatehired 
from employees 
having ondatehired=1; #filltering new created column with having

select email, (email like '%yahoo%') as yahoo from employees having yahoo=1;

#aggregation function.
SElect count(department) from employees;

 SELECT 'this is a test data' as "test data";
select substring('this is a test data', 1, 4);
select substring('this is a test data', 1);

select department,replace(department, 'Clothing','Tools') as updated_department from employees;

select department, concat(department,' ', 'department') as newdepartment from employees;

#Fining the email domin
SELECT   count(1), substring(email,Position('@' in email)+1)as domain from employees where email is not NULL group by domain order by domain ;
SELECT  distinct(substring(email,Position('@' in email)+1)) as domain from employees where email is not NULL ;

# Filling the missing Value 
SELECT coalesce(Email, 'NONE') from employees;
SELECT ifnull(email, 'none') as neweamil from employees;
SELECT IF(email is not null, email,'none') as neweamil from employees;

SELECT 
case
when email is not null then email
 else 'none' 
 end as neweamil from employees;
 
 #Functions
select max(salary) as maxsalary, avg(salary) as averagesalary,min(salary), sum(salary) from employees;
select count(employee_id) from employees;
select count(email)from employees;
select count(*) from employees;
select count(1) from employees;

select count(*)as numberof_departments, department from employees group by department;
# how many employee using same domain for their email?
select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain order by n_domain desc limit 10  ;
select * from employees;

select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain having Max(n_domain); #not giving us the result;

select max(n_domain) from(
select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain) as newtable;# for new variable that we creat we can not use it in where clause
# we can use another select statment 

select n_domain from(
select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain)  as newtable where n_domain >5;

select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain having n_domain>5;
#OR
select count(1) as n_domain, substring(email,position('@' in email)+1)as domain 
from employees where not email is null group by domain having count(*)>5;


select department , sum(salary) as total_salary 
from employees
where region_id in  (1,2,4)
group by department
order by department;


select department, region_id , sum(salary) from employees
Where region_id in (4,5,6,7)
Group by department, region_id
order by department ;

select department, region_id , count(1) as no_employee , round(avg(salary)) from employees
Where region_id in (4,5,6,7)
Group by department, region_id
having avg(salary)>20000
order by department ;

#showing distinct department without using distinct department
select department from employees group by department;

#NOTE: if we have aggregation function with other columns we should have groupby inorderto have meaning full table
select department, count(*) as no_dept from employees group by department having count(*) >35 order by department;

#Subqueries : select statment is either is from or where , in from it should have alianse 
# in the where statment it shoud have just one column/ we can  not use put select statment in the select statment.
#unless we limit the data using limit 1;


SELECT * FROM employees 
WHERE department not in (SELECT department from departments);# does not need aliase

select * from (select department, round(avg(salary)) as average_salary
from employees group by department) as a
 where (average_salary between 2000 and 30000) and department not in (select department from departments);
 # how sql works : first recognoze the table then highlights the records and then highlight hte coulumns if any
 # calculation required willdothat at the end checking the onditions.
 
 
 # subquaries with distributing single value to entire table using inner join
 select first_name, department ,salary,(select Maxsalary from 
                                                      (select department, Max(salary) as Maxsalary
										                from employees  group by department ) as b 
                                         where a.department= b.department) as Maxsalary_by_department
from employees as a
WHere region_id in ( select region_id from regions 
where country= 'Asia' or country= 'Canada');

#ANY is like or(in)  /ALL is act like and : in coditions  either where or having 
select * from employees where region_id in (select region_id from regions where country in ('United States'));

select * from employees
where region_id= any
(select region_id from regions 
 where country='United States');

select * from employees
where region_id = All
(select region_id from regions 
 where country='United States');

select * from employees
where region_id > All
(select region_id from regions 
 where country='United States');

/*--Quary:
 --write a quary that returns all of 
 --those employees that work in the kids
 --division and the dates at which 
 --those employees were hired is greater than all of 
 --the hire_date of employees who work in */

select * from employees 
where department= 
any (select department
       from departments 
        where division='Kids')
and 
hire_date>all(select hire_date 
               from employees 
	            where department='Maintenance')
;


select distinct(division) from departments;


#--quary
#those salary that appears most frequently

select salary, count(*)
from employees 
group by salary 
order by count(1)
desc limit 1;

select salary, count(*) as rep_salary
from employees
where salary >(select salary from employees
group by salary
order by  count(1) desc limit 1);


select salary  from employees
group by salary
order by  count(1) desc limit 1;

Create table dupes( Id int Primary KEY,
name varchar(19));
insert into dupes (id,name) value(2,'Maryam');
select * from dupes;

Create table dupess( Id int AUTO_INCREMENT Primary KEY,
name varchar(19));
insert into dupess (name) value('Maryam');
select * from dupess;

Create Table dupes1 (id integer, name varchar(10));

insert into dupes1 Values (1, 'frank');
insert into dupes1 Values (2, 'frank');
insert into dupes1 Values (3, 'robert');
insert into dupes1 Values (4, 'robert');
insert into dupes1 Values (5, 'sam');
insert into dupes1 Values (6, 'frank');
insert into dupes1 Values (7, 'petter');

select * from dupes1;
#consider the group of name  searching the for min for that group and output the name with min 
#it gib=ves min id in that group;
select  name ,Min(id)
from dupes1 
group by name;
# it groups and each group has its own id 
select * from dupes1 where id in (
select  Min(id)
from dupes1 
group by name);

#Deletig from table;????????????????HOW TO FIX THIS
delete from dupes1 
where id not in (
		select min_id from (
				select min(id) as min_id
				from dupes1 group by name)as t3);
Drop table dupes1;

#find out outlayer
SELECT round(avg(salary)) 
from employees 
where salary not in (
   (select max(salary) from employees)
 and 
   (select min(salary) from employees));
   


#who over paid or under paid

select first_name, salary,
if(salary >(select round(Avg(salary)) as average from employees),'over',if(salary<(select round(avg(salary)) as average from employees),'under',salary)) as paid_condition 
 from employees;
 
 select first_name , salary ,case when 
 salary >(select round(Avg(salary)) as average from employees) then 'over'
 when
 salary <(select round(Avg(salary)) as average from employees) then 'under'
else
'notpaid'
end as paid_condition
from employees;
 
 
select a.category ,count(*) from (Select 
					(case 
					  when salary<100000 then 'under paid'
					  when salary>100000 and salary<160000 then 'paid well'
					  when salary>160000 then 'executive'
					  else 'unpiad'
					end) as category
from employees)a group by category;


#Transpose the data turning rows to columns: converting a column to rows, using case , aggregation on case or case and extractin vlaue form other table,
 #using sum and case functin:
 select 
					(case 
					  when salary <100000 then 1
					end) as underpaid,
	
					(case
					  when salary>100000 and salary<160000 then 1
					end) as paidwell,
                    (case
                    when salary>160000 then 1
					end) as executive
					 
from employees
group by salary;

select sum(underpaid) as underpaid , sum(paidwell) as paidwell,sum(executive) as executive from (
 select 
					(case 
					  when salary <100000 then 1 else 0
					end) as underpaid,
	
					(case
					  when salary>100000 and salary<160000 then 1 else 0
					end) as paidwell,
                    (case
                    when salary>160000 then 1 
					end) as executive
					 
from employees
group by salary) as a;




select 
					(sum(case 
					  when salary <100000 then 1
					end)) as underpaid,
	
					(sum(case
					  when salary>100000 and salary<160000 then 1
					end)) as paidwell,
                  ( sum(case
                    when salary>160000 then 1
					end)) as executive
					 
from employees
group by salary;#?????????????? DOES NOT WORK AS EXPECTED?????????????

select count(case when department='Sport' then 1 else 0 end) as Sport,
       count(case when department ='Tools' then 1 end)as Tools,
	   count(case when department ='Clothing' then 1 end)as Clothing,
	   count(case when department ='Computers' then 1 end )as Computers
				
from employees;

select first_name , (case when region_id=1 then (select country from regions where region_id=1 ) end ) as region_1,
					(case when region_id=2 then (select country from regions where region_id=2 ) end ) as region_2,
					(case when region_id=3 then (select country from regions where region_id=3 ) end ) as region_3,
					(case when region_id=4 then (select country from regions where region_id=4 ) end ) as region_4,
					(case when region_id=5 then (select country from regions where region_id=5 ) end ) as region_5,
					(case when region_id=6 then (select country from regions where region_id=6 ) end ) as region_6,
					(case when region_id=7 then (select country from regions where region_id=7 ) end ) as region_7
					
					
from employees;


select count( case when region_id in (1,2,3) then 1 end) as "United States",
	   count( case when region_id in (4,5) then 1 end) as Asia ,
	   count( case when region_id in (6,7) then 1 end) as Canada 
					
from employees;
#OR
select count(a.region_1)+count(a.region_2)+count(a.region_3) as "United States" , 
	   count(a.region_4)+count(a.region_5) as Asia  ,
	   count(a.region_6)+count(a.region_7) as Canada
from(					
select first_name , case when region_id=1 then (select country from regions where region_id=1 ) end as region_1,
					case when region_id=2 then (select country from regions where region_id=2 ) end as region_2,
					case when region_id=3 then (select country from regions where region_id=3 ) end as region_3,
					case when region_id=4 then (select country from regions where region_id=4 ) end  as region_4,
					case when region_id=5 then (select country from regions where region_id=5 ) end  as region_5,
					case when region_id=6 then (select country from regions where region_id=6 ) end  as region_6,
					case when region_id=7 then (select country from regions where region_id=7 ) end as region_7
					
					
from employees) a;




select first_name, salary 
from employees e1
where salary >(select round(avg(salary)) from employees e2  where e1.department =e2.department group by department);

select department, count(employee_id) as number_of_employee from employees group by department having number_of_employee>35;

select department, (select count(employee_id) from employees a
				
					where a.department =b.department)
from employees b
where (select count(employee_id) from employees a
				
					where a.department =b.department)  > 38
				
                
group by department;


select count(employee_id) from employees a
				
					having count(employee_id)>38;

select department, (select count(employee_id) from employees a
				
					where count(employee_id)>38 )
from employees b    ;

#aggregation function on join table is like group searching
#QUARY: max salary in each department is how much 

select department , (select max(salary) as MAX_salary from employees where department =b.department) max_salary
 from employees b;
 # show the department with max salary above 15000
 
select department , (select max(salary) as MAX_salary from employees where department =b.department) max_salary
 from employees b where (select max(salary) as MAX_salary from employees where department =b.department)>15000 ;
 
 
 select * from(
select 	department, first_name, 
					case when salary = (select Max(salary)from employees b where a.department= b.department)	then Max(salary)
					when salary = (select min(salary)from employees b where a.department= b.department)	then min(salary)
					end salaryy,
					
					case when salary = (select Max(salary)from employees b where a.department= b.department)	then 'highpaid'
					when salary = (select min(salary)from employees b where a.department= b.department)	then 'lowpaid'
					end salary_in_department
					
   from employees a
   group by 	department, first_name, salary)d
where salaryy is not null
group by department,d.first_name,d.salaryy,d.salary_in_department ;

#JOIN:
select first_name , country from employees E, regions R
where E.region_id=R.region_id;

select first_name, email, e.department, region , division
from employees E, departments D, regions R
where e.department= d.department and e.region_id=r.region_id and email is not null;

#SYNTAX FOR JOIN: table1 a inner join table2 b  on a.column=b.column
# right join /left join/ cross join/ self join/
# for right outer join , left outer join , full outer join= union on left and right
#we should use left or right with where condition of inquality 
select first_name , division
 from employees E inner join departments D
on E.department=D.department;

select first_name, email, division,country
from 	employees  a inner join departments b
on 		a.department= b.department					
inner join regions d on 	a.region_id= d.region_id
where email is not null;

#full outer join
select a.first_name, a.email, division,country
from 	employees  a cross join departments b,			
 employees  s cross join regions d
where a.email is not null and
 a.department not in( b.department)
 and a.region_id not in(d.region_id);
 
 
 #Union Table --union remove duplicate 
#union all  does not remove duplicate 
#importent thing is colun shoul match and data types should match
select department from employees
union
select department from departments;

select department from employees
union all
select department from departments;



select  distinct department from employees
union all
select department from departments;
select  distinct department from employees
union all
select distinct department from departments;
# ******order by should be after last table in union


select  distinct department from employees
union all
select department from departments
order by department;


select distinct department from employees 
union all
select department from departments
union 
select country from regions; #it mixed all the vlue of departments
#and regions

#EXPECT MYSQL DOES NOT SUPPort 
/*select distinct department from employees 
except 
select department from departments ;*/


select a.department , first_name ,division  from employees , departments a;


select a.department , first_name ,division  
from employees Cross join  departments a;


(select first_name, department, hire_date, country
from employees a
left join 
regions b 
on a.region_id=b.region_id
where hire_date in (select min(hire_date) 
					from employees)
					
limit 1)					
union

select first_name, department, hire_date, country
from employees a
left join 
regions b 
on a.region_id=b.region_id
where hire_date in (select max(hire_date)
					from employees);



select hire_date, salary, (select sum(salary) as salary_pattern from employees e2
						  where  hire_date between e.hire_date-90 and e.hire_date)
from employees e
order by  hire_date;



select hire_date , salary, (select sum(salary) from employees b
where a.employee_id=b.employee_id ) from employees a group by employee_id;



#create view
create view v_employv_employeeiformationeeiformation as  
select hire_date, salary, (select sum(salary) as salary_pattern from employees e2
						  where  hire_date between e.hire_date-90 and e.hire_date)
from employees e
order by  hire_date;



/*------------------------------***window 
--instead of using corelated subquaries which
-- should be run for each record which is expensive
--we can use window function
--which is nothing but
--* agggregation function +over( partition by column name)
*/

# the subquary is as below
select  first_name, department,(
 select count(*) from employees E1 
 where E1.department=E2.department) commonemployee
 from employees E2 order by department;

#but with partition and window we can group a column based another column
select first_name, department , count(*) over(partition by department)
from employees;

#window function will run at the end of quary

# Framing is window function but with the order by clause and defining a range 
select  first_name, hire_date, 
sum(salary) over( order by hire_date range between
				unbounded preceding and current row) as running_total_of_salaries
				
from employees;
select  first_name, hire_date, 
sum(salary) over( order by hire_date )
from employees;#same result as above so by default it consider 
#the current row and consider the precinding rows

#what if we want have running total by the partition
#we can add partition and runnig total computed on each partion or group seperately
select  first_name, hire_date, salary,department,
sum(salary) over( partition by  department order by hire_date ) 
as running_total_of_salaries				
from employees;



select  first_name, hire_date, salary,
sum(salary) over( order by hire_date rows between
				1 preceding and current row) as running_total_of_salaries
				
from employees;

