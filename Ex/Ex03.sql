--복수 함수
--avg 평균출력 함수
SELECT
    AVG(salary)
FROM
    employees;
--count 데이터 갯수출력 함수 

SELECT
    COUNT(*)
FROM
    employees;
-- null값은 카운트 하지 않는다.

SELECT
    COUNT(commission_pct)
FROM
    employees;

-- salary값이 16000원초과인 갯수

SELECT
    COUNT(manager_id)
FROM
    employees
WHERE
    salary > 16000;

--sum 입력된 데이터의 합계값출력 함수

SELECT
    SUM(salary) AS "합계"
FROM
    employees
WHERE
    salary > 16000;

--avg 평균출력함수(null값은 제외하고 평균)

SELECT
    AVG(manager_id)
FROM
    employees
WHERE
    salary > 16000;

SELECT
    AVG(nvl(manager_id, 0))--null 데이터를  0으로바꿔 평균구하기
FROM
    employees
WHERE
    salary > 16000;

--max,min 함수

SELECT
    MAX(salary)
FROM
    employees;

SELECT
    MIN(salary)
FROM
    employees;

SELECT
    MAX(salary)     AS "최대값",
    MIN(salary)     AS "최소값",
    SUM(salary)     AS "합계"
FROM
    employees;
    
-- group by 절

SELECT
    department_id   AS "부서번호",
    SUM(salary)     AS "합계"
FROM
    employees
GROUP BY
    department_id--(그룹아이디)그룹별로 합계 구하기
ORDER BY
    department_id ASC;
-------------------부서 번호로 그룹하고 job_id로 그룹하는 세분화

SELECT
    department_id,
    job_id,
    COUNT(*),
    SUM(salary)
FROM
    employees
GROUP BY
    department_id,
    job_id
ORDER BY
    department_id ASC,
    job_id ASC;
    
--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요

SELECT
    department_id   AS "부서 번호",
    COUNT(*)        AS "인원 수",
    SUM(salary)     AS "급여합계"
FROM
    employees
GROUP BY
    department_id
HAVING
    SUM(salary) > 20000
ORDER BY
    department_id ASC;

-- case ~End 문

SELECT
    employee_id,
    first_name,
    job_id,
    salary,
    CASE --when 조건 then 출력문
        WHEN job_id = 'AC_ACCOUNT'  THEN --job_id가 ac_account면 salary + salary * 0.1 
            ( salary + salary * 0.1 )
        WHEN job_id = 'SA-PER'      THEN
            ( salary + salary * 0.2 )
        WHEN job_id = 'St-clerk'    THEN
            ( salary + salary * 0.3 )
        ELSE
            salary
    END "최종 연봉"
FROM
    employees;
/*직원의 이름, 부서, 팀을 출력하세요.팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’60~100이면 ‘B-TEAM’ 
110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.*/

SELECT
    first_name,
    department_id,
    CASE
        WHEN department_id >= 10
             AND department_id <= 50 THEN
            'A-TEAM'
        WHEN department_id >= 60
             AND department_id <= 100 THEN
            'B-TEAM'
        WHEN department_id >= 110
             AND department_id <= 150 THEN
            'C-TEAM'
        ELSE
            '팀없음'
    END "team"
FROM
    employees
ORDER BY
    department_id ASC;