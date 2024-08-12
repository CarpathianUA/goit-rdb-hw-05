-- 1
select od.*,
       (select o.customer_id from orders o where o.id = od.order_id) customer_id
        from order_details od limit 30;

-- 2
select * from order_details where order_id in (select id from orders where shipper_id = 3) limit 30;

-- 3
select order_id, avg(qty_10.quantity) "qty > 10\ avg"
from (select * from order_details where quantity > 10) qty_10
group by order_id limit 30;

-- 4
with temp as (select * from order_details where quantity > 10)
select order_id, avg(quantity) "qty > 10\ avg" from temp
group by order_id limit 30;

-- 5
drop function if exists floats_division;

delimiter //

create function floats_division(numerator float, denominator float)
returns float
deterministic
begin
    if denominator = 0 then
        return null;
    else
        return numerator / denominator;
    end if;
end //

delimiter ;

select od.order_id, od.quantity qty, floats_division(od.quantity, 2) divided_qty
from order_details od limit 10;
