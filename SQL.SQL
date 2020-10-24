
-- DEPARTMENT 테이블 생성
CREATE TABLE DEPARTMENT2 (
	-- 컬림이름 타입
	DEPTNO		INT	NOT NULL, -- not null: 비울 수 없다
	DEPTNAME	CHAR(10),
	FLOOR		INT, -- floor라는 함수가 있어서 색 칠해진 것 뿐
	PRIMARY KEY(DEPTNO)
);

drop table department2
-- DEPARTMENT 테이블에 투플 추가
INSERT INTO DEPARTMENT2 VALUES(1, '영업', 8);
INSERT INTO DEPARTMENT2 VALUES(2, '기획', 10);
INSERT INTO DEPARTMENT2 VALUES(3, '개발', 9);
INSERT INTO DEPARTMENT2 VALUES(4, '총무', 7);

/*
	1. emp 테이블 생성
	2. 자체 기본크릴 참조하는 조건 생성
	3. emp 데이터 삽입
	
	INSERT INTO EMPLOYEE VALUES(4377, '이성래', '이사', NULL, 5000000, 2);
	INSERT INTO EMPLOYEE VALUES(3426, '박영권', '과장', 4377, 3000000, 1);
	INSERT INTO EMPLOYEE VALUES(3011, '이수민', '부장', 4377, 4000000, 3);
	INSERT INTO EMPLOYEE VALUES(3427, '최종철', '사원', 3011, 1500000, 3);
	INSERT INTO EMPLOYEE VALUES(1003, '조민희', '과장', 4377, 3000000, 2);
	INSERT INTO EMPLOYEE VALUES(2106, '김창섭', '대리', 1003, 2500000, 2);
	INSERT INTO EMPLOYEE VALUES(1365, '김상원', '사원', 3426, 1500000, 1);
	
	1->2->3 가능
	1->3->2 
*/


-- EMPLOYEE 테이블 생성
-- 테이블 생성하기
-- create table 테이블 이름 (컬럼이름 컬럼타입(ex.int) 조건(ex.not null),...,기본기(컬럼));
CREATE TABLE EMPLOYEE (
	EMPNO	INT	NOT NULL,
	EMPNAME	CHAR(10)	UNIQUE,			-- unique 값
	TITLE	CHAR(10)	DEFAULT '사원',	-- 기본값
	MANAGER	INT,
	SALARY	INT	CHECK (SALARY < 6000000),	-- 월급은 600만원 미만
	DNO		INT,
	PRIMARY KEY(EMPNO)
);

-- MANAGER가 자체 테이블의 EMPNO를 참조하는 외래키 제약조건
-- MANAGER는 자신의 직속 상관이 누구인지를 나타냄
-- ALTER: TABLE 테이블 수정 
-- EMPLOYEE 테이블에 제약조건(CONSTRAINT) 추가(제약 조건의 이름이 FK_MANAGER)
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_MANAGER		
    -- MANAGER가 외래키라는 뜻
	-- EMPLOYEE의 EMPNO 컬럼을 참조하는 외래키
	FOREIGN KEY (MANAGER) REFERENCES EMPLOYEE (EMPNO);	-- 외래키의 3가지 용법: 1. 다른 릴레이션 참조 2. 자체 릴레이션 참조 3. 두 개의 외래키가 키를 이룸
	
-- DNO가 DEPARTMENT 테이블의 기본키 DEPTNO를 참조하는 외래키 제약조건
-- DEPTNO의 변경시 DNO에도 파급(CASCADE)되어 업데이트한다.
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_DNO 
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT (DEPTNO) -- DEPTNO는 DEPARTMENT의 기본키
	ON UPDATE CASCADE;		-- CASCADE: 연쇄 Ex. 1번부서를 4번 부서로 바꿀 때 참조된 외래키도 연쇄적으로 변경
								-- 		dno를 참조한 다른 테이블도 변경

-- EMPLOYEE 테이블에 투플 추가
-- create table한 순서대로 컬럼 추가, 원하는 컬럼만 추가 가능
INSERT INTO EMPLOYEE2 VALUES(4377, '이성래', '이사', NULL, 5000000, 2);
INSERT INTO EMPLOYEE2 VALUES(3426, '박영권', '과장', 4377, 3000000, 1);
INSERT INTO EMPLOYEE2 VALUES(3011, '이수민', '부장', 4377, 4000000, 3);
INSERT INTO EMPLOYEE2 VALUES(3427, '최종철', '사원', 3011, 1500000, 3);
INSERT INTO EMPLOYEE2 VALUES(1003, '조민희', '과장', 4377, 3000000, 2);
INSERT INTO EMPLOYEE2 VALUES(2106, '김창섭', '대리', 1003, 2500000, 2);
INSERT INTO EMPLOYEE2 VALUES(1365, '김상원', '사원', 3426, 1500000, 1);

insert into DEPARTMENT(deptno, deptname) values(5, '홍보')
delete from DEPARTMENT where deptname = '홍보'
-- PROJECT 테이블 생성
CREATE TABLE PROJECT (
	PRJNO		INT	NOT NULL,
	PRJNAME	CHAR(10),
	PRIMARY KEY(PRJNO)
);

-- EMP_PROJ 테이블 생성, 어떤 사원이 어떤 프로젝트를 하는지
CREATE TABLE EMP_PROJ (
	EMPNO		INT 	NOT NULL,
	PRJNO		INT	NOT NULL,
	PRIMARY KEY(EMPNO, PRJNO)	-- EMPNO, PRJNO 쌍이 기본키가 된다. 기본키는 null(X)
);

-- EMP_PROJ의 EMPNO는 EMPLOYEE의 EMPNO를 참조한다.
ALTER TABLE EMP_PROJ ADD CONSTRAINT FK_EMPNO 
	FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE (EMPNO);

-- EMP_PROJ의 PRJNO는 PROJECT의 PRJNO를 참조한다.
ALTER TABLE EMP_PROJ ADD CONSTRAINT FK_PRJNO 
	FOREIGN KEY (PRJNO) REFERENCES PROJECT (PRJNO);

-- PROJECT 릴레이션에 투플 추가
-- 이 때는 참조되는 릴레이션부터 채워야 한다.
INSERT INTO PROJECT VALUES (100, 'A');
INSERT INTO PROJECT VALUES (200, 'B');
INSERT INTO PROJECT VALUES (300, 'C');

-- EMP_PROJ 릴레이션에 투플 추가
INSERT INTO EMP_PROJ VALUES (2106, 200);
INSERT INTO EMP_PROJ VALUES (3426, 200);
INSERT INTO EMP_PROJ VALUES (2106, 300);
INSERT INTO EMP_PROJ VALUES (1003, 300);

SELECT * FROM DEPARTMENT; 
SELECT * FROM EMPLOYEE; 
SELECT * FROM EMP_PROJ;
SELECT * FROM PROJECT;
-- 파이: 특정 컬럼(어트리뷰션)만 선택
-- 실렉션: 조건에 맞는 튜플(어트리뷰션)만 선택
-- SELECT '파이(프로젝션)' FROM DEPARTMENT WHERE(조건문) '셀렉션'

-- EX. 월급이 300만원 이산인 직원들의 이름을 보여라
-- : 파이 employee(셀렉션 salary >= 300 (enpname)) <= 관계대수 연산
SELECT empname FROM EMPLOYEE WHERE SALARY >= 3000000 

-- ex. 직원들의 평균 월급
select avg(salary) from employee

-- ex. 직급별 사원 수
select title, count(*) as "직급별 사원 수" from employee group by title

-- ******자연조인

-- 모든 결과가 나옴(중복): 동등조인
select * from DEPARTMENT d
join EMPLOYEE e
on d.deptno = e.dno; -- 하나의 구문이 끝나면 ; 붙이기 습관 들이기

-- 자연조인(조인에 참여한 중복 어트리뷰트 삭제) <- 일일이 자연조인 하기에 기찮아서 동등조인 주로 함
select e.*, d.deptname, d.floor from DEPARTMENT d
join EMPLOYEE e
on d.deptno = e.dno;

select * 
from department d
join employee e on d.deptno = e.dno
join emp_proj ep on e.empno = ep.prjno
join project p on ep.prjno = p.prjno;

create table mytable (
	col1 int not null primary key,
	col2 text default 'hi',
	col3 int check (col3 in (1,2,3)) -- 도메인 영역에 벗어났는지 check
	col4 int,
	foreign key (col4) references employee (empno)
);
insert into mytable(col1, col3) values (2 , 2)
select * from mytable;
drop table mytable;

-- on delete restrict **********************
-- 자식 릴레이션에서 참조하고 있기 때문에, 부모 릴레이션의 튜플 삭제 제한
CREATE TABLE employee2 (
	empno int primary key,
	manager int references employee2(empno),
	-- dno가 department2 table의 DEPTNO 참조 => 참조하는 부모 릴레이션 튜플 삭제 X
	-- dno int references department2(DEPTNO) on delete restrict
	
	-- on update restrict
	-- 자식 릴레이션이 참조하는 부모 릴레이션의 업데이트를 제한한다
	dno int references department2(DEPTNO) on update cascade
);

insert into employee2 values(4377, null, 2)
insert into employee2 values(3246, 4377, 1)
insert into employee2 values(3533, 4377, 2)

drop table employee2;

select * from department2
select * from employee2

-- restrict update일 때는 삭제 안되지만 cascade는 가능
delete from department2 where deptno = 2

-- update 안된다
update department2 set deptno = 10 where deptno = 2

-- 자식값을 바꾼다고 부모값이 바뀌지 않는다(외래키 제약조건 위반)
update employee2 set dno = 20 where dno = 1


/*셀렉트 들어감*/

select 'hello world'

-- 원하는 순서대로 컬럼 출력하기
select deptno, deptname
from department

--컬럼 이름에 공백 있을 시 중괄호로 묶는다 컬럼 이름에 공백 두지 않기
select [dept no] from department

-- employee 테이블에 title 컬럼 출력, 중복 출력된다
select title from employee
-- 중복 제거 출력
select distinct title from employee

-- where = 조건절
-- between and 와 그냥 and
select title from employee where salary < 5000000 and salary >3000000
-- between은 이상,이하 연산자
select title from employee where salary between 3000000 and 5000000

select * from employee

-- 집합: in, not in, any, all
-- OR 사용법과 같다
select dno in(1,2) from employee = -- dno in (1,2) = dno = 1 or dno = 2

-- 패턴: like

select * from employee where empname like '이%' -- 성이 이
select * from employee where empname like '%수%' -- 이름에 수가 들어가는 사원들 검색
-- 고정 길이: _언더스코어 활용
select * from employee where empname like '이__' -- 성이 이로 시작, 이름 3글자
select * from employee where empname like '__철'
select * from employee where empname like '_정%' -- 두 번째 글자가 정

-- trim 메소드: 문자열의 공백을 제거 trim('~~___') --> '~~'
-- trim('사원___') => '사원'  
-- 사원 뒤에 공백이 있어서 트림안하고 '%원'하면 아무것도 안나옴 
select * from employee where trim(title) like '%원'
select * from employee where title like '%원%'


-- []: 지정된 범위의 단일 문자
select [c-p]arsen -- arsen으로 끝나고 c-p 사이의 문자로 시작되는 문자열
select * from employee where empname like [1-5]%
-- [^]: 지정된 범위에 없는 단일 문자
[^1-5]%


-- null
null = null은 거짓이다
null은 비교 연산자 사용이 안된다

-- 아직 부서 배정 못 받은 김정현 사원 추가
-- dno(외래키)는 null 값 가능
insert into employee values(5000, '김정현', '사원', 2106, 1500000, null)

-- 예제 1) 사원 중 1번 부서가 아닌 사원들의 모든 정보를 검색하시오
select * from employee where dno != 1 -- null 값은 사칙연산 되지 않아서 결과에 포함x
select * from employee where dno <> 1 -- 둘 다 신입 사원 정현이 포함x

-- 사원 중 1번 부서가 아니거나 null인 값 사원들의 모든 정보를 검색하시오
select * from employee where dno <>1 or dno is null -- dno = null(x)

-- 예제) 최상위 직급이 아닌 모든 사원 정보
select * from employee where manager is not null

-- 논리연산자
-- 예제) salary가 3백만원 넘고 이씨 성을 가진 직원
select * from employee where (salary > 3000000) and (empname like '이%')
-- 
select * from employee where empname like '이__%'

-- 예제) 기획부이면서 개발부가 있는 층(만족하는 투플 없음)
select * from department where deptname like '개%' and deptname like '기%' 
select * from department where deptname = '개발' and deptname = '기획' 

-- 집합(in, not in, any, all)
-- 예제) 1번 부서나 3번 부서에 소속된 사원들의 모든 정보
select * from employee where dno in (1,3)
select * from employee where dno = 1 or dno = 3

-- any, all
-- 예제) 1,2 번 부서 중 어떤 부서에도 속하지 않은 사원의 모든 정보
select * from employee where dno not in (1,2)

-- 산술연산자(+, -, * , /): select 구문은 산술연산 가능, as 키워드를 통해 별칭 붙일 수 있음
-- 예제) 사원들의 이름과 월급과 월급의 10% 인상액을 검색하시오
select empname, salary, salary+(salary*0.1) as newSalary, salary*2 as twotimesSalary from employee 

-- order by
-- 예제) 월급순으로 사원정보 정렬
select * from employee order by salary -- 오름차순
select * from employee order by salary desc -- 내림차순

select * from employee where dno = 3 order by salary desc

-- limit: 상위 n개, offset: 상위 n개 제외하고 출력
-- 월급이 낮은 상위 3명
select * from employee order by salary limit 3
-- 월급이 낮은 상위 3명을 제외한 결과
select * from employee order by salary offset 3
-- 월급이 높은 상위 3명
select * from employee order by salary desc limit 3

-- ******집계함수******중요🍰
-- 여러 투플들의 집합에 적용되는 함수
-- 집계함수는 select절과 having 절에만 나타날 수 있다
-- 행의 개수를 세는 count(*)를 제외하고 모든 집계 함수들이 널값을 제거한 후 남아 있는 값들에 대해서 집계함수의 값을 구함

-- 예제) 부서번호가 1이 아닌 직원들의 정보
select * from employee where dno != 1 or dno is null -- and이 아니라 or!!!!

-- count(*): 모든 행(튜플)의 갯수
-- 예제) 전체 사원 수 계산해라
select count(*) from employee
select count(*) as num_person from employee

-- count(colum): 해당 colum의 값이 null이 아닌 행들의 갯수
-- 예제) 부서에 소속된 사원 수를 계산해라
select count(dno) as num_person_excpet_null from employee

-- 예제) 부서번호만 부여주세요
select dno from employee

-- distinct
-- 예제) 직급의 총 갯수를 구하시오
-- 먼저 중복을 없앤 다음에 count하기
select count(distinct title) from employee 

-- sum: 합계 avg: 평균, variance, stddev: 분산과 표준편차
-- max, min: 최대, 최소

select max(salary) from employee
select sum(salary) from employee
select variance(salary), avg(salary) from employee

-- 평균: sum/count
select sum(salary), count(*), sum(salary)/count(*) as avg from employee

-- 제곱은 power(제곱할 거, 승수)
-- 분산: sum(power(salary - 2750000,2)/count(*))
sum(power(salary - 2750000,2)/count(*)) from employee
-- 자유도
select variance(salary) from employee -- 자유도는 모집단에서 1을 뺀 것...?

-- group by, having
-- 집계함수는 group by절과 자주 사용된다
-- where 절에 조건들을 만족하는 투플들이 걸러진 후, group by절에 의해 그룹핑되고 having절에 의해 그룹들이 필터링

/* 
select 문의 구성
1. select * | distinct 컬럼 이름(들)
2. from 테이블 이름(들)
3. where 검색 조건(들)
4. group by 컬럼이름(들) -- 컬럼들을 어떻게 묶을 건인가
5. having 검색 조건(들)  -- 그룹한 다음 사용
6. order by 컬럼 이름(들) asc | desc 
*/


-- 1. group by
-- group by 절에 명시된 컬럼들을 이용하여, 해당 컬럼들을 기준으로 동일한 값을 갖는 투플들이 묶어 하나의 그룹 형성
select * from employee

-- 직급을 기준으로 그루핑
-- group by 절에 명시된 컬럼들은 항상 select 절에 와야 함 ex. group by manager면 select manager 써야 함 
-- group by는 데이터를 묶는 기능이기에 group by에 사용된 컬럼은 집계함수만 적용할 수 있음
select title from employee group by title

-- 예제) 직급별 사원 수, 직급별 평균 급여
-- title별로 그루핑한 다음에 count 세고, 급여 평균낸다
select title, count(empno), avg(salary) from employee group by title

update employee set salary = 1900000 where empno = 5000
-- 예제) 직급으로 오름차순 후, 직급별 월급으로 한 번더 오름차순 시켜라
select * from employee order by title, salary
-- 1. 직급 별로 하나의 튜플(그루핑)로 묶임, 5개의 튜플 생성

-- 예제) 직속상관 별로, 관리하는 직원들의 평균 월급과 관리하는 직원들의 수를 계산하시오 
select manager, avg(salary), count(*) from employee group by manager
-- 예제)에서 회사 대표 제외 + 직원들의 평균 월급 내림차순
select manager, avg(salary), count(*) from employee where manager is not null group by manager
order by avg(salary) desc

-- 2. having: gruop by 절에 그룹핑 되면 특정 조건에 맞는 그룹들만 골라낸다
-- where: 전체 튜플에 적용
-- having: 그루핑 된 튜플에 적용

-- 예제) 사원들이 속한 부서 번호별 그룹화, 사원 수가 2명 이상인 부서에 대해 부서별 사원 수를 검색
select dno, count(*) from employee where dno is not null 
group by dno having count(*) >= 2 
order by dno

-- 예제) 직속상관 별로, 관리하는 직원들의 평균 월급과 관리하는 직원들의 수를 계산하시오 
--		이 때, 회사 대표는 제외하고 관리 직원 수가 2명 이상인 직속상관별로 검색하시오.
select manager, 
avg(salary), count(*) 
from employee 
where manager is not null
group by manager
having count(empno) >= 2

-- 예제) 부서 번호별로 사원 수를 보여라. 이 때 1번 부서는 제외해라
select dno, count(*) from employee
where dno is not null
group by dno 
having dno != 1
-- where 절에서 바로 1번 부서 걸러도 된다
select dno, count(*) from employee
where dno <> 1
group by dno 

-- 예제) 사원들이 속한 부서 번호별로 그룹화 하고 평균 급여가 2백만원 초과하는 부서에 대해
-- 부서별 사원 수와 평균 급여를 검색하시오. 부서별 사원 수로 정렬하여 보여주시오
select dno, count(empno), avg(salary)
from employee
group by dno
having avg(salary) > 2000000
order by count(empno)

-- 예제) 급여가 5백만원 이하이고 부서가 있는 사원들에 대해(전체 조건이므로 where 구문)
-- 사원들이 속한 부서 번호별로 그룹화하고(그룹화 뒤에 조건은 having) 사원 수가 2명 이상이면서
-- 2번 부서가 아닌 부서에 대해
-- 부서 번호, 부서별 사원 수, 평균 급여, 최대 급여를 검색하시오
select dno, count(empno), avg(salary), max(salary)
from employee
where salary <= 5000000 and dno is not null
group by dno
having count(empno) >=2 and (dno != 2) 


-- 질의의 결합
-- 합집합 union
-- (select...from...) union (select...from...)

-- 예제) 월급이 이백만원 미만이거나 2번 부서에서 근무하는 직원들의 이름
(select empname from employee where salary < 2000000)
union
(select empname from employee where dno = 2)
-- = or와 union은 같은 결과를 낸다
select empname from employee where salary < 2000000 or dno = 2

-- union all은 중복값도 출력 
-- 예제) 김영희 또는 이민호가 속한 부서이거나 영업부의 부서 번호를 검색하시오
(select dno from employee where empname = '박영권' or empname = '이민호')
union all
(select deptno from department where deptname = '영업')

-- 교집합: intersect
(select dno from employee where empname = '박영권' or empname = '이민호')
intersect
(select deptno from department where deptname = '영업')

-- 차집합: except
(select dno from employee where empname = '박영권' or empname = '이성래') -- 1,2
except
(select deptno from department where deptname = '영업')

-- limit, offset: 상위 n개 출력, 상위 n개를 제하는 결과를 뽑는 구문
-- 예제) 가장 많은 월급을 받는 사람의 이름과 월급, 그 반대도 출력하시오
(select empname, salary from employee 
order by(salary) desc
limit 1)
union
(select empname, salary from employee 
order by(salary) 
limit 1)

-- 공동 1등, 꼴지가 있을 경우
-- 부속질의
select empname from employee where salary = min(salary) -- 오류: where절은 집계함수 사용x 
-- having 절은 집계함수(min,max,avg 등) 사용할 수 있지만 group by 함수 뒤에만 사용 가능
-- 그루핑을 하지 않고 집계함수 적용하여 필터링하는 법: 부속질의
select empname, salary from employee
where salary = (select min(salary) from employee)
union
select empname, salary from employee
where salary = (select max(salary) from employee)

-- top n = limit: 상위 n개
-- top ~ 조인 전까지 안봐도 됌

-- 조인🥞 짱 중요
-- 부모 릴레이션 r과 자식 릴레이션 s가 있다구 할 때,
-- r과 s의 조인

select r.*, s.* -- 부모와 자식의 전체 컬럼을 보여줘
from  r as r
join s as s
on r.pirimarykey = s.foreignkey

select d.deptname, e.empname, e.title
from department as d
join employee as e
on d.deptno = e.dno -- 부모 쪽 기본키 = 자식 쪽 외래키

-- 일반적으로 부모 릴레이션을 왼쪽에 명시(방향 바뀌어도 무방)
-- department join employee

-- 3개의 테이블 조인
select 
from parent as p
join kid as k
on p.a = k.b
join other as o
on p.c = o.d -- 기본키-외래키 조건이 만족될 때

-- 사원테이블과 프로젝트- 사원 테이블, 프로젝트 테이블을 조인하시오
-- 즉, 사원의 이름과 해당 사원이 수행하는 프로젝트의 번호 및 이름을 검색하시오
select * from employee
select * from emp_proj
select * from project

-- empno(employee의 기본키) - emp_proj - prjno(project의 기본키)
select e.empname, p.prjno, p.prjname
from employee as e
join emp_proj as ep	-- ep는 두 릴레이션을 연결해주는 테이블이다
on e.empno = ep.empno
join project as p
on ep.prjno = p.prjno
order by e.empname

-- using을 이용한거 건너뛴다

-- 카티션 곱(크로스 조인)
select * from department -- cardinary: 4
select * from employee -- cardinary: 8

select * -- = d.*,e.*
from department d
cross join employee e
-- 자연조인과 같은 출력 필요없는거 거르자
where deptno = dno -- 같은 거만 출력

-- 찐 자연조인 구문
select *
from department d
join employee e
on d.deptno = e.dno
-- 아무 사원도 없는 총무부와 부서가 없는 김정현은 출력되지 않음

-- 외부 조인 <-> 내부조인(양쪽 테이블에 조인조건과 일치하는 투플만 반환)
-- :조인되지 않은 한쪽 또는 양쪽 테이블의 투플들을 모두 보여준다
-- 1) 왼쪽 외부 조인 2) 오른쪽 외부 조인 3) 완전 외부 조인

-- 예제) 모든 부서와 해당 부서에서 일하는 사원들을 보이라
select *
from department d
left join employee e -- 정현이가 사라짐 right하면 총무부가 사라짐 자기 테이블 살리는 듯
on d.deptno = e.dno 

-- 예제) 모든 부서와 모든 사원들을 보여주세요
select *
from department d
full join employee e
on d.deptno = e.dno
select * from emp_proj

-- 예제) 모든 사원들의 이름과 각 사원들이 수행하는 프로젝트 이름을 보이라
select empname,prjname
from employee e
left join emp_proj ep -- 모든 사원들
on e.empno = ep.empno 
left join project p		-- 모든 사원들을 출력시키기 위해 employee 계속 유지시킨다
on p.prjno = ep.prjno

-- 세미조인: 관계대수 연산에만 정의
select 
from department d
join employee e
on d.depno = e.dno

-- 왼쪽세미
select distinct d.* -- 관계대수는 중복 제거해야함
form department d
join employee e
on d.depno = d.dno

-- 오른쪽 세미
select distinct e.* -- 관계대수는 중복 제거해야함
form department d
join employee e
on d.depno = d.dno

-- self join(자체조인): 자기 자신과 조인, 별칭을 반드시 사용
-- 예제) 직원의 이름과 해당 직원의 사수의 이름 검색
select e1.empname as "내이름", e2.empname as "사수이름"
from employee e1
join employee e2
on e1.manager = e2.empno


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



