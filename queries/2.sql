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
