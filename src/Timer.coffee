expect = require("chai").expect
EventEmiter = require('events').EventEmitter

class Timer extends EventEmiter
  remainingTime: 0
  running = false
  timerHandler: 0

  constructor: (time)->
    console.log "Timer.constructor()", arguments
    @remainingTime = time
    @on "finish", ->
      running = false
    @on "start", ->
      running = true

  start: (time)->
    @remainingTime = time || @remainingTime
    console.log "Timer.start()", arguments
    throw new Error("The timer has already started") if running
    @emit "start"
    console.log "Tick #{@remainingTime}"
    @timerHandler = setInterval(
      =>
        @remainingTime--
        @emit "tick",@remainingTime
        console.log "Tick #{@remainingTime}"
      1000
    )

    setTimeout(
      =>
        clearInterval(@timerHandler)
        @emit "finish"
      time*1000
    )

  isRunning: ->
    running

module.exports = Timer
