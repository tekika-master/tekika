class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order(created_at: :desc)
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @products = Product.where(user_id: params[:id])

    if @products.empty?
      @user.destroy
      redirect_back(fallback_location: root_path)
      flash[:success] = 'ユーザーを削除しました。'
    else
      @products.destroy
      @user.destroy
      redirect_back(fallback_location: root_path)
      flash[:success] = 'ユーザーを削除しました。'
    end
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
