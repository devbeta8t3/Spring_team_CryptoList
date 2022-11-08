-- users
CREATE TABLE USERS(
   U_ID varchar2(20) primary key,
   U_NAME varchar2(20) NOT NULL,
   U_EMAIL varchar2(40) NOT NULL,
   U_PW varchar2(40) NOT NULL,
   U_REGDATE date default sysdate
 );

-- favorites
create table cryptoFavorite (
	u_id varchar2(20) not null,
	symbol varchar2(10) not null
);
alter table cryptoFavorite ADD CONSTRAINT fk_fav foreign KEY(u_id) references users (u_id);
drop table cryptoFavorite;

insert into cryptoFavorite values ('aaa', 'BTC');
insert into cryptoFavorite values ('aaa', 'ADA');
insert into cryptoFavorite values ('aaa', 'ETH');
insert into cryptoFavorite values ('aaa', 'XRP');
insert into cryptoFavorite values ('aaa', 'FTT');
insert into cryptoFavorite values ('aaa', 'TRX');
insert into cryptoFavorite values ('aaa', 'FLOW');

select u_id, symbol from cryptoFavorite where u_id = 'aaa';
