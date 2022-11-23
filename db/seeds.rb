# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Review.delete_all
SideQuest.delete_all
Category.delete_all
Trip.delete_all
User.delete_all


ricardo = User.create({
  email: "ricardorgvillanueva@gmail.com",
  password:"Ricardo1234"
})

alex = User.create({
  email: "alex.micu2012@yahoo.com",
  password:"Ricardo1234"
})


trip1 = Trip.create({
  start_point: "4200 edouard montpetit",
  end_point:"4571 avenue wilson",
  user: ricardo
})


trip2 = Trip.create({
  start_point: "4000 edouard montpetit",
  end_point:"4171 avenue wilson",
  user: alex
})


category = Category.create({
  name: "parks"
})

sidequest = SideQuest.create!({
  name: "Zoo de Granby",
  address: "4578 rue verdun",
  category: category,
  description: "One of the major zoos located in Canada and North America",
  price: 100,
  user: ricardo
})


sidequest2 = SideQuest.create!({
  name: "Fairmont Le Château Frontenac",
  address: " 1 Rue des Carrières, Québec, QC G1R 4P5",
  category: category,
  description: "The Château Frontenac is an excellent example of the grand hotels developed by railway companies in Canada in the late 1800s. Considered the world's most photographed hotel, it was designated a National Historic Site in 1981",
  price: 100,
  user: ricardo
})



review = Review.create({
  side_quest: sidequest,
  body: "Amazing experience. I highly recommend to visit Zoo de Granby",
  rating: 5,
  user: alex
})


review = Review.create({
  side_quest: sidequest2,
  body: "Amazing experience. I highly recommend to visit #{sidequest2.name}",
  rating: 5,
  user: ricardo
})
