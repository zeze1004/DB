-- ***상관 부속 질의
-- 외부 질의의 테이블에 별칭을 적용
-- 별칭이 부속 질의에 참조되어 연산
-- 외부 질의의 각 행에 대해 순차적으로 연산의 t/f를 검사


/* 예제) 자신이 속한 부서의 사원들의 평균 급여보다 많은 급여를 받는
		 사원들에 대해서, 이름, 부서, 번호, 급여를 검색해라 */
select empname, dno, empno, salary
from employee e -- 별칭 
-- 상관 부속 질의는 외부 질의에서 별칭 적용
where salary >
	(select avg(salary) from employee where dno = e.dno) -- 부속 질의에 별칭 전달

-- 예제) 사원 수가 2명 이상인 부서 이름을 검색하시오
-- 상관 부속 질의로 풀기
select deptname from department as d -- 그냥 d로 써도 ㄱㅊ
-- where 2 <= ('해당 부서의 사원 수')
where 2 <= (select count(*) from employee where d.deptno = dno)

select * from employee
select * from department  

-- 조인으로 풀기
-- 부서'별' <- 그룹핑: group by
select deptname from department d
join employee e
on d.deptno = e.dno
group by deptname -- dno gruop by 할 시 오류 -> group by한 집합만 select 가능
having count(*) >= 2

-- select절에 사용된 상관 부속 질의(where절 외에도 select 사용 가능)
-- 예) 사원 이름과 소속 부서의 이름
select e.empname, (select deptname from department where e.dno = deptno)
from employee e
-- select 구문에서 employee의 dno와 deptno 비교
-- 각 empname 튜플의 dno와 deptno(1,2,3,4) 비교

-- 조인절 이용
select empname, d.deptname from employee e
join department d
on e.dno = d.deptno


-- /*예제*/
-- 프로젝트를 수행하는 사원들의 평균 급여보다 급여를 적게 받는 사원들의 이름을 검색하시오
select empname from employee
where salary <
	(select avg(salary) from employee)
	-- 저체 평균 급여보다 적게 받는 사원들
	-- 프로젝트를 수행하는 사원들의 평균급여와 비교해야 함

-- 프로젝트 수행하는 사원들 평균 급여 구하기
select avg(salary)
from employee e
join emp_proj ep
on e.empno = ep.empno

-- 최종 구하기
select empname from employee
where salary <
	(select avg(salary)
	from employee e
	join emp_proj ep
	on e.empno = ep.empno)
	
select * from emp_proj
select * from project
select * from employee
select * from department

-- 부하직원이 2명 이상인 사원들의 이름을 검색하시오
-- 상관부속질의 이용
select empname from employee e -- 외부질의에 별칭 사용
where 2 <= 
	(select count(*) from employee 
	 where manager = e.empno)
	 -- 상관질의 


-- ***exists
-- 예제) 기획 부서에서 근무하는 사원들의 모든 정보를 검색하시오
-- join
select * from employee e
join department d
on e.dno = d.deptno
where d.deptname = '기획'

-- exists 이용한 상관부속질의
select * from employee e 
where exists	-- 비교구문이 없다, 상관부속질의 내에서 비교
	-- ex. where a < (select b from ...) 이런 식으로 비교하는데
	-- exists는 상관부속질의 내 비교만 맞으면 출력
	(select  * from department 
	where deptno = e.dno
	and deptname = '기획')
-- employee 튜플의 dno 선택 
-- 그 후 상관부속질의의 실행 department 테이블의 deptno를 하나씩 비교
-- 같은 deptno를 찾으면 '기획' deptname인지 비교
-- 맞으면 exists가 true 반환해서 출력

-- 예제) 소속직원이 하나도 없는 부서번화와 부서명을 검색 
select deptno, deptname
from department d
where not exists
	(select * from employee where d.deptno = dno)
