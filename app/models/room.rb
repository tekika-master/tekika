class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifications, dependent: :destroy
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

 def create_message_notification_by(user)
   self.entries.each do |entry|
     if entry.user_id != user.id
       receive_user = User.find_by(id: entry.user_id)
       notification = user.active_notifications.new(
         room_id: self.id,
         visited_id: receive_user.id,
         action: 'message'
       )
       notification.save if notification.valid?
     end
   end


 end
end
