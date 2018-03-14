module CommentsHelper

  def url_status(url)
    Net::HTTP.get_response(URI.parse(url)).code
  end
  
end
