class Admin::UsersController < ApplicationController
  before_action :admin_user, only: :destroy

  def index
    @q = User.with_discarded.ransack(params[:q])
    @users = @q.result.order(id: :desc).page(params[:page]).per(20)
    @counts = User.count
  end

  def destroy
    user = User.find(params[:id])
    user.products.each do |product|
      product.destroy
    end
      user.discard
      flash[:notice] = "退会させました"
      redirect_to admin_users_path
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
