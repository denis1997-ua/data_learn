--Overview

select
	count(distinct o.order_id) "Orders",
	count(distinct o.customer_id) Customers,
	round(sum(o.sales), 2) "Total Sales, $",
	round(sum(o.sales) / count(distinct o.order_id), 2) "Average Order Value, $",
	round(sum(o.sales) / count(distinct o.customer_id), 2) "Sales per Customer, $",
	round(sum(o.profit), 2) "Total Profit, $",
	round(sum(o.profit) / sum(o.sales) * 100, 2) "Profit Ratio, %",
	round(avg(o.discount) * 100, 2) "Avg. Discount, %"
from
	orders o
	
	
-- Monthly Sales by Segment

select
	to_char(to_date(o.order_date, 'MM/DD/YYYY'), 'YYYY-MM') "year-month",
	o.segment,
	round(sum(o.sales), 2) sales
from
	orders o
group by 1, 2
order by 1, 2


--Montly Sales by Product Category

select
	to_char(to_date(o.order_date, 'MM/DD/YYYY'), 'YYYY-MM') "year-month",
	o.category,
	round(sum(o.sales), 2) sales
from
	orders o
group by 1, 2
order by 1, 2


--Sales by Product Category over time

select
	o.category,
	round(sum(o.sales), 2) sales
from
	orders o
group by o.category
order by sales desc


--Customer Ranking

select
	o.customer_name,
	round(sum(o.profit)) profit
from
	orders o
group by 1
order by profit desc


--Sales per region

select
	o.region,
	o.state,
	round(sum(o.sales), 2) sales
from
	orders o
group by o.region, o.state
order by o.region, sales desc


--Returns

select
	o.order_id,
	coalesce(r.returned, 'No') returned,
	round(sum(sales), 2) sales
from
	orders o
		left join "returns" r
			on o.order_id = r.order_id
group by 1, 2
order by sales desc