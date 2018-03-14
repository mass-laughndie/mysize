=begin
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end
=end

CarrierWave.configure do |config|
  #テスト時の画像の格納場所を変更 => gitに保存されなくなる
  config.cache_dir = Rails.root.join 'tmp/uploads'

  if Rails.env.production?

    config.fog_credentials = {
      provider:               'AWS',
      region:                 ENV['S3_REGION'],
      aws_access_key_id:      ENV['S3_ACCESS_KEY'],
      aws_secret_access_key:  ENV['S3_SECRET_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET']

  end
end