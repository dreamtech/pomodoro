expect = require("chai").expect
Timer = require "../src/Timer"

describe "Timer", ->
  @timeout 10000
  timer = {}

  before ->
    timer = new Timer()

  afterEach ->
    clearInterval timer.timerHandler

  it "Should start and finish", (done)->
    timer.start(3)
    ticks = 0
    timer.on "tick",  ->
      ticks++
    expect(timer.isRunning()).to.be.true
    timer.on "finish",  ->
      expect(timer.isRunning()).to.be.false
      expect(ticks).to.equal 2
      done()

  it "Should not start twice", (done)->
    fn =->
      timer.start(3)

    expect(fn).not.to.throw(Error)
    expect(fn).to.throw(Error)
    timer.on "finish",  ->
      done()