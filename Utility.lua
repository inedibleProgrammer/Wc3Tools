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

