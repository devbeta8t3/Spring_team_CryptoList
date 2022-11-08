-- users 사용자 테이블
CREATE TABLE USERS(
   U_ID varchar2(20) primary key,
   U_NAME varchar2(20) NOT NULL,
   U_EMAIL varchar2(40) NOT NULL,
   U_PW varchar2(40) NOT NULL,
   U_REGDATE date default sysdate
 );

-- favorites 즐겨찾기 테이블
create table cryptoFavorite (
	u_id varchar2(20) not null,
	symbol varchar2(10) not null
);
-- FK 설정하기 (종속 삭제)
alter table cryptoFavorite ADD CONSTRAINT fk_fav foreign KEY(u_id) references users (u_id) ON DELETE CASCADE ENABLE;

-- 즐겨찾기 테스트 데이터 삽입
insert into cryptoFavorite values ('aaa', 'BTC');
insert into cryptoFavorite values ('aaa', 'ADA');
insert into cryptoFavorite values ('aaa', 'ETH');
insert into cryptoFavorite values ('aaa', 'XRP');
insert into cryptoFavorite values ('aaa', 'FTT');
insert into cryptoFavorite values ('aaa', 'TRX');
insert into cryptoFavorite values ('aaa', 'FLOW');

select u_id, symbol from cryptoFavorite where u_id = 'aaa';

drop table cryptoFavorite;