module KickspostsHelper

  def picture_url(post)
    if post.picture?
      "#{post.picture}"
    else
      "/images/default.png"
    end
  end
end
