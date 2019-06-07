class AttachmentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
