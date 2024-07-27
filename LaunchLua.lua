function map.UnitTests()
  local testFramework = map.TestFramework_Create()
  map.Commands_Tests(testFramework)
  map.Utility_Tests(testFramework)
  map.Clock_Tests(testFramework)
  map.GameClock_Tests(testFramework)
  map.Players_Tests(testFramework)
  map.Logging_Tests(testFramework)
  map.Colors_Tests(testFramework)
  -- xpcall(testFramework.TestRunner, print)
  testFramework.TestRunner()
end

function map.LaunchLua()
  -- print("Map Start")
  -- map.UnitTests()
  xpcall(map.Game_Start, print)
  -- print("Map End")
end

map.UnitTests()


