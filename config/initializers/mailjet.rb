Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_SECRET_KEY']
  config.default_from = 'hello@kissu.io'
  config.api_version = 'v3.1'
end
