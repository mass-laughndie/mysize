# User
User.create!(name: "Masa",
             email: "mysize@example.com",
             mysize_id: "masa",
             password: "foobar",
             password_confirmation: "foobar",
             shoe_size: 10,
             remote_image_url: Faker::Avatar.image,
             profile_content: "Jordan1(26.5cm)/Kithコラボが好きです！",
             admin: true)

29.times do |n|
  name = Faker::Name.name
  email = "mysize-#{n+1}@example.com"
  mysize_id = "mysize_#{n+1}"
  password = "password"
  shoe_size = rand(1..17)
  image = Faker::Avatar.image
  profile_content = Faker::Lorem.sentence(5)
  User.create!(name: name,
               email: email,
               mysize_id: mysize_id,
               password: password,
               password_confirmation: password,
               shoe_size: shoe_size,
               remote_image_url: image,
               profile_content: profile_content)
end

#Kickspost
users = User.order(:created_at).take(3)
if Rails.env.development?
  5.times do
    users.each do |user|
      user.kicksposts.create!(content: Faker::Lorem.paragraph(2, false, 4),
                              picture: open("#{Rails.root}/db/data/kicks#{rand(1..15)}.jpg"),
                              size: rand(1..17))
    end
  end
elsif Rails.env.production?
  5.times do
    users.each do |user|
      user.kicksposts.create!(content: Faker::Lorem.paragraph(2, false, 4),
                              remote_picture_url: Faker::Avatar.image,
                              size: rand(1..17))
    end
  end
end

#Relationship
users = User.all
user = users.first
following = users[2..25]
followers = users[3..15]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }