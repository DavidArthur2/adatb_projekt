from pymongo import MongoClient

# MongoDB connection with authentication
mongo_username = 'mongadmin'  
mongo_password = 'LikeAndSubscribe'  
client = MongoClient(f'mongodb://{mongo_username}:{mongo_password}@fokakefir.go.ro:27017')
db = client['mydatabase']

categories_with_subcategories_and_articles = db['categories'].find({}, {'_id': 0, 'subcategories.articles': 0})
for category in categories_with_subcategories_and_articles:
    print(category)

client.close()