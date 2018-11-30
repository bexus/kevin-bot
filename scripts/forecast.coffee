# Description:
#   hubot が4castやってくれる
#
# Commands:
#   hubot 4cast お願い
#
{CHANNEL} = require('./constant')
request = require('request')
CIRCLE_CI_API_URL = "https://circleci.com/api/v1.1/project/github/mks1412/ci-batch?circle-token=#{process.env.CIRCLE_CI_TOKEN}"

module.exports = (robot) ->
  robot.respond /4cast (お願い)|(頼んだ)|(頼む)|(おねがい)|(よろしく)$/i, (res) ->
    room = res.message.user.room
    unless room is CHANNEL.forecast
      return
    user_id = res.message.user.id
    data = {
      url: CIRCLE_CI_API_URL
      headers:
        'Content-Type': 'application/json'
      json: true
      form:
        build_parameters:
          SLACK_USER_ID: user_id
    }

    request.post data, (error, response, body) ->
      if !error && response.statusCode >= 200
        res.send "<@#{user_id}> 仕方ねえな 任せとけ！"
      else
        console.log error.message
        res.send "<@#{user_id}> わりぃ。今やる気ねえわ"

