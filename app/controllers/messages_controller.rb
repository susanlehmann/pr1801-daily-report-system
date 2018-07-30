class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :find_conversation

  def index
    @messages = @conversation.messages
    @messages.where(read: false).where.not(user_id: current_user.id).update_all(read: true)
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def find_conversation
    @conversation = Conversation.find_by id: params[:conversation_id]
    if @conversation.nil?
      render file: "public/404.html", status: :not_found
    end
  end

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
