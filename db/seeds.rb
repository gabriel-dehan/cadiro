# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create({ email: 'test@test.com', password: 'password' });

League.destroy_all

# puts "Fetching poe watch data..."
# PoeWatch::Api.refresh!

# PoeWatch::League.all.each do |league|
#   name
#   display
#   hardcore
#   active
#   start
# end


League.create([
  {
    name: "Metamorph",
    start_date: "2019-12-13",
    version: "3.9"
  },
  {
    name: "Blight",
    start_date: "2019-09-06",
    end_date: "2019-12-09",
    version: "3.8"
  },
  {
    name: "Legion",
    start_date: "2019-06-07",
    end_date: "2019-09-03",
    version: "3.7"
  }
])