class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  mount_uploader :image, ImageUploader

  def time
    "#{created_at.strftime('%Y/%m/%d %H:%M:%S')}"
  end
end
