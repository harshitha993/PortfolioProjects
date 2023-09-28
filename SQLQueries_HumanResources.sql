create database SAM 
use sam; 

select * from studies
select * from software
select * from programmer

--1. Find out the selling cost AVG for packages developed in Pascal. 
select AVG(scost) from software as A_Sc 
where developin='PASCAL'

--2. Display Names, Ages of all Programmers. 
select pname, year(getdate())-year(DOB) As age from PROGRAMMER

--3. Display the Names of those who have done the DAP Course. 
select pname, COURSE as Name from STUDIES where course = 'DAP'

--4. Display the Names and Date of Births of all Programmers Born in January. 
select pname as Name, DOB, Datename(MOnth,DOB)Month from PROGRAMMER where datename(Month,DOB)='January' 

--5. What is the Highest Number of copies sold by a Package? 
select max(sold) from SOFTWARE

--6. Display lowest course Fee. 
select min(Course_Fee) from STUDIES

--7. How many programmers done the PGDCA Course? 
Select count(Pname) from STUDIES where course='pgdca'

--8. How much revenue has been earned thru sales of Packages Developed in C.
Select sum(Sold*SCost) As Revenue from Software where DEVELOPIN= 'c'

--9. Display the Details of the Software Developed by Ramesh. 
select * from SOFTWARE where pname= 'Ramesh'

--10. How many Programmers Studied at Sabhari? 
Select count(pname) from STUDIES where INSTITUTE='sabhari'

--11. Display details of Packages whose sales crossed the 2000 Mark. 
select * from SOFTWARE where (SOLD*SCOST)>2000

--12. Display the Details of Packages for which Development Cost have been recovered.
select * from SOFTWARE where (SCOST*SOLD)> DCOST

--13. What is the cost of the costliest software development in Basic? 
select max(DCOST) As Costliest from SOFTWARE where DEVELOPIN='basic'

--14. How many Packages Developed in DBASE? 
Select count(title) As Total from SOFTWARE where DEVELOPIN='Dbase' 

--15. How many programmers studied in Pragathi? 
Select count(pname) from STUDIES where INSTITUTE='Pragathi'

--16. How many Programmers Paid 5000 to 10000 for their course? 
select count(pname) as Number from STUDIES where COURSE_FEE>= 5000 and COURSE_FEE<= 10000

select count(pname) as Number from STUDIES where COURSE_FEE between 5000 and 10000

--17. What is AVG Course Fee 
select avg(course_fee) as AFee from STUDIES

--18. Display the details of the Programmers Knowing C.
Select * from PROGRAMMER where PROF1='c' or PROF2='c'

--19. How many Programmers know either COBOL or PASCAL. 
Select * from PROGRAMMER where PROF1 in ('cobol','PASCAL') or PROF2 in ('cobol','PASCAL')

--20. How many Programmers Don’t know PASCAL and C 
Select * from PROGRAMMER where PROF1 not in ('C','PASCAL') and PROF2 not in ('C','PASCAL')

--21. How old is the Oldest Male Programmer. 
Select max(year(getdate())-year(DOB)) as Age from programmer where Gender='M'

--22. What is the AVG age of Female Programmers? 
Select avg(year(getdate())-year(DOB)) as Age from programmer where Gender='F'

--23. Calculate the Experience in Years for each Programmer and Display with their names in Descending order. 
Select PName As Name,year(getdate())-year(DOJ)As'Exp'from Programmer Order by PNAME Desc

--24. Who are the Programmers who celebrate their Birthday’s During the Current Month? 
SELECT DATEPART(month, DOB) AS DatePartInt from PROGRAMMER where DATEPART(month, DOB) = 4

--25. How many Female Programmers are there? 
Select count(pName) as'No F Programmers'from Programmer where GENDER='F'

--26. What are the Languages studied by Male Programmers. 
Select distinct Prof1 as Lang from PROGRAMMER where Gender='M'
Union 
Select distinct PROF2 as Lang from PROGRAMMER where Gender='M'

select pname, prof1, prof2 from PROGRAMMER where gender = 'm'

--27. What is the AVG Salary? 
Select Avg(Salary) As Avg_Salary from Programmer

--28. How many people draw salary 2000 to 4000? 
select count(Pname) As People from PROGRAMMER where salary between 2000 and 4000

--29. Display the details of those who don’t know Clipper, COBOL or PASCAL. 
Select * from PROGRAMMER where PROF1 not in ('Clipper', 'COBOL','PASCAL') and PROF2 not in ('Clipper', 'COBOL','PASCAL')

--30. Display the Cost of Package Developed By each Programmer. 
Select PNAME, Sum(SCOST) as Package_Cost From Software group by PNAME

--31. Display the sales values of the Packages Developed by the each Programmer. 
Select PNAME, (SCOST*SOLD) as Sales From SOFTWARE

--32. Display the Number of Packages sold by Each Programmer. 
Select pname, Sum(Sold) as Packages_Sold From Software Group by PNAME

--33. Display the sales cost of the packages Developed by each Programmer Language wise. 
Select DEVELOPIN, SUM(SCOST*SOLD) as Sales_Cost From Software Group by DEVELOPIN

--34. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy. 
Select DEVELOPIN, Avg(DCOST) as AVG_DCOST, AVG(SCOST) as AVG_SCOST, AVG(SCOST) as AVG_PRICE From Software Group by DEVELOPIN

--35. Display each programmer’s name, costliest and cheapest Packages Developed by him or her. 
Select PNAME, max(DCOST) as Max_Cost, min(SCOST) as Min_Cost From Software Group by PNAME

--36. Display each institute name with number of Courses, Average Cost per Course. 
Select INSTITUTE, Count(course) as No_Courses, AVG(COURSE_FEE) as Avg_Fee From STUDIES group by INSTITUTE

--37. Display each institute Name with Number of Students. 
Select INSTITUTE, Count(PNAME) as No_Students From STUDIES group by INSTITUTE

--38. Display Names of Male and Female Programmers. Gender also. 
Select PNAME, GENDER From PROGRAMMER

--39. Display the Name of Programmers and Their Packages. 
Select PNAME, Salary From PROGRAMMER

--40. Display the Number of Packages in Each Language Except C and C++. 
Select DEVELOPIN, Count(Title) as No_Packges From Software group by DEVELOPIN Having DEVELOPIN <>'C' and DEVELOPIN <> 'C++'

--41. Display the Number of Packages in Each Language for which Development Cost is less than 1000.
Select DEVELOPIN,COUNT(Title) as No_Packges From Software where dcost <1000 Group by DEVELOPIN

--42. Display AVG Difference between SCOST, DCOST for Each Package. 
Select Title, (Avg(Dcost)-Avg(Scost)) as Avg_Diff From Software group by TITLE

--43. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered. 
Select * From
		(
		Select PNAME, Scost, Dcost, (Scost*Sold)-Dcost as Cost
		From Software
		) as x
		Where Cost < 0

--44. Display Highest, Lowest and Average Salaries for those earning more than 2000. 
Select max(salary) as Max_S,min(salary) as Min_S, avg(salary) as Avg_Salary From PROGRAMMER where SALARY > 2000 

--45. Who is the Highest Paid C Programmers? 
	Select * from PROGRAMMER
		Where Salary = (Select max(salary)
		       from PROGRAMMER 
			   where PROF1 = 'C'
			      or PROF2 = 'C')

--46. Who is the Highest Paid Female COBOL Programmer? 

Select * From PROGRAMMER
		where SALARY = (select max(salary)
						from PROGRAMMER
						where (PROF1='COBOL'
						or Prof2='COBOL'))
						And GENDER = 'F'

--47. Display the names of the highest paid programmers for each Language. 
;With CTC (Pname, Prof, Salary)
as 
(Select PNAME, PROF1 as PROF, SALARY
from PROGRAMMER
Union
Select PNAME, PROF2, SALARY
from PROGRAMMER)

Select P1.PNAME, P1.PROF, P1.SALARY from CTC as P1
left join CTC as P2 on P1.PROF=P2.PROF and P1.SALARY < P2.SALARY
where P2.PNAME is null;

--48. Who is the least experienced Programmer. 
Select * From (Select min(DATEDIFF(year,DOJ,getdate())) AS LEAST_EXP From PROGRAMMER) AS EXPE

--49. Who is the most experienced male programmer knowing PASCAL. 
Select max(DATEDIFF(year,DOJ,getdate())) as Expe_M From PROGRAMMER where PROF1 = 'Pascal' or PROF2 = 'Pascal' And Gender = 'M'

--50. Which Language is known by only one Programmer?
;With CTE(pname,Prof)
		as
		(Select Pname, Prof1 as Prof
		From PROGRAMMER
		union
		Select pname, prof2
		from programmer)

		Select Prof
		from CTE
		group by Prof
		having Count(prof) = 1

--51. Who is the Above Programmer Referred in 50? 
Create Table T1
			(Prof varchar(30)
			)

			Select * From T1

			Insert into T1
			Select prof1 from PROGRAMMER
			group by PROF1
			having PROF1 not in(select Prof2 from PROGRAMMER)
			and count(prof1) = 1
			union 
			Select PROF2 from PROGRAMMER
			group by PROF2
			having PROF2 not in(select PROF1 from PROGRAMMER)
			and count(PROF2) = 1
	
			Select Pname, prof from PROGRAMMER
			Inner join T1 on prof=prof1 or prof=prof2

--52. Who is the Youngest Programmer knowing DBASE? 
SELECT pname, prof1, prof2, datediff(YEAR, dob, getdate()) as age
		from programmer 
		where dob = (SELECT max(dob) from programmer where prof1='dbase' or prof2='dbase');

--53. Which Female Programmer earning more than 3000 does not know C, C++, ORACLE or DBASE? 
Select * from PROGRAMMER
		where gender = 'F'
			and Salary >3000
			and PROF1 <> 'c' 
			and PROF1 <>'c++'
			and PROF1 <>'oracle'
			and PROF1<>'dbase'
			and PROF2 <> 'c' 
			and PROF2 <>'c++'
			and PROF2 <>'oracle'
			and PROF2<>'dbase'

--54. Which Institute has most number of Students? 
Select top 1 INSTITUTE, count(pname) as Max_Stu From STUDIES group by INSTITUTE	order by Count(pname) desc

--55. What is the Costliest course? 
Select * From STUDIES where COURSE_FEE= (Select max(Course_fee) From STUDIES)

--56. Which course has been done by the most of the Students? 
Select Top 2 COURSE , Count(COURSE) as Popular_C From STUDIES group by COURSE order by Popular_C desc

--57. Which Institute conducts costliest course. 
Select Top 1 INSTITUTE, Max(course_fee) as M_Fee From STUDIES Group by INSTITUTE order by M_Fee desc

--58. Display the name of the Institute and Course, which has below AVG course fee. 
Select INSTITUTE, COURSE from STUDIES where COURSE_FEE < (select avg(COURSE_FEE) from STUDIES)

--59. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee
Select COURSE
		From Studies
		where COURSE_FEE < (Select AVG(course_fee)+1000 from STUDIES)
						AND Course_fee > (Select AVG(Course_fee)-1000 from STUDIES)

--60. Which package has the Highest Development cost? 
Select Title, DCOST from Software where DCOST = (Select Max(DCOST) From Software)

--61. Which course has below AVG number of Students? 
Create table A_Count (CRS varchar(30), Cnt INT)

INSERT INTO A_Count(CRS,CNT)

Select COURSE, count(PNAME) as Course_Count From STUDIES group by COURSE
Select CRS, CNT from A_Count where Cnt <= (select avg(cnt) from A_Count)

Select * from A_Count
Drop table A_Count

--62. Which Package has the lowest selling cost? 
Select TITLE, Scost From Software where scost = (select min(scost) from Software)


--63. Who Developed the Package that has sold the least number of copies? 
Select PNAME, TITLE, SOLD from Software where SOLD = (select min(sold) from Software)

--64. Which language has used to develop the package, which has the highest sales amount? 
	Select * From 
		( Select *, Scost as Sell
			from Software) as T1
		where Sell = (select max(scost) from Software)

--65. How many copies of package that has the least difference between development and selling cost where sold. 
Select Title,SOLD as C from Software
where title = (select title from Software
Where (DCOST-SCOST) = (Select min(DCOST-SCOST) from Software))

--66. Which is the costliest package developed in PASCAL. 
Select TITLE, DEVELOPIN	From Software Where DCOST = (select max(DCOST) from software where DEVELOPIN = 'Pascal')

--67. Which language was used to develop the most number of Packages. 
Select top 1 DEVELOPIN, Count(TITLE) as M_Lang From SOFTWARE group by DEVELOPIN	order by M_Lang desc

--68. Which programmer has developed the highest number of Packages? 
Select PNAME From SOFTWARE group by PNAME having PNAME = (Select Max(PNAME) from SOFTWARE)

--69. Who is the Author of the Costliest Package?
Select PNAME, DCOST	From SOFTWARE where DCOST = (Select max(DCOST) from SOFTWARE)

--70. Display the names of the packages, which have sold less than the AVG number of copies. 
Select TITLE From Software where sold < (select avg(sold) from Software)

--71. Who are the authors of the Packages, which have recovered more than double the Development cost? 
Select distinct PNAME From Software	where 2*DCOST>=Scost*Sold

--72. Display the programmer Name and the cheapest packages developed by them ineach language. 
Select Pname, TITLE	from Software where dcost in (select min(dcost) from Software group by DEVELOPIN)

--73. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package. 
Select DEVELOPIN, PNAME	From Software where SOLD in (Select max(SOLD) from Software group by pname)
		union
Select DEVELOPIN, PNAME From Software where SOLD in (Select min(SOLD) from Software group by pname)

--74. Who is the youngest male Programmer born in 1965? 
Select Pname, datepart(year,DOB) as Yearofbirth, GENDER, DATEDIFF(year,dob,getdate()) as age
		from PROGRAMMER
		where datepart(year,DOB) = '1965' and GENDER = 'M'

--75. Who is the oldest Female Programmer who joined in 1992?
Select Pname, datepart(year,DOB) as Yearofbirth, GENDER, DATEDIFF(year,dob,getdate()) as age
		from PROGRAMMER
		where datepart(year,DOB) = '1965' and GENDER = 'F'

--76. In which year was the most number of Programmers born.
Create Table M_Year(YOB int, CNT int)
Insert into M_Year

select year(DOB), count(pname) from PROGRAMMER
	group by year(dob)

Select * from M_Year

Select YOB,CNT from M_Year where cnt = (select max(cnt) from M_Year)

Drop table M_Year

--77. In which month did most number of programmers join? 

create table Join_Month(monthP int,cnt int)
insert into Join_Month
select month(DOJ), count(pname) from PROGRAMMER
group by Month(DOJ)
		
Select * from Join_Month
Select Monthp,CNT from Join_Month
where CNT in (select max(cnt) from Join_Month)

Drop table Join_Month

--78. In which language are most of the programmer’s proficient. 

create table Proff(prof varchar(20),cnt int)
insert into Proff(prof,cnt)

select Prof1,count(pname) from PROGRAMMER group by PROF1
		union all
select Prof2,count(pname) from PROGRAMMER group by PROF2
Drop table proff2
Select * from Proff

Create table proff2(pro varchar(20),cn int)
Insert into proff2 (pro,cn)
Select prof,sum(cnt) from Proff
group by prof

Select * from Proff
Select * from Proff2
Where CN = (select max(CN) from Proff2)

Drop table proff2

--79. Who are the male programmers earning below the AVG salary ofFemale Programmers? 
Select PNAME, GENDER From PROGRAMMER where SALARY < (select avg(salary) from PROGRAMMER
						where GENDER='F')
						And GENDER='m'

--80. Who are the Female Programmers earning more than the Highest Paid? 
Select PNAME, SALARY From PROGRAMMER where SALARY >= (select max(salary) from PROGRAMMER
						where GENDER ='m')
						And GENDER = 'F'

--81. Which language has been stated as the proficiency by most of the Programmers? 
Select prof1
		From PROGRAMMER
		Group by prof1
		Having prof1 = (Select max(prof1) From PROGRAMMER)
		Union
		Select Prof2
		From PROGRAMMER
		Group by PROF2
		Having PROF2 = (Select max(PROF2) From PROGRAMMER)

--82. Display the details of those who are drawing the same salary. 
Select * From PROGRAMMER where SALARY in (Select SALARY from PROGRAMMER	group by SALARY	having count(SALARY)>1);

--83. Display the details of the Software Developed by the Male Programmers Earning More than 3000/-. 
Select * from PROGRAMMER p, Software s	where p.pname = s.pname and salary > 3000 and gender = 'M'

--84. Display the details of the packages developed in Pascal by the Female Programmers. 
Select s.* From Software s, PROGRAMMER p where s.pname = p.pname and DEVELOPIN = 'PAscal' and gender = 'F'

--85. Display the details of the Programmers who joined before 1990. 
Select *From PROGRAMMER	where year(DOJ)<1990

--86. Display the details of the Software Developed in C By female programmers ofPragathi. 
Select s.*	From Software s,STUDIES st,PROGRAMMER p	where S.pname = st.pname and p.pname = s.pname and Gender = 'F' and INSTITUTE ='pragathi'

--87. Display the number of packages, No. of Copies Sold and sales value ofeach programmer institute wise. 
Select p.INSTITUTE, count(s.DEVELOPIN) as Developin,count(s.sold) as Sold, Sum(s.sold*s.scost) as Sales From STUDIES p, Software s  where p.pname = s.PNAME group by p.INSTITUTE
		
--88. Display the details of the software developed in DBASE by Male Programmers, who belong to the institute in which most number of Programmers studied. 

Create Table INST(ins varchar(30), CNT int)

Insert into INST

Select institute, count(pname) from STUDIES
Group by Institute
		
Select * from INST

Select distinct sw.*
From PROGRAMMER p, STUDIES s, Software sw, INST
Where DEVELOPIN = 'DBASE' and gender = 'M' and SW.pname = P.pname
	and INSTITUTE = INS and CNT = (Select max(CNT) from INST)

Drop Table INST

--89. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975. 
Select s.*,Year(p.DOB), GENDER From Software s, PROGRAMMER p where s.pname=p.pname and ((GENDER='M' AND YEAR(DOB)<1965) OR (GENDER='F' AND YEAR(DOB)>1975))

--90. Display the details of the software that has developed in the language which is neither the first nor the second proficiency of the programmers
Select s.*From PROGRAMMER p, Software s where p.pname=s.pname and p.PROF1<>s.DEVELOPIN and p.prof2<>s.DEVELOPIN

--91. Display the details of the software developed by the male students of Sabhari. 
Select s.*From Software s, STUDIES ST, PROGRAMMER P	where s.PNAME = ST.PNAME and p.pname = s.pname and gender = 'M' and st.INSTITUTE ='Sabhari' 

--92. Display the names of the programmers who have not developed any packages. 
Select PNAME From PROGRAMMER where pname not in (Select Pname from Software)

--93. What is the total cost of the Software developed by the programmers of Apple? 
Select Sum(Scost) as Total_Cost	from Software s, STUDIES st	where s.PNAME = st.PNAME and st.INSTITUTE = 'APPLE'

--94. Who are the programmers who joined on the same day? 
Select A.Pname,A.DOJ From PROGRAMMER A, PROGRAMMER B where a.doj = b.doj and A.pname<>b.pname

--95. Who are the programmers who have the same Prof2? 
Select Distinct(a.Pname), a. PROF2 From PROGRAMMER a, PROGRAMMER b
		where a.PROF1 = b.PROF2 and a.pname <> b.pname

--96. Display the total sales value of the software, institute wise. 
Select St.institute, Sum(s.sold*s.SCOST) as Total_Sales_Value from STUDIES st, Software s Where st.pname = S.PNAME group by st.INSTITUTE

--97. In which institute does the person who developed the costliest package studied. 
Select INSTITUTE From STUDIES st, Software s where st.pname = s.pname and DCOST = (Select Max(DCOST) from Software) group by INSTITUTE

--98. Which language listed in prof1, prof2 has not been used to develop any package. 
Select Prof1 from PROGRAMMER where PROF1 not in (select developin from Software)
Union
Select Prof2 from PROGRAMMER where PROF2 not in (select developin from Software)

--99. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo. 
Select p.Pname, p.Salary,st.COURSE From PROGRAMMER p, STUDIES St Where p.pname =st.pname and p.Salary = (Select max(Salary) from PROGRAMMER)

--100. What is the AVG salary for those whose software sales is more than 50,000/-. 
Select AVG(Salary) as Avg_Sal from Software s, PROGRAMMER p where s.pname = P.pname and SCOST*SOLD>50000;

--101. How many packages were developed by students, who studied in institute that charge the lowest course fee? 
Select s.pname, Count(title) as Packages From STUDIES st, Software s Where st.pname = s.pname and COURSE_FEE = (select min(course_fee) from STUDIES)
		Group by S.pname, Course_fee

--102. How many packages were developed by the person who developed the cheapest package, where did HE/SHE study? 
Select Count(DEVELOPIN) as package From PROGRAMMER s, Software P 
where S.pname = p.pname --and DCOST = (select min(DCOST) From Software)
	Group by DEVELOPIN
	having min(dcost)=(select min(dcost) from software)

--103. How many packages were developed by the female programmers earning more than the highest paid male programmer? 
Select Count(DEVELOPIN) From Software s, PROGRAMMER p
	where s.pname = p.pname and  gender = 'F' and Salary>(select max(salary) from PROGRAMMER where gender = 'M')

--104. How many packages are developed by the most experienced programmer form BDPS. 
select count(*) as Countp from software s,programmer p
where p.pname=s.pname group by doj having min(doj)=(select min(doj)
from studies st,programmer p, software s
where p.pname=s.pname and st.pname=p.pname and (institute='bdps'));

--105. List the programmers (form the software table) and the institutes they studied. 
Select PNAME, institute	from STUDIES where pname not in (Select pname from Software)

--106. List each PROF with the number of Programmers having that PROF and the number of the packages in that PROF. 
Select count(*),sum(scost*sold-dcost) "PROFIT" 
from software
where developin in (select distinct(prof1) from programmer
union
select distinct(PROF2) from programmer)
group by developin;

--107. List the programmer names (from the programmer table) and No. Of Packages each has developed.
Select P.pname, count(developin) as Developin From PROGRAMMER p, Software s
where S.pname = P.pname group by p.pname