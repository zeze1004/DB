-- INSERT, DELETE, UPDATE
-- 1. INSERT

-- insert into 테이블이름 values(값들...)
-- insert into 테이블이름(칼럼들) values(각 컬럼에 대응되는 값들...)

insert into department values(5, '홍보', 3)
insert into department(deptno, deptname) values(6, '연구')
insert into department values(6, '해외개발', 3) --  기본키 중복돼서 오류

select * from department

create table department2
(
	deptno int primary key,
	deptname char(10) unique,
	floor int not null
)
select * from department2
insert into department(deptno, deptname) values(6, '연구') -- floor가 not null어서 오류

drop table department2 cascade

-- 예제) employee 테이블에 급여가 3500000 이상인 사원들의
--		 이름, 직급, 급여를 검색하여
--		 high_salary라는 테이블에 추가하시오

-- 먼저 high_salary 조건 만들기
create table high_salary
(
	name char(10) unique,
	title char(10) default '사원',
	salary int check(salary < 60000000) -- 조건: 6백만원을 넘어서는 안된다
)
insert into high_salary(name, title, salary)
select empname, title, salary
from employee
where salary >= 3500000

select * from high_salary

-- 2. DELETE
-- delete from 테이블 이름 (where)
delete from high_salary
delete from department where deptno >4
select * from department

--3. UPDATE
-- UPDATE 테이블 이름 SET 컬럼이름 = 업데이트 값 (WHERE)
-- 총무부를 연구부로 이름 변경
update department set deptname = '연구' where deptname = '총무'
select * from department

-- 테이블에 컬럼 추가(수정)
alter table high_salary add column sla_raise int
select * from high_salary
update high_salary set sal_raise = 1.1*salary

-- 예제) 1번 부서에서 근무하는 홍길동 대리 월급은 250만원 추가
insert into employee values(5001, '홍길동', '대리', null, 2500000, 1)

-- 예제) 사원 테이블에 정수형 타입의 보너스 컬럼 추가
alter table employee add column bonus int

-- 예제) 프로젝트를 수행하고 있는 사원들은 프로젝트 갯수 * 월급의 20% 만큼 보너스를 책정하시오
-- 1. 프로젝트 수행하는 사원들 구하기
select *
from employee e
join emp_proj ep
on e.empno = ep.empno

-- 2. 사원들의 프로젝트 수행 개수 구하기
select e.empno, count(*) 
from employee e
join emp_proj ep
on e.empno = ep.empno
group by e.empno

-- 3. 보너스 업데이트(조인 이용)
update employee e
set bonus = num_prj * 0.2 * e.salary
from (select e.empno, count(*) as num_prj
	from employee e
	join emp_proj ep
	on e.empno = ep.empno
	group by e.empno) e2
where e.empno = e2.empno


