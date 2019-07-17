class LogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
