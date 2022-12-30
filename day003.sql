-- 형(data type)변환 함수 : 숫자, 문자, 날짜 데이터 형을 다른 데이터 형으로 변환할 때 쓰는 함수
-- 종류 : to_number, to_char, to_date
-- number, charracter, date ex)숫자를 문자로 바꿀 때 to_char쓴다.
select sysdate from dual; --별도의 테이블이 없을 때 dual

--format(서식) : yy/yyyy, mm, dd(두자리로 표시해라 라는 뜻)
select sysdate, to_char(sysdate, 'yyyy-mm-dd') from dual;

-- 사원들의 입사일을 출렬하되, 요일을 함께 출력하는 쿼리문을 기술하시오.
-- day : 요일
select hiredate, to_char(hiredate, 'yyyy-mm-dd day')
from emp;

--현재 시스템의 날짜와 시간을 출력하는 쿼리문을 기술하시오
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss')
from dual;

select sal from emp;
--여기서 원 표시를 하고 싶을 때 [L은 지역별 통화 기호가 붙는다.]
--서식에서 숫자를 대신해서 쓰는 기호 2가지 : 0과 9
--데이터의 값이 10, 이 10이라는 숫자 뒤에 점을 붙이고 싶을 때 서식기호=>00점 or 99점
--데이터 값이 8 =>08점 or 8점
--내 급여가 1000원이고 세자리마다 쉼표를 붙이고 싶으면 어떻게 해야할까? 
---서식기호 0,000원 : 1,000 원 / 800원 : 0,800원
---자리수가 맞지 않을 경우 0은 0으로 채우고, 9는 채우지 않는다.
select ename, sal, to_char(sal, 'L99,999')
from emp;

--to_date : 문자형을 날짜형으로 변환하는 함수
--기본 날짜 형식 : yy/mm/dd 
--ex. 주민등록 앞자리로 써있는 경우, 123456-0 이걸 가지고 출생년도를 따올 때, 날짜 형식으로 들고 올 수 있다.
select ename, hiredate
from emp
where hiredate=to_date(19810220, 'yyy/mm/dd');

--to_number : 문자형이나 날짜형을 숫자형으로 변환하는 함수
---20,000과 10,000 값 사이의 차를 알아보는 쿼리(숫자사이에 쉼표가 있으면 숫자가 아니라 문자이다.)
select to_number('20,000', '99,999') - to_number('10,000', '99,999')
from dual;

select 20000 - 10000 from dual;

--NVL 함수 :  NULL을 다른 값으로 변환하는 함수 (커미션에 있는 널값이 어차피 0인데 0으로 계산하고 싶어)
select * from emp;
---직원의 연봉을 계산해 출력하는 쿼리분을 기술하시오
---연봉 = 직원의 급여 *12 + comm (NULL값을 갖고 있으면 산술연산이 안된다.)
select ename, sal, sal*12+comm as "연봉"
from emp; --이렇게 있으면 커미션 계산이 안된다.

select ename, sal, sal*12+NVL(comm, 0) as "연봉" from emp;

--그룹함수(Group Fruntion) : 함수를 적용 할 때, 그룹으로 묶어서 함수를 적용한다는 뜻
--                          하나 이상의 행을 그룹으로 묶어서 연산하는 함수
--엑셀에서 사용 하는 함수
---sum : 해당 컬럼에 총합을 구하는 함수
---사원들의 급여의 총합을 출력하는 쿼리문을 기술하시오
select sum(sal) from emp;  ---이것을 통해서 얻어지는 함수는 한줄이다.
select ename, sum(sal) from emp;---이건 오류 발생 그룹함수는 한줄이 나와야 해서

select sum(comm) from emp;  ---그룹함수는 null을 제외하고 계산한다. 다른 연산자는 null값이 있으면 안됨.

-- avg() : 해당 컬럼 값의 평균을 구하는 함수
-- 직운 급여의 평균을 계산하는 쿼리문을 기술하시오.
select avg(sal) from emp;
select round(avg(sal)) from emp; ---소수점 이하에서 반올림하라.

-- max/min : 최댓값과 최솟값을 구하는 함수
-- 가장 높은 급여와 낮은 급여를 추출하는 쿼리분을 기술하시오.
select max(sal) as "최대급여", min(sal) "최소급여" from emp;
--- 가장 높은 급여를 받는 직원의 이름과 급여를 추출하는 쿼리문을 기술하시오.
select ename, sal from emp where sal = max(sal); ---오류가 나온다. where가 아니라gruop by

--count : 조건에 만족하는 행의 개수를 변환하는 함수
--count 함수에 특정 컬럼을 담으면 해당 컬럼에 값을 담고 있는 행의 개수를 반환
--count 함수는 NULL값에 대한 개수를 세지 않는다.
---직원의 수를 추출하는 쿼리문을 구하시오.
select count(*) from emp;
select count(ename) from emp;
---직원들이 담당하는 업무의 건수를 계산하여 추출하는 쿼리문을 기술하시오
select * from emp;
select count(job) from emp; ---이건 오답
select count(distinct job) from emp;  ---이렇게 해야 정답이다 알겠냐?

-- group by 절 : 특정 칼럼을 기준으로 그룹화하여 해당 그룹에 존재하는 레코드를 대상으로 연산수행하는 함수
-- 그룹 함수를 사용하되, 특정 컬럼을 대상으로 적용할지를 기술할 때 사용
--- 직원의 급여의 합을 추출하는 쿼리문을 추출하시오. 단, 각 부사별 직원의 급여의 합이 출력되도록 기술할 것
---부서별 급여의 합을 출력하는 쿼리문을 추출하시오
select distinct deptno from emp;
select deptno, sum(sal) from emp group by deptno;  --- group by가 있을 때에는 그룹함수와 일반함수를 같이 쓸 수 있다.

---소속부서별 급여의 총합과 평균급여를 추출하는 쿼리를 기술하시오.
---단, 부서번호, 총급여, 평균급여라는 컬럼명을 표시하시오.
select * from emp;
select deptno "부서번호", sum(sal) "총급여", avg(sal) "평균급여"
from emp 
group by deptno;

---부서별 사원수와 커미션을 받는 사원의 수를 추출하는 쿼리문을 구하시오.
select deptno,count(*) "사원수", count(comm) "커미션받는사원" 
from emp group by deptno;
---gruop by 절에 붙일 수 있다.

-- having 절 : group by 절에 의해 생성된 결과 값에 원하는 조건 식을 담는 절
---조건절 :  where절(혼자 쓸수 있음)과 having절(group by랑 써야해)
---부서별 평균급여를 출력하는 쿼리문을 기술하시오.
select deptno, round(avg(sal))
from emp group by deptno;

select deptno, round(avg(sal))
from emp group by deptno
having avg(sal)>=2000;

--- 부서별 직급단위 급여의 평균을 추출한는 쿼리문을 기술하시오.
select deptno, job, round(avg(sal)) from emp group by deptno, job
order by deptno;

select ename, deptno, avg(sal)
from emp
group by deptno; ---이건 ename때문에 오류가 난다. 쟤는 그룹으로 묶을 수 없다.(188p~)

select deptno, job, avg(sal)
from emp
where sal <=3000
group by deptno, job 
having avg(sal)>=2000
order by deptno, job;

--조인(join) 하나 이상의 테이블을 연결하여 조건에 만족하는 자료를 추출하는 기능.
---직원이름, 부서번호, 부서명을 추출하는 쿼리문을 기술하시오.
SELECT e.ename, d.deptno, d.dname from emp e, dept d;

---.직접연결연산자(direct 연산자 : .) 소유 연산자라고 한다. 밑에서emp.deptno는 꼭!
SELECT ename, emp.deptno, dname from emp, dept 
where emp.deptno = dept.deptno;

select *from emp;
select *from dept;

-- cartesian product : 카티션 곱
-- 두 개 이상의 테이블에 존재하는 모든 데이터를 검색 결과로 갖는다.
-- 두 개 이상의 테이블에 공통되는 컬럼이 존재하지 않을 경우
select * from emp, dept;
select * from emp;
select * from dept;

-- equal join : 공통의 칼럼을 대상으로 테이블을 연결하는 기능
---사원 정보를 출력하되, 해당 사원의 부서에 대한 상세정보가 함께 출력되도록 구현
select empno, ename, dname, emp.deptno 
from emp, dept
where emp.deptno = dept.deptno;

---이름이 scott인 사원의 부서명을 찾아 이름과 부서명이 출력되는 쿼리문을 기술하시오.
select deptno 
from emp
where ename='SCOTT';

-- 서브쿼리 :  쿼리 안에 또 다른 쿼릴르 담아서 표현하는 것
select dname
from dept
where deptno = (select deptno 
from emp
where ename='SCOTT');

select * from emp, dept where emp.deptno = dept.deptno;

select ename, dname
from emp, dept
where ename = 'SCOTT' and emp.deptno = dept.deptno;

--- 위 문장을 join없이 한다면,
select emp.ename, dept.dname 
from emp, dept where emp.deptno = dept.deptno and ename = 'SCOTT';

---테이블 명에 별칭을 사용할 수 있다.
select e.ename, d.dname 
from emp e, dept d where e.deptno = d.deptno and ename = 'SCOTT';

---급여가 2500이하이고, 사원번호가 9999이하인 사원의 정보를 출력하시오.
select empno, ename, sal, emp.deptno, dname, loc
from emp, dept
where sal <= 2500 and empno <= 9999 and emp.deptno = dept.deptno;

--equi join 동일한 값을 가진 컬럼을 대상으로 연결(=)
--non equi join

select * from tab;
select * from salgrade;
select * from emp;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;

select ename, dname, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno and sal between losal and hisal;

--self join : 자신과 조인을 하는 기법
---직원 테이블을 이용하여 해당 직원의 상사의 이름을 추출하시오
select * from emp;
--내 이름과 매니저의 이름을 알고싶다
select e.ename, m.ename from emp e, emp m
where e.mgr = m.empno; ---228쪽 참고하고 읽어봐 반드시

--outer join : 외부 조인
---조인 조건에 맞고하지 않는 행도 나타내는 조인 기법

select e.ename, m.ename from emp e, emp m
where e.mgr = m.empno(+);  ---앞의 식과 달리 (+)를 더해서 m이라는 레코드랑 일치하지 않아도 다 나오게 해라는 뜻이다.

--left outer join, right outer join
select deptno from emp where ename='SCOTT';
select dname from dept where deptno=20;
select dname from dept 
where deptno=(select deptno from emp where ename='SCOTT');

--단일행 서브 쿼리 : 수행의 결과가 하나의 레코드(행)으로만 반환하는 것
---단일행 비교 연산자 : =(같다), <>(같지않다.), >, >=, <, <=

---사원들의 평균 급여보다 더 많은 급여를 받는 사원을 추출하는 쿼리를 추출하쇼
select ename, sal from emp
where sal > avg(sal); ---아이고 그룹 함수니깐 오류가 나지...ㅠ 

select ename, sal
from emp
where sal > (select avg(sal) from emp);

---scott의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 추출하시오
select ename, sal from emp
where sal = (select sal(SCOTT) from emp);--이건 scott추출하는 게 틀렸어

---scott의 급여를 먼저 알아야해
select sal from emp
where ename = 'SCOTT'

select ename, sal from emp
where sal >= (select sal from emp
where ename = 'SCOTT'); ---이게 정답이다 응?

-- 다중행 서브 쿼리  : 서브쿼리의 결과가 두 개 이상인 것
-- 다중행 연산자 : in(포함하고 있는), any(어느거 하나라도), some, all
---in : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 하나라도 일치하면 참
---Q.급여가 3000이상 받는 직원의 부서와 동일한 부서에 근무하는 직운의 정보를 추출하시오.
select ename, sal, deptno from emp 
where sal >= 3000;

select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp 
where sal >= 3000);

select ename, sal, deptno from emp
where deptno in (10,20);

----where deptno = 10 or deptno = 20 (위의 조건 식과 같은 뜻)

-- any, some :  메인 쿼리의 비교 조건이 서브 쿼리의 결과와 하나 이상 일치하면 참
-- < any : 찾은 값에 대하여 하나라도 크면 참
-- >any : 찾은 값에 대하여 하나라도 작으면 참
----부서 번호가 30번인 사운의 급여 중 가장 작은 값(950) 보다 높은 급여를 받는 사원 대한 정보를 추출해봐

select sal from emp
where deptno = 30;

select ename, sal from emp
where sal > any(select sal from emp
where deptno = 30);

--all : 메인 쿼리의 비교 조건이 서브 쿼리의 결과와 모두 일치하면 참
--- < all : 최솟값 반환
--- > all : 최댓값 반환
----부서번호가 30번인 사운의 급여 중 가장 많이 받는 사운보다 더 높은 급여를 받는 사원의 정보를 추출하시오
select sal from emp
where deptno = 30;

select ename, sal from emp
where sal >all (select sal from emp
where deptno = 30);

-- exist : 메인쿼리의 비교 조건이 서브쿼리의 결과주에 만족하는 값이 하나라도 존재하면 참
---dept테이블에서 deptno가 10 또는 20인 데이터가 존재한다면, emp 테이블에 해당 컬럼을 추출하쇼.
select ename, deptno from emp
where deptno = 50;

select ename, deptno from emp
where (select 1 from dept d, deptno in(12, 20));