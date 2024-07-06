function map.UnitTests()
  local testFramework = map.TestFramework_Create()
  map.Commands_Tests(testFramework)
  xpcall(testFramework.TestRunner, print)
end

function map.LaunchLua()
  print("Map Start")
  map.UnitTests()
  print("Map End")
end

map.UnitTests()


