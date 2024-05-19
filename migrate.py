import pandas as pd
from pymongo import MongoClient
import cx_Oracle

# Oracle connection details
oracle_dsn = cx_Oracle.makedsn('217.73.170.84', 44678, service_name='ORCL')
oracle_connection = cx_Oracle.connect(user='C##Szamt2', password='Sapi12345', dsn=oracle_dsn)
