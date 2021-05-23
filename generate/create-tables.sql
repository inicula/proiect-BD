create table countries(
        id   number(3) not null primary key,
        name varchar(50) not null
);

create table locations(
        id         number(3) not null primary key,
        city       varchar(50) not null,
        country_id number(3) not null references countries(id)
);

create table artists(
        id                number(3) not null primary key,
        first_name        varchar(50) not null,
        last_name         varchar(50) not null,
        date_birth        date not null,
        date_death        date,
        birth_location_id number(3) not null references Locations(id)
);

create table groups(
        id   number(3) not null primary key,
        name varchar(30) not null
);

create table group_members(
        group_id        number(3) not null references Groups(id),
        member_id       number(3) not null references Artists(id),
        left_group_date date,
        primary key     (group_id, member_id)
);

create table categories(
        id    number(3) not null primary key,
        title varchar(50) not null
);

create table albums(
        id           number(3) not null primary key,
        title        varchar(50) not null,
        release_date date not null,
        category_id  number(3) not null references Categories(id),
        group_id     number(3) not null references Groups(id)
);

create table tracks(
        album_id number(3) not null references Albums(id),
        id       number(3) not null,
        title    varchar(50) not null,
        length   number(5) not null check (length > 0),
        primary key(album_id, id)
);

create table jobs(
        id         number(3) not null primary key,
        title      varchar(50) not null,
        min_salary number(5) not null check (min_salary > 0),
        max_salary number(5) not null check (max_salary > 0)
);

create table employees(
        id         number(3) not null primary key,
        first_name varchar(50) not null,
        last_name  varchar(50) not null,
        salary     number(5) not null check (salary > 0),
        hire_date  date not null,
        job_id     number(3) not null references Jobs(id)
);

create table customers(
        id         number(3) not null primary key,
        first_name varchar(50) not null,
        last_name  varchar(50) not null,
        email      varchar(50) not null
);

create table copies(
        album_id      number(3) not null references Albums(id),
        id            number(3) not null,
        serial_number varchar(8) not null unique,
        price         number(5) not null check (price > 0),
        customer_id   number(3) references Customers(id),
        primary key   (album_id, id)
);

create table subscriptions(
        customer_id number(3) not null references Customers(id),
        category_id number(3) not null references Categories(id),
        employee_id number(3) not null references Employees(id),
        expiry_date date not null,
        primary key(customer_id, category_id, expiry_date)
);
