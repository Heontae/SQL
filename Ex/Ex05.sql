SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'Den'
    )
ORDER BY
    salary DESC;
    
--급여를 가장 적게(2100원) 받는 사람의 이름, 급여, 사원번호는?

SELECT
    first_name   "이름",
    salary       "급여",
    employee_id  "사원번호"
FROM
    employees
WHERE
    salary = (
        SELECT
            MIN(salary)
        FROM
            employees
    );

--평균 급여 (6461원)보다 적게 받는 사람의 이름, 급여를 출력하세요?

SELECT
    first_name  "이름",
    salary      "급여"
FROM
    employees
WHERE
    salary < (
        SELECT
            round(AVG(salary), 0)
        FROM
            employees
    )
ORDER BY
    salary ASC;
--다중행 row값이 여러개 In사용방법

SELECT
    employee_id,
    first_name,
    salary
FROM
    employees
WHERE
    salary IN (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
--각 부서별로 최고급여를 받는 사원을 출력하세요. (동시 비교법),(department_id,salary) in (10,4400) ,(20,13000)

SELECT
    department_id,
    first_name,
    salary
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
    department_id ASC;

/*부서번호가 110인 직원의 급여(12000,8300) 보다 큰 모든 직원의 
사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)*/
--*****다중행에서 or은 any / and는 all로 표기

SELECT
    department_id  "부서번호",
    employee_id    "사번",
    first_name     "이름",
    salary         "급여"
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            department_id = 110
    );
----------------

SELECT
    e.department_id,
    e.employee_id,
    e.first_name,
    e.salary
FROM
    employees e,
    (
        SELECT
            department_id,
            MAX(salary) salary
        FROM
            employees
        GROUP BY
            department_id
    ) s
WHERE
        e.department_id = s.department_id
    AND e.salary = s.salary;
--rownum : 질의의 결과에 가상으로 부여되는 Oracle의 가상(Pseudo)의 Column (일렬번호)
--예제)급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오

SELECT
    ROWNUM,
    em.first_name,
    em.salary
FROM
    (
        SELECT
            first_name,
            salary
        FROM
            employees
        ORDER BY
            salary DESC
    ) em--정렬을 먼저한 테이블 가져오기
WHERE
    ROWNUM < 6;
    
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 

SELECT--조건에 맞는 출력
    omp.first_name    "이름",
    omp.hire_date     "입사일",
    omp.salary        "급여"
FROM
    (
        SELECT --row넘 붙여주기
            ROWNUM rn,
            emp.first_name,
            emp.hire_date,
            emp.salary
        FROM--
            (
                SELECT--07년부터08년까지 테이블을 가져와 연봉 기준내림차순 정렬
                    first_name,
                    hire_date,
                    salary
                FROM
                    employees
                WHERE
                        hire_date > '07-01-01'
                    AND hire_date < '08-01-01'
                ORDER BY
                    salary DESC
            ) emp
    ) omp
where
omp.rn>=3 and omp.rn<=7;