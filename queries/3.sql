--Pentru fiecare membru al carui nume contine un 'e', afiseaza id-ul
--si numele sau, ziua lunii in care s-a nascut, data decesului
--sau alt mesaj corespunzator daca este in viata, varsta sa exprimata
--in numar de luni. Se va afisa, in plus, 'DA/NU' daca membrul este/nu este
--nascut in Anglia si 'DA/NU' daca numele orasului in care s-a nascut
--contine/nu contine un 'u'.

select m.id,
       m.last_name,
       to_char(m.date_birth, 'dd')           as "Ziua lunii nastere",
       nvl(to_char(m.date_death),
           'in viata')                       as "Decedat?",
       trunc(months_between(nvl(m.date_death,
                                sysdate),
                            m.date_birth), 
             0)                              as "Varsta in nr. luni",
       decode(c.name, 'England', 'DA',
                                 'NU')       as "Nascut in Anglia?",
       case
          when lower(l.city) like '%u%'
               then 'DA'
          else      'NU'
       end                                   as "Numele orasului contine 'u'"
from members m
inner join locations l
      on m.birth_location_id = l.id
inner join countries c
      on l.country_id = c.id
where lower(last_name) like '%e%';
