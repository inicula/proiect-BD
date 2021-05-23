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

create sequence seq_artist_id
minvalue 0
start with 0
increment by 1;

insert into countries
values (1, 'England');

insert into countries
values (2, 'Ukraine');

insert into countries
values (3, 'Canada');

insert into countries
values (4, 'Hungary');

insert into countries
values (5, 'United States');

insert into locations
values (0, 'Birmingham', 1);

insert into locations
values (1, 'Great Bookham', 1);

insert into locations
values (2, 'Cambridge', 1);

insert into locations
values (3, 'Hatch End', 1);

insert into locations
values (4, 'Zhytomyr', 2);

insert into locations
values (5, 'Toronto', 3);

insert into locations
values (6, 'Budapest', 4);

insert into locations
values (7, 'West Bromwich', 1);

insert into locations
values (8, 'Heston', 1);

insert into locations
values (9, 'Sidcup', 1);

insert into locations
values (10, 'Redditch', 1);

insert into locations
values (11, 'Hamlet', 5);

insert into artists
values (seq_artist_id.nextval, 'Nick', 'Mason', '27/01/1944', null, 0);

insert into artists
values (seq_artist_id.nextval, 'Roger', 'Waters', '06/09/1943', null, 1);

insert into artists
values (seq_artist_id.nextval, 'Roger Keith', 'Barrett', '06/01/1946', '07/07/2006', 2);

insert into artists
values (seq_artist_id.nextval, 'David', 'Gilmour', '06/03/1946', null, 2);

insert into artists
values (seq_artist_id.nextval, 'Richard', 'Wright', '28/07/1943', '15/09/2008', 3);

insert into artists
values (seq_artist_id.nextval, 'Sviatoslav', 'Richter', '20/03/1915', '01/08/1997', 4);

insert into artists
values (seq_artist_id.nextval, 'Glenn', 'Gould', '25/09/1932', '04/10/1982', 5);

insert into artists
values (seq_artist_id.nextval, 'Andras', 'Schiff', '21/12/1953', null, 6);

insert into artists
values (seq_artist_id.nextval, 'Robert', 'Plant', '20/08/1948', null, 7);

insert into artists
values (seq_artist_id.nextval, 'Jimmy', 'Page', '09/01/1944', null, 8);

insert into artists
values (seq_artist_id.nextval, 'John', 'Baldwin', '03/01/1946', null, 9);

insert into artists
values (seq_artist_id.nextval, 'John', 'Bonham', '31/05/1948', '25/09/1980', 10);

insert into artists
values (seq_artist_id.nextval, 'John', 'Coltrane', '23/09/1926', '17/07/1967', 11);

insert into groups
values (1, 'Pink Floyd');

insert into groups
values (2, 'Led Zeppelin');

insert into groups
values (4, 'Sviatoslav Richter');

insert into groups
values (5, 'Glenn Gould');

insert into groups
values (6, 'Andras Schiff');

insert into groups
values (7, 'John Coltrane');

insert into group_members
values (1, 0, null);

insert into group_members
values (1, 1, null);

insert into group_members
values (1, 2, '06/06/1968');

insert into group_members
values (1, 3, null);

insert into group_members
values (1, 4, null);

insert into group_members
values (2, 8, null);

insert into group_members
values (2, 9, null);

insert into group_members
values (2, 10, null);

insert into group_members
values (2, 11, null);

insert into group_members
values (4, 5, null);

insert into group_members
values (5, 6, null);

insert into group_members
values (6, 7, null);

insert into group_members
values (7, 12, null);

insert into categories
values (1, 'Rock');

insert into categories
values (2, 'Pop');

insert into categories
values (3, 'Classical');

insert into categories
values (4, 'Metal');

insert into categories
values (5, 'Jazz');

insert into customers
values (15, 'Ionut', 'Nicula', 'niculaionut@tutanota.com');

insert into customers
values (19, 'Marin', 'Preda', 'beethoven_is_boring159@gmail.com');

insert into customers
values (10, 'Anca', 'Popescu', 'ilovevivaldi99@gmail.com');

insert into customers
values (27, 'Eugen', 'Ionescu', 'ihatevivaldi@yahoo.ro');

insert into customers
values (77, 'Nichita', 'Stanescu', 'elegy_11@gmail.com');

insert into customers
values (99, 'Andrei', 'Tarkovsky', 'lookinthemirror@gmail.com');

insert into customers
values (98, 'Andrei', 'Rublev', 'ressurrected551@gmail.com');

insert into customers
values (51, 'Marcu', 'Matei', 'mcm@gmail.com');

insert into customers
values (52, 'Cezar', 'Petrescu', 'czp@gmail.com');

insert into customers
values (53, 'Mihnea', 'Florentin', 'mhflorentin@gmail.com');

insert into jobs
values (1, 'Janitor', 500, 700);

insert into jobs
values (2, 'Cashier', 700, 900);

insert into jobs
values (3, 'Sales Associate', 1000, 1300);

insert into jobs
values (4, 'Manager', 1500, 2000);

insert into jobs
values (5, 'Security', 1500, 2000);

insert into employees
values (1, 'Cory', 'Brodie', 700, '01/03/2018', 1);

insert into employees
values (2, 'Dominick', 'Winfred', 750, '09/03/2017', 1);

insert into employees
values (3, 'Craig', 'Geoffrey', 730, '07/07/2017', 1);

insert into employees
values (4, 'Kennard', 'Rolland', 813, '01/12/2012', 2);

insert into employees
values (5, 'Adam', 'Glenn', 850, '09/12/2012', 2);

insert into employees
values (6, 'Sheldon', 'David', 833, '07/12/2012', 2);

insert into employees
values (7, 'Merlyn', 'Washington', 1300, '01/12/2016', 3);

insert into employees
values (8, 'Norman', 'Duncan', 1300, '09/12/2016', 3);

insert into employees
values (9, 'Arden', 'Rollo', 1900, '09/12/2015', 4);

insert into subscriptions
values (15, 3, 4, '12/12/2019');

insert into subscriptions
values (15, 3, 4, '20/12/2023');

insert into subscriptions
values (10, 1, 5, '01/01/2013');

insert into subscriptions
values (99, 1, 6, '01/02/2015');

insert into subscriptions
values (99, 1, 6, '01/02/2016');

insert into subscriptions
values (99, 1, 6, '01/02/2017');

insert into subscriptions
values (77, 3, 6, '09/09/2015');

insert into subscriptions
values (77, 3, 6, '09/09/2016');

insert into subscriptions
values (77, 3, 6, '09/09/2017');

insert into subscriptions
values (27, 1, 4, '05/05/2021');

insert into subscriptions
values (99, 2, 6, '01/02/2017');

insert into subscriptions
values (99, 3, 6, '01/02/2017');

insert into subscriptions
values (99, 4, 6, '01/02/2017');

insert into subscriptions
values (99, 5, 5, '01/02/2017');

insert into subscriptions
values (27, 5, 5, '01/02/2019');

insert into albums
values (1, 'Wish You Were Here', '12/09/1975', 1, 1);

insert into albums
values (2, 'Dark Side of The Moon', '01/03/1973', 1, 1);

insert into albums
values (3, 'Animals', '01/03/1980', 1, 1);

insert into albums
values (4, 'Bach - The Well-Tempered Clavier - Book I', '08/11/2004', 3, 4);

insert into albums
values (5, 'Bach - The Well-Tempered Clavier - Book II', '08/11/2005', 3, 4);

insert into albums
values (6, 'Schubert - Sonatas and Impromptus', '08/04/2019', 3, 6);

insert into albums
values (7, 'Glenn Gould Plays Bach - Goldberg Variations', '03/01/2012', 3, 5);

insert into tracks
values (1, 1, 'Shine On You Crazy Diamond (Parts I-V)', 13);

insert into tracks
values (1, 2, 'Welcome to the Machine', 7);

insert into tracks
values (1, 3, 'Have a Cigar', 5);

insert into tracks
values (1, 4, 'Wish You Were Here', 5);

insert into tracks
values (1, 5, 'Shine On You Crazy Diamond (Parts VI-IX)', 13);

insert into tracks
values (2, 1, 'Speak To Me', 1);

insert into tracks
values (2, 2, 'Breathe3', 1);

insert into tracks
values (2, 3, 'On The Run', 3);

insert into tracks
values (2, 4, 'Time', 6);

insert into tracks
values (2, 5, 'The Great Gig in the Sky', 4);

insert into tracks
values (2, 6, 'Money', 6);

insert into tracks
values (2, 7, 'Us and Them', 8);

insert into tracks
values (2, 8, 'Any Color You Like', 3);

insert into tracks
values (2, 9, 'Brain Damage', 4);

insert into tracks
values (2, 10, 'Eclipse', 2);

insert into tracks
values (3, 1, 'Pigs on the Wing (Part 1)', 1);

insert into tracks
values (3, 2, 'Dogs', 17);

insert into tracks
values (3, 3, 'Pigs (Three Different Ones)', 11);

insert into tracks
values (3, 4, 'Sheep', 10);

insert into tracks
values (3, 5, 'Pigs on the Wing(Part 2)', 2);

insert into tracks
values (4, 1, 'Prelude and Fugue No. 1 in C Major', 4);

insert into tracks
values (4, 2, 'Prelude and Fugue No. 2 in C Minor', 3);

insert into tracks
values (4, 3, 'Prelude and Fugue No. 3 in C-Sharp Major', 3);

insert into tracks
values (4, 4, 'Prelude and Fugue No. 4 in C-Sharp Minor', 10);

insert into tracks
values (4, 5, 'Prelude and Fugue No. 5 in C D Major', 3);

insert into tracks
values (5, 1, 'Prelude and Fugue No. 1 in C Major', 4);

insert into tracks
values (5, 2, 'Prelude and Fugue No. 2 in C Minor', 5);

insert into tracks
values (5, 3, 'Prelude and Fugue No. 3 in C-Sharp Major', 3);

insert into tracks
values (5, 4, 'Prelude and Fugue No. 4 in C-Sharp Minor', 6);

insert into tracks
values (5, 5, 'Prelude and Fugue No. 5 in C D Major', 8);

insert into tracks
values (6, 1, '4 Impromptus - Allegro molto moderato', 9);

insert into tracks
values (6, 2, '4 Impromptus - Allegro', 5);

insert into tracks
values (6, 3, '4 Impromptus - Andante', 5);

insert into tracks
values (6, 4, '4 Impromptus - Allegretto', 7);

insert into tracks
values (6, 5, 'Piano Sonata No. 19 in C minor - Allegro', 10);

insert into tracks
values (6, 6, 'Piano Sonata No. 19 in C minor - Adagio', 7);

insert into tracks
values (6, 7, 'Piano Sonata No. 19 in C minor - Menuetto', 3);

insert into tracks
values (6, 8, 'Piano Sonata No. 19 in C minor - Allegro', 9);

insert into tracks
values (7, 1, 'Aria', 2);

insert into tracks
values (7, 2, 'Variation 1 a 1 Clav.', 1);

insert into tracks
values (7, 3, 'Variation 2 a 1 Clav.', 1);

insert into tracks
values (7, 4, 'Variation 5 a 1 ovvero 2 Clav.', 1);

insert into tracks
values (7, 5, 'Variation 10 a 1 Clav. Fughetta', 2);

insert into copies
values (1, 1, 'LESXQDTY', 15, null);

insert into copies
values (1, 2, 'TOR09C59', 17, null);

insert into copies
values (1, 3, '2AZCOEOZ', 18, null);

insert into copies
values (1, 4, 'HDAS4NOO', 19, null);

insert into copies
values (2, 1, 'B5672J9Y', 25, 15);

insert into copies
values (2, 2, 'YG9C083E', 20, 19);

insert into copies
values (2, 3, '1G75PM2O', 20, 98);

insert into copies
values (2, 4, 'U83HXR3Z', 20, null);

insert into copies
values (2, 5, 'TDARWNR6', 20, null);

insert into copies
values (3, 1, '4H8B6J61', 35, 99);

insert into copies
values (3, 2, 'B1IZN9NE', 35, 15);

insert into copies
values (3, 3, '1Y42Q830', 35, 27);

insert into copies
values (4, 1, 'OMVYTAVG', 12, 77);

insert into copies
values (4, 2, 'LV6HGUFD', 12, 10);

insert into copies
values (4, 3, '3HYQLCBG', 12, null);

insert into copies
values (4, 4, 'NBRHGIV5', 12, 19);

insert into copies
values (5, 1, 'QRS0D93W', 12, 77);

insert into copies
values (5, 2, 'MA75UBO3', 12, 15);

insert into copies
values (5, 3, '9AVRQVOM', 12, null);

insert into copies
values (5, 4, 'P2P7FGV4', 12, 77);

insert into copies
values (6, 1, 'G6109TMX', 15, null);

insert into copies
values (6, 2, 'OETBGS25', 15, null);

insert into copies
values (6, 3, '5WYWR649', 15, null);

insert into copies
values (7, 1, 'SVAD680K', 20, null);

insert into copies
values (7, 2, 'LTVO8F6N', 20, null);

insert into copies
values (7, 3, 'WQEC7MSO', 20, 15);
