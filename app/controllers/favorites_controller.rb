class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    # favorite = current_user.active_favorite.new(product_id:params[:product_id])
    product = Product.find(params[:product_id])
    product.create_notification_favorite!(current_user)
    current_user.favorite(product)
    flash[:success] = "商品をいいねしました。"
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end

  def destroy
  product = Product.find(params[:product_id])
    current_user.unfavorite(product)
    flash[:success] = "いいねを解除しました。"
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
  end
end
