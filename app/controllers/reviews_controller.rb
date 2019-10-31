class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def show
    @review = Reviews.new
  end

  def create
    product = Product.find(params[:product_id])
    @review = current_user.reviews.new(params_review)
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
