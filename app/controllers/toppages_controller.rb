class ToppagesController < ApplicationController
  def index
    if logged_in?
      @product = current_user.products.build
      @products = current_user.feed_products.order(id: :desc).page(params[:page]).per(20)
    end
  end
end
