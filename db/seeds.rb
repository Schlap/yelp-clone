# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all
Review.destroy_all

kfc = Restaurant.create(name: 'KFC', cuisine: 'Fast food', description: 'Fried chicken')
kfc.reviews.create(rating: 3, comment: "average", user_id: 1)
kfc.reviews.create(rating: 1, comment: "bad", user_id: 1)
kfc.reviews.create(rating: 5, comment: "fantastic", user_id: 1)

jamies = Restaurant.create(name: "Jamie's Italian", cuisine: 'Italian', description: "Jamie's Italian features fantastic, rustic dishes, using recipes that Jamie Oliver loves! Jamie's Italian was inspired by Italy & its traditions & values.")
jamies.reviews.create(rating: 3, comment: "average", user_id: 1)
jamies.reviews.create(rating: 2, comment: "could be better", user_id: 1)
jamies.reviews.create(rating: 1, comment: "bad", user_id: 1)
jamies.reviews.create(rating: 4, comment: "not bad", user_id: 1)
jamies.reviews.create(rating: 5, comment: "fantastic", user_id: 1)