create table countries(
        id   number(3) not null primary key,
        name varchar(50)
);

create table locations(
        id         number(3) not null primary key,
        city       varchar(50),
        country_id number(3) references countries(id)
);

create table members(
        id                number(3) not null primary key,
        first_name        varchar(50),
        last_name         varchar(50),
        date_birth        date,
        date_death        date,
        birth_location_id number(3) references Locations(id)
);

create table groups(
        id   number(3) not null primary key,
        name varchar(30)
);

create table group_members(
        group_id        number(3) not null references Groups(id),
        member_id       number(3) not null references Members(id),
        left_group_date date,
        primary key     (group_id, member_id)
);

create table categories(
        id    number(3) not null primary key,
        title varchar(50)
);

create table albums(
        id           number(3) not null primary key,
        title        varchar(50),
        release_date date,
        category_id  number(3) references Categories(id),
        group_id     number(3) references Groups(id)
);

create table tracks(
        album_id number(3) not null references Albums(id),
        id       number(3) not null,
        title    varchar(50),
        length   number(5),
        primary key(album_id, id)
);

create table jobs(
        id         number(3) not null primary key,
        title      varchar(50),
        min_salary number(5) not null,
        max_salary number(5) not null
);

create table employees(
        id         number(3) not null primary key,
        first_name varchar(50),
        last_name  varchar(50),
        salary     number(5) not null,
        hire_date  date not null,
        job_id     number(3) references Jobs(id)
);

create table customers(
        id         number(3) not null primary key,
        first_name varchar(50),
        last_name  varchar(50),
        email      varchar(50)
);

create table copies(
        album_id      number(3) not null references Albums(id),
        id            number(3) not null,
        serial_number varchar(8),
        price         number(5),
        customer_id   number(3) references Customers(id),
        primary key   (album_id, id)
);

create table subscriptions(
        customer_id number(3) not null references Customers(id),
        category_id number(3) not null references Categories(id),
        employee_id number(3) not null references Employees(id),
        expiry_date date not null,
        primary key(customer_id, category_id, employee_id, expiry_date)
);

create sequence seq_member_id
minvalue 0
start with 0
increment by 1;
