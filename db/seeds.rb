# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


divisions = Division.create([{name:'kinh te',manager_id:'2'},{name:'doi ngoai',manager_id: '4'}])

users = User.create([{name: 'killua',email: 'killua@gmail.com',password: '12345678',password_confirmation: '12345678', division_id: '1'},
{name: 'manager1',email: 'manager1@gmail.com',password: '12345678',password_confirmation: '12345678', division_id: '1', role: 'manager'} ,
{name: 'killua1',email: 'killua1@gmail.com',password: '12345678',password_confirmation: '12345678', division_id: '2'} ,
{name: 'manager2',email: 'manager2@gmail.com',password: '12345678',password_confirmation: '12345678', division_id: '2',role: 'manager'}])
