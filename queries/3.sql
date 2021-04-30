--Pentru fiecare membru al cărui nume conține un 'e', afișează id-ul
--și numele lui, ziua lunii în care s-a născut, data decesului
--sau alt mesaj corespunzator dacă este în viață, vârsta sa exprimată
--în număr de luni. Se va afisa, in plus, 'DA/NU' daca membrul este/nu este
--nascut in Anglia si 'DA/NU' daca numele orasului in care s-a nascut
--contine/nu contine un 'u'.

select m.id,
       m.last_name,
       to_char(m.date_birth, 'dd')           as "Ziua lunii nastere",
       nvl(m.date_death, 'in viata')         as "Decedat?",
       months_between(sysdate, m.date_birth) as "Varsta in nr. luni",
       decode(c.name, 'England', 'DA'
                                 'NU')       as "Nascut in Anglia?",
       case
          when lower(l.city) like '%u%'
               then 'DA'
          else      'NU'
       end                                   as "Numele orasului contine 'u'?"
from members m
inner join locations l
      on m.birth_location_id = l.id
inner join countries c
      on l.country_id = c.id
where lower(last_name) like '%e%';
