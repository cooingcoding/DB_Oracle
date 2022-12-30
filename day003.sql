-- ��(data type)��ȯ �Լ� : ����, ����, ��¥ ������ ���� �ٸ� ������ ������ ��ȯ�� �� ���� �Լ�
-- ���� : to_number, to_char, to_date
-- number, charracter, date ex)���ڸ� ���ڷ� �ٲ� �� to_char����.
select sysdate from dual; --������ ���̺��� ���� �� dual

--format(����) : yy/yyyy, mm, dd(���ڸ��� ǥ���ض� ��� ��)
select sysdate, to_char(sysdate, 'yyyy-mm-dd') from dual;

-- ������� �Ի����� ����ϵ�, ������ �Բ� ����ϴ� �������� ����Ͻÿ�.
-- day : ����
select hiredate, to_char(hiredate, 'yyyy-mm-dd day')
from emp;

--���� �ý����� ��¥�� �ð��� ����ϴ� �������� ����Ͻÿ�
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss')
from dual;

select sal from emp;
--���⼭ �� ǥ�ø� �ϰ� ���� �� [L�� ������ ��ȭ ��ȣ�� �ٴ´�.]
--���Ŀ��� ���ڸ� ����ؼ� ���� ��ȣ 2���� : 0�� 9
--�������� ���� 10, �� 10�̶�� ���� �ڿ� ���� ���̰� ���� �� ���ı�ȣ=>00�� or 99��
--������ ���� 8 =>08�� or 8��
--�� �޿��� 1000���̰� ���ڸ����� ��ǥ�� ���̰� ������ ��� �ؾ��ұ�? 
---���ı�ȣ 0,000�� : 1,000 �� / 800�� : 0,800��
---�ڸ����� ���� ���� ��� 0�� 0���� ä���, 9�� ä���� �ʴ´�.
select ename, sal, to_char(sal, 'L99,999')
from emp;

--to_date : �������� ��¥������ ��ȯ�ϴ� �Լ�
--�⺻ ��¥ ���� : yy/mm/dd 
--ex. �ֹε�� ���ڸ��� ���ִ� ���, 123456-0 �̰� ������ ����⵵�� ���� ��, ��¥ �������� ��� �� �� �ִ�.
select ename, hiredate
from emp
where hiredate=to_date(19810220, 'yyy/mm/dd');

--to_number : �������̳� ��¥���� ���������� ��ȯ�ϴ� �Լ�
---20,000�� 10,000 �� ������ ���� �˾ƺ��� ����(���ڻ��̿� ��ǥ�� ������ ���ڰ� �ƴ϶� �����̴�.)
select to_number('20,000', '99,999') - to_number('10,000', '99,999')
from dual;

select 20000 - 10000 from dual;

--NVL �Լ� :  NULL�� �ٸ� ������ ��ȯ�ϴ� �Լ� (Ŀ�̼ǿ� �ִ� �ΰ��� ������ 0�ε� 0���� ����ϰ� �;�)
select * from emp;
---������ ������ ����� ����ϴ� �������� ����Ͻÿ�
---���� = ������ �޿� *12 + comm (NULL���� ���� ������ ��������� �ȵȴ�.)
select ename, sal, sal*12+comm as "����"
from emp; --�̷��� ������ Ŀ�̼� ����� �ȵȴ�.

select ename, sal, sal*12+NVL(comm, 0) as "����" from emp;

--�׷��Լ�(Group Fruntion) : �Լ��� ���� �� ��, �׷����� ��� �Լ��� �����Ѵٴ� ��
--                          �ϳ� �̻��� ���� �׷����� ��� �����ϴ� �Լ�
--�������� ��� �ϴ� �Լ�
---sum : �ش� �÷��� ������ ���ϴ� �Լ�
---������� �޿��� ������ ����ϴ� �������� ����Ͻÿ�
select sum(sal) from emp;  ---�̰��� ���ؼ� ������� �Լ��� �����̴�.
select ename, sum(sal) from emp;---�̰� ���� �߻� �׷��Լ��� ������ ���;� �ؼ�

select sum(comm) from emp;  ---�׷��Լ��� null�� �����ϰ� ����Ѵ�. �ٸ� �����ڴ� null���� ������ �ȵ�.

-- avg() : �ش� �÷� ���� ����� ���ϴ� �Լ�
-- ���� �޿��� ����� ����ϴ� �������� ����Ͻÿ�.
select avg(sal) from emp;
select round(avg(sal)) from emp; ---�Ҽ��� ���Ͽ��� �ݿø��϶�.

-- max/min : �ִ񰪰� �ּڰ��� ���ϴ� �Լ�
-- ���� ���� �޿��� ���� �޿��� �����ϴ� �������� ����Ͻÿ�.
select max(sal) as "�ִ�޿�", min(sal) "�ּұ޿�" from emp;
--- ���� ���� �޿��� �޴� ������ �̸��� �޿��� �����ϴ� �������� ����Ͻÿ�.
select ename, sal from emp where sal = max(sal); ---������ ���´�. where�� �ƴ϶�gruop by

--count : ���ǿ� �����ϴ� ���� ������ ��ȯ�ϴ� �Լ�
--count �Լ��� Ư�� �÷��� ������ �ش� �÷��� ���� ��� �ִ� ���� ������ ��ȯ
--count �Լ��� NULL���� ���� ������ ���� �ʴ´�.
---������ ���� �����ϴ� �������� ���Ͻÿ�.
select count(*) from emp;
select count(ename) from emp;
---�������� ����ϴ� ������ �Ǽ��� ����Ͽ� �����ϴ� �������� ����Ͻÿ�
select * from emp;
select count(job) from emp; ---�̰� ����
select count(distinct job) from emp;  ---�̷��� �ؾ� �����̴� �˰ڳ�?

-- group by �� : Ư�� Į���� �������� �׷�ȭ�Ͽ� �ش� �׷쿡 �����ϴ� ���ڵ带 ������� ��������ϴ� �Լ�
-- �׷� �Լ��� ����ϵ�, Ư�� �÷��� ������� ���������� ����� �� ���
--- ������ �޿��� ���� �����ϴ� �������� �����Ͻÿ�. ��, �� �λ纰 ������ �޿��� ���� ��µǵ��� ����� ��
---�μ��� �޿��� ���� ����ϴ� �������� �����Ͻÿ�
select distinct deptno from emp;
select deptno, sum(sal) from emp group by deptno;  --- group by�� ���� ������ �׷��Լ��� �Ϲ��Լ��� ���� �� �� �ִ�.

---�ҼӺμ��� �޿��� ���հ� ��ձ޿��� �����ϴ� ������ ����Ͻÿ�.
---��, �μ���ȣ, �ѱ޿�, ��ձ޿���� �÷����� ǥ���Ͻÿ�.
select * from emp;
select deptno "�μ���ȣ", sum(sal) "�ѱ޿�", avg(sal) "��ձ޿�"
from emp 
group by deptno;

---�μ��� ������� Ŀ�̼��� �޴� ����� ���� �����ϴ� �������� ���Ͻÿ�.
select deptno,count(*) "�����", count(comm) "Ŀ�̼ǹ޴»��" 
from emp group by deptno;
---gruop by ���� ���� �� �ִ�.

-- having �� : group by ���� ���� ������ ��� ���� ���ϴ� ���� ���� ��� ��
---������ :  where��(ȥ�� ���� ����)�� having��(group by�� �����)
---�μ��� ��ձ޿��� ����ϴ� �������� ����Ͻÿ�.
select deptno, round(avg(sal))
from emp group by deptno;

select deptno, round(avg(sal))
from emp group by deptno
having avg(sal)>=2000;

--- �μ��� ���޴��� �޿��� ����� �����Ѵ� �������� ����Ͻÿ�.
select deptno, job, round(avg(sal)) from emp group by deptno, job
order by deptno;

select ename, deptno, avg(sal)
from emp
group by deptno; ---�̰� ename������ ������ ����. ���� �׷����� ���� �� ����.(188p~)

select deptno, job, avg(sal)
from emp
where sal <=3000
group by deptno, job 
having avg(sal)>=2000
order by deptno, job;

--����(join) �ϳ� �̻��� ���̺��� �����Ͽ� ���ǿ� �����ϴ� �ڷḦ �����ϴ� ���.
---�����̸�, �μ���ȣ, �μ����� �����ϴ� �������� ����Ͻÿ�.
SELECT e.ename, d.deptno, d.dname from emp e, dept d;

---.�������Ῥ����(direct ������ : .) ���� �����ڶ�� �Ѵ�. �ؿ���emp.deptno�� ��!
SELECT ename, emp.deptno, dname from emp, dept 
where emp.deptno = dept.deptno;

select *from emp;
select *from dept;

-- cartesian product : īƼ�� ��
-- �� �� �̻��� ���̺� �����ϴ� ��� �����͸� �˻� ����� ���´�.
-- �� �� �̻��� ���̺� ����Ǵ� �÷��� �������� ���� ���
select * from emp, dept;
select * from emp;
select * from dept;

-- equal join : ������ Į���� ������� ���̺��� �����ϴ� ���
---��� ������ ����ϵ�, �ش� ����� �μ��� ���� �������� �Բ� ��µǵ��� ����
select empno, ename, dname, emp.deptno 
from emp, dept
where emp.deptno = dept.deptno;

---�̸��� scott�� ����� �μ����� ã�� �̸��� �μ����� ��µǴ� �������� ����Ͻÿ�.
select deptno 
from emp
where ename='SCOTT';

-- �������� :  ���� �ȿ� �� �ٸ� ������ ��Ƽ� ǥ���ϴ� ��
select dname
from dept
where deptno = (select deptno 
from emp
where ename='SCOTT');

select * from emp, dept where emp.deptno = dept.deptno;

select ename, dname
from emp, dept
where ename = 'SCOTT' and emp.deptno = dept.deptno;

--- �� ������ join���� �Ѵٸ�,
select emp.ename, dept.dname 
from emp, dept where emp.deptno = dept.deptno and ename = 'SCOTT';

---���̺� �� ��Ī�� ����� �� �ִ�.
select e.ename, d.dname 
from emp e, dept d where e.deptno = d.deptno and ename = 'SCOTT';

---�޿��� 2500�����̰�, �����ȣ�� 9999������ ����� ������ ����Ͻÿ�.
select empno, ename, sal, emp.deptno, dname, loc
from emp, dept
where sal <= 2500 and empno <= 9999 and emp.deptno = dept.deptno;

--equi join ������ ���� ���� �÷��� ������� ����(=)
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

--self join : �ڽŰ� ������ �ϴ� ���
---���� ���̺��� �̿��Ͽ� �ش� ������ ����� �̸��� �����Ͻÿ�
select * from emp;
--�� �̸��� �Ŵ����� �̸��� �˰�ʹ�
select e.ename, m.ename from emp e, emp m
where e.mgr = m.empno; ---228�� �����ϰ� �о�� �ݵ��

--outer join : �ܺ� ����
---���� ���ǿ� �°����� �ʴ� �൵ ��Ÿ���� ���� ���

select e.ename, m.ename from emp e, emp m
where e.mgr = m.empno(+);  ---���� �İ� �޸� (+)�� ���ؼ� m�̶�� ���ڵ�� ��ġ���� �ʾƵ� �� ������ �ض�� ���̴�.

--left outer join, right outer join
select deptno from emp where ename='SCOTT';
select dname from dept where deptno=20;
select dname from dept 
where deptno=(select deptno from emp where ename='SCOTT');

--������ ���� ���� : ������ ����� �ϳ��� ���ڵ�(��)���θ� ��ȯ�ϴ� ��
---������ �� ������ : =(����), <>(�����ʴ�.), >, >=, <, <=

---������� ��� �޿����� �� ���� �޿��� �޴� ����� �����ϴ� ������ �����ϼ�
select ename, sal from emp
where sal > avg(sal); ---���̰� �׷� �Լ��ϱ� ������ ����...�� 

select ename, sal
from emp
where sal > (select avg(sal) from emp);

---scott�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� �����Ͻÿ�
select ename, sal from emp
where sal = (select sal(SCOTT) from emp);--�̰� scott�����ϴ� �� Ʋ�Ⱦ�

---scott�� �޿��� ���� �˾ƾ���
select sal from emp
where ename = 'SCOTT'

select ename, sal from emp
where sal >= (select sal from emp
where ename = 'SCOTT'); ---�̰� �����̴� ��?

-- ������ ���� ����  : ���������� ����� �� �� �̻��� ��
-- ������ ������ : in(�����ϰ� �ִ�), any(����� �ϳ���), some, all
---in : ���� ������ �� ������ ���� ������ ��� �߿��� �ϳ��� ��ġ�ϸ� ��
---Q.�޿��� 3000�̻� �޴� ������ �μ��� ������ �μ��� �ٹ��ϴ� ������ ������ �����Ͻÿ�.
select ename, sal, deptno from emp 
where sal >= 3000;

select ename, sal, deptno from emp
where deptno in (select distinct deptno from emp 
where sal >= 3000);

select ename, sal, deptno from emp
where deptno in (10,20);

----where deptno = 10 or deptno = 20 (���� ���� �İ� ���� ��)

-- any, some :  ���� ������ �� ������ ���� ������ ����� �ϳ� �̻� ��ġ�ϸ� ��
-- < any : ã�� ���� ���Ͽ� �ϳ��� ũ�� ��
-- >any : ã�� ���� ���Ͽ� �ϳ��� ������ ��
----�μ� ��ȣ�� 30���� ����� �޿� �� ���� ���� ��(950) ���� ���� �޿��� �޴� ��� ���� ������ �����غ�

select sal from emp
where deptno = 30;

select ename, sal from emp
where sal > any(select sal from emp
where deptno = 30);

--all : ���� ������ �� ������ ���� ������ ����� ��� ��ġ�ϸ� ��
--- < all : �ּڰ� ��ȯ
--- > all : �ִ� ��ȯ
----�μ���ȣ�� 30���� ����� �޿� �� ���� ���� �޴� ���� �� ���� �޿��� �޴� ����� ������ �����Ͻÿ�
select sal from emp
where deptno = 30;

select ename, sal from emp
where sal >all (select sal from emp
where deptno = 30);

-- exist : ���������� �� ������ ���������� ����ֿ� �����ϴ� ���� �ϳ��� �����ϸ� ��
---dept���̺��� deptno�� 10 �Ǵ� 20�� �����Ͱ� �����Ѵٸ�, emp ���̺� �ش� �÷��� �����ϼ�.
select ename, deptno from emp
where deptno = 50;

select ename, deptno from emp
where (select 1 from dept d, deptno in(12, 20));