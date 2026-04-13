select * from products;
select * from sales;

create or replace function check_stock_before_sale()
returns trigger as $$
    declare
        current_stock int;
    begin
        select stock
        into current_stock
        from products
        where product_id = new.product_id;

        if current_stock is null then
            raise exception 'Products does not exist';
        end if;

        if new.quantity > current_stock then
            raise exception 'Not enough stock';
        end if;
            return new;
    end;
    $$ language plpgsql;

create trigger tg_check_stock
    before insert on sales
    for each row
    execute function check_stock_before_sale();

INSERT INTO sales (product_id, quantity)
VALUES (1, 5);

