--Pentru fiecare abonament care a expirat in anul 2019 sa se afiseze
--categoria sa, numele clientului, numele vanzatorului si data expirarii.

select cat.title,
       c.last_name,
       e.last_name,
       s.expiry_date
from subscriptions s
inner join categories cat
      on s.category_id = cat.id
inner join customers c
      on s.customer_id = c.id
inner join employees e
      on s.employee_id = e.id
where to_char(expiry_date, 'yyyy') = '2019';
