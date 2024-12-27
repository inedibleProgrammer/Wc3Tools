function map.Triggers_Create(wc3api)
  local triggers = {}


  function triggers.CreatePeriodicTrigger(period, action)
    local periodicTrigger = {}

    periodicTrigger.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(periodicTrigger.trigger, action)
    wc3api.TriggerRegisterTimerEvent(periodicTrigger.trigger, period, wc3api.constants.IS_PERIODIC)

    -- TODO: Add a way to destroy/disable this trigger

    return periodicTrigger
  end

  function triggers.CreateTimedTrigger(time, action)
    local timedTrigger = {}

    local function ActionWithCleanup()
      action()
      wc3api.DestroyTrigger(timedTrigger.trigger)
    end

    timedTrigger.trigger = wc3api.CreateTrigger()
    wc3api.TriggerAddAction(timedTrigger.trigger, ActionWithCleanup)
    wc3api.TriggerRegisterTimerEvent(timedTrigger.trigger, time, wc3api.constants.IS_NOT_PERIODIC)

    return timedTrigger
  end

  return triggers
end
