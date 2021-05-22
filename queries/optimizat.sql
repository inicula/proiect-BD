select member_id,
       title
from  (select *
       from (select group_id,
                    title
             from albums)
       where lower(title) like '%s%') r1
inner join (select *
            from (select id
                  from groups) tmp0
            inner join (select *
                        from (select group_id,
                                     member_id
                              from group_members)
                        where mod(member_id, 2) = 0) tmp1
                  on tmp0.id = tmp1.group_id) r2
      on r1.group_id = r2.id;
