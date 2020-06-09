--join 테이블 연결
SELECT
    em.employee_id,
    em.first_name,
    em.department_id,
    de.department_id,
    de.department_name
FROM
    employees    em, --27개 테이블 이름이 길어서 변수em으로 선언
    departments  de --107개 변수de
WHERE
    em.department_id = de.department_id;

--EQUI Join / 예제)모든 직원이름, 부서이름, 업무명 을 출력하세요

SELECT
    first_name          "이름",
    em.department_id    "부서번호",
    department_name     "부서명",
    em.job_id           "업무 아이디",
    job_title           "업무명"
FROM
    employees    em,
    departments  de,
    jobs         jb
WHERE
        em.department_id = de.department_id
    AND em.job_id = jb.job_id;

--left outer join / 직원의 이름과 부서명 출력

SELECT
    first_name       "이름",
    department_name  "부서명"
FROM
    employees    em
    LEFT OUTER JOIN departments  de --left outer join 왼쪽을 기준으로 잡는다(em이 기준)
    on em.department_id = de.department_id; --null값을 출력
----------- 다른 표기법 결과는 같음
SELECT
    first_name       "이름",
    department_name  "부서명"
FROM
    employees    em,
    departments  de 
where
    em.department_id = de.department_id(+); --null값이 나와야하는곳에 (+)써주기
    
--right outer join / 직원의 이름과 부서명 출력

SELECT
    first_name       "이름",
    department_name  "부서명"
FROM
    employees    em
    right OUTER JOIN departments  de --right outer join 왼쪽을 기준으로 잡는다(em이 기준)
    on em.department_id = de.department_id; --null값을 출력
    
--full outer join / 양쪽에(+)붙이는거 안됨
SELECT
    first_name       "이름",
    department_name  "부서명"
FROM
    employees    em 
    full OUTER JOIN departments  de --full outer join 왼쪽을 기준으로 잡는다(em이 기준)
    on em.department_id = de.department_id; --null값을 출력    
--self join    
SELECT
    emp.employee_id "사원번호",
    emp.first_name "이름",
    emp.salary "연봉",
    man.first_name "매니저 이름"
FROM
employees emp,
employees man
where
emp.manager_id = man.employee_id
order by
emp.employee_id asc;