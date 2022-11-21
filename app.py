from flask import Flask, request, abort
from linebot import (
 LineBotApi, WebhookHandler
)
from linebot.exceptions import (
 InvalidSignatureError
)
from linebot.models import (
 MessageEvent, TextMessage, TextSendMessage
)

app = Flask(__name__)

ACCESS_TOKEN = "1657669164"
SECRET = "6373d78a3d704292f81c3feb2a805b20"

line_bot_api = LineBotApi(ACCESS_TOKEN)
handler = WebhookHandler(SECRET)

@app.route("https://git.heroku.com/sosuu-hantei-bot.git/callback", methods=['POST'])
def callback():
    signature = request.headers['X-Line-Signature']  
    body = request.get_data(as_text=True)
    app.logger.info("Request body: " + body)

    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        abort(400)

    return 'OK'

@handler.add(MessageEvent, message=TextMessage)#ここでイベントに対する応答をする
def handle_message(event):
 line_bot_api.reply_message(
  event.reply_token,
  TextSendMessage(text=event.message.text))

if __name__ == "__main__":
 app.run()

