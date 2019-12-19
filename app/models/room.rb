class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
 belongs_to :user
 belongs_to :product

 def create_cancel_notification_by(user)
       notification = self.product.user.active_notifications.new(
         product_id: self.product_id,
         visited_id: user.id,
         action: 'cancel'
       )
       notification.save if notification.valid?
 end
end
