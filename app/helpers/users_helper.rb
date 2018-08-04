module UsersHelper

  def image_url(user)
    if user.image?
      "#{user.image}"
    else
      "/images/default1.png"
    end
  end
end
