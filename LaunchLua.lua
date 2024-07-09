function map.UnitTests()
  local testFramework = map.TestFramework_Create()
  map.Commands_Tests(testFramework)
  map.Utility_Tests(testFramework)
  xpcall(testFramework.TestRunner, print)
end

function map.LaunchLua()
  print("Map Start")
  map.UnitTests()
  map.Game_Start()
  print("Map End")
end

map.UnitTests()


