puts 'Reset of the models.'
User.destroy_all
Request.destroy_all
puts 'All stuff destroyed.'

10.times do
  users = User.create!(name: Faker::Name.first_name, email: Faker::Internet.email,
  password: Faker::Pokemon.name, phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10))
end

User.last(2).first.update(wait_order: 1)
User.last.update(wait_order: 2)

Request.create!(user_id: 1, status: 0)
Request.create!(user_id: 2, status: 0)
Request.create!(user_id: 3, status: 0)
Request.create!(user_id: 9, status: 10)
Request.create!(user_id: 10, status: 10)

puts 'Seed generated !'
