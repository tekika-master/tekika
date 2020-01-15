class RoomsController < ApplicationController
	def create
    @room = Room.new
    @room.user_id = current_user.id
		@room.product_id = params[:product_id]
    @room.save
		@product = Product.find(params[:product_id])
		@product.chosen = true
			if @product.save
				@product.create_purchase_notification_by(current_user)
      	flash[:success] = '商品を購入しました。'
			end
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id, :product_id => @room.product_id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id, :product_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end


  def show
    @room = Room.find(params[:id])
		@product = @room.product
    @messages = Message.where(room_id: params[:id])
    @message = Message.new
    @entries = @room.entries

		@user = @product.user
  end

	def index
    @entries = Entry.where(user_id: current_user.id, product_id: params[:product_id])
  end

  def new

  end
end
