function map.Game_Initialize()
  local initFinished = false
  local game = {}
  local wc3api = map.RealWc3Api_Create()
  local sounds = map.Sounds_Create(wc3api)
  local triggers = map.Triggers_Create(wc3api)
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
  local world = map.World_Create(wc3api, players, commands)
  local debugTools = map.DebugTools_Create(wc3api, logging, players, commands, utility, colors)

  initFinished = true
  assert(initFinished, "Init did not finish.")



  function TestGeneral()
    local function TestPings()
      local function Ping()
        wc3api.PingMinimapEx(0, 0, 5, 255, 0, 0, false)
      end
      triggers.CreateTimedTrigger(1, Ping)
    end
    TestPings()

    local function TestCamera()
      local function Camera()
        wc3api.PanCameraToForPlayer(wc3api.Player(0),
                                    wc3api.GetRectCenterX(wc3api.GetWorldBounds()),
                                    wc3api.GetRectCenterY(wc3api.GetWorldBounds()))
      end
      Camera()
    end
    TestCamera()


    local function TestMusic()
      local function Music()
        sounds.PlayTension()
        -- local g_musicpath = "Tension" .. ";NightElfDefeat"
        -- wc3api.SetMapMusic(gg_snd_NightElfDefeat, false, 0)
        -- wc3api.StopMusic(true)
        -- wc3api.ClearMapMusic()
        -- wc3api.SetMapMusic(g_musicpath, false, 0)
        -- wc3api.StartSound(bj_victoryDialogSound)
        -- wc3api.PlayMusic("Tension")
        -- wc3api.StartSound(gg_snd_NightElfDefeat)
        -- wc3api.PlayMusic(musicpath)
      end
      xpcall(Music, print)
    end
    TestMusic()

    local function TestCreateFile()
      wc3api.PreloadGenClear()
      wc3api.PreloadGenStart()
      wc3api.Preload("Dummy1246\nDummy123")
      wc3api.PreloadGenEnd("Dummy.txt")
    end
    xpcall(TestCreateFile, print)

    local function TestFileIO()
      local fileIO = map.FileIO_Create(wc3api)
      fileIO.Init("FileIO.txt") -- Max you can write is apparently 259 bytes
      for i=0, 20 do
        local m = ""
        m = m .. tostring(i) .. ":" .. "sometext"
        fileIO.WriteLine(m)
      end
      fileIO.Flush()
    end
    xpcall(TestFileIO, print)

    local function TestCeresFileIO()
      local ofstream = {}
      ofstream.raw_prefix = ']]i(p,[['
      ofstream.raw_suffix = ']])--[['
      ofstream.raw_size = 256 - #ofstream.raw_prefix - #ofstream.raw_suffix
      ofstream.load_ability = FourCC('ANdc')

      function ofstream.open(filename)
        ofstream.name = filename
        PreloadGenClear()
        Preload('")\nendfunction\n//! beginusercode\nlocal p={} local i=table.insert--[[')
      end

      function ofstream.write(s)
        for i=1, #s, ofstream.raw_size do
          Preload(ofstream.raw_prefix..s:sub(i,i+ofstream.raw_size-1)..ofstream.raw_suffix)
        end
      end

      function ofstream.close()
        Preload(']]BlzSetAbilityTooltip('..ofstream.load_ability..', table.concat(p), 0) print("File '.. ofstream.name ..' loaded successfully!")\n//! endusercode\nfunction AAA takes nothing returns nothing\n//')
        PreloadGenEnd( ofstream.name )
        ofstream.name = nil
      end

      function loadfile(filename)
        local s = BlzGetAbilityTooltip(ofstream.load_ability, 0)
        BlzSetAbilityTooltip(ofstream.load_ability, '', 0)
        Preloader(filename)
        local loaded = BlzGetAbilityTooltip(ofstream.load_ability, 0)
        BlzSetAbilityTooltip(ofstream.load_ability, s, 0)
        return loaded
      end

      ofstream.open("TestCeresFileIO.txt")
      for i=0, 999 do
        ofstream.write("0123456789")
      end
      ofstream.close()
    end
    xpcall(TestCeresFileIO, print)

    local function TestShell()
      local shell = CreateTrigger()
      TriggerRegisterPlayerChatEvent(shell, Player(0), '$', false)
      TriggerAddAction(shell, function()
                         local s = GetEventPlayerChatString()
                         if s:sub(1,1) ~= '$' then
                           return
                         end
                         s = s:sub(2)
                         ExecuteString(s)
      end)

      function ExecuteString(s)
        local f = load(s)
        if not f then
          Log.error('invalid shell command "' .. s .. '"')
        end
        print(f())
        table.insert(cache, s)
      end
    end
    TestShell()

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

    local function TestTriggers2()
      local counter = 0
      local function PrintHello()
        wc3api.BJDebugMsg("Hello - test periodic")
      end
      triggers.CreatePeriodicTrigger(1.0, PrintHello)
    end
    TestTriggers2()

    return true
  end
  assert(TestTriggers(), "Trigger tests did not finish.")

  function TestRegions()
    -- Editor prepares region to have 3 red knights and 3 blue knights
    local function TestRegions1()
      local unitCount = unitManager.CountUnitsInRegion(editor.TestRegion1)
      assert(unitCount == 6, "TestRegion1: Unit count not 6")

      local biggestPlayer = unitManager.GetPlayerWithMostUnitsInRegion(editor.TestRegion1)
      assert(biggestPlayer == wc3api.Player(wc3api.GetPlayerNeutralPassive()), "TestRegions1: Red and blue have same size")
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

      unitManager.ConvertUnitToOtherPlayer(unit1, wc3api.Player(1))
      assert(wc3api.GetOwningPlayer(unit1) == wc3api.Player(1), "TestRegions3: Unit does not belong to Player(1)")
    end
    TestRegions3()

    -- Editor prepares region to have 1 town hall for red
    local function TestRegions4()
      local playerUnits = unitManager.CountUnitsPerPlayerInRegion(editor.TestRegion4)
      assert(playerUnits[wc3api.Player(0)] == 1, "TestRegions4: Red does not have 1 unit")

      local unitCount = unitManager.CountUnitsInRegion(editor.TestRegion4)
      assert(unitCount == 1, "TestRegions4: Unit count not 1")

      local theUnit = unitManager.GetSingleUnitInRegionOrNil(editor.TestRegion4)
      assert(wc3api.IsUnitInRangeXY(theUnit, wc3api.GetRectCenterX(editor.TestRegion4), wc3api.GetRectCenterY(editor.TestRegion4), 10), "TestRegions4: Unit out of range")
    end
    TestRegions4()

    -- Editor prepares region to have many different players and units
    local function TestRegions5()
      local playerUnits = unitManager.CountUnitsPerPlayerInRegion(editor.TestRegion5)
      assert(playerUnits[wc3api.Player(0)] == 2, "TestRegions5: Red does not have 2 units")
      assert(playerUnits[wc3api.Player(1)] == 2, "TestRegions5: Blue does not have 2 units")
      assert(playerUnits[wc3api.Player(2)] == 2, "TestRegions5: Teal does not have 2 units")
      assert(playerUnits[wc3api.Player(3)] == 2, "TestRegions5: Purple does not have 2 units")
      assert(playerUnits[wc3api.Player(4)] == 2, "TestRegions5: Yellow does not have 2 units")
      assert(playerUnits[wc3api.Player(wc3api.GetPlayerNeutralPassive())] == 2, "TestRegions5: Neutral does not have 2 units")
    end
    TestRegions5()

    local function TestRegions6()
      local th = wc3api.CreateUnit(wc3api.Player(0),
                                     wc3api.FourCC("htow"),
                                     wc3api.GetRectCenterX(editor.TestRegion6),
                                     wc3api.GetRectCenterY(editor.TestRegion6),
                                     0)

      local newUnit = unitManager.ConvertUnitToOtherUnit(th, wc3api.FourCC("etol"))

      assert(wc3api.GetUnitTypeId(newUnit) == wc3api.FourCC("etol"), "TestRegion6: not tree of life")
      local g = wc3api.CreateGroup()
      wc3api.GroupEnumUnitsInRect(g, editor.TestRegion6, wc3api.constants.NO_FILTER)
      assert(wc3api.BlzGroupGetSize(g) == 1, "TestRegions6: Group size")
      assert(wc3api.BlzGroupUnitAt(g, 0) == newUnit, "TestRegions6: Wrong unit")
    end
    TestRegions6()

    return true
  end
  assert(TestRegions(), "Region tests did not finish.")

  debugTools.Display("Tests finished")
end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

