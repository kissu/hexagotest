namespace :db do
  desc "Reset all the database !"
  task fresh: [ 'db:drop', 'db:create', 'db:migrate', 'db:seed' ] do
    puts 'Fresh data ready !'
  end
end
