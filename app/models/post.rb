class Post < ApplicationRecord

  validates :image, presence: true
  validates :problem, presence: true, length: {maximum: 11 }
  validates :department, presence: true
  validates :campus, presence: true


  mount_uploader :image, ImagesUploader

  belongs_to :user

  has_many :problems

  default_scope -> { order(created_at: :desc) }
end
