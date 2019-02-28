10.times do |n|
    name = Faker::TvShows::BreakingBad.character
    email = Faker::Internet.email
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 )
  end