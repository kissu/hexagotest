puts 'Reset of the models.'
User.destroy_all
Request.destroy_all
puts 'All stuff destroyed.'

9.times do
  users = User.create!(name: Faker::Name.first_name, email: Faker::Internet.email,
  password: Faker::Pokemon.name,
  phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10), confirmation_token: nil)
end

User.create!(name: 'kos', email: 'hello@kissu.io', password: 'hexa',
  phone_number: '0101010101', biography: 'whateverzerzeiorjze',
  confirmation_token: nil)

User.last(5).first.update(wait_order: 1)
User.last(4).first.update(wait_order: 2)
User.last(3).first.update(wait_order: 3)
User.last(2).first.update(wait_order: 4)
User.last.update(wait_order: 5)

Request.find(10).update(status: 0)

puts 'Seed generated !'
