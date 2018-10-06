# Description:
#   database notify
#
# Author:
#   mukasa

cronJob = require('cron').CronJob
exec = require('child_process').exec
moment = require("moment")
{CHANNEL} = require('./constant')


module.exports = (robot) ->
  cronjob = new cronJob(
    cronTime: "0 0 9 * * 0"
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      robot.send {room: CHANNEL.database}, "@channel レビューシート締切日だけど、まだ出してないやつなんておる？ちな期限外提出は100点★減点★らしいぞ"
  )

  cronjob = new cronJob(
    cronTime: "0 40 10 * * 1" #月曜2限
    start: true
    timeZone: "Asia/Tokyo"
    onTick: ->
      today = moment().format("YYYYMMDD")
      filename = "images/db_#{today}.png"
      channel = CHANNEL.database
      exec "curl -F file=@#{filename} -F channels=#{channel} -F token=#{process.env.HUBOT_SLACK_TOKEN} https://slack.com/api/files.upload", (err, stdout, stderr) ->
        if err
          console.log err
        else
          robot.send {room: CHANNEL.database}, "@channel 今日はコレな"
  )

  robot.respond /db-question (.*)/i, (res) ->
    day = res.match[1]
    filename = "images/db_#{day}.png"
    channel = CHANNEL.bot
    exec "curl -F file=@#{filename} -F channels=#{channel} -F token=#{process.env.HUBOT_SLACK_TOKEN} https://slack.com/api/files.upload", (err, stdout, stderr) ->
        if err
          console.log err
        else
          robot.send {room: CHANNEL.bot}, "今日はコレな"
