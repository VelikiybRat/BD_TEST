-- загальний денний дохід за останній місяць
select 
    date(o.created_at) as work_date,
    sum(od.portions_count * d.price) as daily_profit
from client_orders o
inner join order_details od on o.order_id = od.order_id
inner join dishes d on od.dish_id = d.dish_id
where o.created_at >= current_date - interval '1 month'
group by date(o.created_at)
order by work_date desc;

-- топ-10 найбільш популярних позицій меню
select 
    d.dish_title as menu_item,
    sum(od.portions_count) as total_sold
from order_details od
left join dishes d on od.dish_id = d.dish_id
group by d.dish_title
order by total_sold desc
limit 10;

-- середня вартість замовлення за часом доби (сніданок, обід, вечеря)
select 
    case 
        when extract(hour from o.created_at) between 6 and 11 then 'сніданок'
        when extract(hour from o.created_at) between 12 and 16 then 'обід'
        else 'вечеря'
    end as part_of_day,
    round(avg(receipt_totals.total_sum), 2) as average_check
from client_orders o
inner join (
    select od.order_id, sum(od.portions_count * d.price) as total_sum
    from order_details od
    inner join dishes d on od.dish_id = d.dish_id
    group by od.order_id
) receipt_totals on o.order_id = receipt_totals.order_id
group by 
    case 
        when extract(hour from o.created_at) between 6 and 11 then 'сніданок'
        when extract(hour from o.created_at) between 12 and 16 then 'обід'
        else 'вечеря'
    end;

-- клієнти з найбільшими витратами
with vip_clients as (
    select 
        c.client_id,
        c.full_name,
        sum(od.portions_count * d.price) as total_money_spent
    from clients c
    inner join client_orders o on c.client_id = o.client_id
    inner join order_details od on o.order_id = od.order_id
    inner join dishes d on od.dish_id = d.dish_id
    group by c.client_id, c.full_name
)
select full_name, total_money_spent
from vip_clients
order by total_money_spent desc
limit 5;
