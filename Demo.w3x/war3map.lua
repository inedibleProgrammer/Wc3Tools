gg_trg_PeriodicPrint = nil
gg_trg_LaunchLua = nil
function InitGlobals()
end

map = {}
function map.Commands_Create(wc3api)
  local commands = {}

  function commands.Add(command)
    -- TODO: Log command added
    if (#command.users <= 0) then
      return
    end

    command.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(command.trigger, command.Handler)

    for _,user in pairs(command.users) do
      wc3api.TriggerRegisterPlayerChatEvent(command.trigger, user, command.activator, wc3api.NO_EXACT_MATCH)
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

  function wc3api.Player()
  end

  function wc3api.TriggerRegisterPlayerChatEvent() end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.AddNewCommand()
    local commands = map.Commands_Create(wc3api)

    local dummyCmd = {}
    dummyCmd.activator = "-dummy"
    dummyCmd.users = {wc3api.Player(0)}
    dummyCmd.dummyVar = 0
    function dummyCmd:Handler()
      cmdString = wc3api.GetPlayerChatString()
      self.dummyVar = 1
    end

    -- commands.Add(dummyCmd)
    -- assert(commands.length == 1)

    -- dummyCmd:Handler("-dummy param1 param2")
    -- assert(dummyCmd.dummyVar == 1)
  end
end


function map.TestFramework_Create()
  local testFramework = {}
  testFramework.Suites = {}

  function testFramework.TestRunner()
    for _, suite in pairs(testFramework.Suites) do
      for _, test in pairs(suite.Tests) do
        suite.Setup()
        test()
        suite.Teardown()
      end
    end
  end

  return testFramework
end

function map.Game_Initialize()
  local wc3api = map.RealWc3Api_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local players = map.Players_Create(wc3api, commands)
  local gameClock = map.GameClock_Create(wc3api, clock, commands, players)
  local logging = map.Logging_Create(wc3api, gameClock, commands, players)

  local function testLogging()
    -- local masterLich = players.GetPlayerByName("MasterLich#11192")
    local worldEdit = players.GetPlayerByName("WorldEdit")

    -- logging.SetPlayerOptionByID(masterLich.id, logging.types.ALL)
    logging.SetPlayerOptionByID(worldEdit.id, logging.types.ALL)

    local function DumDum()
      local function DumDum2()
        local dumLog = {}
        dumLog.message = "This is a dummy"
        dumLog.type = logging.types.DEBUG
        logging.Write(dumLog)
      end
      xpcall(DumDum2, print)
    end

    local dummyTrigger = wc3api.CreateTrigger()
    wc3api.TriggerRegisterTimerEvent(dummyTrigger, 1.00, true)
    wc3api.TriggerAddAction(dummyTrigger, DumDum)
  end

  testLogging()

  local function testPlayers()
    for _,player in pairs(players.list) do
      print(player.id)
    end
  end

  -- testPlayers()

end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

--luacheck: ignore

function map.RealWc3Api_Create()
  local realWc3Api = {}

  realWc3Api.constants = {}
  realWc3Api.constants.EXACT_MATCH = true
  realWc3Api.constants.NO_EXACT_MATCH = false

  realWc3Api.constants.bj_FORCE_ALL_PLAYERS = nil

  function realWc3Api.CreateTrigger()
    return CreateTrigger()
  end

  function realWc3Api.TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
    TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
  end

  function realWc3Api.Player(playerNum)
    return Player(playerNum)
  end

  function realWc3Api.TriggerAddAction(whichTrigger, actionFunc)
    return TriggerAddAction(whichTrigger, actionFunc)
  end

  function realWc3Api.TriggerRegisterTimerEvent(whichTrigger, timeout, periodic)
    return TriggerRegisterTimerEvent(whichTrigger, timeout, periodic)
  end

  function realWc3Api.DisplayTimedTextToPlayer(toPlayer, x, y, duration, message)
    DisplayTimedTextToPlayer(toPlayer, x, y, duration, message)
  end

  function realWc3Api.DisplayTextToPlayer(toPlayer, x, y, message)
    DisplayTextToPlayer(toPlayer, x, y, message)
  end

  function realWc3Api.GetPlayers()
    return GetPlayers()
  end

  function realWc3Api.GetBJMaxPlayers()
    return GetBJMaxPlayers()
  end

  function realWc3Api.GetPlayerId(whichPlayer)
    return GetPlayerId(whichPlayer)
  end

  function realWc3Api.GetPlayerName(whichPlayer)
    return GetPlayerName(whichPlayer)
  end

  function realWc3Api.GetPlayerRace(whichPlayer)
    return GetPlayerRace(whichPlayer)
  end

  function realWc3Api.GetPlayerTeam(whichPlayer)
    return GetPlayerTeam()
  end

  function realWc3Api.GetPlayerColor(whichPlayer)
    return GetPlayerColor(whichPlayer)
  end

  function realWc3Api.GetPlayerController(whichPlayer)
    return GetPlayerController(whichPlayer)
  end

  function realWc3Api.GetPlayerSlotState(whichPlayer)
    return GetPlayerSlotState(whichPlayer)
  end

  function realWc3Api.GetTriggerPlayer()
    return GetTriggerPlayer()
  end

  return realWc3Api
end
function map.Split(inputStr, sep)
  if sep == nil then
    sep = " "
  end
  local t = {}
  for str in string.gmatch(inputStr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function map.Utility_Tests(testFramework)
  testFramework.Suites.UtilitySuite = {}
  testFramework.Suites.UtilitySuite.Tests = {}
  local tsu = testFramework.Suites.UtilitySuite

  function tsu.Setup() end
  function tsu.Teardown() end

  function tsu.Tests.SplitTest()
    dummyString = "This is a test 113."
    splitString = map.Split(dummyString)

    assert(#splitString == 5)
    assert(table.remove(splitString) == "113.")
    assert(table.remove(splitString) == "test")
    assert(table.remove(splitString) == "a")
    assert(table.remove(splitString) == "is")
    assert(table.remove(splitString) == "This")
  end
end

function map.GameClock_Create(wc3api, clock, commands, players)
  local gameClock = {}
  gameClock.wc3api = wc3api
  gameClock.clock = clock
  gameClock.commands = commands
  gameClock.players = players
  -- print("GameClock_Create")

  function gameClock.ClockTick()
    -- print("ClockTick start")
    -- DisplayTextToForce(GetPlayersAll(), "ClockTick start")
    -- DisplayTextToForce(GetPlayersAll(), gameClock.clock.seconds)
    gameClock.clock.Tick()
    -- print("ClockTick end")
  end

  -- print("gameclock setup")
  gameClock.trigger = wc3api.CreateTrigger()
  wc3api.TriggerRegisterTimerEvent(gameClock.trigger, 1.00, true)
  wc3api.TriggerAddAction(gameClock.trigger, gameClock.ClockTick)
  -- print("gameclock finish")

  local displayTimeCommand = {}
  displayTimeCommand.activator = "-time"
  displayTimeCommand.users = players.ALL_PLAYERS
  function displayTimeCommand:Handler()
    wc3api.DisplayTextToPlayer(wc3api.GetTriggerPlayer(), 0, 0, gameClock.clock.GetTimeString())
  end
  commands.Add(displayTimeCommand)

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

  function wc3api.Player() return "dummy player ref" end
  function wc3api.TriggerRegisterTimerEvent() end
  function wc3api.TriggerAddAction() end
  function wc3api.GetBJMaxPlayers() return 1 end
  function wc3api.GetPlayerId() end
  function wc3api.GetPlayerName() end
  function wc3api.GetPlayerRace() end
  function wc3api.GetPlayerTeam() end
  function wc3api.GetPlayerColor() end
  function wc3api.GetPlayerController() end
  function wc3api.GetPlayerSlotState() end
  function wc3api.TriggerRegisterPlayerChatEvent() end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.CreateClock()
    local clock = map.Clock_Create()
    local commands = map.Commands_Create(wc3api)
    local players = map.Players_Create(wc3api, commands)
    local gameClock = map.GameClock_Create(wc3api, clock, commands, players)

    assert(true)
  end

end
function map.Clock_Create()
  local clock = {}
  clock.seconds = 0

  function clock.Tick()
    clock.seconds = clock.seconds + 1
  end

  function clock.TimeElapsed()
    local timeElapsed = {}
    timeElapsed.hours = 0
    timeElapsed.minutes = 0
    timeElapsed.seconds = 0
    local tempSeconds = clock.seconds

    while tempSeconds >= 3600 do
      tempSeconds = tempSeconds - 3600
      timeElapsed.hours = timeElapsed.hours + 1
    end

    while tempSeconds >= 60 do
      tempSeconds = tempSeconds - 60
      timeElapsed.minutes = timeElapsed.minutes + 1
    end

    timeElapsed.seconds = tempSeconds

    return timeElapsed
  end

  function clock.GetTimeString()
    local timeString = ""
    local timeElapsed = clock.TimeElapsed()

    timeString = tostring(timeElapsed.hours) .. ":" .. tostring(timeElapsed.minutes) .. ":" .. tostring(timeElapsed.seconds)
    -- timeString = string.format("10:07:05", timeElapsed.hours, timeElapsed.minutes, timeElapsed.seconds) -- This doesn't work in wc3 for some reason

    return timeString
  end

  return clock
end

function map.Clock_Tests(testFramework)
  testFramework.Suites.ClockSuite = {}
  testFramework.Suites.ClockSuite.Tests = {}
  local tsc = testFramework.Suites.ClockSuite
  local wc3api = {}
  wc3api.constants = map.RealWc3Api_Create().constants

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.HoursMinutesSeconds()
    local clock = map.Clock_Create()
    clock.seconds = 8192
    assert(clock.TimeElapsed().hours == 2, "hours wrong")
    assert(clock.TimeElapsed().minutes == 16, "minutes wrong")
    assert(clock.TimeElapsed().seconds == 32, "seconds wrong")
  end

  function tsc.Tests.HoursMinutesSeconds2()
    local clock = map.Clock_Create()
    clock.seconds = 3600
    assert(clock.TimeElapsed().hours == 1, "hours wrong")
    assert(clock.TimeElapsed().minutes == 0, "minutes wrong")
    assert(clock.TimeElapsed().seconds == 0, "seconds wrong")
  end

  function tsc.Tests.GetTimeAsString()
    local clock = map.Clock_Create()
    clock.seconds = 8192
    assert(clock.GetTimeString() == "2:16:32")
    clock.seconds = 3600
    assert(clock.GetTimeString() == "1:0:0")
  end
end


function map.Players_Create(wc3api, commands)
  local players = {}
  players.wc3api = wc3api
  players.commands = commands
  players.list = {}
  players.ALL_PLAYERS = {}

  for i=0, wc3api.GetBJMaxPlayers() do
    local player = {}
    player.ref = wc3api.Player(i)
    player.id = wc3api.GetPlayerId(player.ref)
    player.name = wc3api.GetPlayerName(player.ref)
    player.race = wc3api.GetPlayerRace(player.ref)
    player.team = wc3api.GetPlayerTeam(player.ref)
    player.playercolor = wc3api.GetPlayerColor(player.ref)
    player.mapcontrol = wc3api.GetPlayerController(player.ref)
    player.playerslotstate = wc3api.GetPlayerSlotState(player.ref)

    table.insert(players.ALL_PLAYERS, player.ref)

    table.insert(players.list, player)
  end

  local displayPlayerCmd = {}

  function players.GetPlayerByName(name)
    for _,player in pairs(players.list) do
      if player.name == name then
        return player
      end
    end
    return nil
  end

  function players.GetPlayerByID(id)
    for _,player in pairs(players.list) do
      if player.id == id then
        return player
      end
    end
    return nil
  end

  return players
end



function map.Players_Tests(testFramework)
  testFramework.Suites.PlayersSuite = {}
  testFramework.Suites.PlayersSuite.Tests = {}
  local tsc = testFramework.Suites.PlayersSuite
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

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

end



function map.Logging_Create(wc3api, gameClock, commands, players)
  local logging = {}
  logging.wc3api = wc3api
  logging.gameClock = gameClock
  logging.commands = commands
  logging.players = players

  logging.messages = {}
  logging.count = 0
  logging.types = {TRACE = "000001", DEBUG = "000010", INFO = "000100", WARN = "001000", ERROR = "010000", FATAL = "100000", ALL = "111111", NONE = "000000"}
  logging.playerOptions = {}

  for _,player in pairs(players.list) do
    playerLogOptions = {}
    playerLogOptions.id = player.id
    playerLogOptions.visibility = logging.types.NONE

    table.insert(logging.playerOptions, playerLogOptions)
  end

  function logging.Write(logMessage)
    -- print("logging.Write")
    -- print("1")
    local logString = tostring(logging.count) .. "#" .. logging.gameClock.clock.GetTimeString() .. "#" .. logMessage.type .. "#" .. logMessage.message
    -- print("2")

    for _,player in pairs(players.list) do
      -- print("3")
      for _,playerLogOptions in pairs(logging.playerOptions) do
        -- print("4")
        if(playerLogOptions.id == player.id) then
          -- print("5")
          local playerVisibilityOptionBinary = tonumber(playerLogOptions.visibility, 2)
          local logMessageTypeBinary = tonumber(logMessage.type, 2)
          -- print("6")
          -- print(playerVisibilityOptionBinary)
          -- print(logMessageTypeBinary)
          -- print(playerVisibilityOptionBinary & logMessageTypeBinary)
          if (playerVisibilityOptionBinary & logMessageTypeBinary) > 0 then
            -- print("7")
            wc3api.DisplayTextToPlayer(player.ref, 0, 0, logString)
          end
        end
      end
    end

    table.insert(logging.messages, logMessage)
    logging.count = logging.count + 1
  end


  function logging.SetPlayerOptionByID(id, option)
    for _,playerLogOptions in pairs(logging.playerOptions) do
      if playerLogOptions.id == id then
        for _,visibilityOption in pairs(logging.types) do
          if(option == visibilityOption) then
            playerLogOptions.visibility = option
          end
        end
      end
    end
  end

  return logging
end


function map.Logging_Tests(testFramework)
  testFramework.Suites.LoggingSuite = {}
  testFramework.Suites.LoggingSuite.Tests = {}
  local tsc = testFramework.Suites.LoggingSuite
  local wc3api = {}
  wc3api.constants = map.RealWc3Api_Create().constants

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.DisplayMessagesForSpecificPlayers()
    local gameClock = {}
    gameClock.clock = {}
    local commands = {}
    local players = {}
    players.list = {}
    local player1 = {}
    player1.id = 0
    local player2 = {}
    player2.id = 1
    table.insert(players.list, player1)
    table.insert(players.list, player2)
    local logging = map.Logging_Create(wc3api, gameClock, commands, players)

    function gameClock.clock.GetTimeString() return "0:0:0" end

    local testCalled = 0
    function wc3api.DisplayTextToPlayer(p1, p2, p3, p4)
      testCalled = testCalled + 1
    end


    logging.SetPlayerOptionByID(1,logging.types.DEBUG)

    local logMessage = {}
    logMessage.message = "This is a dummy"
    logMessage.type = logging.types.DEBUG
    logging.Write(logMessage)

    assert(logging.count == 1)
    assert(testCalled == 1)
  end

end
function map.UnitTests()
  local testFramework = map.TestFramework_Create()
  map.Commands_Tests(testFramework)
  map.Utility_Tests(testFramework)
  map.Clock_Tests(testFramework)
  map.GameClock_Tests(testFramework)
  map.Players_Tests(testFramework)
  map.Logging_Tests(testFramework)
  xpcall(testFramework.TestRunner, print)
end

function map.LaunchLua()
  print("Map Start")
  -- map.UnitTests()
  map.Game_Start()
  print("Map End")
end

map.UnitTests()



function Trig_LaunchLua_Actions()
    map.LaunchLua()
end

function InitTrig_LaunchLua()
gg_trg_LaunchLua = CreateTrigger()
TriggerAddAction(gg_trg_LaunchLua, Trig_LaunchLua_Actions)
end

function InitCustomTriggers()
InitTrig_LaunchLua()
end

function RunInitializationTriggers()
ConditionalTriggerExecute(gg_trg_LaunchLua)
end

function InitCustomPlayerSlots()
SetPlayerStartLocation(Player(0), 0)
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
end

function main()
SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("CityScapeDay")
SetAmbientNightSound("CityScapeNight")
SetMapMusic("Music", true, 0)
InitBlizzard()
InitGlobals()
InitCustomTriggers()
RunInitializationTriggers()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(1)
SetTeams(1)
SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
DefineStartLocation(0, 2816.0, 1792.0)
InitCustomPlayerSlots()
SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
InitGenericPlayerSlots()
end

