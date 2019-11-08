class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]



  def index
    @q = Micropost.ransack(params[:q])
      @microposts = @q.result.order(id: :desc).page(params[:page]).per(15)
    @micropost = current_user.microposts.build  # form_with 用
  end

  def show

  end

  def new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
        redirect_back(fallback_location: root_path)
    else
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
        redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
  end



  def search
    @products = Micropost.search(params[:search])
    @microposts = current_user.microposts.order(id: :desc).page(params[:page])

  end



  # def set_search
  #      @w = Micropost.ransack(params[:q])
  # end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :info)
  end

  # def search_params
  #   params.require(:w).permit(:easy, :info, :exam, :other)
  # end

  def correct_user
   @micropost = current_user.microposts.find_by(id: params[:id])
   unless @micropost
     redirect_to root_url
   end
 end
end
