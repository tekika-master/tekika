class Notification < ApplicationRecord
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  default_scope->{order(created_at: :desc)}
  belongs_to :product, optional: true
  belongs_to :review, optional: true

  # belongs_to :like, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
