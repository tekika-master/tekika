class MessagesController < ApplicationController
	def create
		@message = Message.new(params_message)
		@message.user_id = current_user.id
    if @message.save
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
 def params_message
 	params.require(:message).permit(:user_id, :room_id, :content)
 end
end

