/*문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)*/
SELECT
    COUNT(salary)
FROM
    employees
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            employees
    );
 /*문제2. 
평균급여(6462) 이상, 최대급여(24000) 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
(51건)*/

SELECT
    emp.employee_id    "직원번호",
    emp.first_name     "이름",
    emp.salary         "급여",
    avgs               "평균급여",
    maxs               "최대급여"
FROM
    employees emp,
    (
        SELECT
            MAX(salary)                   maxs,
            round(AVG(salary), 0)         avgs
        FROM
            employees
    )
WHERE
        salary <= maxs
    AND salary >= avgs
ORDER BY
    salary ASC;
/*문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 
나라아이디(country_id) 를 출력하세요(1건)*/

SELECT
    lo.*
FROM
    employees    em,
    departments  de,
    locations    lo
WHERE
        em.first_name = 'Steven'
    AND em.last_name = 'King'
    AND em.department_id = de.department_id
    AND de.location_id = lo.location_id;

/*문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요
-ANY연산자 사용(74건)*/

SELECT
    employee_id  "사번",
    first_name   "이름",
    salary       "급여"
FROM
    employees
WHERE
    salary < ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            job_id = 'ST_MAN'
    )
order by
salary desc; 

/*문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/
-- 조건절비교

SELECT
    em.employee_id    "직원번호",
    em.first_name     "이름",
    em.salary         "급여",
    em.department_id  "부서번호"
FROM
    employees em
WHERE
    ( em.department_id,
      em.salary ) IN (
        SELECT
            department_id,
            MAX(salary)
        FROM
            employees
        GROUP BY
            department_id
    )
ORDER BY
    salary DESC;
-- 테이블절비교

SELECT
    emp.employee_id      "직원번호",
    emp.first_name       "이름",
    emp.salary           "급여",
    emp.department_id    "부서번호"
FROM
    employees emp,
    (
        SELECT
            department_id,
            MAX(salary) maxs
        FROM
            employees
        GROUP BY
            department_id
    ) emp2
WHERE
        emp.department_id = emp2.department_id
    AND emp.salary = emp2.maxs
ORDER BY
    emp.salary DESC;
/*문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)*/
--테이블 절
SELECT
    jo.job_title "업무명",
    t.sums "연봉총합"
FROM
    jobs jo,
    (
        SELECT
            job_id,
            SUM(salary) sums
        FROM
            employees
        GROUP BY
            job_id
    ) t
WHERE
    jo.job_id = t.job_id
ORDER BY
    sums DESC;
--조건절
SELECT
    jo.job_title "업무명",
    sum(em.salary) "연봉 총합"
FROM
employees em , jobs jo
where
em.job_id = jo.job_id
GROUP by
jo.job_title
order by
sum(em.salary) desc;
/*문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)*/

SELECT
    emp.employee_id    "직원번호",
    emp.first_name     "이름",
    emp.salary         "급여"
FROM
    employees emp,
    (
        SELECT
            AVG(salary) avgs,
            department_id
        FROM
            employees
        GROUP BY
            department_id
    ) emp2
WHERE
        emp.department_id = emp2.department_id
    AND emp.salary > avgs
ORDER BY
    salary ASC;

/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요*/

SELECT
    emp2.employee_id    "사번",
    emp2.first_name     "이름",
    emp2.salary         "급여",
    emp2.hire_date      "입사일"
FROM
    (
        SELECT
            ROWNUM rn,
            emp.employee_id,
            emp.first_name,
            emp.salary,
            emp.hire_date
        FROM
            (
                SELECT
                    employee_id,
                    first_name,
                    salary,
                    hire_date
                FROM
                    employees
                ORDER BY
                    hire_date ASC
            ) emp
    ) emp2
WHERE
        rn >= 11
    AND rn <= 15;