



-- Inserindo dados
insert into bronze_customers
-- create or replace table bronze_customers as
SELECT
METADATA$FILME as filename,
cast($1 as variant) as raw,
CURRENT_TIMESTAMP as created_at
    FROM @north/cust
    (FILE_FORMAT => PARQUET_FORMAT);

	

-- Apagando os dados tabela bronze_customers
truncate table bronze_customers;



-- north é o nome do external stage que acessar os arquivo do S3 na AWS.
-- COPY INTO não repe o processamento do mesmo arquivo da dados, por isso ele somento só dará carga na tabela bronze_customers somente uma vez.
-- COPY INTO tem uma tabela interna que valida qual arquivo e qual linha já foi processado ou não.

COPY INTO bronze_customers
FROM(
   SELECT
       METADATA$FILME,
       $1,
       CURRENT_TIMESTAMP 
    FROM @north/cust
    (FILE_FORMAT => PARQUET_FORMAT)
);


-- Verificando os dados inseridos na nova tabela
select * from table bronze_customers