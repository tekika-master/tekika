class Post < ApplicationRecord

  attachment :figure
  validates_presence_of :figure
  validates :problem, presence: true, length: {maximum: 10 }
  validates :department, presence: true
  belongs_to :user

  has_many :problems

  default_scope -> { order(created_at: :desc) }
end
