--luacheck: ignore

function map.RealWc3Api_Create()
  local realWc3Api = {}

  realWc3Api.constants = {}
  realWc3Api.constants.EXACT_MATCH = true
  realWc3Api.constants.NO_EXACT_MATCH = false

  realWc3Api.constants.bj_FORCE_ALL_PLAYERS = nil
  realWc3Api.constants.EVENT_PLAYER_LEAVE = EVENT_PLAYER_LEAVE

  function realWc3Api.BJDebugMsg(msg)
    return BJDebugMsg(msg)
  end

  function realWc3Api.CreateTrigger()
    return CreateTrigger()
  end

  function realWc3Api.Condition(func)
    return Condition(func)
  end

  function realWc3Api.DestroyCondition(c)
    return DestroyCondition(c)
  end

  function realWc3Api.Filter(func)
    return Filter(func)
  end

  function realWc3Api.DestroyFilter(f)
    return DestroyFilter(f)
  end

  function realWc3Api.DestroyBoolExpr(e)
    return DestroyBoolExpr(e)
  end

  function realWc3Api.TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
    return TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
  end

  function realWc3Api.TriggerRegisterPlayerEvent(whichTrigger, whichPlayer, whichPlayerEvent)
    return TriggerRegisterPlayerEvent(whichTrigger, whichPlayer, whichPlayerEvent)
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
    return DisplayTimedTextToPlayer(toPlayer, x, y, duration, message)
  end

  function realWc3Api.DisplayTextToPlayer(toPlayer, x, y, message)
    return DisplayTextToPlayer(toPlayer, x, y, message)
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

  function realWc3Api.CreateGroup()
    return CreateGroup()
  end

  function realWc3Api.DestroyGroup(whichGroup)
    return DestroyGroup(whichGroup)
  end

  function realWc3Api.GroupAddUnit(whichGroup, whichUnit)
    return GroupAddUnit(whichGroup, whichUnit)
  end

  function realWc3Api.GroupRemoveUnit(whichGroup, whichUnit)
    return GroupRemoveUnit(whichGroup, whichUnit)
  end

  function realWc3Api.GroupClear(whichGroup)
    return GroupClear(WhichGroup)
  end

  function realWc3Api.ForGroup(whichGroup, callback)
    return ForGroup(whichGroup, callback)
  end

  function realWc3Api.GetEnumUnit()
    return GetEnumUnit()
  end

  function realWc3Api.GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter)
    return GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter)
  end

  function realWc3Api.GroupEnumUnitsInRect(whichGroup, r, filter)
    return GroupEnumUnitsInRect(whichGroup, r, filter)
  end

  function realWc3Api.GroupEnumUnitsInRange(whichGroup, x, y, radius, filter)
    return GroupEnumUnitsInRange(whichGroup, x, y, radius, filter)
  end

  function realWc3Api.GroupImmediateOrder(whichGroup, order)
    return GroupImmediateOrder(whichGroup, order)
  end

  function realWc3Api.GroupImmediateOrderById(whichGroup, order)
    return GroupImmediateOrderById(whichGroup, order)
  end

  function realWc3Api.GroupPointOrder(whichGroup, order, x, y)
    return GroupPointOrder(whichGroup, order, x, y)
  end

  function realWc3Api.GroupTargetOrderById(whichGroup, order, targetWidget)
    return GroupTargetOrderById(whichGroup, order, targetWidget)
  end

  function realWc3Api.GroupTargetOrder(whichGroup, order, targetWidget)
    return GroupTargetOrder(whichGroup, order, targetWidget)
  end

  function realWc3Api.Rect(minx, miny, maxx, maxy)
    return Rect(minx, miny, maxx, maxy)
  end

  function realWc3Api.RemoveRect(whichRect)
    return RemoveRect(whichRect)
  end

  function realWc3Api.SetRect(whichRect, minx, miny, maxx, maxy)
    return SetRect(whichRect, minx, miny, maxx, maxy)
  end

  function realWc3Api.GetRectCenterX(whichRect)
    return GetRectCenterX(whichRect)
  end

  function realWc3Api.GetRectCenterY(whichRect)
    return GetRectCenterY(whichRect)
  end

  function realWc3Api.GetRectMinX(whichRect)
    return GetRectMinX(whichRect)
  end

  function realWc3Api.GetRectMinY(whichRect)
    return GetRectMinY(whichRect)
  end

  function realWc3Api.GetRectMaxX(whichRect)
    return GetRectMaxX(whichRect)
  end

  function realWc3Api.GetRectMaxY(whichRect)
    return GetRectMaxY(whichRect)
  end

  function realWc3Api.CreateRegion()
    return CreateRegion()
  end

  function realWc3Api.RemoveRegion(whichRegion)
    return RemoveRegion(whichRegion)
  end

  function realWc3Api.RegionAddRect(whichRegion, r)
    return RegionAddRect(whichRegion, r)
  end

  function realWc3Api.GetWorldBounds()
    return GetWorldBounds()
  end

  return realWc3Api
end
