/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)*/
SELECT
    e.first_name        "이름",
    e.manager_id        "매니저아이디",
    e.commission_pct    "커미션비율",
    e.salary            "월급"
FROM
    employees e
WHERE
    e.manager_id IS NOT NULL
    AND e.commission_pct IS NULL
    AND e.salary > 3000;

/*문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date),
전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/

SELECT
    employee_id                               "직원번호",
    first_name                                "이름",
    salary                                    "급여",
    to_char(hire_date, 'YYYY-DD-MM day')      "입사일",
    replace(phone_number, '.', '-')           "전화번호",
    department_id                             "부서번호"
FROM
    employees
WHERE
    ( department_id,
      salary ) IN (
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

/*문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)*/

SELECT
    avgs  AS "평균급여",
    mins  AS "최소급여",
    maxs  AS "최대급여",
    em.manager_id,
    t.first_name
FROM
    (
        SELECT
            round(AVG(salary), 0)         avgs,
            MIN(salary)                   mins,
            MAX(salary)                   maxs,
            manager_id
        FROM
            employees
        WHERE
            hire_date > '2005,01,01'
        GROUP BY
            manager_id
        HAVING
            round(AVG(salary), 0) >= 5000
    ) em,
    employees t
WHERE
    em.manager_id = t.employee_id
ORDER BY
    avgs DESC;
/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/

SELECT
    em.employee_id        "사번",
    em.first_name         "이름",
    de.department_name    "부서명",
    t.first_name          "매니저이름"
FROM
    employees    em,
    departments  de,
    employees    t
WHERE
        em.department_id = de.department_id (+)
    AND em.manager_id = t.employee_id
ORDER BY
    em.employee_id ASC;
/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

SELECT
    emp2.*
FROM
    (
        SELECT
            ROWNUM rn,
            emp.*
        FROM
            (
                SELECT
                    em.employee_id        "사번",
                    em.first_name         "이름",
                    de.department_name    "부서명",
                    em.salary             "급여",
                    em.hire_date          "입사일"
                FROM
                    employees    em,
                    departments  de
                WHERE
                        em.department_id = de.department_id
                    AND em.hire_date >= '2005/01/01'
                ORDER BY
                    em.hire_date ASC
            ) emp
    ) emp2
WHERE
        rn >= 11
    AND rn <= 20;
/*문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)를 출력
*/

SELECT
    em.first_name
    || '/'
    || em.last_name "이름",
    em.salary             "연봉",
    de.department_name    "부서명"
FROM
    departments de,
    (
        SELECT
            hire_date,
            department_id,
            first_name,
            last_name,
            salary
        FROM
            employees
    ) em
WHERE
        em.department_id = de.department_id
    AND em.hire_date = (
        SELECT
            MAX(hire_date)
        FROM
            employees
    );
/*문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name),
성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.*/

SELECT
    em.employee_id    "직원번호",
    em.first_name     "이름",
    em.last_name      "성",
    jo.job_title      "업무",
    em.salary         "연봉",
    avgs              "평균연봉"
FROM
    employees  em,
    jobs       jo,
    (
        SELECT
            AVG(salary) avgs,
            department_id
        FROM
            employees
        GROUP BY
            department_id
    ) a
WHERE
        em.department_id = a.department_id
    AND em.job_id = jo.job_id
    AND a.avgs = (
        SELECT
            MAX(AVG(salary))
        FROM
            employees
        GROUP BY
            department_id
    )
ORDER BY
    em.employee_id ASC;

/*문제8.
평균 급여(salary)가 가장 높은 부서는? */

SELECT
    de.department_name "부서"
FROM
    departments de,
    (
        SELECT
            AVG(salary) avgs,
            department_id
        FROM
            employees
        GROUP BY
            department_id
    ) a
WHERE
        de.department_id = a.department_id
    AND a.avgs = (
        SELECT
            MAX(AVG(salary))
        FROM
            employees
        GROUP BY
            department_id
    );
/*문제9.
평균 급여(salary)가 가장 높은 지역은? */

SELECT
    *
FROM
    (
        SELECT
            re.region_name,
            AVG(em.salary) avgs
        FROM
            employees    em,
            departments  de,
            locations    lo,
            countries    co,
            regions      re
        WHERE
                em.department_id = de.department_id
            AND de.location_id = lo.location_id
            AND lo.country_id = co.country_id
            AND co.region_id = re.region_id
        GROUP BY
            re.region_name
    ) a
WHERE
    a.avgs = (
        SELECT
            max(AVG(em.salary)) avgs
        FROM
            employees    em,
            departments  de,
            locations    lo,
            countries    co,
            regions      re
        WHERE
                em.department_id = de.department_id
            AND de.location_id = lo.location_id
            AND lo.country_id = co.country_id
            AND co.region_id = re.region_id
        GROUP BY
            re.region_name
    );
/*문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/

SELECT
    jo.job_title
FROM
    (
        SELECT
            AVG(salary) avgs,
            job_id
        FROM
            employees
        GROUP BY
            job_id
    ) em,
    jobs jo
WHERE
        em.job_id = jo.job_id
    AND em.avgs = (
        SELECT
            MAX(AVG(salary))
        FROM
            employees
        GROUP BY
            job_id
    );