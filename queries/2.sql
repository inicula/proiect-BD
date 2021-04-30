--Afișează titlul și durata pentru fiecare album cu durată mai
--mare decât 20(minute) și care este compus de un grup care are
--în componență cel puțin un membru al cărui nume începe cu 'G'.

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
