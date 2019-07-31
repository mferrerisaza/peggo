class AttachmentsController < ApplicationController
  before_action :set_business
  before_action :set_attachment

  def show
    authorize @business, :business_of_current_user?
    url = if @attachment.file.file.storage_type == "private"
            Cloudinary::Utils.private_download_url(@attachment.file.file.public_id, @attachment.file.format)
          else
            Cloudinary::Utils.cloudinary_url(@attachment.file.filename)
          end
    redirect_to url
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end
