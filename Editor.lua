--luacheck: push ignore

function map.Editor_Create()
  local editor = {}

  editor.TestRegion1 = gg_rct_TestRegion1
  editor.TestRegion2 = gg_rct_TestRegion2
  editor.TestRegion3 = gg_rct_TestRegion3
  editor.TestRegion4 = gg_rct_TestRegion4

  return editor
end

--luacheck: pop
