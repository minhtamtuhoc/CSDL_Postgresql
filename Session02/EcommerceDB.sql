create table shop.Users
(
    user_id  SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE                                NOT NULL,
    email    VARCHAR(100) UNIQUE                               NOT NULL,
    password VARCHAR(100)                                      NOT NULL,
    role     VARCHAR(20) CHECK (role IN ('Customer', 'Admin')) NOT NULL
);
CREATE TABLE shop.Categories
(
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
create table shop.Product
(
    product_id   serial primary key,
    product_name varchar(100) not null,
    price        numeric(10, 2) check (price > 0),
    stock        int check (stock > 0),
    category_id  int,
    foreign key (category_id) references shop.Categories (category_id)
);
create table shop.Orders
(
    order_id   serial primary key,
    user_id    int,
    order_date date                                                                           not null default current_date,
    status     varchar(20) check (status in ('Pending', 'Shipped', 'Delivered', 'Cancelled')) not null,
    foreign key (user_id) references shop.Users (user_id)
);

create table shop.OrderDetails
(
    order_detail_id serial primary key,
    order_id        int,
    product_id      int,
    quantity        int check (quantity > 0),
    price_each      numeric(10, 2) check (price_each > 0),
    foreign key (order_id) references shop.Orders (order_id),
    foreign key (product_id) references shop.Product (product_id)
);

create table shop.Payments
(
    payment_id   serial primary key,
    order_id     int,
    amount       numeric(10, 2) check (amount >= 0),
    payment_date date                                                                           not null default current_date,
    method       varchar(30) check (method in ('Credit Card', 'Momo', 'Bank Transfer', 'Cash')) not null,
    foreign key (order_id) references shop.Orders (order_id)
);