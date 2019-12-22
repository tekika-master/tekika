class NotificationsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(15)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
private
  def correct_user
    @notifications = current_user.products.find_by(id: params[:id])
    unless @notifications
      redirect_to root_url
    end
  end
end
