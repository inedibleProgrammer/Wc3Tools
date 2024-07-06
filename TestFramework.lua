function map.TestFramework_Create()
  local testFramework = {}
  testFramework.Suites = {}

  function testFramework.TestRunner()
    for _, suite in pairs(testFramework.Suites) do
      for _, test in pairs(suite.Tests) do
        suite.Setup()
        test()
        suite.Teardown()
      end
    end
  end

  return testFramework
end

