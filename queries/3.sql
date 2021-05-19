--Pentru fiecare artist al carui nume contine un 'e', afiseaza id-ul
--si numele sau, ziua lunii in care s-a nascut, data decesului
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
