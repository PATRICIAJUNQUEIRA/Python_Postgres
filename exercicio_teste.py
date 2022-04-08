import csv
import psycopg2

conn = psycopg2.connect(host="localhost", database="Exercicio_1", user="postgres", password="postgres", port=5432)
cur = conn.cursor()

postgres = '''CREATE TABLE raw(
     ROW INT,
     ID INT,
     ACTIVE BOOLEAN,
     NAME VARCHAR(60),
     COUNTRY VARCHAR (50),
     HEIGHT INT,
     WEIGHT INT,
     POSITION VARCHAR(50),
     TEAM_ID INT,
     TEAM_CITY VARCHAR(50),
     TEAM_STATE VARCHAR(50),
     PLAYER_SALARY_SEASON VARCHAR(15),
     PLAYER_SALARY_AMOUNT INT  
 );'''

cur.execute(postgres) 

x = 'C:/Users/patricia.miranda/Documents/patricia.miranda/SQL_EXERCICIOS/exercicio_SQL.tsv'

with open(x, 'r') as arquivo:
     header = next(arquivo) 
     cur.copy_from(arquivo, 'raw', sep='\t', null='') 
     conn.commit()
conn.close()    

