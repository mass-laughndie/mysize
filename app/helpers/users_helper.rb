module UsersHelper

  def gravatar_for(user, size: 50 )
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def image_for(user, size: 50 )
    if user.image
      image_url = "/user_images/#{user.image}"
    else
      image_url = "default_image1.png"
    end
    image_tag(image_url, alt: user.name, size: "#{size}x#{size}", class: "user_image")
  end
end
