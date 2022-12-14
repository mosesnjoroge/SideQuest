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
  start_location: "1155 Metcalfe St, Montreal, Qc",
  end_location: "380 Sussex Dr, Ottawa, ON",
  user: ricardo
})


trip2 = Trip.create({
  start_location: "1155 Metcalfe St, Montreal, Qc",
  end_location: "3515 Rue la Fontaine, Montreal, QC",
  user: alex
})


category = Category.create({
  name: "parks"
})



sidequest = SideQuest.create!({
  name: "Parc Omega",
  address: "399 QC-323, Montebello, QC",
  category: category,
  description: "Nature park featuring wildlife, picnicking, First Nations totems & an eatery, plus cabins & tipis.",
  price: 50,
  user: ricardo,
  latitude:45.686390,
  longitude: -74.946080
})
file = URI.open("https://upload.wikimedia.org/wikipedia/commons/5/59/Two_Wapiti_%28Elk%29_at_Parc_Omega%2C_a_drive-through_safari_park_in_Montebello%2C_Quebec_%28Canada%29.jpg")
sidequest.photo.attach(io: file, filename: "sidequest.png", content_type: "image/png")
sidequest.save!

sidequest2 = SideQuest.create!({
  name: "Jessup's Falls Conservation Area",
  address: "6675 County Rd 17, Plantagenet, ON",
  category: category,
  description: "A Little Corner of Paradase",
  price: 25,
  user: ricardo,
  latitude: 45.559260,
  longitude: -75.059930
})
file2 = URI.open("https://www.nation.on.ca/sites/default/files/Jessup%27s%20Falls%20CA_Bridge.jpg")
sidequest2.photo.attach(io: file2, filename: "sidequest2.png", content_type: "image/png")
sidequest2.save!


sidequest3 = SideQuest.create!({
  name: "Papanack Park Zoo",
  address: "150 County Rd 19, Wendover, ON",
  category: category,
  description: "A Small Zoo in Wendover",
  price: 50,
  user: alex,
  latitude: 45.561610,
  longitude: -75.119840
})
file3 = URI.open("https://upload.wikimedia.org/wikipedia/commons/b/b2/Arctic_Wolf%27s_Impression_of_a_Dog.jpg")
sidequest3.photo.attach(io: file3, filename: "sidequest3.png", content_type: "image/png")
sidequest3.save!


sidequest4 = SideQuest.create!({
  name: "Humanics Sanctuary and Sculpture Park",
  address: "3468 Ch. Old Montréal Rd, Ottawa, ON",
  category: category,
  description: "Come and experience this hidden jewel just outside Cumberland Village in Ottawa. ",
  price: 5,
  user: ricardo,
  latitude:45.515775,
  longitude: -75.364055
})

file4 = URI.open("https://upload.wikimedia.org/wikipedia/commons/e/e6/Humanics_02.jpg")
sidequest4.photo.attach(io: file4, filename: "sidequest4.png", content_type: "image/png")
sidequest4.save!



sidequest5 = SideQuest.create!({
  name: "Proulx Sugar Bush & Berry Farm",
  address: "1865 O'Toole Rd, Cumberland, ON",
  category: category,
  description: "Since 1920, this family-owned farm has offered maple products & activities such as berry picking",
  price: 100,
  user: ricardo,
  latitude:45.5168,
  longitude: -75.39932
})
file5 = URI.open("https://www.biline.ca/Ottawa/Family/sugarbush/Proulx/IMG_1948.jpg")
sidequest5.photo.attach(io: file5, filename: "sidequest5.png", content_type: "image/png")
sidequest5.save!


sidequest6 = SideQuest.create!({
  name: "Calypso Theme Waterpark",
  address: "2015 Calypso St, Limoges, ON",
  category: category,
  description: "100 acres of activities for all ages, including a giant wave pool, toddler area & fast waterslides.",
  price: 100,
  user: ricardo,
  latitude:45.3334,
  longitude: -75.24931
})

file6 = URI.open("https://upload.wikimedia.org/wikipedia/commons/8/89/Calypso_Park.jpg")
sidequest6.photo.attach(io: file6, filename: "sidequest6.png", content_type: "image/png")
sidequest6.save!

sidequest7 = SideQuest.create!({
  name: "Mariposa Farm",
  address: "6468 County Rd 17, Plantagenet, ON",
  category: category,
  description: "SUSTAINABLE AGRICULTURE, LOCAL FOOD AND RURAL LIFE IS WHAT WE’RE ALL ABOUT!",
  price: 100,
  user: ricardo,
  latitude:45.5326,
  longitude: -74.99369
})

file7 = URI.open("https://upload.wikimedia.org/wikipedia/commons/7/70/Borgboda2006_web.jpg")
sidequest7.photo.attach(io: file7, filename: "sidequest7.png", content_type: "image/png")
sidequest7.save!

sidequest8 = SideQuest.create!({
  name: "Kirkview Farms",
  address: "20921 Laggan Glenelg Rd, Dalkeith, ON",
  category: category,
  description: "Your farmers. Naturally",
  price: 100,
  user: ricardo,
  latitude:45.45009,
  longitude: -74.58256
})
file8 = URI.open("https://upload.wikimedia.org/wikipedia/commons/d/d2/Goat_at_the_Farm.jpg")
sidequest8.photo.attach(io: file8, filename: "sidequest8.png", content_type: "image/png")
sidequest8.save!

sidequest9 = SideQuest.create!({
  name: "Cumberland Heritage Village Museum",
  address: "2940 Ch. Old Montréal Rd, Cumberland, ON",
  category: category,
  description: "Collection of structures depicting early 20th-century life from a general store to a train station.",
  price: 100,
  user: ricardo,
  latitude:45.5178222,
  longitude: -75.3911933
})
file9 = URI.open("https://upload.wikimedia.org/wikipedia/commons/7/72/Cumberland_Ottawa.JPG")
sidequest9.photo.attach(io: file9, filename: "sidequest9.png", content_type: "image/png")
sidequest9.save!


sidequest10 = SideQuest.create!({
  name: "Good Food Garden",
  address: "1793 Pleasant Corner Rd, Vankleek Hill, ON",
  category: category,
  description: "Heathy and Natural Soil. Healthy Plants. Heathy Food.",
  price: 100,
  user: ricardo,
  latitude:45.51679,
  longitude: -74.64926
})
file10 = URI.open("https://upload.wikimedia.org/wikipedia/commons/4/41/Brooklyn_Botanic_Garden_New_York_May_2015_010.jpg")
sidequest10.photo.attach(io: file10, filename: "sidequest10.png", content_type: "image/png")
sidequest10.save!


sidequest11 = SideQuest.create!({
  name: "L'Orignal Schoolhouse #4",
  address: "6675 County Rd 17, Plantagenet, ON",
  category: category,
  description: "This is School house #4, which was built in the early 1900's. It is located in L'orignal/Cassburn Ontario. It was built for Franco Ontariens.",
  price: 100,
  user: ricardo,
  latitude:45.5326,
  longitude: -74.99369
})
file11 = URI.open("https://upload.wikimedia.org/wikipedia/commons/b/b1/Wells_maine_div_9_schoolhouse_2006.jpg")
sidequest11.photo.attach(io: file11, filename: "sidequest11.png", content_type: "image/png")
sidequest11.save!


review = Review.create({
  side_quest: sidequest,
  body: "Awesome place its a must place to visit in Canada",
  rating: 5,
  user: alex
})

review2 = Review.create({
  side_quest: sidequest,
  body: "Great activities for the kids",
  rating: 5,
  user: alex
})

review3 = Review.create({
  side_quest: sidequest2,
  body: "Beautiful place for  a picnic and to relax!",
  rating: 3,
  user: alex
})

review4 = Review.create({
  side_quest: sidequest2,
  body: "Good spot for a picnic with the kids.",
  rating: 3,
  user: alex
})

review5 = Review.create({
  side_quest: sidequest3,
  body: "Do not support this zoo",
  rating: 3,
  user: alex
})

review6 = Review.create({
  side_quest: sidequest3,
  body: "More animals than I expected, decent place, we had fun",
  rating: 3,
  user: alex
})

review7 = Review.create({
  side_quest: sidequest4,
  body: "I had a great time",
  rating: 5,
  user: alex
})

review8 = Review.create({
  side_quest: sidequest6,
  body: "great place for fun with family",
  rating: 4,
  user: alex
})

review9 = Review.create({
  side_quest: sidequest7,
  body: "Great food, friendly staff and lovely place. ",
  rating: 5,
  user: alex
})

review10 = Review.create({
  side_quest: sidequest9,
  body: "Excellent place. Staff is great and kind. Need a little bit of maintenance but overall it is a fun experience",
  rating: 4,
  user: alex
})

review11 = Review.create({
  side_quest: sidequest11,
  body: "A great road side photo opportunity.",
  rating: 4,
  user: alex
})



review = Review.create({
  side_quest: sidequest2,
  body: "Nice walk in wooded area with great sculptures",
  rating: 5,
  user: ricardo
})
