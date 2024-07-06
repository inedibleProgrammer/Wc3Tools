Build = {}
Build.Combined = "Combined.lua"

Build.SourceFiles = {
  "Commands.lua",
  "TestFramework.lua",
  "LaunchLua.lua",
}

function main()
  local combined = io.open(Build.Combined, "w")
  combined:close()

  local combined = io.open(Build.Combined, "w+")
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
