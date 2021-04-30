--Afiseaza titlul si durata pentru fiecare album cu durata mai
--mare decat 20(minute) si care este compus de un grup care are
--in componenta cel putin un membru al carui nume incepe cu 'G'.

select a.title,
       sum(t.length)
from albums a
inner join tracks t
      on a.id = t.album_id
where exists(select m.last_name
             from groups g
             inner join group_members
                   on g.id = group_members.group_id
             inner join members m
                   on g.member_id = m.id
             where g.id = a.group_id and
                   lower(m.last_name) like 'g%')
group by a.id, a.title
having sum(t.length) > 20;
