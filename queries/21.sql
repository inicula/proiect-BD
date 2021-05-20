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
