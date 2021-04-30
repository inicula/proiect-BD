--Afiseaza titlul si durata pentru fiecare album cu durata mai mare
--decat media duratelor tuturor albumelor.

with average_duration(average_duration_val)
     as (select avg(sum(t.length)
         from albums a
         inner join tracks t
               on a.id = t.album_id
         group by a.id)
select a.title,
       sum(t.length)
from albums a
inner join tracks t
      on a.id = t.album_id
group by a.id, a.title
having sum(t.length) > average_duration.average_duration_val;
