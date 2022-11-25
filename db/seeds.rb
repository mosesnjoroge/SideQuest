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
  name: "Parc Omega",
  address: "399 QC-323, Montebello, QC J0V 1L0",
  category: category,
  description: "Nature park featuring wildlife, picnicking, First Nations totems & an eatery, plus cabins & tipis.",
  price: 50,
  user: ricardo
})


sidequest2 = SideQuest.create!({
  name: "Jessup's Falls Conservation Area",
  address: "6675 County Rd 17, Plantagenet, ON K0B 1L0",
  category: category,
  description: "A Little Corner of Paradase",
  price: 25,
  user: ricardo
})

sidequest2 = SideQuest.create!({
  name: "Papanack Park Zoo",
  address: "150 County Rd 19, Wendover, ON K0A 3K0",
  category: category,
  description: "A Small Zoo in Wendover",
  price: 50,
  user: alex
})


sidequest2 = SideQuest.create!({
  name: "Little Ray's Nature Centre",
  address: "6675 County Rd 17, Plantagenet, ON K0B 1L0",
  category: category,
  description: "One of the largest exotic animal rescues in North America",
  price: 100,
  user: alex
})


sidequest2 = SideQuest.create!({
  name: "Humanics Sanctuary and Sculpture Park",
  address: "3468 Ch. Old Montréal Rd, Ottawa, ON K4C 1C8",
  category: category,
  description: "Come and experience this hidden jewel just outside Cumberland Village in Ottawa. ",
  price: 5,
  user: ricardo
})



sidequest2 = SideQuest.create!({
  name: "Proulx Sugar Bush & Berry Farm",
  address: "1865 O'Toole Rd, Cumberland, ON K4C 1N2",
  category: category,
  description: "
  Since 1920, this family-owned farm has offered maple products & activities such as berry picking",
  price: 100,
  user: ricardo
})


sidequest2 = SideQuest.create!({
  name: "Calypso Theme Waterpark",
  address: "2015 Calypso St, Limoges, ON K0A 2M0",
  category: category,
  description: "100 acres of activities for all ages, including a giant wave pool, toddler area & fast waterslides.

  ",
  price: 100,
  user: ricardo
})

sidequest2 = SideQuest.create!({
  name: "Mariposa Farm",
  address: "6468 County Rd 17, Plantagenet, ON K0B 1L0",
  category: category,
  description: "SUSTAINABLE AGRICULTURE, LOCAL FOOD AND RURAL LIFE IS WHAT WE’RE ALL ABOUT!",
  price: 100,
  user: ricardo
})

sidequest2 = SideQuest.create!({
  name: "Kirkview Farms",
  address: "20921 Laggan Glenelg Rd, Dalkeith, ON K0B 1E0",
  category: category,
  description: "Your farmers. Naturally",
  price: 100,
  user: ricardo
})


sidequest2 = SideQuest.create!({
  name: "Cumberland Heritage Village Museum",
  address: "2940 Ch. Old Montréal Rd, Cumberland, ON K4C 1G3",
  category: category,
  description: "Collection of structures depicting early 20th-century life from a general store to a train station.",
  price: 100,
  user: ricardo
})


sidequest2 = SideQuest.create!({
  name: "Good Food Garden",
  address: "1793 Pleasant Corner Rd, Vankleek Hill, ON K0B 1R0",
  category: category,
  description: "Heathy and Natural Soil. Healthy Plants. Heathy Food.",
  price: 100,
  user: ricardo
})

sidequest2 = SideQuest.create!({
  name: "L'Orignal Schoolhouse #4",
  address: "6675 County Rd 17, Plantagenet, ON K0B 1L0",
  category: category,
  description: "This is School house #4, which was built in the early 1900's. It is located in L'orignal/Cassburn Ontario. It was built for Franco Ontariens.",
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
