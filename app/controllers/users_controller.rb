class UsersController < ApplicationController
before_action :require_user_logged_in, only: [:index, :show, :exhibition,
   :likes, :evaluates, :tweets, :microposts, :good]
  def index
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products.order(id: :desc).page(params[:page]).per(20)
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(20)
    @evaluates = @user.evaluates.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end

  def edit
   @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end
    else
      redirect_to @user
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @products = Product.find_by(user_id: params[:id])

    if @products.nil?
       current_user.destroy
      redirect_to("/")
      flash[:success] = 'ユーザーを削除しました。'
    else
      @products.destroy
      current_user.destroy
      redirect_to("/")
      flash[:success] = 'ユーザーを削除しました。'
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end

  def evaluates
    @user = User.find(params[:id])
    @evaluates = @user.evaluates.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end

  def exhibition
    @user = User.find(params[:id])
    @products = @user.products.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end

  def microposts
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end


  def tweets
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end


  def problem
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(20)
    counts(@user)
  end

  def reviewed
    @user = User.find(params[:id])
    @reviews = []
    @user.products.each do |product|
      Review.where(product_id: product.id).each do |review|
        @reviews << review
      end
    def simple_time(time)
      time.strftime("%Y-%m-%d　%H:%M　")
    end
  end
end

#   def good
#     @user = User.find(params[:id])
#     @reviews = []
#     @user.products.each do |product|
#       Review.where(product_id: product.id).each do |review|
#         @reviews << review
#       end
#     def simple_time(time)
#       time.strftime("%Y-%m-%d　%H:%M　")
#     end
#   end
# end


  private

  def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation, :intro)
  end
end
