class RoomsController < ApplicationController
	def create
    @room = Room.new
    @room.user_id = current_user.id
		@room.product_id = params[:product_id]
    @room.save
		@product = Product.find(params[:product_id])
		@product.chosen = true
			if @product.save
      	flash[:success] = '商品を購入しました。'
			end
		# 商品のIDを前のフォームで引っ張ってくる
		# 商品のIDからProduct.find()
		# product.chosen = true
		# product.save→その商品は取引中になる
		# _____________________________________
		# discarded_at (gem discard)を用いて無効化させる
		# 条件分岐でsoldoutって表示させる
		# あとはviewにif文でif product.chosen = true ボタンを押せなくする。
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id, :product_id => @room.product_id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id, :product_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end


  def show
		# @user = @product.user
    @room = Room.find(params[:id])
    @messages = Message.where(room_id: params[:id])
    @message = Message.new
    @entries = @room.entries
    # 	if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
    #   	@messages = @room.messages
    # 		@message = Message.new
    #   	@entries = @room.entries
    # 	end
  end

	def index
    @entries = Entry.where(user_id: current_user.id, product_id: params[:product_id])
  end

  def new

  end

  private

  # def params_room
  #   params.require(:room).permit(:user_id, :product_id)
  # end

  def star
  end
end
