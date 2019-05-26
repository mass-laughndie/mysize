class ExternalSigninUser < User
  self.table_name = "users"

  DEFAULT_SHOESIZE = 27.0

  class << self
    def find_or_create_from_auth(auth)
      find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
        user.name  = auth[:info][:name]
        user.email = dummy_email(auth)
        user.remote_image_url = auth[:info][:image].sub("_normal", "")
        user.size = DEFAULT_SHOESIZE
        user.mysize_id = set_mysize_id(auth[:info][:nickname])
      end
    end

    private

    def dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

    def set_mysize_id(mysize_id)
      return mysize_id if User.find_by(mysize_id: mysize_id).nil?
      while true
        num = SecureRandom.urlsafe_base64(10)
        return num if User.find_by(mysize_id: num).nil?
      end
    end
  end
end