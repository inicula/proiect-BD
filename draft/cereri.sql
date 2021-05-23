--Cerinta 11

--Pentru fiecare Artist afiseaza id-ul, numele complet si informatiile
--despre fiecare track la care a contribuit. Track-ul trebuie sa apartina
--unui album ce are cel putin o copie vanduta si un 'a' in titlu,
--altfel nu se va afisa nimic.

select art.id,
       concat(concat(art.first_name, ' '), art.last_name),
       t.*
from artists art
inner join group_members g_m
      on art.id = g_m.member_id
inner join groups g
      on g_m.group_id = g.id
inner join albums a
      on g.id = a.group_id
inner join tracks t
      on a.id = t.album_id
where (g_m.left_group_date is null or
       g_m.left_group_date >= a.release_date) and
       a.id in (select a2.id
                from customers cust
                inner join copies cop
                      on cust.id = cop.customer_id
                inner join albums a2
                      on cop.album_id = a2.id
                where lower(a2.title) like '%a%')
order by art.id desc;

--Afiseaza titlul si durata pentru fiecare album cu durata mai
--mare decat 20(minute) si care este compus de un grup care are
--in componenta cel putin un membru al carui nume incepe cu 'G'.

select a.title,
       sum(t.length)
from albums a
inner join tracks t
      on a.id = t.album_id
where exists(select art.last_name
             from groups g
             inner join group_members g_m
                   on g.id = g_m.group_id
             inner join artists art
                   on g_m.member_id = art.id
             where g.id = a.group_id and
                   lower(art.last_name) like 'g%')
group by a.id, a.title
having sum(t.length) > 20;

--Pentru fiecare artist al carui nume contine un 'e', afiseaza id-ul
--si numele lui, ziua lunii in care s-a nascut, data decesului
--sau alt mesaj corespunzator daca este in viata, varsta sa exprimata
--in numar de luni. Se va afisa, in plus, 'DA/NU' daca artistul este/nu este
--nascut in Anglia si 'DA/NU' daca numele orasului in care s-a nascut
--contine/nu contine un 'u'.

select art.id,
       art.last_name,
       to_char(art.date_birth, 'dd')   as "Ziua lunii nastere",
       nvl(to_char(art.date_death),
           'in viata')                 as "Decedat?",
       trunc(months_between(
                nvl(art.date_death,
                    sysdate),
                art.date_birth),
             0)                        as "Varsta in nr. luni",
       decode(c.name, 'England', 'DA',
                                 'NU') as "Nascut in Anglia?",
       case
          when lower(l.city) like '%u%'
               then 'DA'
          else      'NU'
       end                             as "Numele orasului contine 'u'"
from artists art
inner join locations l
      on art.birth_location_id = l.id
inner join countries c
      on l.country_id = c.id
where lower(art.last_name) like '%e%';

--Afiseaza titlul si durata pentru fiecare album cu durata mai mare
--decat media duratelor tuturor albumelor.

with avgduration(val)
     as (select avg(sum(t.length))
         from albums a
         inner join tracks t
               on a.id = t.album_id
         group by a.id)
select a.title,
       sum(t.length)
from avgduration avgdur, albums a
inner join tracks t
      on a.id = t.album_id
group by a.id, a.title, avgdur.val
having sum(t.length) > avgdur.val;

--Pentru fiecare abonament care a expirat in anul 2019 sa se afiseze
--categoria sa, numele clientului, numele vanzatorului si data expirarii.

select cat.title,
       c.last_name,
       e.last_name,
       s.expiry_date
from subscriptions s
inner join categories cat
      on s.category_id = cat.id
inner join customers c
      on s.customer_id = c.id
inner join employees e
      on s.employee_id = e.id
where to_char(expiry_date, 'yyyy') = '2019';

--Cerinta 12

--Prelungeste pana la 1 ianuarie 2025 toate abonamentele care
--expira in anul 2023 si care au fost facute de un angajat al
--carui nume contine numar impar de litere.

update subscriptions s
set s.expiry_date = to_date('01/01/2025')
where to_char(s.expiry_date, 'yyyy') = '2023' and
      exists(select e.id
             from employees e
             where e.id = s.employee_id and
                   mod(length(e.last_name), 2) = 1);

--Sterge din tabela CUSTOMERS toti clientii care nu au nicio
--copie cumparata si nu au facut niciun abonament.

delete from customers cust
where not exists(select c.id
                 from copies c
                 where c.customer_id is not null and
                       c.customer_id = cust.id)
      and cust.id not in (select distinct s.customer_id
                          from subscriptions s);

--Mareste cu 10% salariul angajatilor ale caror prenume contin
--litera 'm'. Se va tine cont de faptul ca salariul lor nu poate
--sa depaseasca jobs.max_salary.

update employees e
set e.salary = decode(sign(e.salary + e.salary * (10 / 100) -
                                 (select j.max_salary
                                  from jobs j
                                  where e.job_id = j.id)),
                      1, (select j.max_salary
                          from jobs j
                          where e.job_id = j.id),
                      e.salary + e.salary * (10 / 100))
where lower(e.first_name) like '%m%';

--Cerinta 13

create sequence seq_artist_id
minvalue 0
start with 0
increment by 1;

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

--Cerinta 16

--Pentru fiecare artist, afiseaza numele si prenumele lui si
--informatii despre track-urile din albume la care a contribuit.
--Coloanele aferente artistilor care nu au asociat niciun album
--vor aparea cu valori 'null'.

select art.first_name,
       art.last_name,
       g.name,
       a.title,
       a.release_date,
       t.title,
       t.length
from artists art
left join group_members g_m
      on art.id = g_m.member_id
left join groups g
      on g_m.group_id = g.id
left join albums a
     on g.id = a.group_id
left join tracks t
     on a.id = t.album_id
where g_m.left_group_date is null or
      g_m.left_group_date > a.release_date;

--Afiseaza id-ul clientilor abonati la toate categoriile.

select c.customer_id
from (select distinct customer_id
      from subscriptions) c
where not exists (select 1
                  from categories cat
                  where (c.customer_id, cat.id)
                        not in (select s.customer_id,
                                       s.category_id
                                from subscriptions s));

--Afiseaza id-ul angajatilor care au facut cel putin un abonament (indiferent
--de categorie) tuturor clientilor abonati la categoria 'Rock'. 

select emp.employee_id
from (select distinct employee_id
      from subscriptions) emp
where not exists (select 1
                  from (select distinct s.customer_id
                        from subscriptions s
                        inner join categories cat
                              on s.category_id = cat.id
                        where lower(cat.title) = 'rock') rock_c
                  where (emp.employee_id, rock_c.customer_id)
                        not in (select employee_id, customer_id
                                from subscriptions));
