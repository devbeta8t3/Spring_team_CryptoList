-- users 사용자 테이블
CREATE TABLE USERS(
   U_ID varchar2(20) primary key,
   U_NAME varchar2(20) NOT NULL,
   U_EMAIL varchar2(40) NOT NULL,
   U_PW varchar2(40) NOT NULL,
   U_REGDATE date default sysdate
);
------------------------------------------------------------------------
-- cryptoboard 게시판 테이블
CREATE TABLE cryptoboard (
   C_ID NUMBER primary key,
   U_ID varchar2(20),
   U_NAME varchar2(20) NOT NULL,
   SYMBOL varchar2(20) NOT NULL,
   C_DATE date default sysdate,
   C_UPDATE date default sysdate,
   CONTENT varchar2(500),
   CONSTRAINT FK_crytoboard foreign key(U_ID) references users(U_ID)
 );
-- 시퀀스 설정
create sequence cryptoboard_seq start with 1 increment BY 1 maxvalue 1000000; 
-- 테스트 데이터 cryptoboard
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'aaa', '이세환', 'BTC', sysdate, sysdate, 'First content');
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'aaa', '이세환', 'BTC', sysdate, sysdate, 'Second content');
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'aaa', '이세환', 'BTC', sysdate, sysdate, 'Third content');
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'aaa', '이세환', 'BTC', sysdate, sysdate, 'Fourth content');
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'bbb', '이세환2', 'BTC', sysdate, sysdate, 'Fifth content');
insert into cryptoBoard (c_id, u_id, u_name, symbol, c_date, c_update, content) 
values ( cryptoboard_seq.nextval, 'ddd', 'rgKim', 'BTC', sysdate, sysdate, '록길의 게시물 내용');
-- 삭제
drop table crytoboard;
drop sequence crytoboard_seq;
-----------------------------------------------------------------
-- cryptoFavorite 즐겨찾기 테이블
create table cryptoFavorite (
    u_id varchar2(20) not null,
    symbol varchar2(10) not null
);
-- FK 설정하기 (종속 삭제)
alter table cryptoFavorite ADD CONSTRAINT fk_fav foreign KEY(u_id) references users (u_id) ON DELETE CASCADE ENABLE;
-- 테스트 데이터 cryptoFavorite
insert into cryptoFavorite values ('aaa', 'BTC');
insert into cryptoFavorite values ('aaa', 'ADA');
insert into cryptoFavorite values ('aaa', 'ETH');
insert into cryptoFavorite values ('aaa', 'XRP');
insert into cryptoFavorite values ('aaa', 'FTT');
insert into cryptoFavorite values ('aaa', 'TRX');
insert into cryptoFavorite values ('aaa', 'FLOW');
-- 내용 확인
select u_id, symbol from cryptoFavorite where u_id = 'aaa';
-- 삭제
drop table cryptoFavorite;
