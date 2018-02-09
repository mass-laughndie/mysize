User.create!(name: "Masa",
             email: "mysize@example.com",
             mysize_id: "masa",
             password: "foobar",
             password_confirmation: "foobar",
             shoe_size: 10,
             image: nil,
             profile_content: "Jordan1(26.5cm)/Kithコラボが好きです！",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "mysize-#{n+1}@example.com"
  mysize_id = "mysize_#{n+1}"
  password = "password"
  shoe_size = rand(1..17)
  profile_content = Faker::Lorem.sentence(5)
  User.create!(name: name,
               email: email,
               mysize_id: mysize_id,
               password: password,
               password_confirmation: password,
               shoe_size: shoe_size,
               image: nil,
               profile_content: profile_content)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  picture = nil
  users.each { |user| user.kicksposts.create!(content: content,
                                              picture: picture) }
end