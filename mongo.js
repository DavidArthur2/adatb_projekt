// Find all categories
db.categories.find({})

// Find a category by its name
db.categories.find({ name: 'Books' })

// Find all subcategories within a specific category (e.g., 'Electronics')
db.categories.find(
    { name: 'Electronics' },
    { subcategories: 1, _id: 0 }
)

// Find all articles within a specific subcategory (e.g., 'Mobile Phones') under a specific category (e.g., 'Electronics')
db.categories.find(
    { 'subcategories.name': 'Mobile Phones' },
    { 'subcategories.$': 1 }
)

// Find articles with a discount greater than 0
db.categories.aggregate([
    { $unwind: '$subcategories' },
    { $unwind: '$subcategories.articles' },
    { $match: { 'subcategories.articles.discount': { $gt: 0 } } },
    { $project: { name: '$subcategories.articles.name', discount: '$subcategories.articles.discount' } }
])

// Find the total quantity of a specific article (e.g., 'iPhone 12') across all categories and subcategories
db.categories.aggregate([
    { $unwind: '$subcategories' },
    { $unwind: '$subcategories.articles' },
    { $match: { 'subcategories.articles.name': 'iPhone 12' } },
    { $group: { _id: '$subcategories.articles.name', totalQuantity: { $sum: '$subcategories.articles.quantity' } } }
])

// Find subcategories with articles priced above a certain amount (e.g., $1000)
db.categories.aggregate([
    { $unwind: '$subcategories' },
    { $unwind: '$subcategories.articles' },
    { $match: { 'subcategories.articles.price': { $gt: 1000 } } },
    { $project: { subcategory: '$subcategories.name', article: '$subcategories.articles.name', price: '$subcategories.articles.price' } }
])

// Find articles with a specific discount percentage (e.g., 0.2)
db.categories.aggregate([
    { $unwind: '$subcategories' },
    { $unwind: '$subcategories.articles' },
    { $match: { 'subcategories.articles.discount': 0.2 } },
    { $project: { article: '$subcategories.articles.name', discount: '$subcategories.articles.discount' } }
])

// Update the quantity of a specific article (e.g., 'Samsung Galaxy S21') to a new value (e.g., 10)
db.categories.updateOne(
    { 'subcategories.articles.name': 'Samsung Galaxy S21' },
    { $set: { 'subcategories.$[].articles.$[article].quantity': 10 } },
    { arrayFilters: [{ 'article.name': 'Samsung Galaxy S21' }] }
)

// Remove an article by its ID (e.g., article ID 1)
db.categories.updateOne(
    { 'subcategories.articles._id': 1 },
    { $pull: { 'subcategories.$[].articles': { _id: 1 } } }
)