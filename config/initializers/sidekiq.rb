require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["#{User.find(1).name}", "#{ENV['PSW_SIDEKIQ']}"]
end
