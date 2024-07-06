gg_trg_LaunchLua = nil
function InitGlobals()
end

function Commands_Create()
  
end

function Commands_Tests(testFramework)
  testFramework.Suites.CommandsSuite = {}
  testFramework.Suites.CommandsSuite.Tests = {}
  local tsc = testFramework.Suites.CommandsSuite

  function tsc.Setup()
  end

  function tsc.Teardown()
  end

  function tsc.Tests.DummyTest()
    assert(true)
  end
end


function TestFramework_Create()
  local testFramework = {}
  testFramework.Suites = {}

  function testFramework.TestRunner()
    for k1, suite in pairs(testFramework.Suites) do
      for k2, test in pairs(suite.Tests) do
        suite.Setup()
        test()
        suite.Teardown()
      end
    end
  end

  return testFramework
end

--[[
-- Example Usage: 
print("Start")
dummyTestFramework = TestFramework_Create()
dummyTestFramework.Suites.Dummy = {}
dummyTestFramework.Suites.Dummy.Tests = {}

function dummyTestFramework.Suites.Dummy.Setup()
  print("Setup")
end

function dummyTestFramework.Suites.Dummy.Teardown()
  print("Teardown")
end

function dummyTestFramework.Suites.Dummy.Tests.FirstTest()
  print("First Test")
end

function dummyTestFramework.Suites.Dummy.Tests.SecondTest()
  print("Second Test")
end

dummyTestFramework.TestRunner()
print("End")
--]]

--[[

TestFramework = {}
TestFramework.Suites = {}


TestFramework.Suites.Dummy = {}
function TestFramework.Suites.Dummy.Setup()
  print("Setup")
end

function TestFramework.Suites.Dummy.Teardown()
  print("Teardown")
end

function TestFramework.Suites.Dummy.Tests.MyFirstTest()
  print("My First Test")
end

function TestFramework.Suites.Dummy.Tests.MySecondTest()
  print("My Second Test")
end


function TestFramework.Runner()
  for k1,suite in pairs(TestFramework.Suites) do
    print(suite)
    print(TestFramework.Suites.Dummy)
  end
end


TestFramework.Runner()


    for k2, test in pairs(suites.Tests) do
      print(test)
      -- xpcall(suites.Setup, print)
      -- xpcall(test, print)
      -- xpcall(suites.Teardown, print)
    end
]]

function UnitTests()
  local testFramework = TestFramework_Create()
  Commands_Tests(testFramework)
  testFramework.TestRunner()
end

function LaunchLua()
  print("Map Start")
end

UnitTests()



function Trig_LaunchLua_Actions()
    LaunchLua()
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
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
end

function main()
SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("CityScapeDay")
SetAmbientNightSound("CityScapeNight")
SetMapMusic("Music", true, 0)
InitBlizzard()
InitGlobals()
InitCustomTriggers()
RunInitializationTriggers()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(1)
SetTeams(1)
SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
DefineStartLocation(0, 2816.0, 1792.0)
InitCustomPlayerSlots()
SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
InitGenericPlayerSlots()
end

