SELECT COUNT(*)
       , customer_gender 
  FROM sa_customers_user.sa_customers 
 GROUP BY customer_gender;

SELECT COUNT(*)
       , customer_age 
  FROM sa_customers_user.sa_customers 
 GROUP BY customer_age 
 ORDER BY customer_age;

SELECT * FROM sa_companies_user.sa_companies ORDER BY company_id;

SELECT COUNT(*)
       , game_cost 
  FROM sa_games_user.sa_games 
 GROUP BY game_cost 
 ORDER BY game_cost;
       
SELECT COUNT(*)
       , category_id 
  FROM sa_games_user.sa_games 
 GROUP BY category_id 
 ORDER BY category_id;
       
SELECT COUNT(*)
       , platform_id 
  FROM sa_games_user.sa_games 
 GROUP BY platform_id 
 ORDER BY platform_id;

SELECT COUNT(*)
       , sales_amount 
   FROM sa_tnx_sales_user.sa_tnx_sales 
  GROUP BY sales_amount 
  ORDER BY sales_amount;
  
SELECT COUNT(*)
       , sales_dollars 
  FROM sa_tnx_sales_user.sa_tnx_sales 
 GROUP BY sales_dollars 
 ORDER BY sales_dollars;
 
 
SELECT COUNT(*)
       , profit_margin 
  FROM sa_tnx_sales_user.sa_tnx_sales 
 GROUP BY profit_margin 
 ORDER BY profit_margin;


CREATE TABLE sa_customers_user.updated_sa_customers 
(
   customer_id          NUMBER(22, 0)                     NOT NULL,
   customer_desc        VARCHAR2(30 CHAR)                 NOT NULL,
   customer_gender      VARCHAR2(10 CHAR)                 NOT NULL,
   customer_age         NUMBER (22, 0)                    NOT NULL,
   CONSTRAINT pk_upt_sa_customers PRIMARY KEY (customer_id)
)
TABLESPACE ts_sa_customers_data_01;


INSERT INTO sa_customers_user.updated_sa_customers(customer_id
                                                   , customer_desc
                                                   , customer_gender
                                                   , customer_age)
SELECT ROWNUM
       , 'Customer ' || to_char(ROWNUM)
       , randomstring('FM', 1)
       , ROUND((DBMS_RANDOM.VALUE(1, 100)),0) 
  FROM dual
  CONNECT BY LEVEL <= 100000;

SELECT * FROM sa_customers_user.updated_sa_customers;

MERGE INTO sa_customers_user.updated_sa_customers D
USING (SELECT customer_age
              , COUNT(*) cnt 
         FROM sa_customers_user.sa_customers 
        GROUP BY customer_age) E
   ON (D.customer_age = E.customer_age)
 WHEN MATCHED THEN UPDATE SET customer_desc = to_char(E.cnt);

SELECT * FROM sa_customers_user.updated_sa_customers;
COMMIT;