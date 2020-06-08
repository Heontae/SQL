SELECT
    employee_id,
    first_name,
    last_name
FROM
    employees;
--사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요

SELECT
    first_name,
    phone_number,
    hire_date,
    salary
FROM
    employees;

/*사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
 컬럼명이 많을때 표기팁 Ctrl+F7 자동정렬*/

SELECT
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    salary
FROM
    employees;
    
--Select문 출력할 때 컬럼에 별명 사용하기 as생략가능 ""큰따옴표 안에 그대로 출력 안쓰면 모두 대문자

SELECT
    employee_id  AS empno,
    first_name   "E-name",
    salary       "연봉"
FROM
    employees;
/*[예제]
사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
*/

SELECT
    employee_id   AS "사원번호",
    first_name    AS "이름",
    last_name     AS "성",
    salary        AS "급여",
    phone_number  AS "전화번호",
    email         AS "이메일",
    hire_date     AS "입사일"
FROM
    employees;

--연결 연산자||(Concatenation)로 컬럼들 붙이기

SELECT
    first_name
    || '  ' --공백 만들기
    || hire_date AS "이름과 입사일"
FROM
    employees;
    
--산술 연산자 사용하기 

SELECT
    first_name,
    salary AS "월급",
    salary * 12,
    ( salary + 300 ) * 12
FROM
    employees;
    
/*전체직원의 정보를 다음과 같이 출력하세요
성명(first_name last_name 성과 이름사이에 – 로 구분
급여
연봉(급여*12)
연봉2(급여*12+5000)
전화번호
*/

SELECT
    first_name
    || '-'
    || last_name AS "성명",
    salary              AS "급여",
    salary * 12         AS "연봉",
    salary * 12 + 5000  AS "연봉2",
    phone_number        AS "전화번호"
FROM
    employees;

--employees테이블에서 department_id가 10인 row에 first_name 컬럼만 가져오기.

SELECT
    first_name
FROM
    employees
WHERE
    department_id = 10;
    
--연봉이 15000 이상인 사원들의 이름과 연봉을 출력하세요

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 15000;
--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요    

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date >= '07/01/01';
    
--이름이 Lex인 직원의 연봉을 출력하세요*/

SELECT
    salary
FROM
    employees
WHERE
    first_name = 'Lex';
--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary <= 14000
    OR salary >= 17000;
--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '04/01/01'
    AND hire_date <= '05/12/31';
--연봉이 14000 이상 17000이하인 사원의이름과 연봉을 구하시오

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary BETWEEN 14000 AND 17000; --between(이상<이하)14000원이상 17000원 사이 ex)작은수가 앞에

--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary IN (
        2100,
        3100,
        4100,
        5100
    ); --연봉이 2100,3100,4100,5100인 조건

--L%->L로시작 ,%L->L로 끝나는 ,%L% 중간에 L이들어가는

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name LIKE 'L%%%';    --first_name에서 L로 시작하는 조건 

-- _언더바 갯수가 공백 L_ L로시작하는 2글자 L_._._ L로시작하는 4글자

SELECT
    first_name,
    last_name,
    salary
FROM
    employees
WHERE
    first_name LIKE 'L___';

--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '%am%';
--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    first_name LIKE '_a%';
--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요

SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '___a%';
    --이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요

SELECT
    first_name
FROM
    employees
WHERE
    first_name LIKE '__a_';
    
--null 은0이아니다 (데이터가없는것!)

SELECT
    first_name,
    salary,
    commission_pct,
    salary * commission_pct
FROM
    employees
WHERE
    salary BETWEEN 13000 AND 15000;
------------------------------------

SELECT
    first_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NULL; --commission_pct가 null값인 이름,급여,수당 출력
--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요

SELECT
    first_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL;--null이 아닌 is not null
--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요

SELECT
    first_name
FROM
    employees
WHERE
    manager_id IS NULL
    AND commission_pct IS NULL;
    
--order by 명령어(정렬) 작은거부터 ->큰수(오름차순)asc , 큰수 ->작은수(내림차순)desc

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 9000
ORDER BY
    salary DESC,--샐러리를 큰수부터 작은수 로 정렬 아무것도안쓰면 asc (desc는 큰수부터 작은수 ,asc는 작은수 부터 큰수)
    first_name ASC; --salary값이 똑같으면 퍼스트네임이 낮은수부터 정렬
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요

SELECT
    department_id,
    salary,
    first_name
FROM
    employees
where
department_id is not null
ORDER BY
    department_id aSC;
    
--급여가 1000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary >= 1000
ORDER BY
    salary DESC;
    
--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
SELECT
    department_id,
    salary,
    first_name
FROM
    employees
where
department_id is not null

ORDER BY
    department_id aSC , salary desc;
    