-- Carga incremental
-- MERGE da tbl Silver para a tbl Gold


merge into gold_dim_customers g
using (
select
    customer_sk,
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    postal_code,
    country,
    phone,
    fax,
    MD5( -- Concatena as colunas abaixo para gerar um hash criptografado com identificador
       NVL(customer_sk,'') || '|' ||
       NVL(customer_id,'') || '|' ||
       NVL(company_name,'') || '|' ||
       NVL(contact_name,'') || '|' ||
       NVL(contact_title,'') || '|' ||
       NVL(address,'') || '|' ||
       NVL(city,'') || '|' ||
       NVL(postal_code,'') || '|' ||
       NVL(country,'') || '|' ||
       NVL(phone,'') || '|' ||
       NVL(fax,'') || '|' ||
    ) AS hash_diff VARCHAR(300),
from silver_customers ) s
on g.customer_id = s.customer_id

when matched -- Nessa parte, ele compara o campo hash_diff das tabela gold e silver, se ela achar algum hash diferente, ele faz o updade com o dados da tabela silver para a gold.
    and g.hash_diff != s.hash_diff
    update set
       g.company_name = s.company_name,
       g.contact_name = s.contact_name,
       g.contact_title = s.contact_title,
       g.address = s.address,
       g.city = s.city,
       g.postal_code = s.postal_code,
       g.country = s.country,
       g.phone = s.phone,
       g.fax = s.fax,
       g.hash_diff = s.hash_diff 

when not matched then -- Caso ele nçao entendo nenhum hash na tabela gold, fará p insert com o dados da tabela silver.
    insert (
    customer_sk,
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    postal_code,
    country,
    phone,
    fax,
)
values 
(
  s.customer_sk,
  s.customer_id,
  s.company_name,
  s.contact_name,
  s.contact_title,
  s.address,
  s.city,
  s.postal_code,
  s.country,
  s.phone,
  s.fax    
); -- Se ele enontra os mesmos dados da tabela silver e gold ele não fará nada.







    
CREATE TABLE IF NOT EXISTS gold_dim_customers_scd2 (
    customer_sk BIGINT AUTOINCREMENT,
    customer_id VARCHAR(20),
    company_name VARCHAR(100),
    contact_name VARCHAR(200),
    contact_title VARCHAR(100),
    address VARCHAR(300),
    city VARCHAR(100),
    postal_code VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(100),
    fax VARCHAR(100),
    hash_diff VARCHAR(300),
    effective_date TIMESTAMP_NTZ NOT NULL,
    expiry_date TIMESTAMP_NTZ,
    is_current BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

