class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 200 }

  default_scope -> { order(created_at: :desc) }
end
