class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages  = @chat_room.messages.includes(:user)
    @message   = Message.new
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      redirect_to @chat_room
    else
      render :new
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
