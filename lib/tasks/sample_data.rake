namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                surname: "Chichevago",
                email: "example@railstutorial.org",
                password: "foobar",
                password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.first_name
      surname = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                  surname: surname,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end

    StudentLevel.create!(title: "beginner")
    StudentLevel.create!(title: "elementary")
    StudentLevel.create!(title: "intermediate")
    StudentLevel.create!(title: "upper intermediate")
    StudentLevel.create!(title: "advanced")
    StudentLevel.create!(title: "proficiency")
    
  end
end
