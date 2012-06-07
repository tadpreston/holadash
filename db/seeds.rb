# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({ email: 'superuser@root.com', 
              employee_id: '99999999', 
              first_name: 'Root', 
              last_name: 'User', 
              roles: [User::ROLE_ROOT], 
              username: 'root',
              password: 'nov8ordie' })
