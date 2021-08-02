CREATE OR REPLACE FUNCTION randomstring(p_Characters VARCHAR2, p_length NUMBER)
  RETURN VARCHAR2
  IS
     l_res VARCHAR2(256);
  BEGIN
    SELECT substr(LISTAGG(SUBSTR(p_Characters, LEVEL, 1)) WITHIN GROUP(ORDER BY DBMS_RANDOM.VALUE), 1, p_length)
      INTO l_res
      FROM DUAL
    CONNECT BY LEVEL <= LENGTH(p_Characters);
    RETURN l_res;
  END;
  /
COMMIT;


--ALTER USER sa_customers_user QUOTA UNLIMITED ON TS_SA_CUSTOMERS_DATA_01;
--GRANT UNLIMITED TABLESPACE TO sa_customers_user;
ALTER USER sa_games_user QUOTA UNLIMITED ON TS_SA_GAMES_DATA_01;
GRANT UNLIMITED TABLESPACE TO sa_games_user;
ALTER USER sa_companies_user QUOTA UNLIMITED ON TS_SA_COMPANIES_DATA_01;
GRANT UNLIMITED TABLESPACE TO sa_companies_user;
ALTER USER sa_tnx_sales_user QUOTA UNLIMITED ON TS_SA_SALES_DATA_01;
GRANT UNLIMITED TABLESPACE TO sa_tnx_sales_user;
ALTER USER sa_geo_locations_user QUOTA UNLIMITED ON TS_SA_GEO_LOCATIONS_DATA_01;
GRANT UNLIMITED TABLESPACE TO sa_geo_locations_user;

TRUNCATE TABLE sa_customers_user.sa_customers;
INSERT INTO sa_customers_user.sa_customers(customer_id
                                           , customer_desc
                                           , customer_gender
                                           , customer_age)
SELECT ROWNUM
       , 'Customer ' || to_char(ROWNUM)
       , randomstring('FM', 1)
       , round((DBMS_RANDOM.VALUE(1, 100)),0) 
  FROM DUAL
  CONNECT BY LEVEL <= 5000000;
COMMIT;

SELECT * FROM sa_customers_user.sa_customers;



TRUNCATE TABLE sa_companies_user.sa_companies;
INSERT INTO sa_companies_user.sa_companies(company_id
                                           , company_desc
                                           , company_name)
SELECT ROWNUM
       , 'Company ' || to_char(ROWNUM)
       , DBMS_RANDOM.STRING('L',TRUNC(DBMS_RANDOM.VALUE(10,21)))
  FROM DUAL
  CONNECT BY LEVEL <= 500000;
COMMIT;

SELECT * FROM sa_companies_user.sa_companies;



--TRUNCATE TABLE ts_dw_data_user.dw_games_scd;
TRUNCATE TABLE sa_games_user.sa_games;
INSERT INTO sa_games_user.sa_games(game_id
                                   , game_desc
                                   , game_cost
                                   , category_id
                                   , category_desc
                                   , platform_id
                                   , platform_desc)
SELECT ROWNUM
       , 'Game ' || to_char(ROWNUM)
       , ROUND((Dbms_Random.VALUE(1, 1000)),0)
       , round((DBMS_RANDOM.VALUE(1, 4000)),0),
       'Category ' 
       ,Round((DBMS_RANDOM.VALUE(1, 100)),0)
       ,  'Platform' 
  FROM dual
CONNECT BY LEVEL <= 50000;
COMMIT;


UPDATE sa_games_user.sa_games
   SET category_desc = 'Category ' || to_char(category_id);
COMMIT;

SELECT * FROM sa_games_user.sa_games;


UPDATE sa_games_user.sa_games
   SET platform_desc = 'PLatform ' || to_char(platform_id);
COMMIT;




SELECT * FROM sa_games_user.sa_games;


--(select date '2020-01-01' + level - 1 datum
--     from dual
--     connect by level <= date '2020-12-31' - date '2020-01-01' + 1
--)
--  select datum
--  From dates

TRUNCATE TABLE sa_tnx_sales_user.sa_tnx_sales;
INSERT INTO sa_tnx_sales_user.sa_tnx_sales(sales_id
                                           , sales_date
                                           ,  sales_amount
                                           , sales_dollars
                                           , profit_margin)
SELECT ROWNUM
       , (DATE '2020-01-01' + LEVEL - 1)
       , ROUND((DBMS_RANDOM.VALUE(1, 1000000)),0)
       , ROUND((DBMS_RANDOM.VALUE(1, 100000000)),0)
       , ROUND((DBMS_RANDOM.VALUE(1, 100)),0)
  FROM DUAL
CONNECT BY LEVEL <= DATE '2020-12-31' - DATE '2020-01-01' + 1;
COMMIT;

SELECT * FROM sa_tnx_sales_user.sa_tnx_sales ORDER BY sales_id;