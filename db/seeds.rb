# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all

c1 = Cat.create!(birth_date: '2014/3/3', sex: 'M', name: 'Professor Tiddles', color: 'calico', description: 'Our dear and lovel professor of adorableness.')
c2 = Cat.create!(birth_date: '2014/4/17', sex: 'F', name: 'Thranh the Destroyer', color: 'black', description: 'Demolisher of petunias, slayer of vermin, and queen of the seven settees.')
c3 = Cat.create!(birth_date: '2010/12/30', sex: 'M', name: 'Whiskers', color: 'white', description: 'Widdle kitty witty.')

CatRentalRequest.destroy_all

crr1 = CatRentalRequest.create!(cat_id: c1.id, start_date: "3/3/2015", end_date: "4/4/2016", status: "APPROVED")
crr2 = CatRentalRequest.create!(cat_id: c1.id, start_date: "2/2/2015", end_date: "3/2/2015", status: "APPROVED")
crr3 = CatRentalRequest.create!(cat_id: c1.id, start_date: "4/5/2016", end_date: "5/5/2016", status: "APPROVED")
crr4 = CatRentalRequest.create!(cat_id: c1.id, start_date: "6/6/2016", end_date: "7/7/2016", status: "APPROVED")
