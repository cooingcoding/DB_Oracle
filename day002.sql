alter session set nls_date_format='RR/MM/DD';

drop table emp;
drop table dept;

CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-11',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);

commit;

drop  table  salgrade;

create table salgrade
( grade   number(10),
  losal   number(10),
  hisal   number(10) );

insert into salgrade  values(1,700,1200);
insert into salgrade  values(2,1201,1400);
insert into salgrade  values(3,1401,2000);
insert into salgrade  values(4,2001,3000);
insert into salgrade  values(5,3001,9999);

commit;
--- scott 계정이 가지고 있는 테이블의 목록을 확인
select * from tab;

--- salgrade 테이블의 목록 내용을 확인
select * from salgrade;

---Q1. dept 테이블은 부서정보를 가지고 있는 테이블이다.
select * from dept;
---부서 테이블(dept)에 부서이름 dname만 추출
select dname from dept;
---부서 테이블(dept)에 부서이름, 위치 추출

select dname, loc from dept;
select * from emp;

select empno, ename, job from emp;
---예약어(keyword) 의미와 용도가 정해진 명령어로 다른 용도로 사용할 수 없음
---직운테이블에서 직운이름과 급여를 추출하시오.
select ename, ssal from emp;
selct ename, sal from emp;
select ename, sal, sal+100 from emp;
select ename, sal, sal+100 as "인상급여" from emp;

---급여가 2500을 초과하는 직원의 목록을 추출하쇼.
select * from emp where sal > 2500;

---직원 테이블에 직우 중 부서번호가 20인 사원에 관한 정보를 추출하시오.
select * from emp where deptno = 20;
---Q. 이름 ename이 ford인 사운의 사번(enpno), 이름 ename, 급여sal 추출

select empno, ename, sal from emp where ename='FORD';

--- 문자, 날짜, 시간 등은 따옴표('',"")안에 담아야 한다.
--- 필드명은 대소문자를 구별하지 않지만, 레코드는 반드시 대소문자를 구별해야 한다.

---Q 입시일이 1982년 1월 1일 이후인 정보 추출해
select * from emp where hiredate>'19820101';
select * from emp where hiredate >= '82/01/01';

---Q. 직원의 부서번호가 10인 직운의 정보를 추출
select * from emp where empno = 10;

---직운의 부서 번호가 10이 아닌 직운의 정보를 추출
select * from emp where not empno = 10;
select * from emp where deptno = '10';
---부서 번호가 10인 직원 중에서(이고, 이면서) 직군(job)이 메니저인 직운의 정보 추출
selcet * from emp where deptno = 10 and job = 'MANAGER';

----부서 번호가 10 이거나 직군이 메니저인 직원의 정보 추출 or을 쓴다.
---- - 급여가 2000이상(이고 or ,) 3000이하인 사운의 정보 추출(2000~3000)
select * from emp where sal >= 2000 and sal <= 3000;

--- 관용구 between and
--- between : 숫자형 문자형 날짜형 모두 사용이 가능하다.
select * from emp where sal between 2000 and 3000;

---Q. 급여가 2000 미만이거나 3000을 초과한 사원의 정보를 구하시오
select * from emp where sal not between 2000 and 3000;


---관용구 in
---커미션이 300 혹은 1400인 사운의 정보를 추출하시오
select * from emp where comm=300 or comm=1400;
select * from emp where comm in(300, 1400);

---커미션이 300 혹은 1400이 아닌 사운의 정보를 추출하시오
select * from emp where comm not in(300, 1400);
select * from emp where comm <> 300 or comm <> 1400;

--- 관용구 like, ~같이, 처럼
---와일드 카드문자 or 만능문자와(문자를 대신해주는 역할) like를 같이 쓴다. : %, _
select ename from emp;
사원 중 첫글자가 'c'인 사원
select ename from emp where ename like 'C%';
select ename from emp where ename not like 'c%';
사원중 마지막 글자가 e인 사운
select ename from emp where ename like '%e';

--사원의 이름의 두번째 글자가 'A'
select ename from emp where ename like '_A%';
select ename from emp where ename not like '_A%';

select * from emp;
--NULL의 의미 : 미확정, 알 수없는 값
--NULL은 연산, 할당 , 비교가 불가능하다.
--is NULL / is not null
--is : 은/는/이/가

---사원 테이블의 커미션이 null인 사원의 정보를 추출하시오
select empno, ename, comm from emp where comm is null;
select empno, ename, comm from emp where comm is not null;

--select와 함께 확장해서 사용하는 order by절
--정렬 : 특정 필드에 따라 순서대로 나열하는 것
--정렬방식 : 기본형(오름차순 ,asc), 내림차순(desc)
--숫자, 문자(사전순서대로), 날짜, null

-사원의 급여를 기준으로 오름차순으로 정렬
select * from emp order by sal asc;
select * from emp order by sal;
위의 두개는 같은 값이 나온다 기본형이 오름차순이라서
select * from emp order by sal

-가장 최근에 입사한 사원의 순서로 추출
select *from emp order by hiredate desc;

-사원의 급여를 기준으로 오름차순 하되, 동일한 급여를 받는 사우네 이름으로 오름차순 하시오
select * from emp order by sal, ename;
select * from emp order by sal, ename desc;

distinct 중복을 제거하고 추출할 때 사용
--사원 테이블에서 부서번호를 추출
select deptno from emp;
select distinct deptno from emp;

--별칭(nick name) : 필드명에 별명을 부여
select ename, sal*12 from emp;
select ename, sal*12 as "연봉" from emp;
select ename, sal*12 "연봉" from emp;

--연결연산자 : select문 내부에 "||"(기존의 컬럼에 특정 문자열을 추가할 때,문자열과 문자열을 연결하고자 할 때 쓰는 것)
select ename || ' 씨의 직군은 ' || job || ' 입니다. ' from emp;

select ename, job
from emp;

--dual 테이블 : 한 행의 결과를 출력하기 위해 사용하는 임시테이블
-- 간단한 계산식 : 30*50
select 30*40
from dual;

desc dual

select *
from dual;

select sysdate
from dual;

--숫자함수 : 숫자 데이터를 처리하기 위해 사용하는 함수
-- abs : 절댓값
select -10, abs(-10)
from dual;

-- floor : 소숫점 아래를 버리는 함수
select 42.195, floor(42.195)
from dual;

--round : 특정 자릿수에서 반올림하는 함수
--round (숫자, 자릿수)
select 34.5678, round(34.5678)
from dual;

select 34.5678, round(34.5678, 2)
from dual;

select 34.5678, round(34.5678, -1)
from dual;

--trunc : 특정 자릿수에서 잘라내는 함수
--trunc(숫자, 자릿수)
--자릿수에 2인 경우 : 소수점이하 세번째 자리에서 버림 연산 수행
select trunc(34.5678, 2), trunc(34.5678, -1), trunc(34.5678), trunc(34.5678, 0)
from dual

--mod:나머지를 되돌려주는 함수
--mod(숫자, 나누는 수)

select mod(27, 2), mod(27, 5), mod(27, 7)
from dual;

--문자 처리 함수 : 문자 데이터를 처리하는 함수, 문자열
--upper() : 소문자가 들어오면 대문자로 바꿔라
select 'welcome to oracle' "적용전", upper('welcome to oracle')"upper적용후"
from dual;
--lower() : 대문자가 들어오면 소문자로 바꿔라
select 'Welcome to Oracle' "적용전", lower('Welcome to Oracle')"upper적용후"
from dual;
--intcap() : initial 첫글자만 대문자로 바꿔라
select 'WELCOME TO ORACLE' "적용전", initcap('WELCOME TO ORACLE') "initcap적용후"
from dual;
--length() : 문자 길이를 구하는 함수
select length('oracle'), length('오라클')
from dual;
--lengthb() :  문자 길이를 byte수로 알려주는 함수
select lengthb('oracle'), lengthb('오라클')
from dual;
--instr() : 특정 문자의 위치를 구하는 함수
select instr('Welcome to Oracle', 'O')
from dual;
--substr(문자열, 시작위치, 글자수) : 문자열에서 시작위치부터 글자수만큼 추출
select substr('Welcome to Oracle',4, 4)
from dual;

---Q. 사원정보테이블에서 사원들의 입사일에서 입사 년도와 입사 한 달을 추출하시오.
---단, 추출된 결과의 컬럼명은 직원이름, 년도, 월이 추출되도록 하시오.
select ename, hiredate from emp;
select ename as "직원이름", 19||substr(hiredate, 1, 2) as "년도",
substr(hiredate, 4, 2) as "월"
from emp;

---Q. 9월에 입사한 사원의 정보를 추출하시오
select ename, hiredate from emp;
select ename as "직원이름", 19||substr(hiredate, 1, 2) as "년도",
substr(hiredate, 4, 2) as "월"
from emp
where substr(hiredate, 4, 2) = '09';
--substrb(): bite수로 잘라내라 / 명시 된 갯수만큼의 문자가 아니라 바이트 수를 잘라낸다
--substr()함수는 한글/한자를 1바이트로 보지만, substrb()는 2바이트로 본다.
select substr('웰컴투오라클', 3, 4),
substrb('오라클오라클', 3, 4)
from dual;

---trim() : 좌우 공백을 제거하는 함수
---ltrim() / rtrim()
select ltrim(' oracle') from dual;

-- 단일행함수 : 날짜함수, 형변환함수, 일반함수(함수를 실행한 뒤 한줄만 나오는 것이 단일행함수)
---날짜함수 : date(날짜데이터)
---날짜 + 숫자 : 주어진 날짜부터 숫자의 기간만큼 지난 날짜를 계산해서 추출
---날짜 - 숫자 : 주어진 날짜에서 숫자의 기간만큼 이전 날짜를 계산해서 추출
---날짜 - 날짜 : 두 날짜 사이의 기간을 추출
---sysdate : 현재 시스템에 등록된 날짜를 반환
---sysdate + 1 : 내일
---sysdate - 1 : 어제
---months_between : 두 날짜 사이의 개월 수
---Q.직원 정보 테이블의 입사날짜를 이용하여 직원들의 근무한 개월수를 추출
select ename, sysdate, hiredate, months_between(sysdate, hiredate)
"근무개월수" from emp;

select *from emp;

-- add_months : 특정 개월 수를 더한 날짜를 구하는 함수
---입사날짜에서 4개월 추가한 날짜를 추출하시오.
select ename, hiredate, add_months(hiredate, 4) from emp;

---next_day : 해당 날짜에서부터 시작해 명시된 요일에 해당하는 날짜를 반환해주는 함수
select sysdate, next_day(sysdate, '수요일')
from dual;

---last_day : 해당 달의 마지막 날짜를 반환하는 함수
---직원들의 입사한 달의 마지막 날을 추출
select ename, hiredate, last_day(hiredate) from emp;