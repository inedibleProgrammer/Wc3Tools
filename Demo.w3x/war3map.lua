gg_rct_testcop = nil
gg_rct_startRect = nil
gg_trg_playerunits = nil
gg_trg_quest = nil
gg_trg_testcop = nil
gg_trg_PeriodicPrint = nil
gg_trg_LaunchLua = nil
function InitGlobals()
end

function CreateUnitsForPlayer0()
local p = Player(0)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("Hpal"), 1724.8, -1939.8, 13.887, FourCC("Hpal"))
u = BlzCreateUnitWithSkin(p, FourCC("h000"), 293.8, -1558.5, 129.313, FourCC("h000"))
end

function CreateNeutralPassiveBuildings()
local p = Player(PLAYER_NEUTRAL_PASSIVE)
local u
local unitID
local t
local life

u = BlzCreateUnitWithSkin(p, FourCC("ncop"), 1984.0, -1792.0, 270.000, FourCC("ncop"))
u = BlzCreateUnitWithSkin(p, FourCC("nico"), 1536.0, -1536.0, 270.000, FourCC("nico"))
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
CreateUnitsForPlayer0()
end

function CreateAllUnits()
CreateNeutralPassiveBuildings()
CreatePlayerBuildings()
CreatePlayerUnits()
end

function CreateRegions()
local we

gg_rct_testcop = Rect(1888.0, -1888.0, 2080.0, -1696.0)
gg_rct_startRect = Rect(-2496.0, -2880.0, -1440.0, -1792.0)
end

map = {}
function map.Commands_Create(wc3api)
  local commands = {}
  commands.list = {}
  commands.count = 0

  function commands.Add(command)
    if (#command.users <= 0) then
      return
    end

    command.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(command.trigger, command.Handler)

    for _,user in pairs(command.users) do
      wc3api.TriggerRegisterPlayerChatEvent(command.trigger, user, command.activator, wc3api.NO_EXACT_MATCH)
    end

    table.insert(commands.list, command)
    commands.count = commands.count + 1
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


function map.Colors_Create()
  local colors = {}
  colors.ColorList = {}

  function colors.AddColor(text, number, hexCode)
    local color = {}
    color.text = text
    color.number = number
    color.hexCode = hexCode

    table.insert(colors.ColorList, color)
  end

  -- This function returns a color object from text
  function colors.GetColor_T(t)
    for _,v in ipairs(colors.ColorList) do
      if t == v.text then
        return v
      end
    end
  end

  function colors.GetColor_N(n)
    for _,v in ipairs(colors.ColorList) do
      if n == v.number then
        return v
      end
    end
  end

  function colors.GetColorCode(text)
    for _,v in ipairs(colors.ColorList) do
      if text == v.text then
        return v.hexCode
      end
    end
  end

  function colors.GetColoredString(normalString, colorName)
    local coloredString = "|c" .. colors.GetColorCode(colorName) .. normalString  .. "|r"
    return coloredString
  end

  colors.AddColor("red", 1, "00FF0303")
  colors.AddColor("blue", 2, "000042FF")
  colors.AddColor("teal", 3, "001CE6B9")
  colors.AddColor("purple", 4, "00540081")
  colors.AddColor("yellow", 5, "00FFFC00")
  colors.AddColor("orange", 6, "00FE8A0E")
  colors.AddColor("green", 7, "0020C000")
  colors.AddColor("pink", 8, "00E55BB0")
  colors.AddColor("gray", 9, "00959697")
  colors.AddColor("light_blue", 10, "007EBFF1")
  colors.AddColor("dark_green", 11, "00106246")
  colors.AddColor("brown", 12, "004E2A04")
  colors.AddColor("maroon", 13, "009B0000")
  colors.AddColor("navy", 14, "000000C3")
  colors.AddColor("turquoise", 15, "0000EAFF")
  colors.AddColor("violet", 16, "00BE00FE")
  colors.AddColor("wheat", 17, "00EBCD87")
  colors.AddColor("peach", 18, "00F8A48B")
  colors.AddColor("mint", 19, "00BFFF80")
  colors.AddColor("lavender", 20, "00DCB9EB")
  colors.AddColor("coal", 21, "00282828")
  colors.AddColor("snow", 22, "00EBF0FF")
  colors.AddColor("emerald", 23, "0000781E")
  colors.AddColor("peanut", 24, "00A46F33")
  colors.AddColor("some_weird_green", 25, "0022744F")
  colors.AddColor("gold", 26, "00FFD700")
  colors.AddColor("bright_blue", 27, "0019CAF6")

  return colors
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

function map.DebugTools_Create(wc3api, logging, players, commands, utility, colors)
  local debugTools = {}

  local authenticatedUsers = {}
  local debugLog = {}
  debugLog.type = logging.types.DEBUG
  debugLog.message = ""

  local function TryAddPlayerName(playerName, toList)
    local player = players.GetPlayerByName(playerName)
    if(player ~= nil) then
      table.insert(toList, player.ref)
    end
  end

  TryAddPlayerName("WorldEdit", authenticatedUsers)
  TryAddPlayerName("MasterLich#11192", authenticatedUsers)
  TryAddPlayerName("MagicDoor#1685", authenticatedUsers)

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
  setGoldCommand.users = authenticatedUsers
  function setGoldCommand.Handler()
    local data = GetResourceData()

    if(data ~= nil) then
      wc3api.SetPlayerState(data.receivingPlayer.ref, wc3api.constants.PLAYER_STATE_RESOURCE_GOLD, data.amount)
      debugLog.message = data.commandingPlayer.coloredname .. " set player " .. data.receivingPlayer.coloredname .. " gold to amount " .. data.amount
      logging.Write(debugLog)
    end
  end

  local setWoodCommand = {}
  setWoodCommand.activator = "-wood"
  setWoodCommand.users = authenticatedUsers
  function setWoodCommand.Handler()
    local data = GetResourceData()

    if(data ~= nil) then
      wc3api.SetPlayerState(data.receivingPlayer.ref, wc3api.constants.PLAYER_STATE_RESOURCE_LUMBER, data.amount)
      debugLog.message = data.commandingPlayer.coloredname .. " set player " .. data.receivingPlayer.coloredname .. " wood to amount " .. data.amount
      logging.Write(debugLog)
    end
  end

  commands.Add(setGoldCommand)
  commands.Add(setWoodCommand)

  return debugTools
end
function map.Game_Initialize()
  local game = {}
  local wc3api = map.RealWc3Api_Create()
  local colors = map.Colors_Create()
  local utility = map.Utility_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local players = map.Players_Create(wc3api, commands, colors)
  local gameClock = map.GameClock_Create(wc3api, clock, commands, players)
  local logging = map.Logging_Create(wc3api, gameClock, commands, players)
  local unitManager = map.UnitManager_Create(wc3api, logging, commands)
  local editor = map.Editor_Create()
  local debugTools = map.DebugTools_Create(wc3api, logging, players, commands, utility, colors)

  game.worldEdit = players.GetPlayerByName("WorldEdit")
  logging.SetPlayerOptionByID(game.worldEdit.id, logging.types.ALL)

  local gameStatusLog = {}
  gameStatusLog.type = logging.types.INFO
  gameStatusLog.message = "Game Start"
  logging.Write(gameStatusLog)

  print("??")
  wc3api.SetPlayerState(game.worldEdit.ref, wc3api.constants.PLAYER_STATE_RESOURCE_GOLD, 99999)
  wc3api.SetPlayerState(game.worldEdit.ref, wc3api.constants.PLAYER_STATE_RESOURCE_LUMBER, 99999)

  local function testLogging()
    -- local masterLich = players.GetPlayerByName("MasterLich#11192")
    -- local worldEdit = players.GetPlayerByName("WorldEdit")

    -- logging.SetPlayerOptionByID(masterLich.id, logging.types.ALL)
    -- logging.SetPlayerOptionByID(worldEdit.id, logging.types.ALL)

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

  -- testLogging()

  local function testPlayers()
    for _,player in pairs(players.list) do
      print(player.id)
    end
  end

  -- testPlayers()

  local function testWalkOnCircle()
    local function testWalkOnCircle2()
      local testWalkOnCircleLog = {}
      -- local triggerUnitName = wc3api.GetUnitName(wc3api.GetTriggerUnit())
      -- local triggerUnitName = wc3api.GetObjectName(wc3api.GetUnitTypeId(wc3api.GetTriggerUnit()))
      local unit = wc3api.GetTriggerUnit()
      local unitid = wc3api.GetUnitTypeId(unit)
      local unitname = wc3api.GetObjectName(unitid)
      -- testWalkOnCircleLog.message = "Unit " .. unitname .. " walked on testcop"
      -- testWalkOnCircleLog.message = "" .. type(editor.testcop)
      testWalkOnCircleLog.message = colors.GetColoredString(type(editor.testcop), "blue")
      testWalkOnCircleLog.type = logging.types.DEBUG
      logging.Write(testWalkOnCircleLog)
    end
    xpcall(testWalkOnCircle2, print)
  end

  local unitWalksOnCircleTrigger = wc3api.CreateTrigger()
  wc3api.TriggerRegisterEnterRectSimple(unitWalksOnCircleTrigger, editor.testcop)
  wc3api.TriggerAddAction(unitWalksOnCircleTrigger, testWalkOnCircle)


  local function testUnitManager()
    local function testUnitManager2()
      unitManager.ScanAllUnitsOwnedByPlayer(players.GetPlayerByName("WorldEdit"))
    end
    xpcall(testUnitManager2, print)
  end

  -- testUnitManager()

  local startRectInfo = {}
  startRectInfo.centerx = wc3api.GetRectCenterX(editor.startRect)
  startRectInfo.centery = wc3api.GetRectCenterY(editor.startRect)

  game.wagonUnit = wc3api.CreateUnit(game.worldEdit.ref,
                                      wc3api.FourCC("h000"),
                                      startRectInfo.centerx,
                                      startRectInfo.centery,
                                      0.00)

  local function testWagons()
    local function testWagons2()


      local wagonSpeedLog = {}
      wagonSpeedLog.type = logging.types.DEBUG
      wagonSpeedLog.message = "movespeed before: " .. wc3api.GetUnitMoveSpeed(game.wagonUnit)
      logging.Write(wagonSpeedLog)
      wc3api.SetUnitMoveSpeed(game.wagonUnit, 3000)
      wagonSpeedLog.message = "movespeed after: " .. wc3api.GetUnitMoveSpeed(game.wagonUnit)
      logging.Write(wagonSpeedLog)

      -- Wagon goes from 180 speed to 400 (max)

      wc3api.UnitAddAbility(game.wagonUnit, wc3api.FourCC("AEbl")) -- blink
      wc3api.BlzSetUnitMaxMana(game.wagonUnit, 500)
      wc3api.BlzSetUnitRealField(game.wagonUnit, wc3api.constants.UNIT_RF_MANA, 300)
      wc3api.BlzSetUnitRealField(game.wagonUnit, wc3api.constants.UNIT_RF_MANA_REGENERATION, 5)
      wc3api.BlzSetUnitName(game.wagonUnit, "Wagon Builder")

      local function WagonBuildingAction()
        local function WagonBuildingAction2()
          local theUnit = wc3api.GetTriggerUnit() -- This returns the building itself (Blizzard Bug)
          -- https://www.hiveworkshop.com/threads/how-to-get-building-unit.274883/
          -- local theUnitName = wc3api.GetUnitName(theUnit) -- Doesn't work?
          local theBuilding = wc3api.GetConstructingStructure()


          local wagonBuildLog = {}
          wagonBuildLog.type = logging.types.INFO

          -- print("Here")
          -- print(theUnitName) -- Why doesn't this work? because of SetUnitName?

          if(wc3api.IsUnitInRange(game.wagonUnit, theBuilding, 120)) then
            -- wc3api.TriggerSleepAction(0.1)
            -- wc3api.UnitSetConstructionProgress(theBuilding, 200.0) -- Doesn't work...?
            -- https://www.hiveworkshop.com/threads/unitsetcontructionprogress-wont-finish-construction.222521/
            local baseID = wc3api.GetUnitTypeId(theUnit)
            local basex = wc3api.GetUnitX(theUnit)
            local basey = wc3api.GetUnitY(theUnit)
            local baseface = wc3api.GetUnitFacing(theUnit)
            wc3api.RemoveUnit(theUnit)
            wc3api.RemoveUnit(game.wagonUnit)
            wc3api.CreateUnit(game.worldEdit.ref, baseID, basex, basey, baseface)


            wagonBuildLog.message = "Wagon built something"
            logging.Write(wagonBuildLog)
          else
            print("bleh")
            wc3api.KillUnit(theUnit)



          end
        end
        xpcall(WagonBuildingAction2, print)
      end

      local finishBuildingTrigger = wc3api.CreateTrigger()
      --TODO: Destroy the trigger after building finished
      wc3api.TriggerRegisterPlayerUnitEvent(finishBuildingTrigger, game.worldEdit.ref, wc3api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_START, wc3api.constants.NO_FILTER)
      wc3api.TriggerAddAction(finishBuildingTrigger, WagonBuildingAction)
    end
    xpcall(testWagons2, print)
  end

  testWagons()


  gameStatusLog.message = "Game End"
  logging.Write(gameStatusLog)
end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

--luacheck: ignore

function map.RealWc3Api_Create()
  local realWc3Api = {}

  realWc3Api.constants = {}
  realWc3Api.constants.NO_FILTER = nil
  realWc3Api.constants.EXACT_MATCH = true
  realWc3Api.constants.NO_EXACT_MATCH = false

  realWc3Api.constants.bj_FORCE_ALL_PLAYERS = nil
  realWc3Api.constants.EVENT_PLAYER_LEAVE = EVENT_PLAYER_LEAVE

  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_START = EVENT_PLAYER_UNIT_CONSTRUCT_START
  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL
  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = EVENT_PLAYER_UNIT_CONSTRUCT_FINISH

  realWc3Api.constants.UNIT_RF_HP = UNIT_RF_HP
  realWc3Api.constants.UNIT_RF_HIT_POINTS_REGENERATION_RATE = UNIT_RF_HIT_POINTS_REGENERATION_RATE
  realWc3Api.constants.UNIT_RF_MANA = UNIT_RF_MANA
  realWc3Api.constants.UNIT_RF_MANA_REGENERATION = UNIT_RF_MANA_REGENERATION

  realWc3Api.constants.UNIT_STATE_LIFE = UNIT_STATE_LIFE
  realWc3Api.constants.UNIT_STATE_MAX_LIFE = UNIT_STATE_MAX_LIFE
  realWc3Api.constants.UNIT_STATE_MANA = UNIT_STATE_MANA
  realWc3Api.constants.UNIT_STATE_MAX_MANA = UNIT_STATE_MAX_MANA

  realWc3Api.constants.PLAYER_STATE_RESOURCE_GOLD = PLAYER_STATE_RESOURCE_GOLD
  realWc3Api.constants.PLAYER_STATE_RESOURCE_LUMBER = PLAYER_STATE_RESOURCE_LUMBER

  function realWc3Api.BJDebugMsg(msg)
    return BJDebugMsg(msg)
  end

  function realWc3Api.CreateTrigger()
    return CreateTrigger()
  end

  function realWc3Api.TriggerSleepAction(timeout)
    return TriggerSleepAction(timeout)
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

  function realWc3Api.TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter)
    return TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter)
  end

  function realWc3Api.GetEventPlayerChatString()
    return GetEventPlayerChatString()
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

  function realWc3Api.GetPlayerState(whichPlayer, whichPlayerState)
    return GetPlayerState(whichPlayer, whichPlayerState)
  end

  function realWc3Api.SetPlayerState(whichPlayer, whichPlayerState, value)
    return SetPlayerState(whichPlayer, whichPlayerState, value)
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

  function realWc3Api.BlzSetUnitName(whichUnit, name)
    return BlzSetUnitName(whichUnit, name)
  end

  function realWc3Api.GetUnitName()
    return GetUnitName()
  end

  function realWc3Api.SetUnitMoveSpeed(whichUnit, newSpeed)
    return SetUnitMoveSpeed(whichUnit, newSpeed)
  end

  function realWc3Api.GetUnitMoveSpeed(whichUnit)
    return GetUnitMoveSpeed(whichUnit)
  end

  function realWc3Api.BlzGetUnitBooleanField(whichUnit, whichField)
    return BlzGetUnitBooleanField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitIntegerField(whichUnit, whichField)
    return BlzGetUnitIntegerField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitRealField(whichUnit, whichField)
    return BlzGetUnitRealField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitStringField(whichUnit, whichField)
    return BlzGetUnitStringField(whichUnit, whichField)
  end

  function realWc3Api.BlzSetUnitBooleanField(whichUnit, whichField, value)
    return BlzSetUnitBooleanField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitIntegerField(whichUnit, whichField, value)
    return BlzSetUnitIntegerField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitRealField(whichUnit, whichField, value)
    return BlzSetUnitRealField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitStringField(whichUnit, whichField, value)
    return BlzSetUnitStringField(whichUnit, whichField, value)
  end

  function realWc3Api.SetUnitState(whichUnit, whichUnitState, newVal)
    return SetUnitState(whichUnit, whichUnitState, newVal)
  end

  function realWc3Api.SetUnitPosition(whichUnit, newX, newY)
    return SetUnitPosition(whichUnit, newX, newY)
  end

  function realWc3Api.KillUnit(whichUnit)
    return KillUnit(whichUnit)
  end

  function realWc3Api.RemoveUnit(whichUnit)
    return RemoveUnit(whichUnit)
  end

  function realWc3Api.FourCC(typeId)
    return FourCC(typeId)
  end

  function realWc3Api.CreateUnitByName(whichPlayer, unitname, x, y, face)
    return CreateUnitByName(whichPlayer, unitname, x, y, face)
  end

  function realWc3Api.CreateUnit(id, unitid, x, y, face)
    return CreateUnit(id, unitid, x, y, face)
  end

  function realWc3Api.UnitAddAbility(whichUnit, abilityId)
    return UnitAddAbility(whichUnit, abilityId)
  end

  function realWc3Api.UnitRemoveAbility(whichUnit, abilityId)
    return UnitRemoveAbility(whichUnit, abilityId)
  end

  function realWc3Api.BlzGetUnitMaxMana(whichUnit)
    return BlzGetUnitMaxMana(whichUnit)
  end

  function realWc3Api.BlzSetUnitMaxMana(whichUnit, mana)
    return BlzSetUnitMaxMana(whichUnit, mana)
  end

  function realWc3Api.BlzSetUnitMaxHP(whichUnit, hp)
    return BlzSetUnitMaxHP(whichUnit, hp)
  end

  function realWc3Api.BlzGetUnitMaxHP(whichUnit)
    return BlzGetUnitMaxHP(whichUnit)
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

  function realWc3Api.GetConstructingStructure()
    return GetConstructingStructure()
  end

  function realWc3Api.GetCancelledStructure()
    return GetCancelledStructure()
  end

  function realWc3Api.GetConstructedStructure()
    return GetConstructedStructure()
  end

  function realWc3Api.UnitSetConstructionProgress(whichUnit, constructionPercentage)
    return UnitSetConstructionProgress(whichUnit, constructionPercentage)
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

  function realWc3Api.IsUnitInRange(whichUnit, otherUnit, distance)
    return IsUnitInRange(whichUnit, otherUnit, distance)
  end

  function realWc3Api.IsUnitInRangeXY(whichUnit, x, y, distance)
    return IsUnitInRangeXY(whichUnit, x, y, distance)
  end

  function realWc3Api.GetUnitX(whichUnit)
    return GetUnitX(whichUnit)
  end

  function realWc3Api.GetUnitY(whichUnit)
    return GetUnitY(whichUnit)
  end

  function realWc3Api.GetUnitFacing(whichUnit)
    return GetUnitFacing(whichUnit)
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
--luacheck: ignore

function map.Editor_Create()
  local editor = {}

  editor.testcop = gg_rct_testcop
  editor.startRect = gg_rct_startRect

  return editor
end
function map.Utility_Create()
  local utility = {}

  function utility.Split(inputStr, sep)
    if sep == nil then
      sep = " "
    end
    local t = {}
    for str in string.gmatch(inputStr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
  end

  return utility
end




function map.Utility_Tests(testFramework)
  testFramework.Suites.UtilitySuite = {}
  testFramework.Suites.UtilitySuite.Tests = {}
  local tsu = testFramework.Suites.UtilitySuite

  function tsu.Setup() end
  function tsu.Teardown() end

  function tsu.Tests.SplitTest()
    local utility = map.Utility_Create()
    dummyString = "This is a test 113."
    splitString = utility.Split(dummyString)

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
    collectgarbage("collect")
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
  function displayTimeCommand.Handler()
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
  function wc3api.GetPlayerId() return 0 end
  function wc3api.TriggerRegisterTimerEvent() end
  function wc3api.TriggerAddAction() end
  function wc3api.GetBJMaxPlayers() return 1 end
  function wc3api.GetPlayerName() end
  function wc3api.GetPlayerRace() end
  function wc3api.GetPlayerTeam() end
  function wc3api.GetPlayerColor() end
  function wc3api.GetPlayerController() end
  function wc3api.GetPlayerSlotState() end
  function wc3api.TriggerRegisterPlayerChatEvent() end
  function wc3api.TriggerRegisterPlayerEvent() end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.CreateClock()
    --[[
      local clock = map.Clock_Create()
      local commands = map.Commands_Create(wc3api)
      local colors = map.Colors_Create()
      local players = map.Players_Create(wc3api, commands, colors)
      local gameClock = map.GameClock_Create(wc3api, clock, commands, players)
    --]]

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
    -- timeString = string.format("10:07:08", timeElapsed.hours, timeElapsed.minutes, timeElapsed.seconds) -- This doesn't work in wc3 for some reason

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


function map.Players_Create(wc3api, commands, colors)
  local players = {}

  players.list = {}
  players.ALL_PLAYERS = {}

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

  function wc3api.TriggerRegisterPlayerEvent()
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
  logging.types = {
    TRACE = {bin = "000001", name = "TRACE"},
    DEBUG = {bin = "000010", name = "DEBUG"},
    INFO =  {bin = "000100", name = "INFO"},
    WARN =  {bin = "001000", name = "WARN"},
    ERROR = {bin = "010000", name = "ERROR"},
    FATAL = {bin = "100000", name = "FATAL"},
    ALL =   {bin = "111111", name = "ALL"},
    NONE =  {bin = "000000", name = "NONE"}
  }
  logging.playerOptions = {}

  for _,player in pairs(players.list) do
    playerLogOptions = {}
    playerLogOptions.id = player.id
    playerLogOptions.visibility = logging.types.NONE

    table.insert(logging.playerOptions, playerLogOptions)
  end

  function logging.Write(logMessage)
    -- print("logging.Write")
    -- print("1"))
    local logString = tostring(logging.count) .. "#" .. logging.gameClock.clock.GetTimeString() .. "#" .. logMessage.type.name .. "#" .. logMessage.message
    -- print("2")

    for _,player in pairs(players.list) do
      -- print("3")
      for _,playerLogOptions in pairs(logging.playerOptions) do
        -- print("4")
        if(playerLogOptions.id == player.id) then
          -- print("5")
          local playerVisibilityOptionBinary = tonumber(playerLogOptions.visibility.bin, 2)
          local logMessageTypeBinary = tonumber(logMessage.type.bin, 2)
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
function map.UnitManager_Create(wc3api, logging, commands)
  local unitManager = {}
  unitManager.wc3api = wc3api
  unitManager.logging = logging
  unitManager.commands = commands


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

  return unitManager
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
  -- print("Map Start")
  -- map.UnitTests()
  xpcall(map.Game_Start, print)
  -- print("Map End")
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
ForcePlayerStartLocation(Player(0), 0)
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(1), 1)
ForcePlayerStartLocation(Player(1), 1)
SetPlayerColor(Player(1), ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1), RACE_PREF_RANDOM)
SetPlayerRaceSelectable(Player(1), true)
SetPlayerController(Player(1), MAP_CONTROL_USER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
SetPlayerTeam(Player(1), 0)
SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
end

function InitAllyPriorities()
SetStartLocPrioCount(0, 1)
SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
SetStartLocPrioCount(1, 1)
SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
end

function main()
SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("CityScapeDay")
SetAmbientNightSound("CityScapeNight")
SetMapMusic("Music", true, 0)
CreateRegions()
CreateAllUnits()
InitBlizzard()
InitGlobals()
InitCustomTriggers()
RunInitializationTriggers()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(2)
SetTeams(2)
SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
DefineStartLocation(0, 1984.0, -2368.0)
DefineStartLocation(1, -1600.0, 1792.0)
InitCustomPlayerSlots()
InitCustomTeams()
InitAllyPriorities()
end

