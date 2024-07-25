function map.Game_Initialize()
  local game = {}
  local wc3api = map.RealWc3Api_Create()
  local colors = map.Colors_Create()
  local utility = map.Utility_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local authenticatedNames = {"WorldEdit", "MasterLich#11192", "MagicDoor#1685"}
  local players = map.Players_Create(wc3api, commands, colors, authenticatedNames)
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

  wc3api.SetPlayerState(game.worldEdit.ref, wc3api.constants.PLAYER_STATE_RESOURCE_GOLD, 99999)
  wc3api.SetPlayerState(game.worldEdit.ref, wc3api.constants.PLAYER_STATE_RESOURCE_LUMBER, 99999)


  gameStatusLog.message = "Game End"
  logging.Write(gameStatusLog)
end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

