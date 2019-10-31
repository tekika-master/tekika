class ToppagesController < ApplicationController
  def index
    if logged_in?
      @product = current_user.products.build
      @products = current_user.feed_products.order(id: :desc).page(params[:page])

    end

  
  end


  # def _products
  #   @review = Review.find(params[:review_id])
  #   @review.save
  # end
  #
  #
# end
