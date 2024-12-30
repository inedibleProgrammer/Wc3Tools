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

  function utility.TableMerge(t1, t2)
    local t3 = {}
    for k,v in ipairs(t1) do
      table.insert(t3, v)
    end
    for k,v in ipairs(t2) do
      table.insert(t3, v)
    end
    return t3
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
    local dummyString = "This is a test 113."
    local splitString = utility.Split(dummyString)

    assert(#splitString == 5)
    assert(table.remove(splitString) == "113.")
    assert(table.remove(splitString) == "test")
    assert(table.remove(splitString) == "a")
    assert(table.remove(splitString) == "is")
    assert(table.remove(splitString) == "This")
  end

  function tsu.Tests.MergeTest()
    local t1 = {}
    t1[1] = "first"
    t1[2] = "second"
    local t2 = {}
    t2[1] = "third"
    t2[2] = "fourth"

    local utility = map.Utility_Create()

    local t3 = utility.TableMerge(t1, t2)
    assert(t3[1] == "first")
    assert(t3[2] == "second")
    assert(t3[3] == "third")
    assert(t3[4] == "fourth")
  end
end

