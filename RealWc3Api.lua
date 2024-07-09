--luacheck: ignore

function map.RealWc3Api_Create()
  local realWc3Api = {}

  realWc3Api.constants = {}
  realWc3Api.constants.EXACT_MATCH = true
  realWc3Api.constants.NO_EXACT_MATCH = false

  function realWc3Api.CreateTrigger()
    local t = CreateTrigger()
    return t
  end

  return realWc3Api
end
