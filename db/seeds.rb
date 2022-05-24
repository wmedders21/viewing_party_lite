# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all

User.create!(name: 'Will', email: 'abc@mail.com', password: 'test')
User.create!(name: 'Craig', email: 'zyx@mail.com', password: 'test')
User.create!(name: 'Alicia', email: '321@mail.com', password: 'test')
