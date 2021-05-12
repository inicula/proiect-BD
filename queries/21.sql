--Pentru fiecare artist, afiseaza numele si prenumele sau si
--informatii despre albumele la care a contribuit.Coloanele
--aferente artistilor care nu au asociat niciun album
--vor aparea cu valori 'null'.

select art.first_name,
       art.last_name,
       group.name,
       a.*
from artists art
left join group_members g_m
      on art.id = g_m.member_id
left join groups g
      on g_m.group_id = g.id
left join albums a
     on g.id = a.group_id
where g_m.left_group_date is null or
      g_m.left_group_date > a.release_date;

--Pentru fiecare angajat, sa se afiseze informatii despre fiecare
--abonament pe care l-a creat. Coloanele aferente angajatilor care
--nu au creat niciun abonament vor aparea cu valori 'null'.

select e.employee_id,
       e.last_name,
       s.*
from employees e
left join subscriptions s
     on e.employee_id = s.employee_id;
