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

Refile.secret_key = 'ff06c91633c8cf80f54f0e6890adafab8bd731b269523660f8f277e0f3b0823b5535b9a7bc9f9d7938b4aca89dd4222b41175ac68f13edb641acd16c3cbd826d'
