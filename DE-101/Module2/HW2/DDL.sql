-- create schema
CREATE SCHEMA data_model;

-- DIM Table
CREATE TABLE data_model."shipping_dim"
(
 "ship_id"   serial NOT NULL,
 "ship_mode" varchar(16) NOT NULL,
 CONSTRAINT "PK_shipping_dim" PRIMARY KEY ( "ship_id" )
);

-- insert unique values + generate id
insert into data_model.shipping_dim
select
	100 + row_number() over() "id",
	"a".ship_mode
from
	(
		select
			distinct o.ship_mode
		from
			public.orders o
	) "a"
	
-- check data
select
	*
from
	data_model.shipping_dim