module KickspostsHelper

  def picture_url(post)
    if post.picture?
      "#{post.picture}"
    else
      "/images/no_image.png"
    end
  end
end
