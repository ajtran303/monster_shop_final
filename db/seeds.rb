# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
megan.bulk_discounts.create!(bulk_quantity: 5, percentage_discount: 20)
megan.bulk_discounts.create!(bulk_quantity: 10, percentage_discount: 25)

megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian.bulk_discounts.create!(bulk_quantity: 10, percentage_discount: 30)

brian.items.create!(name: 'Basilisk', description: "I'm a Basilisk!", price: 100, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 30 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

meg_employee = User.create!(name: "Megan's Employee", address: "Cool Street", city: "Rubyville", state: "CO", zip: 12345, role: 1, merchant: megan, password: "password", email: "meg@email.com")
brian_employee = User.create!(name: "Brian's Employee", address: "Cool Avenue", city: "Railsville", state: "CO", zip: 54321, role: 1, merchant: brian, password: "password", email: "brian@email.com")

rose_customer = User.create!(name: "Rose", address: "Ice Cold Lane", city: "Assembly City", state: "CO", zip: 45412, role: 0, password: "password", email: "rose@email.com")
