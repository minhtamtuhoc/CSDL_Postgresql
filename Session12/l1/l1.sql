create or replace function log_new_customer()
    returns trigger as
$$
begin
    insert into customer_log(customer_name, action_time)
    values (new.name, now());

    return new;
end;
$$ language plpgsql;

create trigger tg_insert_customer
    after insert
    on customers
    for each row
execute function log_new_customer();

insert into customers(name, email)
values ('Nguyen Van A', 'a@gmail.com'),
       ('Tran Van B', 'b@gmail.com');

