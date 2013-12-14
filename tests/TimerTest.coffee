expect = require("chai").expect
Timer = require "../src/Timer"

describe "Timer", ->
  @timeout 10000
  timer = new Timer()
  testTime = 2


  beforeEach ->
    timer = new Timer()

  afterEach ->
    clearInterval timer.timerHandler

  it "Should start and finish", (done)->
    timer.start(testTime)
    ticks = 0
    timer.on "tick",  ->
      ticks++
    expect(timer.isRunning()).to.be.true
    timer.on "finish",  ->
      expect(timer.isRunning()).to.be.false
      expect(ticks).to.equal testTime-1
      done()

  it "Should not start twice", (done)->
    fn =->
      timer.start(testTime-1)

    expect( fn ).not.to.throw(Error)
    expect(fn).to.throw(Error)

    timer.on "finish",  ->
      done()
