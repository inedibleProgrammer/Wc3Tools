function map.Players_Create(wc3api, commands, colors, authenticatedNames)
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



  return players
end



function map.Players_Tests(testFramework)
  testFramework.Suites.PlayersSuite = {}
  testFramework.Suites.PlayersSuite.Tests = {}
  local tsc = testFramework.Suites.PlayersSuite
  local wc3api = {}
  local commands = {}
  local colors = {}
  local authenticatedNames = { "authenticatedName1", "authenticatedName2" }

  wc3api.constants = map.RealWc3Api_Create().constants

  function wc3api.CreateTrigger() return {} end

  function wc3api.TriggerAddAction(trigger, handler)
    assert(type(trigger) ~= "nil")
    assert(type(handler) == "function")
  end

  function wc3api.GetEventPlayerChatString() return "" end
  function wc3api.TriggerRegisterPlayerEvent() return "" end
  function wc3api.Player() return {dummy = "dummy"} end
  function wc3api.GetBJMaxPlayers() return 26 end
  function wc3api.GetPlayerId(player) return 0 end
  function wc3api.GetPlayerName(player) return "name" end
  function colors.GetColor_N(p1) return {} end
  function colors.GetColoredString(p1) return "coloredstring" end
  function wc3api.GetPlayerRace(player) return "race" end
  function wc3api.GetPlayerTeam(player) return "team" end
  function wc3api.GetPlayerColor(player) return "color" end
  function wc3api.GetPlayerController(player) return "controller" end
  function wc3api.GetPlayerSlotState(player) return "slotstate" end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.AddAuthenticatedPlayers()
    -- function map.Players_Create(wc3api, commands, colors, authenticatedNames)
    local firstTime = true
    function wc3api.GetPlayerName(player)
      if firstTime then
        firstTime = false
        return "authenticatedName1"
      end
      return "noname"
    end
    local players = map.Players_Create(wc3api, commands, colors, authenticatedNames)

    assert(#players.AUTHENTICATED_PLAYERS > 0, "AUTHENTICATED_PLAYERS EMPTY")
    assert(#players.AUTHENTICATED_PLAYERS == 1)
  end

end



