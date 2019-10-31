# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Department.create!(name:'経済学部')
Department.create!(name:'商学部')
Department.create!(name:'文学部')
Department.create!(name:'理工学部')
Campus.create!(name:'日吉')
Campus.create!(name:'三田')
Campus.create!(name:'湘南藤沢')
Problem.create!(name:'人類学', campus_id:1)
Problem.create!(name:'考古学', campus_id:2)
Problem.create!(name:'社会思想史', campus_id:3)
Problem.create!(name:'会計学', campus_id:4)
