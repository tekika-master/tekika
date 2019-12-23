class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  def new
    @product = Product.find(params[:product_id])
    @product.create_submit_notification_by(current_user)
    @room = Room.find_by(params[:room_id])
    @room.destroy
    @review = Review.new
  end

  def show
    @review = Reviews.new
  end

  def create
    product = Product.find(params[:product_id])
    @review = current_user.reviews.new(params_review)
    product.create_review_notification_by(current_user)
    @review.product_id = product.id
      if @review.save
        flash[:success] = "商品を評価しました。"
        redirect_to root_url
      end
  end


  private
    def params_review
      params.require(:review).permit(:feeling, :content)
    end
  end
