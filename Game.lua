function map.Game_Initialize()
  local wc3api = map.RealWc3Api_Create()
  local commands = map.Commands_Create(wc3api)
  local clock = map.Clock_Create()
  local players = map.Players_Create(wc3api, commands)
  local gameClock = map.GameClock_Create(wc3api, clock, commands, players)
  local logging = map.Logging_Create(wc3api, gameClock, commands, players)

  local function testLogging()
    -- local masterLich = players.GetPlayerByName("MasterLich#11192")
    local worldEdit = players.GetPlayerByName("WorldEdit")

    -- logging.SetPlayerOptionByID(masterLich.id, logging.types.ALL)
    logging.SetPlayerOptionByID(worldEdit.id, logging.types.ALL)

    local function DumDum()
      local function DumDum2()
        local dumLog = {}
        dumLog.message = "This is a dummy"
        dumLog.type = logging.types.DEBUG
        logging.Write(dumLog)
      end
      xpcall(DumDum2, print)
    end

    local dummyTrigger = wc3api.CreateTrigger()
    wc3api.TriggerRegisterTimerEvent(dummyTrigger, 1.00, true)
    wc3api.TriggerAddAction(dummyTrigger, DumDum)
  end

  testLogging()

  local function testPlayers()
    for _,player in pairs(players.list) do
      print(player.id)
    end
  end

  -- testPlayers()

end



function map.Game_Start()
  xpcall(map.Game_Initialize, print)
end

