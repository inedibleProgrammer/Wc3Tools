function map.Players_Create(wc3api, commands, colors, authenticatedNames, utility)
  local players = {}

  players.list = {}
  players.ALL_PLAYERS = {}
  players.AUTHENTICATED_PLAYERS = {}

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

  local function PlayerLeavingAction()
    local p = wc3api.GetTriggerPlayer()
    local pname = wc3api.GetPlayerName(p)
    local player = players.GetPlayerByName(pname)

    -- print(gp.coloredName .. " has left the game")
    -- local coloredPName = colors.GetColoredString(pname, colors.GetColor_N(player.id + 1).text)
    wc3api.BJDebugMsg(player.coloredname .. " has left the game.")
  end

  players.playerLeavingTrigger = wc3api.CreateTrigger()
  wc3api.TriggerAddAction(players.playerLeavingTrigger, PlayerLeavingAction)
  for i=0, wc3api.GetBJMaxPlayers() do
    local player = {}
    player.ref = wc3api.Player(i)
    player.id = wc3api.GetPlayerId(player.ref)
    player.name = wc3api.GetPlayerName(player.ref)
    player.coloredname = colors.GetColoredString(player.name, colors.GetColor_N(player.id + 1).text)
    player.race = wc3api.GetPlayerRace(player.ref)
    player.team = wc3api.GetPlayerTeam(player.ref)
    player.playercolor = wc3api.GetPlayerColor(player.ref)
    player.mapcontrol = wc3api.GetPlayerController(player.ref)
    player.playerslotstate = wc3api.GetPlayerSlotState(player.ref)

    table.insert(players.ALL_PLAYERS, player.ref)

    wc3api.TriggerRegisterPlayerEvent(players.playerLeavingTrigger, player.ref, wc3api.constants.EVENT_PLAYER_LEAVE)

    table.insert(players.list, player)
  end

  local function TryAddPlayerName(playerName, toList)
    local player = players.GetPlayerByName(playerName)
    if(player ~= nil) then
      table.insert(toList, player.ref)
    end
  end

  for _,name in pairs(authenticatedNames) do
    TryAddPlayerName(name, players.AUTHENTICATED_PLAYERS)
  end

  local showPlayersCommand = {}
  showPlayersCommand.activator = "-players"
  showPlayersCommand.users = players.ALL_PLAYERS
  function showPlayersCommand.Handler()
    local commandingPlayer = wc3api.GetTriggerPlayer()
    local cmdString = wc3api.GetEventPlayerChatString()
    local splitString = utility.Split(cmdString)

    local pageParam = table.remove(splitString)
    if(pageParam == "1") then
      for i=0, 13 do
        local player = players.GetPlayerByID(i)
        if(player ~= nil) then
          local playerInfo = "(" .. player.id + 1 .. ")" .. " " .. player.coloredname ..  " " .. colors.GetColor_N(player.id + 1).text
          wc3api.DisplayTextToPlayer(commandingPlayer, 0, 0, playerInfo)
        end
      end
    elseif(pageParam == "2") then
      for i=14, 23 do
        local player = players.GetPlayerByID(i)
        if(player ~= nil) then
          local playerInfo = "(" .. player.id + 1 .. ")" .. " " .. player.coloredname ..  " " .. colors.GetColor_N(player.id + 1).text
          wc3api.DisplayTextToPlayer(commandingPlayer, 0, 0, playerInfo)
        end
      end
    end
  end
  commands.Add(showPlayersCommand)


  local allyPlayerCommand = {}
  allyPlayerCommand.activator = "-ally"
  allyPlayerCommand.users = players.ALL_PLAYERS
  function allyPlayerCommand.Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local commandingPlayer = wc3api.GetTriggerPlayer()

    local splitString = utility.Split(cmdString)
    local playerColorNumber = table.remove(splitString)
    local otherPlayer = players.GetPlayerByID(tonumber(playerColorNumber) - 1)

    if(otherPlayer ~= nil) then
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_PASSIVE, true)
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_SHARED_SPELLS, true)
    end
  end
  commands.Add(allyPlayerCommand)

  local unallyPlayerCommand = {}
  unallyPlayerCommand.activator = "-unally"
  unallyPlayerCommand.users = players.ALL_PLAYERS
  function unallyPlayerCommand.Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local commandingPlayer = wc3api.GetTriggerPlayer()

    local splitString = utility.Split(cmdString)
    local playerColorNumber = table.remove(splitString)
    local otherPlayer = players.GetPlayerByID(tonumber(playerColorNumber) - 1)

    if(otherPlayer ~= nil) then
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_PASSIVE, false)
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_SHARED_SPELLS, false)
    end
  end
  commands.Add(unallyPlayerCommand)

  local visionPlayerCommand = {}
  visionPlayerCommand.activator = "-vision"
  visionPlayerCommand.users = players.ALL_PLAYERS
  function visionPlayerCommand.Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local commandingPlayer = wc3api.GetTriggerPlayer()

    local splitString = utility.Split(cmdString)
    local playerColorNumber = table.remove(splitString)
    local otherPlayer = players.GetPlayerByID(tonumber(playerColorNumber) - 1)

    if(otherPlayer ~= nil) then
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_SHARED_VISION, true)
    end
  end
  commands.Add(visionPlayerCommand)

  local unvisionPlayerCommand = {}
  unvisionPlayerCommand.activator = "-unvision"
  unvisionPlayerCommand.users = players.ALL_PLAYERS
  function unvisionPlayerCommand.Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local commandingPlayer = wc3api.GetTriggerPlayer()

    local splitString = utility.Split(cmdString)
    local playerColorNumber = table.remove(splitString)
    local otherPlayer = players.GetPlayerByID(tonumber(playerColorNumber) - 1)

    if(otherPlayer ~= nil) then
      wc3api.SetPlayerAlliance(commandingPlayer, otherPlayer.ref,
                               wc3api.constants.ALLIANCE_SHARED_VISION, false)
    end
  end
  commands.Add(unvisionPlayerCommand)

  local cameraCommand = {}
  cameraCommand.activator = "-camera"
  cameraCommand.users = players.ALL_PLAYERS
  function cameraCommand.Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local commandingPlayer = wc3api.GetTriggerPlayer()

    local splitString = utility.Split(cmdString)
    local distance = tonumber(table.remove(splitString))
    wc3api.SetCameraFieldForPlayer(commandingPlayer,
                                   wc3api.constants.CAMERA_FIELD_TARGET_DISTANCE,
                                   distance, 1.00)
  end
  commands.Add(cameraCommand)



  return players
end



function map.Players_Tests(testFramework)
  testFramework.Suites.PlayersSuite = {}
  testFramework.Suites.PlayersSuite.Tests = {}
  local tsc = testFramework.Suites.PlayersSuite
  local wc3api = {}
  local commands = {}
  local colors = {}
  local utility = {}
  local authenticatedNames = { "authenticatedName1", "authenticatedName2" }
  wc3api.constants = map.RealWc3Api_Create().constants

  --luacheck: push ignore
  function wc3api.CreateTrigger() return {} end
  function wc3api.TriggerAddAction(trigger, handler)
    assert(type(trigger) ~= "nil")
    assert(type(handler) == "function")
  end
  function wc3api.GetTriggerPlayer() return "GetTriggerPlayer" end
  function wc3api.GetEventPlayerChatString() return "" end
  function wc3api.TriggerRegisterPlayerEvent() return "" end
  function wc3api.Player() return {dummy = "dummy"} end
  function wc3api.GetBJMaxPlayers() return 26 end
  function wc3api.GetPlayerId(player) return 0 end
  function wc3api.GetPlayerName(player) return "name" end
  function colors.GetColor_N(p1) return {text = "text"} end
  function colors.GetColoredString(p1, p2) return "coloredstring" end
  function wc3api.GetPlayerRace(player) return "race" end
  function wc3api.GetPlayerTeam(player) return "team" end
  function wc3api.GetPlayerColor(player) return "color" end
  function wc3api.GetPlayerController(player) return "controller" end
  function wc3api.GetPlayerSlotState(player) return "slotstate" end
  function wc3api.SetPlayerAlliance() end
  function utility.Split() return {"1"} end

  local storedCommands = {}
  function commands.Add(command)
    table.insert(storedCommands, command)
  end
  --luacheck: pop

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.AddAuthenticatedPlayers()
    local firstTime = true
    function wc3api.GetPlayerName(player)
      if firstTime then
        firstTime = false
        return "authenticatedName1"
      end
      return "noname"
    end
    local players = map.Players_Create(wc3api, commands, colors, authenticatedNames, utility)

    assert(#players.AUTHENTICATED_PLAYERS > 0, "AUTHENTICATED_PLAYERS EMPTY")
    assert(#players.AUTHENTICATED_PLAYERS == 1)
  end

  function tsc.Tests.ShowPlayers()
    local players = map.Players_Create(wc3api, commands, colors, authenticatedNames, utility)
    local fnCalled = false

    function wc3api.DisplayTextToPlayer(p1, p2, p3, p4)
      fnCalled = true
    end

    for _,command in pairs(storedCommands) do
      if(command.activator == "-players") then
        command.Handler()
        assert(fnCalled == true)
      end
    end
  end

  function tsc.Tests.AllyPlayer()
    local players = map.Players_Create(wc3api, commands, colors, authenticatedNames, utility)

    for _,command in pairs(storedCommands) do
      if(command.activator == "-ally") then
        command.Handler()
      end
    end

  end

end



