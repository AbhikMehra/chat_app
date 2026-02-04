import consumer from "./consumer"

const chatRoomId = window.chatRoomId

consumer.subscriptions.create(
  { channel: "ChatRoomChannel", id: chatRoomId },
  {
    connected() {
      console.log("✅ WebSocket connected")
    },

    disconnected() {
      console.log("❌ WebSocket disconnected")
    },

    received(data) {
      if (data.type === "typing") {
        document.getElementById("typing").innerText =
          `${data.user} is typing...`

        setTimeout(() => {
          document.getElementById("typing").innerText = ""
        }, 1500)
      } else {
        document.getElementById("messages")
          .insertAdjacentHTML("beforeend", data)
      }
    },

    typing() {
      this.perform("typing")
    }
  }
)
