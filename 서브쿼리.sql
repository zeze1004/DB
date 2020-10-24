-- ***서브쿼리
-- 예) 조민희 사원의 직급과 같은 직급의 사원들이 근무하는 부서 이름 검색
-- 1. 조민희 사원의 직급 찾기
select title
from employee
where empname = '조민희'

-- 2. 조민희 사원의 직급과 같은 직급의 사원들의 부서 검색
select dno
from employee
where title = 
(select title from employee where empname = '조민희')			  
			  
-- 3. 조민희 사원의 직급과 같은 직급의 사원들이 근무하는 부서 이름 검색
select deptname
from department
where deptno in -- 반환값이 집합(컬럼)값이므로 = 이 아닌 in
	(select dno from employee where title = 
		(select title from employee where empname = '조민희'))
