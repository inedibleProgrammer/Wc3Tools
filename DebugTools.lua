function map.DebugTools_Create(wc3api, logging, players, commands, utility, colors)
  local debugTools = {}

  local authenticatedUsers = {}
  local debugLog = {}
  debugLog.type = logging.types.DEBUG
  debugLog.message = ""

  local versionCommand = {}
  versionCommand.activator = "-version"
  versionCommand.users = players.ALL_PLAYERS
  function versionCommand.Handler()
    local commandingPlayer = wc3api.GetTriggerPlayer()
    local mapVer = "Map Version: " .. map.version
    local mapCommit = "Map Commit: " .. map.commit

    wc3api.DisplayTextToPlayer(commandingPlayer, 0, 0, mapVer)
    wc3api.DisplayTextToPlayer(commandingPlayer, 0, 0, mapCommit)
  end

  local function GetResourceData()
    local data = {}

    local cmdString = wc3api.GetEventPlayerChatString()
    local splitString = utility.Split(cmdString)

    data.commandingPlayer = players.GetPlayerByName(wc3api.GetPlayerName(wc3api.GetTriggerPlayer()))

    data.amount = tonumber(table.remove(splitString))
    if(data.amount < 0) then
      data = nil
    end

    local playerID = tonumber(table.remove(splitString))
    if(playerID < 0 or playerID > wc3api.GetBJMaxPlayers()) then
      data = nil
    end

    if(data ~= nil) then
      data.receivingPlayer = players.GetPlayerByID(playerID)
    end

    return data
  end

  -- Usage: "-gold 0 10000"
  local setGoldCommand = {}
  setGoldCommand.activator = "-gold"
  setGoldCommand.users = players.AUTHENTICATED_PLAYERS
  function setGoldCommand.Handler()
    local data = GetResourceData()

    if(data ~= nil) then
      wc3api.SetPlayerState(data.receivingPlayer.ref, wc3api.constants.PLAYER_STATE_RESOURCE_GOLD, data.amount)
      debugLog.message = data.commandingPlayer.coloredname .. " set player " .. data.receivingPlayer.coloredname .. " gold to amount " .. data.amount
      logging.Write(debugLog)
    end
  end

  -- Usage: "-wood 0 10000"
  local setWoodCommand = {}
  setWoodCommand.activator = "-wood"
  setWoodCommand.users = players.AUTHENTICATED_PLAYERS
  function setWoodCommand.Handler()
    local data = GetResourceData()

    if(data ~= nil) then
      wc3api.SetPlayerState(data.receivingPlayer.ref, wc3api.constants.PLAYER_STATE_RESOURCE_LUMBER, data.amount)
      debugLog.message = data.commandingPlayer.coloredname .. " set player " .. data.receivingPlayer.coloredname .. " wood to amount " .. data.amount
      logging.Write(debugLog)
    end
  end


  commands.Add(versionCommand)
  commands.Add(setGoldCommand)
  commands.Add(setWoodCommand)

  return debugTools
end
