import pandas as pd
from pymongo import MongoClient
import cx_Oracle

# Oracle connection details
oracle_dsn = cx_Oracle.makedsn('217.73.170.84', 44678, service_name='ORCL')
oracle_connection = cx_Oracle.connect(user='C##Szamt2', password='Sapi12345', dsn=oracle_dsn)


# MongoDB connection with authentication
mongo_username = 'mongadmin'  
mongo_password = 'LikeAndSubscribe'  
client = MongoClient(f'mongodb://{mongo_username}:{mongo_password}@fokakefir.go.ro:27017')
db = client['mydatabase']

# Read Oracle tables into DataFrames
category_df = pd.read_sql("SELECT * FROM C##Szamt4.Category", oracle_connection)
subcategory_df = pd.read_sql("SELECT * FROM C##Szamt4.Subcategory", oracle_connection)
article_df = pd.read_sql("select art.id, art.SUBCATID, art.NAME, art.PRICE, art.DISCOUNT, ware.QUANTITY from C##SZAMT4.ARTICLE art, C##SZAMT4.WAREHOUSE ware where art.id = ware.ARTICLEID and art.SUBCATID is not null", oracle_connection)


# Convert DataFrames to dictionaries
categories = category_df.to_dict(orient='records')
subcategories = subcategory_df.to_dict(orient='records')
articles = article_df.to_dict(orient='records')

# Function to lowercase all keys in a dictionary
def lowercase_keys(d):
    if isinstance(d, dict):
        return {k.lower(): lowercase_keys(v) for k, v in d.items()}
    elif isinstance(d, list):
        return [lowercase_keys(i) for i in d]
    else:
        return d
    
# Function to replace 'id' with '_id' in dictionary keys
def replace_id_with__id(d):
    if isinstance(d, dict):
        return {k.replace('id', '_id'): replace_id_with__id(v) for k, v in d.items()}
    elif isinstance(d, list):
        return [replace_id_with__id(i) for i in d]
    else:
        return d

# Lowercase all keys in the dictionaries
categories = lowercase_keys(categories)
subcategories = lowercase_keys(subcategories)
articles = lowercase_keys(articles)

# Replace 'id' with '_id' in the dictionaries
categories = replace_id_with__id(categories)
subcategories = replace_id_with__id(subcategories)
articles = replace_id_with__id(articles)

# Create a dictionary for quick lookup
subcategory_dict = {subcat['_id']: subcat for subcat in subcategories}
article_dict = {article['_id']: article for article in articles}

# Remove subcatid and categoryid from dictionaries
for category in categories:
    category.pop('category_id', None)
    category['subcategories'] = []
    for subcategory in subcategories:
        subcategory_copy = subcategory.copy()
        if subcategory_copy['category_id'] == category['_id']:
            subcategory_copy.pop('category_id', None)
            subcategory_copy['articles'] = []
            for article in articles:
                article_copy = article.copy()
                if article_copy['subcat_id'] == subcategory_copy['_id']:
                    article_copy.pop('subcat_id', None)
                    subcategory_copy['articles'].append(article_copy)
            category['subcategories'].append(subcategory_copy)

print(categories)

# Insert nested documents into MongoDB
db['categories'].insert_many(categories)

# Close connections
oracle_connection.close()
client.close()

print('Done')