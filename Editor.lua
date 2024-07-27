--luacheck: push ignore

function map.Editor_Create()
  local editor = {}

  editor.testcop = gg_rct_testcop
  editor.startRect = gg_rct_startRect

  return editor
end

--luacheck: pop
