Build = {}
Build.Combined = "Combined.lua"

MAP_VERSION = "Alpha"

Build.SourceFiles = {
  "Commands.lua",
  "Colors.lua",
  "TestFramework.lua",
  "Game.lua",
  "RealWc3Api.lua",
  "Editor.lua",
  "Utility.lua",
  "GameClock.lua",
  "Clock.lua",
  "Players.lua",
  "Logging.lua",
  "UnitManager.lua",
  "LaunchLua.lua", -- Must be last
}

function createMapFile()
  local mapFileContents = "map = {}\n"
  local mapVersion = "map.version = " .. "\"" .. MAP_VERSION .. "\"\n"

  local handle = io.popen("git rev-parse HEAD")
  local gitCommit = handle:read("*l")
  handle:close()

  local gitString = "map.commit = " .. "\"" .. gitCommit .. "\"\n"

  map_file_contents = mapFileContents .. mapVersion .. gitString
  return mapFileContents
end

function main()
  local combined = io.open(Build.Combined, "w")
  combined:close()

  local combined = io.open(Build.Combined, "w+")

  local mapFileContents = createMapFile()
  combined:write(mapFileContents)

  for k1, filename in pairs(Build.SourceFiles) do
    file = io.open(filename, "r")
    fileContents = file:read("*a")
    combined:write(fileContents)
    file:close()
  end
  combined:close()
end

main()
