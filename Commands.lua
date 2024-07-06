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


