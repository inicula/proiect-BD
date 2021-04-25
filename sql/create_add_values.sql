create table locations (
    id number(3) not null primary key,
    country varchar(30),
    city varchar(30)
);

create table members (
    id number(4) not null primary key,
    first_name varchar(30),
    last_name varchar(30),
    date_birth date not null,
    date_death date,
    birth_location_id number(3),
    constraint FK_Member_Location foreign key (birth_location_id) references Locations(id)
);
