select member_id,
       title
from groups g
inner join group_members g_m
      on g.id = g_m.group_id
inner join albums a
      on g.id = a.group_id
where lower(a.title) like '%s%' and
      mod(member_id, 2) = 0;
