--Prelungeste pana la 1 ianuarie 2022 toate abonamentele care au
--expirat in anul 2020 si care au fost facute de un angajat al
--carui nume contine numar impar de litere.

update subscriptions s
set s.expiry_date = to_date('01/01/2022')
where to_char(s.expiry_date, 'yyyy') = '2020' and
      exists(select e.id
             from employees e
             where e.id = s.employee_id and
                   mod(length(e.last_name), 2) = 1);

--Sterge din tabela CUSTOMERS toti clientii care nu au nicio
--copie cumparata si nu au facut niciun abonament.

delete from customers cust
where not exists(select c.id
                 from copies c
                 where c.customer_id is not null and
                       c.customer_id = cust.id)
      and cust.id not in (select distinct s.customer_id
                          from subscriptions s);

--Mareste cu 10% salariul angajatilor ale caror prenume contin
--litera 'm'. Se va tine cont de faptul ca salariul lor nu poate
--sa depaseasca jobs.max_salary.

update employees e
set e.salary = decode(sign(e.salary + e.salary * (10 / 100) -
                                 (select j.max_salary
                                  from jobs j
                                  where e.job_id = j.id)),
                      1, (select j.max_salary
                          from jobs j
                          where e.job_id = j.id),
                      e.salary + e.salary * (10 / 100))
where lower(e.first_name) like '%m%';
