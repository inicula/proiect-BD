--Pentru fiecare Membru afișează id-ul, numele complet și informațiile
--despre fiecare track la care a contribuit. Track-ul trebuie să aparțină
--unui album ce are cel puțin o copie cumpărată și un 'a' în titlu,
--altfel nu se va afișa nimic.

select m.id,
       concat(concat(m.first_name, ' '), m.last_name),
       t.*
from members m
inner join group_members g_m
      on m.id = g_m.member_id
inner join groups g
      on g_m.group_id = g.id
inner join albums a
      on g.id = a.group_id
inner join tracks t
      on a.id = t.album_id
where g_m.left_group_date is null or
      g_m.left_group_date >= a.release_date and
      a.id in (select a2.id
               from customers cust
               inner join copies cop
                     on cust.id = cop.customer_id
               inner join albums a2
                     on cop.album_id = a2.id
               where lower(a2.title))
order by m.id desc;
