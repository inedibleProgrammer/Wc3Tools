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

  function realWc3Api.TriggerRegisterEnterRectSimple(trig, r)
    return TriggerRegisterEnterRectSimple(trig, r)
  end

  function realWc3Api.GetTriggerUnit()
    return GetTriggerUnit()
  end

  function realWc3Api.GetUnitName()
    return GetUnitName()
  end

  function realWc3Api.GetHeroProperName(whichHero)
    return GetHeroProperName(whichHero)
  end

  function realWc3Api.IsHeroUnitId(unitId)
    return IsHeroUnitId(unitId)
  end

  function realWc3Api.GetObjectName(objectId)
    return GetObjectName(objectId)
  end

  function realWc3Api.GetUnitTypeId(whichUnit)
    return GetUnitTypeId(whichUnit)
  end

  return realWc3Api
end
