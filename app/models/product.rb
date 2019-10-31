class Product < ApplicationRecord
  belongs_to :user
  has_many :rooms
  mount_uploader :image, ImagesUploader

  has_many :favorites, dependent: :destroy

  has_many :reviews, dependent: :destroy


  has_many :notifications, dependent: :destroy

  def create_notification_favorite!(current_user)
      # すでに「いいね」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # いいねされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          product_id: id,
          visited_id: user_id,
          action: 'favorite'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

  def self.search(search)
    return Product.all unless search
    Product.where(['lecture LIKE ?', "%#{search}%"])
  end
end
