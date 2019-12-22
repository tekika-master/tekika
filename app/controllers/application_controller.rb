class ApplicationController < ActionController::Base
	private

	include SessionsHelper

	def require_user_logged_in
		unless logged_in?
			redirect_to login_url
		end
	end

	def counts(user)
		@count_products = user.products.count
		@count_likes = user.likes.count
		@count_evaluates = user.evaluates.count
		@count_problems = user.posts.count
		@count_microposts = user.microposts.count
	end



	protect_from_forgery with: :exception

  before_action :set_locale



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
     { :locale => I18n.locale }.merge options
  end

end
