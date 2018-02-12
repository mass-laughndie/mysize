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

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.production?
    config.storage :file
  elsif Rails.env.test?
    config.strage NullStorage
  end
end
=end
module CarrierWave
  module MiniMagick
    #画質調整
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    #画像の自動回転を防ぐ
    def fix_exif_rotation
      manipulate! do |img|
        img = img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end
  end
end