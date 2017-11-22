puts 'Reset of the models.'
User.destroy_all
Request.destroy_all
puts 'All stuff destroyed.'

admin = User.create!(name: 'admin', email: 'admin@mail.com', password: 'admin',
  phone_number: '0101010101', biography: "Hi, I'm the admin !", admin: true)
admin.request.update(user: admin, status: 'confirmed')

unconfirmed = User.create!(name: Faker::Name.first_name,
  email: 'unconfirmed@mail.com', password: 'unconfirmed',
  phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10))
unconfirmed.request.update(user: unconfirmed, status: 'unconfirmed')

refresh = User.create!(name: Faker::Name.first_name,
  email: 'refresh@mail.com', password: 'refresh',
  phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10), confirmation_token: nil,
  wait_order: 1)
refresh.request.update(user: refresh, status: 'need_refresh')

confirmed_users_suffix = [*'2'..'6']

confirmed_users_suffix.each do |value|
  confirmed = User.create!(name: Faker::Name.first_name,
    email: "confirmed#{value}@mail.com", password: "confirmed#{value}",
    phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
    biography: Faker::Lorem.sentence(5, true, 10), confirmation_token: nil,
    wait_order: value.to_i)
  confirmed.request.update(user: confirmed, status: 'confirmed')
end

accepted = User.create!(name: Faker::Name.first_name,
  email: 'accepted@mail.com', password: 'accepted',
  phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10), confirmation_token: nil,
  wait_order: 0)
accepted.request.update(user: accepted, status: 'accepted')

expired = User.create!(name: Faker::Name.first_name,
  email: 'expired@mail.com', password: 'expired',
  phone_number: "05#{Faker::PhoneNumber.subscriber_number(8)}",
  biography: Faker::Lorem.sentence(5, true, 10), confirmation_token: nil,
  wait_order: nil)
expired.request.update(user: expired, status: 'expired')

puts 'Seed generated !'
