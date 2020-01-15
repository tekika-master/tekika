class Product < ApplicationRecord

  attachment :picture
  validates_presence_of :picture
  validates :title, presence: true, length: {maximum: 20 }
  validates :price, presence: true, length: {maximum: 6 }
  validates :lecture, presence: true, length: {maximum: 20 }
  validates :university, presence: true, length: {maximum: 30 }
  validates :place, presence: true, length: {maximum: 15 }
  validates :writing, presence: true, length: {maximum: 500 }

  belongs_to :user
  has_many :rooms

  has_many :favorites, dependent: :destroy

  has_many :reviews, dependent: :destroy


  has_many :notifications, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def create_favorite_notification_by(current_user)
      # すでに「いいね」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # いいねされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          product_id:self.id,
          visited_id:user_id,
          action: 'favorite'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
  end

  def create_review_notification_by(current_user)
      temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_user.id, user_id, id, 'review'])
      # 評価されていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          product_id:self.id,
          visited_id:user_id,
          action: 'review'
        )
        # 自分の投稿に対する評価の場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    def create_purchase_notification_by(current_user)
          notification_buy = current_user.active_notifications.new(
            product_id:self.id,
            visited_id:user_id,
            action: 'purchase'
          )
          notification_buy.save if notification_buy.valid?
          notification_own = current_user.active_notifications.new(
            product_id:self.id,
            visited_id:current_user.id,
            action: 'purchase'
          )
          notification_own.save if notification_own.valid?
    end

    def create_submit_notification_by(current_user)
          notification = current_user.active_notifications.new(
            product_id:self.id,
            visited_id:user_id,
            action: 'submit'
          )
          notification.save if notification.valid?
    end

    def self.search(search)
     return Product.all unless search
     Product.where(['lecture LIKE ?', "%#{search}%"])
   end


  def self.search(search) #self.でクラスメソッドとしている
      if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
        Product.where(['lecture LIKE ?', "%#{search}%"])
      else
        Product.order(id: :desc).page(params[:page]).per(20)
      end
    end
end
