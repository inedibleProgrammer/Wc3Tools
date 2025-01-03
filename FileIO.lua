function map.FileIO_Create(wc3api)
  local fileIO = {}
  fileIO.name = ""
  fileIO.bufferedMessage = "\n"

  function fileIO.Init(filename)
    fileIO.name = filename
    wc3api.PreloadGenClear()
    wc3api.PreloadGenStart()
  end

  function fileIO.WriteLine(message)
    fileIO.bufferedMessage = fileIO.bufferedMessage .. message .. "\n"
  end

  function fileIO.Flush()
    wc3api.Preload(fileIO.bufferedMessage)
    wc3api.PreloadGenEnd(fileIO.name)
  end

  return fileIO
end


function map.FileIO_Tests(testFramework)
  testFramework.Suites.FileIOSuite = {}
  testFramework.Suites.FileIOSuite.Tests = {}
  local tsc = testFramework.Suites.FileIOSuite
  local wc3api = {}
  wc3api.constants = map.RealWc3Api_Create().constants

  function wc3api.PreloadGenClear() end
  function wc3api.PreloadGenStart() end
  function wc3api.Preload() end
  function wc3api.PreloadGenEnd() end

  function tsc.Setup() end
  function tsc.Teardown() end

  function tsc.Tests.DummyTest()
    assert(true)
  end

  function tsc.Tests.FileIOWrappedWithNewlines()
    local fileIO = map.FileIO_Create(wc3api)

    fileIO.Init("dummy.txt")
    fileIO.WriteLine("This is a test")

    assert(fileIO.bufferedMessage == "\nThis is a test\n")
  end
end
