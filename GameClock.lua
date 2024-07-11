function map.GameClock_Create(wc3api, clock, commands)
  local gameClock = {}
  gameClock.wc3api = wc3api
  gameClock.clock = clock
  gameClock.commands = commands
  print("GameClock_Create")

  function gameClock.ClockTick()
    -- print("ClockTick start")
    DisplayTextToForce(GetPlayersAll(), "ClockTick start")
    gameClock.clock.Tick()
    print("ClockTick end")
  end

  print("gameclock setup")
  gameClock.trigger = wc3api.CreateTrigger()
  wc3api.TriggerRegisterTimerEvent(gameClock.trigger, 1.00, true)
  wc3api.TriggerAddAction(gameClock.trigger, gameClock.ClockTick)
  print("gameclock finish")

  return gameClock
end


function map.GameClock_Tests(testFramework)
  testFramework.Suites.GameClockSuite = {}
  testFramework.Suites.GameClockSuite.Tests = {}
  local tsc = testFramework.Suites.GameClockSuite
  local wc3api = {}
  wc3api.constants = map.RealWc3Api_Create().constants

  function wc3api.CreateTrigger()
    return {}
  end

  function wc3api.TriggerAddAction(trigger, handler)
    assert(type(trigger) ~= "nil")
    assert(type(handler) == "function")
  end

  function wc3api.GetEventPlayerChatString()
    return ""
  end

  function wc3api.Player()
  end

  function wc3api.TriggerRegisterTimerEvent()
  end

  function wc3api.TriggerAddAction()
  end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.CreateClock()
    local clock = map.Clock_Create()
    local commands = map.Commands_Create()
    local gameClock = map.GameClock_Create(wc3api, clock, commands)

    assert(true)
  end

end
