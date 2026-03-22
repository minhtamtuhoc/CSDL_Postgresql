create table sales.Customers
(
    customer_id serial primary key,
    first_name  varchar(50)         not null,
    last_name   varchar(50)         not null,
    email       varchar(100) unique not null,
    phone       varchar(15)
);
create table sales.Products
(
    product_id     serial primary key,
    product_name   varchar(100)   not null,
    price          numeric(10, 2) not null check (price > 0),
    stock_quantity int            not null check (stock_quantity >= 0)
);
create table sales.Orders
(
    order_id    serial primary key,
    customer_id int,
    order_date  date not null default current_date,
    foreign key (customer_id) references sales.Customers (customer_id)
);
create table sales.OrderItems
(
    order_item_id serial primary key,
    order_id      int,
    product_id    int,
    quantity      int not null check (quantity >= 1),
    foreign key (order_id) references sales.Orders (order_id),
    foreign key (product_id) references sales.Products (product_id)
);