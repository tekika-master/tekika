module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  # def notification_form(notification)
  #   @comment = nil
  #   @visitor = link_to notification.visitor.name, notification.visitor
  #   @your_post = link_to 'あなたの商品', notification.product
  #   case notification.action
  #   when "favorite" then
  #       "#{notification.visitor.name}が#{@your_post}にいいね！しました"
  #   when "comment" then
  #     @comment=Comment.find_by(id:notification.comment_id)&.content
  #     "#{visiter}が#{your_post}にコメントしました"
    end


# <div>
#   <%= link_to notification.user.name, user_path(notification.user) %>
#   <%= link_to 'あなたの商品'notification.product, user_path(notification.product) %>
#     <span class="text-muted">　posted at
#       <%= micropost.created_at.strftime("%Y年%m月%d日 %H時%M分") %>
#     </span>
# </div>
