Build = {}
Build.Combined = "Combined.lua"

MAP_VERSION = "Alpha"

Build.SourceFiles = {
  "Commands.lua",
  "TestFramework.lua",
  "LaunchLua.lua",
}

function createMapFile()
  local map_file_contents = "map = {}\n"
  local map_version = "map.version = " .. "\"" .. MAP_VERSION .. "\"\n"

  local handle = io.popen("git rev-parse HEAD")
  local git_commit = handle:read("*l")
  handle:close()

  local git_string = "map.commit = " .. "\"" .. git_commit .. "\"\n"

  map_file_contents = map_file_contents .. map_version .. git_string
  return map_file_contents
end

function main()
  local combined = io.open(Build.Combined, "w")
  combined:close()

  local combined = io.open(Build.Combined, "w+")

  local map_file_contents = createMapFile()
  combined:write(map_file_contents)

  for k1, filename in pairs(Build.SourceFiles) do
    file = io.open(filename, "r")
    file_contents = file:read("*a")
    combined:write(file_contents)
    file:close()
  end
  combined:close()
end

main()

--[[
function main()
  local combined = io.open(Build.Combined, "w")
  combined:close()

  local combined = io.open(Build.Combined, "w+")
  for k1, filename in pairs(Build.SourceFiles) do
    file = io.open(filename, "r")
    for line in file:lines() do
      combined:write(line)
    end
    file:close()
  end
  combined:close()
end


if pcall(getfenv, 4) then
  -- print("Library")
  return Build
else
  -- print("Main file")
  main()
end
--]]
