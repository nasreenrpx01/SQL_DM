-- using practice database
use practicedb;

-- view the entire table
select * from marketing;

-- check the available years in the data
select distinct(year(c_date)) as year
from marketing;

-- data contains only feb 2021 records
select distinct(format(cast(c_date as date), 'MM')) as month
from marketing
where isdate(c_date) = 1;

-- total unique campaigns
select distinct(campaign_name)
from marketing;

-- list the different source categories
select distinct(category)
from marketing;

-- count number of campaigns per category
select category, count(distinct(campaign_name)) as campaign_count
from marketing
group by category;

-- category with the highest and lowest spend
select category, campaign_name, sum(mark_spent) as total_spent
from marketing
group by category, campaign_name
order by sum(mark_spent) desc;

-- add calculated metrics for campaign evaluation
alter table marketing
add ctr float,
    cpc float,
    cpl float,
    cpql float;

-- calculate ctr, cpc, cpl, cpql for each row
update marketing
set ctr = case 
             when impressions > 0 then round((clicks * 1.0 / impressions) * 100, 2) 
             else 0 
          end,
    cpc = case 
             when clicks > 0 then round(mark_spent / clicks, 2) 
             else 0 
          end,
    cpl = case 
             when leads > 0 then round(mark_spent / leads, 2) 
             else 0 
          end,
    cpql = case 
             when orders > 0 then round(mark_spent / orders, 2) 
             else 0 
          end;

-- assign week numbers for february (split into 4 weeks)
alter table marketing
add week_number int;

update marketing
set week_number = case 
    when day(c_date) between 1 and 7 then 1
    when day(c_date) between 8 and 14 then 2
    when day(c_date) between 15 and 21 then 3
    when day(c_date) between 22 and 28 then 4
    else null
end;

-- spend and performance by campaign
select campaign_name,
       sum(mark_spent) as total_spent,
       sum(impressions) as total_impressions,
       sum(clicks) as total_clicks,
       sum(leads) as total_leads,
       sum(orders) as total_qls,
       sum(revenue) as total_revenue,
       round(sum(clicks) * 100.0 / nullif(sum(impressions), 0), 2) as ctr,
       round(sum(mark_spent) / nullif(sum(clicks), 0), 2) as cpc,
       round(sum(mark_spent) / nullif(sum(leads), 0), 2) as cpl,
       round(sum(mark_spent) / nullif(sum(orders), 0), 2) as cpql
from marketing
group by campaign_name
order by total_spent desc;

-- spend and performance by category
select category,
       sum(mark_spent) as total_spent,
       sum(impressions) as total_impressions,
       sum(clicks) as total_clicks,
       sum(leads) as total_leads,
       sum(orders) as total_qls,
       sum(revenue) as total_revenue,
       round(sum(clicks) * 100.0 / nullif(sum(impressions), 0), 2) as ctr,
       round(sum(mark_spent) / nullif(sum(clicks), 0), 2) as cpc,
       round(sum(mark_spent) / nullif(sum(leads), 0), 2) as cpl,
       round(sum(mark_spent) / nullif(sum(orders), 0), 2) as cpql
from marketing
group by category
order by total_spent desc;

-- weekly performance split by category
select 
    week_number,
    category,
    sum(impressions) as total_impressions,
    sum(mark_spent) as total_spent,
    sum(clicks) as total_clicks,
    sum(leads) as total_leads,
    sum(orders) as total_orders,
    sum(revenue) as total_revenue,
    round(avg(ctr), 2) as avg_ctr,
    round(avg(cpc), 2) as avg_cpc,
    round(avg(cpl), 2) as avg_cpl,
    round(avg(cpql), 2) as avg_cpql
from marketing
group by week_number, category
order by week_number;


-- 1. total performance by week
select 
    week_number,
    sum(impressions) as total_impressions,
    sum(clicks) as total_clicks,
    sum(orders) as total_conversions,
    sum(revenue) as total_revenue
from Marketing
group by week_number
order by week_number;

-- 2. best campaign by week (based on highest revenue)
select 
    week_number,
    campaign_name,
    sum(revenue) as total_revenue
from Marketing
group by week_number, campaign_name
order by week_number, total_revenue desc;

-- 3. best campaign by category (based on highest conversion rate)
select 
    category,
    campaign_name,
    sum(clicks) as total_clicks,
    sum(orders) as total_conversions,
    round((sum(orders) * 100.0 / nullif(sum(clicks), 0)), 2) as conversion_rate
from Marketing
group by category, campaign_name
order by category, conversion_rate desc;

-- 4. overall top campaign for the month (based on revenue)
select 
    campaign_name,
    sum(revenue) as total_revenue
from Marketing
group by campaign_name
order by total_revenue desc
Limit 1;

-- 5. category-level weekly winner (campaign with max revenue in each category per week)
-- overall top campaign for the month (based on revenue)
select top 1
    campaign_name,
    sum(revenue) as total_revenue
from Marketing
group by campaign_name
order by total_revenue desc;

-- 6. roi (return on investment) calculation for each campaign
-- formula: (revenue - cost) / cost * 100
select 
    campaign_name,
    round(((sum(revenue) - sum(mark_spent)) / nullif(sum(mark_spent), 0)) * 100, 2) as roi_percentage
from Marketing
group by campaign_name
order by roi_percentage desc;
