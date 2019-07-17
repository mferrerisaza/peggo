class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
  belongs_to :expense, optional: true
  belongs_to :invoice_equivalent, optional: true
end
