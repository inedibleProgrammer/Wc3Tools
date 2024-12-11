function map.Game_Initialize()
  local initFinished = false
  local game = {}
  local wc3api = map.RealWc3Api_Create()
  local colors = map.Colors_Create()
  local utility = map.Utility_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local authenticatedNames = {"WorldEdit", "MasterLich#11192", "MagicDoor#1685"}
  local players = map.Players_Create(wc3api, commands, colors, authenticatedNames, utility)
  local gameClock = map.GameClock_Create(wc3api, clock, commands, players)
  local logging = map.Logging_Create(wc3api, gameClock, commands, players)
  local unitManager = map.UnitManager_Create(wc3api, logging, commands)
  local editor = map.Editor_Create()
  local debugTools = map.DebugTools_Create(wc3api, logging, players, commands, utility, colors)

  initFinished = true
  assert(initFinished, "Init did not finish.")

  function TestGeneral()
    
    return true
  end
  assert(TestGeneral(), "General tests did not finish.")

  local function TestPlayers()
    local function TestPlayers1()
      -- debugTools.Display(wc3api.Player(0)) -- Error: expected string but got player

      local container = {}
      container[wc3api.Player(0)] = 7
      assert(container[wc3api.Player(0)] == 7)
    end
    TestPlayers1()

    return true
  end
  assert(TestPlayers(), "Player tests did not finish.")

  function TestTriggers()
    local function TestTriggers1()
      local testTrigger = wc3api.CreateTrigger()
      -- debugTools.Display(type(testTrigger))
      -- debugTools.Display(testTrigger)
      -- Note: Every time you run this you get a different output 
      -- print(testTrigger) -- Output: "trigger: 000002BF1A1D7480"

      -- Not sure what "userdata" means
      assert(type(testTrigger) == "userdata")

      wc3api.DestroyTrigger(testTrigger)
      -- debugTools.Display(type(testTrigger))
      assert(type(testTrigger) == "userdata")
    end
    TestTriggers1()

    return true
  end
  assert(TestTriggers(), "Trigger tests did not finish.")

  function TestRegions()
    -- Editor prepares region to have 3 red knights and 3 blue knights
    local function TestRegions1()
      local unitCount = unitManager.CountUnitsInRegion(editor.TestRegion1)
      assert(unitCount == 6, "TestRegion1: Unit count not 6")

      local biggestPlayer = unitManager.GetPlayerWithMostUnitsInRegion(editor.TestRegion1)
      assert(biggestPlayer == wc3api.GetPlayerNeutralPassive(), "TestRegions1: Red and blue have same size")
    end
    TestRegions1()

    -- Editor prepares region to have 3 red Knights and 2 blue knights
    local function TestRegions2()
      local playerUnits = unitManager.CountUnitsPerPlayerInRegion(editor.TestRegion2)

      assert(playerUnits[wc3api.Player(0)] == 3, "TestRegions2: Red not 3 units")
      assert(playerUnits[wc3api.Player(1)] == 2, "TestRegions2: Blue not 3 units")

      local biggestPlayer = unitManager.GetPlayerWithMostUnitsInRegion(editor.TestRegion2)
      assert(biggestPlayer == wc3api.Player(0), "TestRegions2: Red must be larger")
      -- local biggestPlayer = unitManager.GetPlayerWithMostUnitsInRegion(editor.TestRegion2)
      -- assert(biggestPlayer == wc3api.Player(0), "TestRegion2: Biggest player not red")
    end
    TestRegions2()

    local function TestRegions3()
      local unit1 = wc3api.CreateUnit(wc3api.Player(0),
                                     wc3api.FourCC("hkni"),
                                     wc3api.GetRectCenterX(editor.TestRegion3),
                                     wc3api.GetRectCenterY(editor.TestRegion3),
                                     0)
      local unit2 = wc3api.CreateUnit(wc3api.Player(1),
                                     wc3api.FourCC("hkni"),
                                     wc3api.GetRectCenterX(editor.TestRegion3),
                                     wc3api.GetRectCenterY(editor.TestRegion3),
                                     0)

      local playerUnits = {}
      playerUnits[wc3api.GetOwningPlayer(unit1)] = 1
      -- debugTools.Display(playerUnits[wc3api.GetOwningPlayer(unit1)])
      assert(playerUnits[wc3api.GetOwningPlayer(unit1)] == 1, "playerUnits not 1")
      -- local biggestPlayer = unitManager.GetPlayerWithMostUnitsInRegion(editor.TestRegion2)
      -- assert(biggestPlayer == wc3api.Player(0), "TestRegion2: Biggest player not red")
    end
    TestRegions3()

    -- Editor prepares region to have 1 town hall for red
    local function TestRegions4()
      local playerUnits = unitManager.CountUnitsPerPlayerInRegion(editor.TestRegion4)
      assert(playerUnits[wc3api.Player(0)] == 1, "TestRegions4: Red does not have 1 unit")
    end
    TestRegions4()

    return true
  end
  assert(TestRegions(), "Region tests did not finish.")


end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

