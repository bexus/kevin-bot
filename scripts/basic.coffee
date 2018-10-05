# Description:
#   hubot を面白くする
#
# Commands:
#   hubot say #channnel メッセージ
#

module.exports = (robot) ->
  robot.hear /ちょっと何言ってるかわかんない/, (res) ->
    room = res.message.user.room
    robot.send {room: room}, 'ちょっと何言ってるかわかんない'

  robot.respond /say (.*) (.*)/i, (res) ->
    channel = res.match[1]
    msg = res.match[2]
    robot.send {room: channel}, msg

  enterReplies = ['お前も底辺か。クソうけるんだがwww']
  leaveReplies = ['じゃあな！', 'ぶっちゃけこいついない方がよかったよなwww']
  robot.enter (res) ->
    res.send res.random enterReplies
  robot.leave (res) ->
    res.send res.random leaveReplies

