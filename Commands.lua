function map.Commands_Create(wc3api)
  local commands = {}

  commands.length = 0
  commands.list = {}

  function commands.Add(command)
    command.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(command.trigger, command.Handler)

    for _,v in pairs(command.users) do
      wc3api.TriggerRegisterPlayerChatEvent(command.trigger, v, command.activator, wc3api.NO_EXACT_MATCH)
    end
  end

  return commands
end



function map.Commands_Tests(testFramework)
  testFramework.Suites.CommandsSuite = {}
  testFramework.Suites.CommandsSuite.Tests = {}
  local tsc = testFramework.Suites.CommandsSuite
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

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.AddNewCommand()
    local commands = map.Commands_Create(wc3api)

    local dummyCmd = {}
    dummyCmd.activator = "-dummy"
    dummyCmd.users = {}
    dummyCmd.dummyVar = 0
    function dummyCmd:Handler()
      self.dummyVar = 1
    end

    assert(commands.length == 0)
    commands.Add(dummyCmd)
    assert(commands.length == 1)

    dummyCmd:Handler("-dummy param1 param2")
    assert(dummyCmd.dummyVar == 1)
  end
end


