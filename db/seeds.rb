# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all
Review.destroy_all

kfc = Restaurant.create(name: 'KFC')
kfc.reviews.create(rating: 3, comment: "average")
kfc.reviews.create(rating: 1, comment: "bad")
kfc.reviews.create(rating: 5, comment: "fantastic")

jamies = Restaurant.create(name: 'Jamie\'s Italian')
jamies.reviews.create(rating: 3, comment: "average")
jamies.reviews.create(rating: 2, comment: "could be better")
jamies.reviews.create(rating: 1, comment: "bad")
jamies.reviews.create(rating: 4, comment: "not bad")
jamies.reviews.create(rating: 5, comment: "fantastic")