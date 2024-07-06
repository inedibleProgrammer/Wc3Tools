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

