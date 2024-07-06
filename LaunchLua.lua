

function LaunchLua()

end

function UnitTests()
  local testFramework = TestFramework_Create()
  Commands_Tests(testFramework)
  testFramework.TestRunner()
end


UnitTests()


