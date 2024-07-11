

function map.Game_Initialize()
  local wc3api = map.RealWc3Api_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local gameClock = map.GameClock_Create(wc3api, clock, commands)
end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

