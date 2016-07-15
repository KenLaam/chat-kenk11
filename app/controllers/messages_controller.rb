class MessagesController < ApplicationController
  def new
    @recipient = User.find params[:user_id]
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = User.find params[:user_id]
    if @message.save
      flash[:success] = 'Message sent!'
      redirect_to users_path
    else
      flash[:error] = "Error: #{@message.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :body)
  end
end
