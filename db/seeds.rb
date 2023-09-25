require 'faker'
require 'open-uri'

Doctor.destroy_all
Appointment.destroy_all
User.destroy_all
quantity_users = 5
users = []
images = ["https://i.ibb.co/TrK90p2/doctor.png", "https://i.ibb.co/vk5zGmP/doctor2.png", "https://i.ibb.co/TYTTRPN/doctor3.png", "https://i.ibb.co/brGvWWx/doctor4.png"]

for user_position in 1..quantity_users do
  temp_user = User.create!(user_name: "User Number #{user_position}")
  users << temp_user
end

for i in 0..users.length - 1 do
  for j in 1..4 do
    Doctor.create!(user: users[i], name: "Dr Number #{j}", bio: Faker::Lorem.sentences(number: 5 + Random.rand(10)).join(' '), hospital: Faker::Lorem.sentences(number: 1), specialization: Faker::Lorem.sentences(number: 1), rate: Random.rand(100..1000), image: URI.open(images[j-1]).read)
  end
end