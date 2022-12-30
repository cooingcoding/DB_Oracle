-- DDL(정의문) : create table - 새로운 테이블을 생성하는 sql 명령어
create table emp01(
 empno number(4),
 ename varchar2(20),
 sal number(7, 2)
);

-- 테이블의 구조 확인 : desc
desc emp01;

--테이블 삭제
drop table emp02;
--기존 테이블 확인
select * from emp;
-- 새로운 테이블을 생성할 때 기존의 테이블과 동일한 구조로 이루어진 테이블 생성 시 :as
-- 구조와 내용을 함께 복사해서 새로운 테이블이 생성된다.(*가 내용까지 포함한다는 뜻)

create table emp02 as select * from emp;

--테이블 구조 확인(내용을 봐도 된다.)
select * from emp02;

--기존의 테이블에 일부 필드를 복사해서 새로운 테이블을 생성할 때
create table emp03 as select empno, ename from emp;

--내용 확인
select * from emp03;

-- 내용까지 복사하지 않고, 구조만 복사 할 수 있다. where이라는 조건절을 사용하여
-- 기존의 테이블의 구조만 이용하여 새로운 테이블 생성
--부서번호가 10번인 직원의 정보를 확인할 때
select * from emp where deptno = 10; --주어진 조건에 만족하는 자료만 복사

create table emp04 as select * from emp where deptno = 10;

select * from emp04;

-- 구조만 이용해서 조금 다른 형태를 띄는데, 구조만 복사했으면 내용을 갖고 잇지 않다.
create table emp05 as select * from emp where 1=0;  --where 1=0 항상 거짓인 조건이라 구조만 가져온다는 뜻)
select * from emp05;
desc emp05;

-- where 절 조건절, 주어진 조건이 참인것 만

--DDL(정의문) : alter table - 테이블 구조를 변경하는 sql명령어
                           --컬럼의 추가, 수정, 삭제 시 사용
                           --alter을 통해서 table을 추가할 때 : ~add(기존의 테이블에 새로운 컬럼을 추가하는 명령어)
                           
desc emp01;
alter table emp01 add(job varchar2(9));

-- add(), modifiy()
--수정을 할 때에는 alter modify를 쓴다.
--여기서 주의해야 할 것은 수정할 컬럼에 자료가 없는 경우 : 데이터 타입 변경가능, 컬럼의 크기 변경불가능
--- 수정 할 컬럼에 자료가 있는 경우 : 데이터 타입 불가, 컬럼의 크기 변경 불가하기도 하고 가능하다
--- 컬럼의 크기를 키울 수 있으나 작아지면 유실 될 수 있기 때문에 크기를 줄일 수 없다.
--- 데이터 타입이 일반적으로 불가능 하나, 자료가 기존에 있더라도 char와 varchar2 사이의 타입은 변경이 가능하다.

select * from emp01;
--컬럼의 크기를 변경하자
alter table emp01 modify(job varchar2(30));

-- alter 에는 추가와 수정뿐만아니라 컬럼을 제거할 수 있다.
--- alter table에 제거를 할 것이다. ~drop column : 테이블에 컬럼을 삭제하는 명령어
alter table emp01 drop column job;

desc emp01

--DDL - drop table 테이블을 제거하는 명령어
-- 한 번 제거 된 테이블은 복구를 할 수 없다.
-- 레코드는 복구 할 수 있다.(rollback)
desc emp01
drop table emp01;

-- 테이블 삭제 시 주의 사항
---무결성 제약 조건에 있는 테이블은 삭제 할 수 없다.
---삭제하고자 하는 테이블의 기본키나 고유키를 다른 테이블에서 참조하고 있는 경우

-- DDL - rename 테이블명을 변경하는 명령어
---기본의 사용하는 테이블의 이름을 변경할 때 사용
select *from emp05;
rename emp05 to test;
select *from test;

--DML(조작어) :  실제 일반 개발자에 의해서 사용되는 명령어 조합
-- 레코드 단위로 조작을 한다
-- DML - select~from ~where
-- DML - select 테이블의 내용(레코드)을 확인, 조건에 만족하는 레코드를 추출

select * --모든 컬럼(레코드)를 보여달라는 의미/ all
from emp;
--조건식은 참 또는 거짓으로 판정되는 것이다.
---참 또는 거짓 : 관계식(비교식, 대소관계식), 논리식
---관계식 : 같다(=), 같지않다(<>, !=), >,>=,<,<=
---논리식 : 집합과 같다. and(교집합, 논리곱 모두 참을 때 참), or(합집합, 논리합, 어느거 하나라도 참일 때 참)
---                   not(여집합, 논리부정, 참이면 거짓으로, 거짓이면 참으로)
select * from emp
where sal >= 2000;

select * from emp
where job = 'MANAGER';

select * from emp where sal>=2000 and job = 'MANAGER';

select empno, job, sal from emp
where sal>=2000 and job = 'MANAGER';

-- DML(조작어) : insert into ~ values()
--새로운 레코드를 추가할 때 사용하는 sql 명령어

create table dept01 as select * from dept where 1=0;
desc dept01

insert into dept01 values(10, 'accounting', 'new york'); --dept01옆에 안썻을 때는 모든 필드값을 넣는 것이다. 그래서 밸류즈 뒤에 세개의 값을 다 넣었다.

select * from dept01;

insert into dept01(deptno, dname) values(20, 'research');
---생략을 해도 만들어지나 값들이 매칭되는 것을 써줘야 한다.

insert into dept01(deptno, dname, loc) 
values (30, 'sales', 'chicago');
--기본키(개체무결성) : not null, 중복불가
create table sample(
    h_no number primary key, 
    h_name varchar2(10) not null,
    score number null
    );
    
insert into sample(h_no, h_name, score) values(1234, 'aaa', 88);
insert into sample(h_no, h_name, score) values(1234, 'bbb', 99);
insert into sample(h_no, h_name, score) values(2345, 'bbb', 89);
insert into sample(h_no, h_name, score) values(3456, 'ccc', 97);

select * from sample;

insert into sample(h_no, h_name, score) values(7777, 'ddd', 100);

--DML(조작어) : update ~ set
--테이블에 저장된 레코드를 수정하는 sql명령어
--where 절을 사용하지 않을 경우 모든 레코드의 값이 변경된다.

drop table emp01;
create table emp01 as select * from emp;

--모든 사운의 부서번호를 30번으로 수정
update emp01 set deptno = 30;
select * from emp01;

--사원의 급여를 10%인상하는 쿼리문을 기술하시오.
update emp01 set sal = sal * 1.1;

--모든 직원의 입사일을 오늘로 변경하시오
update emp01 set hiredate = sysdate;

--테이블 삭제
drop table emp01;
create table emp01 as select * from emp;

--부서 번호가 10번인 직원의 부서번호를 40으로 변경하는 쿼리문
update emp01 set deptno = 40 where deptno = 10;
select *from emp01;

--q. job이 MANAGER인 직원만 급여를 10%인상하는 쿼리문을 기술하시오.
update emp01 set sal = sal*1.1 where job = 'MANAGER';
select * from emp01;

--q. 1981년도에 입사한 직원의 입사일을 오늘로 변경하는 쿼리문을 기술하시오.
update emp01 set hiredate = sysdate where substr(hiredate, 1, 2) = '81';

select *from emp01;

drop table emp01;

create table emp01 as select * from emp;

--scott 사원의 부서번호는 20, job은 MANAGER로 변경하는 쿼리문을 추출하시오
update emp01 set deptno=20, job='MANAGER' where ename = 'SCOTT';

--scott의 입자날짜를 오늘로, 급여는 50으로, 커미션은 4000으로 변경하는 쿼리문
update emp01 set hiredate=sysdate, sal='50', comm='4000' where ename='SCOTT';

select * from emp01 where ename='SCOTT';

drop table dept01;
create table dept01 as select * from dept;
--부서번호가 20번이 부서의 지역명을 부서번호가 40번인 부서의 지역명으로 변경
select loc from dept01 where deptno = 40;
update dept01 
set loc = (select loc from dept01 where deptno = 40)
where deptno = 20;

select * from emp;

--DML :  delete ~ from ~ where
--테이블에 저장된 레코드를 삭제하는 명령문
--특정 행을 삭제할 경우 where 조건 절을 담는다.
select * from dept01;
delete from dept01;

--부서번호가 30번인 레코드를 삭제하는 쿼리문
delete from dept01 where deptno = 30;

drop table emp01;
create table emp01 as select * from emp;

--사원 테이블의 부서명이 'SALES'인 부서에 근무하는 모든 사원들을 삭제하는 쿼리문
select * from emp01;  --사원정보를 담고 있는 사원테이블
select * from dept01; --부서 정보를 담고 있는 부서테이블
select deptno from dept01 where dname = 'SALES';
delete from emp01 
where deptno = (select deptno from dept01 where dname = 'SALES');

--DCL(제어어) - 무결성, 병행부행 권한, 트랜잭션처리
--commit : 변경 내용을 데이터 베이스에 영구 저장(데이터 베이스의 원본이 바뀌는 것)
--rollback : 되돌리는 작업
-- 실제 개발자들은 commit과 rollback을 쓴다.그렇게는 자주 쓰지는 않음
-- 자동 commit 되는 경우 : DDL, DCL 명령문이 수행되는 경우, 정상종료
-- 자동 rollback 되는 경우 : 비정상종료 정전 혹은 컴퓨터 다운

drop table dept01;
create table dept01 as select * from dept;

delete from dept01;
select *from dept01;
rollback;

delete from dept01 where deptno = 20;
commit;
rollback;

-- 무결성 제약 조건 : 유효성 검사 규칙
-- 테이블의 부적절한 자료가 입력되는 것을 방지하기 위해 테이블을 생성할 때 사용하는 규칙
-- 무결성 : 정확성 유지./결정이 없다. 정확하게 데이터를 입력할 수 있어야 한다.
--제약조건 : 바람직하지 않은 데이터의 저장을 방지하는 것
select * from emp;
desc emp
select * from dept;
desc dept;

--primary key(기본키) : 반드시 입력되어야 하고(null값이 있으면 안됨) 유일한 값을 가져야 해
drop table dept01;
create table dept01 as select * from dept;

select * from dept01;
insert into dept01
values(10, 'TEST', 'BUSAN');

drop table dept02;
create table dept02 (
    deptno number(2) primary key,
    dname varchar2(20),
    loc varchar2(20));
    
    
select * from dept02;
insert into dept02 values(10, 'ACCOUNTING', 'NEW YOTK');
insert into dept02 values(10, 'TEST', 'BUSAN');
insert into dept02 values(20, 'RESEARCH', 'DALLAS');
insert into dept02 values(30, 'SALES', 'CHICAGO');
insert into dept02 values(40, 'OPERATIONS', 'BOSTON');
insert into dept02 values(50, 'ANALYSIST', 'BOSTON');
select * from dept02;

-- 기본키와 외래키에 대한 설정을 해보쟈아
drop table emp06;

create table emp06(
    empno number(4) primary key, --기본키 설정 비어있으면 안됨, 중복 안돼!
    ename varchar2(10) not null, --비어있으면 안돼~중복 됨
    job varchar2(9),
    deptno number(2) references dept02(deptno)
);


insert into emp06 values(1111, 'aaa', 'a', 10);
select * from emp06;
insert into emp06 values(2222, 'bbb', 'b', 20);
insert into emp06 values(3333, 'bbb', 'b', 50);
insert into emp06 values(3333, 'bbb', 'b', 50);
insert into emp06 values(4444, 'bbb', 'b', 50);