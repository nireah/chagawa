--����--------------------------------------------------------------------------
--ȸ������
drop table driver CASCADE CONSTRAINTS;
drop table member CASCADE CONSTRAINTS;
drop table grade CASCADE CONSTRAINTS;
--��������
drop table notice cascade constraints;
drop sequence notice_seq;
--����Ʈ
drop table point cascade constraints;
drop sequence point_seq;
--īǮ
DROP TABLE passenger CASCADE CONSTRAINTS;
DROP TABLE carpool CASCADE CONSTRAINTS;
DROP SEQUENCE carpool_seq;
--�޽���
drop trigger update_latest_message_content;
drop trigger update_set_room_status;
drop trigger message_trigger;

drop table messageRoom CASCADE CONSTRAINTS;
drop sequence messageRoom_seq;
drop table message CASCADE CONSTRAINTS;
drop sequence message_seq;

--�̿��ı�
DROP TABLE epilogue CASCADE CONSTRAINTS;
DROP TABLE starPoint CASCADE CONSTRAINTS;
DROP SEQUENCE epilogue_seq;
DROP SEQUENCE starPoint_seq;


--����------------------------------------------------------------------------------------------------
--ȸ������
create table grade(
    gradeNo number(2) primary key,
    gradeName varchar2(30) not null
);
create table member(
    id varchar2(20) primary key,
    pw varchar2(20) not null,
    nickname varchar2(30) not null unique,
    name varchar2(30) not null,
    profileImage varchar2(100),
    myPoint number(10) default 200,
    gender varchar2(6) not null check (gender in('����', '����')),
    birth varchar2(10) not null,
    tel varchar2(13) not null unique,
    bank varchar2(15) not null,
    account varchar2(20) not null,
    regDate date default sysdate,
    conDate date default sysdate,
    status varchar2(12) default '����' check (status in('����', 'Ż��', '�̿�����')),
    gradeNo number(2) default 1 REFERENCES grade(gradeNo) on delete cascade
);
create table driver(
    id varchar2(20) primary key REFERENCES member(id) on delete cascade,
    carModel varchar2(50) not null,
    carNo varchar2(11) not null unique,
    licenseNo varchar2(15) not null unique
);

--��������
create table notice(
no number primary key,
title varchar2(300) not null,
content varchar2(2000) not null,
startDate date default sysdate,
endDate date default '9999-12-31',
writeDate date default sysdate,
updateDate date default sysdate,
gnrFile varchar2(100),
imgFile varchar2(100)
);
create sequence notice_seq;

--����Ʈ
create table point(
no number primary key,
id varchar2(20) not null references member(id),
memo varchar2(300) not null,
runDate date default sysdate,
price number(10) not null
);
create sequence point_seq;

--īǮ
CREATE TABLE carpool (
   no NUMBER PRIMARY KEY,
   regTime DATE  DEFAULT sysdate NOT NULL,
   driverId VARCHAR2(20) NOT NULL REFERENCES member(id) ON DELETE CASCADE,
   startRegion VARCHAR2(100) NOT NULL,
   startAddress VARCHAR2(100) NOT NULL,
   startLat NUMBER NOT NULL,
   startLng NUMBER NOT NULL,
   arriveLat NUMBER NOT NULL,
   arriveLng NUMBER NOT NULL,
   arriveRegion VARCHAR2(100) NOT NULL,
   arriveAddress VARCHAR2(100) NOT NULL,
   startTimePre DATE NOT NULL,
   arriveTimePre DATE NOT NULL,
   startTime DATE,
   arriveTime DATE,
   status VARCHAR2(30) DEFAULT '������' NOT NULL CHECK (status IN ('������', '��ߴ��', '������', '����', '����', '���')),
   price NUMBER(10) NOT NULL,
   seats NUMBER(2) NOT NULL,
   memo VARCHAR2(500),
   reviewed NUMBER(2) DEFAULT 0 NOT NULL CHECK (reviewed IN (0, 1)),
   star NUMBER(2) DEFAULT 0 NOT NULL CHECK (star IN (0, 1))
);
CREATE SEQUENCE carpool_seq;

CREATE TABLE passenger (
   cpNo NUMBER REFERENCES carpool(no),
   psgId VARCHAR2(20) REFERENCES member(id) ON DELETE CASCADE,
   msg VARCHAR2(500),
   appTime DATE  DEFAULT sysdate NOT NULL,
   status VARCHAR2(30) DEFAULT '��û' NOT NULL CHECK (status IN ('��û', 'Ȯ��', 'ž��', '����', '����', '��ž��', '���')),
   fixed NUMBER(2) DEFAULT 0 NOT NULL CHECK (fixed IN (0, 1)),
   gotIn NUMBER(2) DEFAULT 0 NOT NULL CHECK (gotIn IN (0, 1)),
   arrived NUMBER(2) DEFAULT 0 NOT NULL CHECK (arrived IN (0, 1)),
   reviewed NUMBER(2) DEFAULT 0 NOT NULL CHECK (reviewed IN (0, 1)),
   star NUMBER(2) DEFAULT 0 NOT NULL CHECK (star IN (0, 1)),
   PRIMARY KEY(cpNo, psgId)
);

--�޽���
create table messageRoom(
    roomNo number PRIMARY key,
    par1 VARCHAR2(20) not null REFERENCES member(id),
    par2 VARCHAR2(20) not null REFERENCES member(id),
    LMContent varchar2(2000),
    CDate timestamp(0) default current_timestamp,
    roomstatus1 varchar2(10),
    roomstatus2 varchar2(10),
    unreadcount1 number(10) default 0,
    unreadcount2 number(10) default 0  
);
create SEQUENCE messageRoom_seq;
CREATE TABLE message(
    no NUMBER PRIMARY KEY,
    content VARCHAR2(2000) NOT NULL,
    sender VARCHAR2(20) NOT NULL REFERENCES member(id),
    sendDate DATE DEFAULT sysdate NOT NULL,
    accepter VARCHAR2(20) NOT NULL REFERENCES member(id),
    acceptDate date default null,
    roomno number references messageroom(roomNo)   
);
CREATE SEQUENCE message_seq;

--�̿��ı�
CREATE TABLE epilogue(
no NUMBER CONSTRAINT epilogue_no_pk PRIMARY KEY,
title VARCHAR2(300) NOT NULL,
content VARCHAR2(2000) NOT NULL,
writer VARCHAR2(20) NOT NULL REFERENCES MEMBER(id) ON DELETE CASCADE,
writeDate DATE DEFAULT sysdate,
cpNo NUMBER NOT NULL REFERENCES CARPOOL(no) ON DELETE CASCADE,
hit NUMBER DEFAULT 0
);
CREATE SEQUENCE epilogue_seq;

CREATE TABLE starPoint(
no NUMBER CONSTRAINT starPoint_no_pk PRIMARY KEY,
cpNo NUMBER NOT NULL REFERENCES CARPOOL(no)ON DELETE CASCADE,
starter VARCHAR2(20) NOT NULL REFERENCES MEMBER(id) ON DELETE CASCADE,
receiver VARCHAR2(20) NOT NULL REFERENCES MEMBER(id) ON DELETE CASCADE,
star NUMBER NOT NULL
);
CREATE SEQUENCE starPoint_seq;


--���õ�����-----------------------------------------------------------------------------------------------------------
--ȸ������
insert into grade values(1, '������');
insert into grade values(2, '������');
insert into grade values(9, '������');
commit;

insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('passenger', '1111', '�¿��ּ���', '��ö��', '/upload/member/chagawa.jpg', '2000.01.01', '����', '010-0000-1234', 'īī��', '3333-1234-0000', '1');
insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('passenger2', '1111', '��������ٷ�', '������', '/upload/member/chagawa.jpg', '1990.01.01', '����', '010-0000-1111', 'īī��', '3333-1111-000000', '1');
insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('passenger3', '1111', 'seventeen', '����ĥ', '/upload/member/chagawa.jpg', '2005.03.10', '����', '010-0000-2222', '�츮', '1111-222-000000', '1');

insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('driver', '1111', 'driver', '�����', '/upload/member/chagawa.jpg', '1994.01.01', '����', '010-0000-0001', '����', '0000-0000-0000', '2');
insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('driver2', '1111', '�����ýÿ�����', '�ڿ���', '/upload/member/chagawa.jpg', '1988.01.01', '����', '010-1111-0001', '����', '1234-000-5678', '2');
insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo)
values('driver3', '1111', '�������㶡', '�ֿ���', '/upload/member/chagawa.jpg', '1970.01.01', '����', '010-2222-0001', '��ü��', '1234-000-99999', '2');

insert into member(id, pw, nickname, name, profileImage, birth, gender, tel, bank, account, gradeNo, Mypoint)
values('admin', '1111', 'admin', '������', '/upload/member/chagawa.jpg', '1998.03.18', '����', '010-0000-0000', '�츮', '0000-000-000000', '9', '0');
commit;

insert into driver(id, carModel, carNo, licenseNo)
values('driver', '�̴�����', '123��1234', '12-34-567890-11');
insert into driver(id, carModel, carNo, licenseNo)
values('driver2', '�ƹݶ�', '12��1111', '12-34-567890-22');
insert into driver(id, carModel, carNo, licenseNo)
values('driver3', 'ī�Ϲ�', '22��3333', '12-34-567890-33');
commit;

--��������
insert into notice(no, title, content, startDate, endDate)
values(notice_seq.nextval, '�����������', '�����������', '2023-02-15', '2024-02-20');
insert into notice(no, title, content, startDate, endDate)
values(notice_seq.nextval, '������������', '������������', '2022-02-15', '2022-02-20');
insert into notice(no, title, content, startDate, endDate)
values(notice_seq.nextval, '�����������', '�����������', '2024-02-15', '2024-02-20');
commit;

--īǮ
INSERT INTO carpool
(no, driverId, startRegion, startAddress, arriveRegion, arriveAddress, startLat, startLng, arriveLat, arriveLng,
startTimePre, arriveTimePre, price, seats, memo)
VALUES
(carpool_seq.NEXTVAL, 'driver', '��� �����ν�', '�����ν�û', '��� �����ν�', '�����ο�', 37.737701693632, 127.03378547826114, 37.73771555559455, 127.0460608010701,
to_date('2023-02-17 08:50:00', 'YYYY-MM-DD hh:mi:ss'), to_date('2023-02-17 09:15:00', 'YYYY-MM-DD hh:mi:ss'), 500, 3, '������ ���� ��');

INSERT INTO passenger (cpNo, psgId, msg)
VALUES(1, 'passenger', '���� Ÿ��~');

INSERT INTO passenger (cpNo, psgId, msg)
VALUES(1, 'passenger2', '���� Ÿ�� �;��~');

UPDATE passenger SET fixed = 1, status = 'Ȯ��' WHERE cpNo = 1 AND psgId = 'passenger';
commit;
