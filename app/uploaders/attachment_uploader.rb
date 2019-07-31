class AttachmentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  make_private

  def extension_whitelist
    %w(jpg jpeg gif png pdf)
  end
end
