# User
User.create!(name: "Masa",
             email: "mysize@example.com",
             mysize_id: "masa",
             password: "foobar",
             password_confirmation: "foobar",
             size: 26.5,
             remote_image_url: Faker::Avatar.image,
             content: "Jordan1(26.5cm)/Kithコラボが好きです！",
             admin: true)

9.times do |n|
  name = Faker::Name.name
  email = "mysize-#{n+1}@example.com"
  mysize_id = "mysize_#{n+1}"
  password = "password"
  size = 21.5 + 0.5 * rand(1..17)
  image = Faker::Avatar.image
  content = Faker::Lorem.sentence(5)
  User.create!(name: name,
               email: email,
               mysize_id: mysize_id,
               password: password,
               password_confirmation: password,
               size: size,
               remote_image_url: image,
               content: content)
end

#Kickspost
if Rails.env.development?
  users = User.order(:created_at).take(3)
  3.times do
    users.each do |user|
      user.kicksposts.create!(content: Faker::Lorem.paragraph(2, false, 4),
                              picture: open("#{Rails.root}/db/data/kicks#{rand(1..15)}.jpg"),
                              size: 21.5 + 0.5 * rand(1..17))
    end
  end
end
=begin
if Rails.env.production?
  users = User.order(:created_at).take(3)
  3.times do
    users.each do |user|
      user.kicksposts.create!(content: Faker::Lorem.paragraph(2, false, 4),
                              remote_picture_url: Faker::Avatar.image,
                              size: 21.5 + 0.5 * rand(1..17))
    end
  end
end
=end
#Relationship
users = User.all
user = users.first
following = users[2..6]
followers = users[3..6]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }