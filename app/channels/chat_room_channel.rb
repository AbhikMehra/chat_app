class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    @chat_room = ChatRoom.find(params[:id])
    stream_for @chat_room
  end

  def typing(data)
    ChatRoomChannel.broadcast_to(
      @chat_room,
      {
        type: "typing",
        user: current_user.email
      }
    )
  end
end
