# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(name: "Andrea")
drugs = Drug.create([
  {name: 'Malox', active: 1, reset_amount: 3, reset_at: Date.today - 1.week},
  {name: 'Aspirin', active: 1, reset_amount: 10, reset_at: Date.today},
  {name: 'OKI', active: 1}])

Consumption.create(amount: 1, every_days: 7, when: "10:00", drug: drugs.first, user: user, ends_at: Date.today + 1.year)
