function map.Triggers_Create(wc3api)
  local triggers = {}


  function triggers.CreatePeriodicTrigger(period, action)
    local periodicTrigger = {}

    periodicTrigger.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(periodicTrigger.trigger, action)
    wc3api.TriggerRegisterTimerEvent(periodicTrigger.trigger, period, wc3api.constants.IS_PERIODIC)

    return periodicTrigger
  end

  return triggers
end
