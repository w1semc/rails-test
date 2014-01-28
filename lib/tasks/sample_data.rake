namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    3.times do
    zagolovok = Faker::Lorem.sentence(5)
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(zagolovok: zagolovok, 
                                                content: content) }
    end
  
  microposts = Micropost.all
  3.times do
  content = Faker::Lorem.sentence(5)
  microposts.each { |micropost| micropost.comments.create!(content: content) }
  end
end
end
