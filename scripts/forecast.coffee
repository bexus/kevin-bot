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
  robot.hear /((ケビン)|(けびん))(様)?\s?4cast\s?((お願いします)|((お願い)|(おねがい)|(頼む)|(たのむ)|(頼んだ)|(やっといて)|(やって)))/i, (res) ->
    user_id = res.message.user.id
    room = res.message.user.room

    console.log res.match

    if !res.match[4] or !res.match[6]
      res.send "<@#{user_id}> それが人にものを頼む態度か？"
      return

    unless room is CHANNEL.forecast
      res.send "#4cast でやってくれ"
      return

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
      if !error and response.statusCode >= 200
        res.send "<@#{user_id}> 仕方ねえな 任せとけ！"
      else
        console.log error.message
        res.send "<@#{user_id}> わりぃ。今やる気ねえわ"

