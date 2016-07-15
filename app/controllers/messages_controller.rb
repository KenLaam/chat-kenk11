class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = 'Message sent!'
    else
      flash[:error] = "Error: #{@message.errors.full_messages.to_sentence}"
    end
  end

  private
  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :body)
  end
end
