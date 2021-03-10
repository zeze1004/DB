## 프로그래머스 SQL



### 1. SELECT

1. 전체출력



2. 역순 정렬

   ```sql
   SELECT NAME, DATETIME from ANIMAL_INS
   order by ANIMAL_ID desc
   ```

3. 아픈 동물

   특정 칼럼에서 특정 데이터 값만 출력

   ```sql
   SELECT ANIMAL_ID, NAME from ANIMAL_INS 
   where INTAKE_CONDITION = 'Sick'
   ```

4. 어린 동물 찾기

   특정 칼럼에서 특정 데이터 값이 아닌 것만 출력

   ```sql
   SELECT ANIMAL_ID, NAME from ANIMAL_INS
   where not INTAKE_CONDITION = 'Aged'
   ```

5. 동물의 아이디와 이름

   아이디 순으로 아이디와 이름 출력

   ```sql
   SELECT ANIMAL_ID, NAME from ANIMAL_INS 
   order by ANIMAL_ID
   ```

6. 여러 기준으로 정렬

   이름 순으로 나열하되 이름이 같을 시 보호를 나중에 시작한 동물의 이름을 먼저 보여줌

   ```sql
   SELECT ANIMAL_ID, NAME, DATETIME from ANIMAL_INS
   order by NAME, DATETIME desc
   ```

7. 상위 n개 레코드

   보호소에 가장 일찍 들어온 동물의 이름 출력

   ```sql
   SELECT NAME from ANIMAL_INS 
   order by DATETIME 
   limit 1
   ```



### 2. SUM, MAX, MIN

1. 최솟값, 최댓값 구하기

   가장 일찍 보호소에 들어온 동물의 일자를 출력

   ```sql
   // 최솟값
   SELECT DATETIME FROM ANIMAL_INS 
   order by DATETIME 
   limit 1
   
   // 최댓값
   SELECT DATETIME from ANIMAL_INS 
   order by DATETIME desc
   limit 1
   ```

2. 동물 수 구하기

   동물 수 출력(전체 행 갯수)

   ```sql
   SELECT count(*) from ANIMAL_INS 
   ```

3. 중복 제거하기

   중복되는 동물 이름과 NULL을 제거한 수를 출력해라

   ```sql
   SELECT count(DISTINCT(NAME)) FROM ANIMAL_INS 
   WHERE NOT NAME = 'NULL'
   ```

   