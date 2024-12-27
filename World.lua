function map.World_Create(wc3api, players, commands)
  local world = {}

  world.rect = wc3api.GetWorldBounds()

  world.center = {}
  world.center.x = wc3api.GetRectCenterX(world.rect)
  world.center.y = wc3api.GetRectCenterY(world.rect)

  local displayWorldBoundsCommand = {}
  displayWorldBoundsCommand.activator = "-world"
  displayWorldBoundsCommand.users = players.ALL_PLAYERS
  function displayWorldBoundsCommand.Handler()
    local message = "Center: " .. "(" .. tostring(world.center.x) .. "," .. tostring(world.center.y) .. ")"
    wc3api.BJDebugMsg(message)
  end
  commands.Add(displayWorldBoundsCommand)

  return world
end
