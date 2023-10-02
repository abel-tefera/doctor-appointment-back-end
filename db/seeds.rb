require 'faker'
require 'open-uri'

Doctor.destroy_all
Appointment.destroy_all
User.destroy_all
quantity_users = 3
users = []
images = ["https://i.ibb.co/TrK90p2/doctor.png", "https://i.ibb.co/vk5zGmP/doctor2.png", "https://i.ibb.co/TYTTRPN/doctor3.png", "https://i.ibb.co/brGvWWx/doctor4.png"]

for user_position in 1..quantity_users do
  temp_user = User.create!(user_name: Faker::Name.name)
  users << temp_user
end

for i in 0..9 do
  Doctor.create!(user: users[0], name: Faker::Name.name, bio: Faker::Lorem.sentences(number: 5 + Random.rand(10)).join(' '), hospital: Faker::Address.city(), specialization: Faker::Lorem.sentences(number: 1).join(''), rate: Random.rand(100..1000), image: URI.open(images[i % 3 ]).read)
end