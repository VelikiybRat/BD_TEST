-- додаємо нового клієнта
insert into Clients (client_id, full_name, phone_number, email_address) 
values (101, 'Іван Романенко', '0682304151', 'velikiybrat1702@gmail.com');

-- додаємо нову позицію в меню
insert into Dishes (dish_id, dish_title, dish_desc, price, dish_category) 
values (14, 'Паста Карбонара', 'Класична італійська паста з беконом', 285.50, 'Гаряче');

-- фіксуємо оплату замовлення
update Client_Orders 
set order_status = 'Оплачено та закрито' 
where order_id = 10;

-- коригуємо ціну страви
update Dishes 
set price = 299.00 
where dish_id = 14;

-- прибираємо зайву страву з чеку клієнта
delete from Order_Details 
where order_id = 10 and dish_id = 3;

-- чистимо неактивного юзера
delete from Clients 
where client_id = 77;

-- генеруємо чек для клієнта (з нормальними назвами колонок)
select 
    d.dish_title as "Назва",
    od.portions_count as "К-ть",
    d.price as "Ціна",
    (od.portions_count * d.price) as "До сплати"
from Order_Details od
inner join Dishes d on d.dish_id = od.dish_id
where od.order_id = 102;

-- шукаємо столики, які зараз вільні (через not exists)
select table_num, guests_capacity, table_location 
from Restaurant_Tables t
where not exists (
    select 1 
    from Client_Orders o 
    where o.table_id = t.table_id 
    and o.order_status in ('Створено', 'Готується', 'Видано')
);
