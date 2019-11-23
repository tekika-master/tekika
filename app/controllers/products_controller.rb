class ProductsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def cancel
    @product = Product.find(params[:product_id])
		@product.chosen = false
			if @product.save
        @room = Room.find(params[:room_id])
        @room.destroy
      	flash[:success] = '取引をキャンセルしました。'
        redirect_to root_url
			end
  end

  def review
    @review.product_id = product.id
    @review = Review.find(params[:review_id])
    @review.save
  end

  # def index
  #   @q = Product.ransack(params[:q])
  #     @products = @q.result.order(id: :desc).page(params[:page]).per(20)
  #
  #
  # end

  def index
    @products = Product.search(params[:search])
    # @products = Product.order(id: :desc).page(params[:page]).per(2)
  end


  def edit
     @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if current_user == @product.user
      @product.update(product_params)
      flash[:success] = '商品を編集しました。'
      redirect_to root_url
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = '商品を出品しました。'
      redirect_to root_url
    else
      @products = current_user.feed_products.order(id: :desc).page(params[:page])
      flash.now[:danger] = '商品の出品に失敗しました。'
      render 'products/new'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = '商品を削除しました。'
    redirect_to root_url
  end

  def show
     @product = Product.find(params[:id])
     @user = @product.user
       if @user.id != current_user.id
        @currentUserEntry=Entry.where(user_id: current_user.id, product_id: @product.id )
        @userEntry=Entry.where(user_id: @user.id, product_id: @product.id )
          if @userEntry.blank?
            @isRoom = false
            @room = Room.new
            @entry = Entry.new
          elsif @currentUserEntry.blank?
            @isRoom = false
            @room = Room.new
            @entry = Entry.new
          elsif @product.reviews.present?
            @isRoom = false
          else
            @currentUserEntry.each do |cu|
              @userEntry.each do |u|
                @isRoom = true
                @roomId = cu.room_id
              end
            end
          end
        else
         @currentUserEntry=Entry.where(user_id: current_user.id, product_id: @product.id )
        end

  end

  def search
    @products = Product.search(params[:search])
  end

  def likes
    @product = Product.find(params[:id])
    @likes = @user.likes.page(params[:page])
  end


  private

  def product_params
    params.require(:product).permit(:image, :title, :price, :lecture, :university, :place, :writing)
  end

  def correct_user
    @product = current_user.products.find_by(id: params[:id])
    unless @product
      redirect_to root_url
    end
  end

  def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
  end

end
