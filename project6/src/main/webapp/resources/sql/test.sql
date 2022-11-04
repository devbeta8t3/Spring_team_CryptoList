create table tbl_favorite (
    u_id varchar2(20) not null,
    symbol varchar2(10) not null
);
drop table tbl_favorite;

insert into tbl_favorite values ('aaa', 'BTC');
insert into tbl_favorite values ('aaa', 'ADA');
insert into tbl_favorite values ('aaa', 'ETH');
insert into tbl_favorite values ('aaa', 'XRP');
insert into tbl_favorite values ('aaa', 'FTT');
insert into tbl_favorite values ('aaa', 'TRX');
insert into tbl_favorite values ('aaa', 'FLOW');

select u_id, symbol from tbl_favorite where u_id = 'aaa';