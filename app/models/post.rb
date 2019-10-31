class Post < ApplicationRecord

  mount_uploader :image, ImagesUploader

  belongs_to :user

  has_many :problems

  default_scope -> { order(created_at: :desc) }
end
