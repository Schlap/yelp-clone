# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all
Review.destroy_all
User.destroy_all

ethel = User.create(username: 'ch2ch3', email: 'ethel@gmail.com', password: 'password', password_confirmation: 'password')
james = User.create(username: 'jrmcneil', email: 'james@gmail.com', password: 'password', password_confirmation: 'password')

kfc = Restaurant.create(name: 'KFC', cuisine: 'Fast food', description: 'Fried chicken')
kfc.reviews.create(rating: 3, comment: "Average", user_id: User.first.id)
kfc.reviews.create(rating: 1, comment: "Bad", user_id: User.last.id)

jamies = Restaurant.create(name: "Jamie's Italian", cuisine: 'Italian', description: "Jamie's Italian features fantastic, rustic dishes, using recipes that Jamie Oliver loves! Jamie's Italian was inspired by Italy & its traditions & values.")
jamies.reviews.create(rating: 2, comment: "Could be better", user_id: User.first.id)
jamies.reviews.create(rating: 4, comment: "Not bad", user_id: User.last.id)