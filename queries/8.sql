--Afiseaza id-ul clientilor abonati la toate categoriile.

select c.customer_id
from (select distinct customer_id
      from subscriptions) c
where not exists (select 1
                  from categories cat
                  where (c.customer_id, cat.id)
                        not in (select s.customer_id,
                                       s.category_id
                                from subscriptions s));

--Afiseaza id-ul angajatilor care au facut cel putin un abonament (indiferent
--de categorie) tuturor clientilor abonati la categoria 'Rock'. 

select emp.employee_id
from (select distinct employee_id
      from subscriptions) emp
where not exists (select 1
                  from (select distinct s.customer_id
                        from subscriptions s
                        inner join categories cat
                              on s.category_id = cat.id
                        where lower(cat.title) = 'rock') rock_c
                  where (emp.employee_id, rock_c.customer_id)
                        not in (select employee_id, customer_id
                                from subscriptions));
