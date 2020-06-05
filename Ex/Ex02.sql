--단일행 함수

--문자함수
SELECT
    initcap('aaaaa')--initcap(변수)
FROM
    dual;--dual은 가상 테이블
    
--영어의 첫 글자만 '대문자'로 출력하고 나머지는 전부 소문자로 출력하는 함수 INITCAP(컬럼명)

SELECT
    email,
    initcap(email),
    department_id
FROM
    employees
WHERE
    department_id = 100;
--문자함수 – LOWER(컬럼명)소문자 / UPPER(컬럼명)대문자 입력되는 값을 전부 소문자/대문자로 변경하는 함수

SELECT
    first_name,
    lower(first_name),
    upper(first_name)
FROM
    employees
WHERE
    department_id = 100;
--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수) 주어진 문자열에서 특정길이의 문자열을 구하는 함수

SELECT
    first_name,
    substr(first_name, 2, 3), --2번쨰 칸부터 3개출력
    substr(first_name, - 3, 2) --뒤로3칸부터 2칸 출력
FROM
    employees
WHERE
    department_id = 100;
/*문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’)
LPAD() :왼쪽 공백에 특별한 문자로 채우기
RPAD() :오른쪽 공백에 특별한 문자로 채우기*/

SELECT
    first_name,
    lpad(first_name, 10, '*'), --10칸으로 만들고 나머지를 *로채움
    rpad(first_name, 10, '*')
FROM
    employees;
/*문자함수 – REPLACE (컬럼명, 문자1, 문자2)
컬럼명에서 문자1을 문자2로 바꾸는 함수*/

SELECT
    first_name,
    replace(first_name, 'a', '*') --a를 *로 변경
FROM
    employees
WHERE
    department_id = 100;

SELECT
    first_name,
    replace(first_name, 'a', '*'),
    replace(first_name, substr(first_name, 2, 3), '***')--first_name 2번칸부터3칸을 ***로변경
FROM
    employees
WHERE
    department_id = 100;

--trim 공백 자르기

SELECT
    ltrim('          aaa         ')
    || '--------',
    rtrim('          aaa         ')
    || '--------',
    TRIM('          aaa         ')
    || '--------'
FROM
    dual;
--숫자함수
--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 주어진 숫자의 반올림을 하는 함수

SELECT
    round(123.346, 2)          "r2",--소수점 2번째 자릿까지 반올림해서 표기
    round(123.456, 0)          "r0",
    round(123.456, - 1)        "r-1"
FROM
    dual;

--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 주어진 숫자의 버림을 하는 함수

SELECT
    trunc(123.346, 2)          "r2",
    trunc(123.456, 0)          "r0",
    trunc(123.456, - 1)        "r-1"
FROM
    dual;
--날짜 함수

SELECT
    sysdate,
    first_name
FROM
    employees;
--단일함수>날짜함수 – MONTH_BETWEEN(d1, d2)  d1날짜와 d2날짜의 개월수를 출력하는 함수 

SELECT
    sysdate,--현재 날짜
    hire_date,
    round(months_between(sysdate, hire_date), 0)--입사한지 몇개월이 됐는지 현재날짜,입사날짜,반올림
FROM
    employees
WHERE
    department_id = 110;
--last_day (변수)달의 마지막 날짜

SELECT
    last_day('20,06,06'),
    last_day(sysdate)
FROM
    dual;
    
--변환함수
--to_char(n,fmt)

SELECT
    first_name,
    salary * 12,
    to_char(salary * 12, '$999,999')           "SAL", --앞에 달려표시하고 $999,999형식
    to_char(salary * 12, '$99999999.999')      "SAL",
    to_char(salary * 12, '$0999999')           "SAL"
FROM
    employees
WHERE
    department_id = 110;

SELECT
    to_char(9876, '9999'),
    to_char(9876, '009999'),
    to_char(9876, '$9999'),
    to_char(9876, '$9999.99')
FROM
    dual;   
 --to_char(날짜,'출력모양')

SELECT
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd hh24:mI:ss')
FROM
    dual;
 /*일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
NVL(조사할 컬럼, NULL 일 경우 치환할 값)
NVL2(조사할 컬럼, NULL이 아닐때 치환할 값, NULL일때 치환할 값)*/

SELECT
    first_name,
    commission_pct,
    nvl(commission_pct, 0),--null일 경우 null값을 0으로 변경
    salary * nvl(commission_pct, 0), --값을 구해야하는데 널값은 계산이 안돼서 널을 0값으로 변경
    nvl2(commission_pct, 100, 0)--null값이면 0으로 null값이 아닌 것들은 100으로 변경

FROM
    employees;