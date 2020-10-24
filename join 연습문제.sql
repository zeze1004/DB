예1)
select * 
from department d
cross join employee e

예2) 
select d.deptname, e.empname
from department d 
left join employee e 
on d.deptno = e.dno 

예3)
select d.deptname, e.empname
from department d
join employee e 
on d.deptno = e.dno 
where d.deptname = '개발'

예4) 
select d.deptname, e.empname, e.title, e.salary
from department d
join employee e 
on d.deptno = e.dno 
order by d.deptname, e.salary desc

예5) -- 셀프조인
select e1.empno, e1.empname, e2.empno, e2.empname, e1.title
from employee e1
join employee e2
on e1.title = e2.title
where e1.empno != e2.empno -- 하나 밖에 없는 이사 직급은 출력 되지 않음
-- order by e1.salary desc	-- 높은 직급부터 출려되도록 

예6)
select d.deptno, d.deptname, e.empname, e.title
from department d
left join employee e  -- 모든 부서를 출력
on d.deptno = e.dno 

예7)
select d.deptno, d.deptname, e.empname, e.title
from department d
right join employee e  -- 모든 사원을 출력
on d.deptno = e.dno 

예8)
select d.deptno, d.deptname, e.empname, e.title
from department d
full join employee e  -- 모든 부서, 사원을 출력
on d.deptno = e.dno

예9)
select e1.empname, e1.title, e2.empname, e2.title
from employee e1
left join employee e2
on e1.empno = e2.manager

예10)
select e2.empname, e2.title, e1.empname, e1.title
from employee e1
right join employee e2
on e1.empno = e2.manager

예11)
select e1.empname, e1.title, e2.empname, e2.title
from employee e1
full join employee e2
on e1.empno = e2.manager
