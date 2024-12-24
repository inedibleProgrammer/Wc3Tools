function map.UnitManager_Create(wc3api, logging, commands)
  local unitManager = {}
  unitManager.wc3api = wc3api
  unitManager.logging = logging
  unitManager.commands = commands

  function unitManager.CountUnitsInRegion(region)
    local unitCount = 0
    local function CountUnits()
      local u = wc3api.GetTriggerUnit() -- Why does this work? Do I need to replace with GetEnumUnit?
      unitCount = unitCount + 1
    end
    local g = wc3api.CreateGroup()
    wc3api.GroupEnumUnitsInRect(g, region, wc3api.constants.NO_FILTER)
    wc3api.ForGroup(g, CountUnits)
    wc3api.DestroyGroup(g)
    g = nil
    return unitCount
  end

  function unitManager.CountUnitsPerPlayerInRegion(region)
    local playerUnits = {}

    local function CountUnitsOfPlayer()
      local unit = wc3api.GetEnumUnit() -- Why didn't GetTriggerUnit work?
      local owningPlayer = wc3api.GetOwningPlayer(unit)
      if(playerUnits[owningPlayer] == nil) then
        playerUnits[owningPlayer] = 1
      else
        playerUnits[owningPlayer] = playerUnits[owningPlayer] + 1
      end
    end

    local g = wc3api.CreateGroup()
    wc3api.GroupEnumUnitsInRect(g, region, wc3api.constants.NO_FILTER)
    wc3api.ForGroup(g, CountUnitsOfPlayer)

    wc3api.DestroyGroup(g)
    g = nil
    return playerUnits
  end


  function unitManager.GetPlayerWithMostUnitsInRegion(region)
    local biggestPlayer = wc3api.Player(wc3api.GetPlayerNeutralPassive())
    local biggestCount = 0
    local playerUnits = unitManager.CountUnitsPerPlayerInRegion(region)

    for player,count in pairs(playerUnits) do
      if biggestCount == count then
        biggestPlayer = wc3api.Player(wc3api.GetPlayerNeutralPassive())
      end
      if count > biggestCount then
        biggestPlayer = player
        biggestCount = count
      end
    end

    return biggestPlayer
  end

  function unitManager.GetSingleUnitInRegionOrNil(region)
    local unitCount = 0
    local theUnit = nil
    local function CountUnits()
      theUnit = wc3api.GetEnumUnit()
      unitCount = unitCount + 1
    end
    local g = wc3api.CreateGroup()
    wc3api.GroupEnumUnitsInRect(g, region, wc3api.constants.NO_FILTER)
    wc3api.ForGroup(g, CountUnits)
    wc3api.DestroyGroup(g)
    g = nil

    if(unitCount ~= 1) then
      theUnit = nil
    end
    return theUnit
  end


  function unitManager.ScanAllUnitsOwnedByPlayer(player)
    local group g = wc3api.CreateGroup()

    local function filterUnits()
      return true
    end

    wc3api.GroupEnumUnitsOfPlayer(g, player.ref, wc3api.Filter(filterUnits))

    local function testGroups()
      local function testGroups2()
        local testGroupLog = {}
        testGroupLog.type = logging.types.DEBUG
        local u = wc3api.GetEnumUnit()
        local uid = wc3api.GetUnitTypeId(u)
        local uname = wc3api.GetObjectName(uid)

        testGroupLog.message = "unitname: " .. uname

        logging.Write(testGroupLog)
      end
      xpcall(testGroups2, print)
    end

    wc3api.ForGroup(g, testGroups)
  end

  function unitManager.ConvertUnitToOtherPlayer(unit, otherPlayer)
    wc3api.SetUnitOwner(unit, otherPlayer, wc3api.constants.CHANGE_COLOR)
  end

  function unitManager.ConvertUnitToOtherUnit(unit, otherUnitID)
    local unitID = wc3api.GetUnitTypeId(unit)
    local unitx = wc3api.GetUnitX(unit)
    local unity = wc3api.GetUnitY(unit)
    local unitface = wc3api.GetUnitFacing(unit)
    local unitowner = wc3api.GetOwningPlayer(unit)
    wc3api.RemoveUnit(unit)
    local newUnit = wc3api.CreateUnit(unitowner, otherUnitID, unitx, unity, unitface)
    return newUnit
  end


  --[[ TODO: Implement a command to get useful info
  -- Commands
  local getUnitRegionInfo = {}
  getUnitRegionInfo.activator = "-region"
  getUnitRegionInfo.users = {wc3api.Player(0)}
  -- getUnitRegionInfo.dummyVar = 0
  function getUnitRegionInfo:Handler()
    local cmdString = wc3api.GetEventPlayerChatString()
    local splitString = utility.Split(cmdString)
  end
    commands.Add(getUnitRegionInfo)
  --]]

  return unitManager
end
