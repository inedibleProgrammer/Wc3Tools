--luacheck: push ignore

function map.RealWc3Api_Create()
  local realWc3Api = {}

  realWc3Api.constants = {}
  realWc3Api.constants.NO_FILTER = nil
  realWc3Api.constants.EXACT_MATCH = true
  realWc3Api.constants.NO_EXACT_MATCH = false

  realWc3Api.constants.WEAPON_INDEX_GROUND = 0
  realWc3Api.constants.WEAPON_INDEX_AIR = 1

  realWc3Api.constants.bj_FORCE_ALL_PLAYERS = nil
  realWc3Api.constants.EVENT_PLAYER_LEAVE = EVENT_PLAYER_LEAVE

  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_START = EVENT_PLAYER_UNIT_CONSTRUCT_START
  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL
  realWc3Api.constants.EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = EVENT_PLAYER_UNIT_CONSTRUCT_FINISH

  realWc3Api.constants.UNIT_TYPE_HERO = UNIT_TYPE_HERO
  realWc3Api.constants.UNIT_TYPE_DEAD = UNIT_TYPE_DEAD
  realWc3Api.constants.UNIT_TYPE_STRUCTURE = UNIT_TYPE_STRUCTURE
  realWc3Api.constants.UNIT_TYPE_FLYING = UNIT_TYPE_FLYING
  realWc3Api.constants.UNIT_TYPE_GROUND = UNIT_TYPE_GROUND
  realWc3Api.constants.UNIT_TYPE_ATTACKS_FLYING = UNIT_TYPE_ATTACKS_FLYING
  realWc3Api.constants.UNIT_TYPE_ATTACKS_GROUND = UNIT_TYPE_ATTACKS_GROUND
  realWc3Api.constants.UNIT_TYPE_MELEE_ATTACKER = UNIT_TYPE_MELEE_ATTACKER
  realWc3Api.constants.UNIT_TYPE_RANGED_ATTACKER = UNIT_TYPE_RANGED_ATTACKER
  realWc3Api.constants.UNIT_TYPE_GIANT = UNIT_TYPE_GIANT
  realWc3Api.constants.UNIT_TYPE_SUMMONED = UNIT_TYPE_SUMMONED
  realWc3Api.constants.UNIT_TYPE_STUNNED = UNIT_TYPE_STUNNED
  realWc3Api.constants.UNIT_TYPE_PLAGUED = UNIT_TYPE_PLAGUED
  realWc3Api.constants.UNIT_TYPE_SNARED = UNIT_TYPE_SNARED
  realWc3Api.constants.UNIT_TYPE_UNDEAD = UNIT_TYPE_UNDEAD
  realWc3Api.constants.UNIT_TYPE_MECHANICAL = UNIT_TYPE_MECHANICAL
  realWc3Api.constants.UNIT_TYPE_PEON = UNIT_TYPE_PEON
  realWc3Api.constants.UNIT_TYPE_SAPPER = UNIT_TYPE_SAPPER
  realWc3Api.constants.UNIT_TYPE_TOWNHALL = UNIT_TYPE_TOWNHALL
  realWc3Api.constants.UNIT_TYPE_ANCIENT = UNIT_TYPE_ANCIENT
  realWc3Api.constants.UNIT_TYPE_TAUREN = UNIT_TYPE_TAUREN
  realWc3Api.constants.UNIT_TYPE_POISONED = UNIT_TYPE_POISONED
  realWc3Api.constants.UNIT_TYPE_POLYMORPHED = UNIT_TYPE_POLYMORPHED
  realWc3Api.constants.UNIT_TYPE_SLEEPING = UNIT_TYPE_SLEEPING
  realWc3Api.constants.UNIT_TYPE_RESISTANT = UNIT_TYPE_RESISTANT
  realWc3Api.constants.UNIT_TYPE_ETHEREAL = UNIT_TYPE_ETHEREAL
  realWc3Api.constants.UNIT_TYPE_MAGIC_IMMUNE = UNIT_TYPE_MAGIC_IMMUNE

  realWc3Api.constants.UNIT_RF_HP = UNIT_RF_HP
  realWc3Api.constants.UNIT_RF_HIT_POINTS_REGENERATION_RATE = UNIT_RF_HIT_POINTS_REGENERATION_RATE
  realWc3Api.constants.UNIT_RF_MANA = UNIT_RF_MANA
  realWc3Api.constants.UNIT_RF_MANA_REGENERATION = UNIT_RF_MANA_REGENERATION

  realWc3Api.constants.UNIT_STATE_LIFE = UNIT_STATE_LIFE
  realWc3Api.constants.UNIT_STATE_MAX_LIFE = UNIT_STATE_MAX_LIFE
  realWc3Api.constants.UNIT_STATE_MANA = UNIT_STATE_MANA
  realWc3Api.constants.UNIT_STATE_MAX_MANA = UNIT_STATE_MAX_MANA

  realWc3Api.constants.PLAYER_STATE_RESOURCE_GOLD = PLAYER_STATE_RESOURCE_GOLD
  realWc3Api.constants.PLAYER_STATE_RESOURCE_LUMBER = PLAYER_STATE_RESOURCE_LUMBER

  realWc3Api.constants.PLAYER_SLOT_STATE_EMPTY = PLAYER_SLOT_STATE_EMPTY
  realWc3Api.constants.PLAYER_SLOT_STATE_PLAYING = PLAYER_SLOT_STATE_PLAYING
  realWc3Api.constants.PLAYER_SLOT_STATE_LEFT = PLAYER_SLOT_STATE_LEFT

  realWc3Api.constants.MAP_CONTROL_USER = MAP_CONTROL_USER
  realWc3Api.constants.MAP_CONTROL_COMPUTER = MAP_CONTROL_COMPU
  realWc3Api.constants.MAP_CONTROL_RESCUABLE = MAP_CONTROL_RESCU
  realWc3Api.constants.MAP_CONTROL_NEUTRAL = MAP_CONTROL_NEUTR
  realWc3Api.constants.MAP_CONTROL_CREEP = MAP_CONTROL_CREEP
  realWc3Api.constants.MAP_CONTROL_NONE = MAP_CONTROL_NONE

  realWc3Api.constants.ALLIANCE_SHARED_XP = ALLIANCE_SHARED_XP
  realWc3Api.constants.ALLIANCE_SHARED_SPELLS = ALLIANCE_SHARED_SPELLS
  realWc3Api.constants.ALLIANCE_SHARED_VISION = ALLIANCE_SHARED_VISION
  realWc3Api.constants.ALLIANCE_SHARED_CONTROL = ALLIANCE_SHARED_CONTROL
  realWc3Api.constants.ALLIANCE_SHARED_ADVANCED_CONTROL = ALLIANCE_SHARED_ADVANCED_CONTROL

  realWc3Api.constants.CAMERA_FIELD_TARGET_DISTANCE = CAMERA_FIELD_TARGET_DISTANCE

  function realWc3Api.BJDebugMsg(msg)
    return BJDebugMsg(msg)
  end

  function realWc3Api.CreateTrigger()
    return CreateTrigger()
  end

  function realWc3Api.DestroyTrigger(whichTrigger)
    return DestroyTrigger(whichTrigger)
  end

  function realWc3Api.TriggerSleepAction(timeout)
    return TriggerSleepAction(timeout)
  end

  function realWc3Api.Condition(func)
    return Condition(func)
  end

  function realWc3Api.DestroyCondition(c)
    return DestroyCondition(c)
  end

  function realWc3Api.Filter(func)
    return Filter(func)
  end

  function realWc3Api.DestroyFilter(f)
    return DestroyFilter(f)
  end

  function realWc3Api.DestroyBoolExpr(e)
    return DestroyBoolExpr(e)
  end

  function realWc3Api.TriggerRegisterUnitInRange(whichTrigger, whichUnit, range, filter)
    return TriggerRegisterUnitInRange(whichTrigger, whichUnit, range, filter)
  end

  function realWc3Api.TriggerRemoveCondition(whichTrigger, whichCondition)
    return TriggerRemoveCondition(whichTrigger, whichCondition)
  end

  function realWc3Api.TriggerClearConditions(whichTrigger)
    return TriggerClearConditions(whichTrigger)
  end

  function realWc3Api.TriggerRemoveAction(whichTrigger, whichAction)
    return TriggerRemoveAction(whichTrigger, whichAction)
  end

  function realWc3Api.TriggerClearActions(whichTrigger)
    return TriggerClearActions(whichTrigger)
  end

  function realWc3Api.TriggerSleepAction(timeout)
    return TriggerSleepAction(timeout)
  end

  function realWc3Api.TriggerWaitForSound(s, offset)
    return TriggerWaitForSound(s, offset)
  end

  function realWc3Api.TriggerExecute(whichTrigger)
    return TriggerExecute(whichTrigger)
  end

  function realWc3Api.TriggerEvaluate(whichTrigger)
    return TriggerEvaluate(whichTrigger)
  end

  function realWc3Api.TriggerExecuteWait(whichTrigger)
    return TriggerExecuteWait(whichTrigger)
  end

  function realWc3Api.TriggerSyncStart()
    return TriggerSyncStart()
  end

  function realWc3Api.TriggerSyncReady()
    return TriggerSyncReady()
  end

  function realWc3Api.TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
    return TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly)
  end

  function realWc3Api.TriggerRegisterPlayerEvent(whichTrigger, whichPlayer, whichPlayerEvent)
    return TriggerRegisterPlayerEvent(whichTrigger, whichPlayer, whichPlayerEvent)
  end

  function realWc3Api.TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter)
    return TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter)
  end

  function realWc3Api.GetEventPlayerChatString()
    return GetEventPlayerChatString()
  end

  function realWc3Api.Player(playerNum)
    return Player(playerNum)
  end

  function realWc3Api.TriggerAddAction(whichTrigger, actionFunc)
    return TriggerAddAction(whichTrigger, actionFunc)
  end

  function realWc3Api.TriggerRegisterTimerEvent(whichTrigger, timeout, periodic)
    return TriggerRegisterTimerEvent(whichTrigger, timeout, periodic)
  end

  function realWc3Api.DisplayTimedTextToPlayer(toPlayer, x, y, duration, message)
    return DisplayTimedTextToPlayer(toPlayer, x, y, duration, message)
  end

  function realWc3Api.DisplayTextToPlayer(toPlayer, x, y, message)
    return DisplayTextToPlayer(toPlayer, x, y, message)
  end

  function realWc3Api.GetPlayers()
    return GetPlayers()
  end

  function realWc3Api.GetBJMaxPlayers()
    return GetBJMaxPlayers()
  end

  function realWc3Api.GetPlayerId(whichPlayer)
    return GetPlayerId(whichPlayer)
  end

  function realWc3Api.GetPlayerName(whichPlayer)
    return GetPlayerName(whichPlayer)
  end

  function realWc3Api.GetPlayerRace(whichPlayer)
    return GetPlayerRace(whichPlayer)
  end

  function realWc3Api.GetPlayerTeam(whichPlayer)
    return GetPlayerTeam()
  end

  function realWc3Api.GetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting)
    return GetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting)
  end

  function realWc3Api.SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value)
    return SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value)
  end

  function realWc3Api.GetPlayerColor(whichPlayer)
    return GetPlayerColor(whichPlayer)
  end

  function realWc3Api.GetPlayerController(whichPlayer)
    return GetPlayerController(whichPlayer)
  end

  function realWc3Api.GetPlayerSlotState(whichPlayer)
    return GetPlayerSlotState(whichPlayer)
  end

  function realWc3Api.GetPlayerState(whichPlayer, whichPlayerState)
    return GetPlayerState(whichPlayer, whichPlayerState)
  end

  function realWc3Api.SetPlayerState(whichPlayer, whichPlayerState, value)
    return SetPlayerState(whichPlayer, whichPlayerState, value)
  end

  function realWc3Api.GetTriggerPlayer()
    return GetTriggerPlayer()
  end

  function realWc3Api.TriggerRegisterEnterRectSimple(trig, r)
    return TriggerRegisterEnterRectSimple(trig, r)
  end

  function realWc3Api.GetTriggerUnit()
    return GetTriggerUnit()
  end

  function realWc3Api.BlzSetUnitName(whichUnit, name)
    return BlzSetUnitName(whichUnit, name)
  end

  function realWc3Api.GetUnitName()
    return GetUnitName()
  end

  function realWc3Api.SetUnitMoveSpeed(whichUnit, newSpeed)
    return SetUnitMoveSpeed(whichUnit, newSpeed)
  end

  function realWc3Api.GetUnitMoveSpeed(whichUnit)
    return GetUnitMoveSpeed(whichUnit)
  end

  function realWc3Api.BlzGetUnitBooleanField(whichUnit, whichField)
    return BlzGetUnitBooleanField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitIntegerField(whichUnit, whichField)
    return BlzGetUnitIntegerField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitRealField(whichUnit, whichField)
    return BlzGetUnitRealField(whichUnit, whichField)
  end

  function realWc3Api.BlzGetUnitStringField(whichUnit, whichField)
    return BlzGetUnitStringField(whichUnit, whichField)
  end

  function realWc3Api.SetUnitState(whichUnit, whichUnitState, newVal)
    return SetUnitState(whichUnit, whichUnitState, newVal)
  end

  function realWc3Api.GetUnitState(whichUnit, whichUnitState)
    return GetUnitState(whichUnit, whichUnitState)
  end

  function realWc3Api.BlzSetUnitBooleanField(whichUnit, whichField, value)
    return BlzSetUnitBooleanField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitIntegerField(whichUnit, whichField, value)
    return BlzSetUnitIntegerField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitRealField(whichUnit, whichField, value)
    return BlzSetUnitRealField(whichUnit, whichField, value)
  end

  function realWc3Api.BlzSetUnitStringField(whichUnit, whichField, value)
    return BlzSetUnitStringField(whichUnit, whichField, value)
  end

  function realWc3Api.SetUnitState(whichUnit, whichUnitState, newVal)
    return SetUnitState(whichUnit, whichUnitState, newVal)
  end

  function realWc3Api.BlzGetUnitBaseDamage(whichUnit, weaponIndex)
    return BlzGetUnitBaseDamage(whichUnit, weaponIndex)
  end

  function realWc3Api.BlzGetUnitArmor(whichUnit)
    return BlzGetUnitArmor(whichUnit)
  end

  function realWc3Api.BlzSetUnitArmor(whichUnit, armorAmount)
    return BlzSetUnitArmor(whichUnit, armorAmount)
  end

  function realWc3Api.BlzUnitHideAbility(whichUnit, abilId, flag)
    return BlzUnitHideAbility(whichUnit, abilId, flag)
  end

  function realWc3Api.BlzUnitDisableAbility(whichUnit, abilId, flag, hideUI)
    return BlzUnitDisableAbility(whichUnit, abilId, flag, hideUI)
  end

  function realWc3Api.BlzUnitCancelTimedLife(whichUnit)
    return BlzUnitCancelTimedLife(whichUnit)
  end

  function realWc3Api.BlzIsUnitSelectable(whichUnit)
    return BlzIsUnitSelectable(whichUnit)
  end

  function realWc3Api.BlzIsUnitInvulnerable(whichUnit)
    return BlzIsUnitInvulnerable(whichUnit)
  end

  function realWc3Api.BlzUnitInterruptAttack(whichUnit)
    return BlzUnitInterruptAttack(whichUnit)
  end

  function realWc3Api.BlzGetUnitCollisionSize(whichUnit)
    return BlzGetUnitCollisionSize(whichUnit)
  end

  function realWc3Api.BlzGetAbilityManaCost(abilId, level)
    return BlzGetAbilityManaCost(abilId, level)
  end

  function realWc3Api.BlzGetAbilityCooldown(abilId, level)
    return BlzGetAbilityCooldown(abilId, level)
  end

  function realWc3Api.BlzSetUnitAbilityCooldown(whichUnit, abilId, level, cooldown)
    return BlzSetUnitAbilityCooldown(whichUnit, abilId, level, cooldown)
  end

  function realWc3Api.BlzGetUnitAbilityCooldown(whichUnit, abilId, level)
    return BlzGetUnitAbilityCooldown(whichUnit, abilId, level)
  end

  function realWc3Api.BlzGetUnitAbilityCooldownRemaining(whichUnit, abilId)
    return BlzGetUnitAbilityCooldownRemaining(whichUnit, abilId)
  end

  function realWc3Api.BlzEndUnitAbilityCooldown(whichUnit, abilCode)
    return BlzEndUnitAbilityCooldown(whichUnit, abilCode)
  end

  function realWc3Api.BlzStartUnitAbilityCooldown(whichUnit, abilCode, cooldown)
    return BlzStartUnitAbilityCooldown(whichUnit, abilCode, cooldown)
  end

  function realWc3Api.BlzGetUnitAbilityManaCost(whichUnit, abilId, level)
    return BlzGetUnitAbilityManaCost(whichUnit, abilId, level)
  end

  function realWc3Api.BlzSetUnitAbilityManaCost(whichUnit, abilId, level, manaCost)
    return BlzSetUnitAbilityManaCost(whichUnit, abilId, level, manaCost)
  end

  function realWc3Api.BlzSetUnitBaseDamage(whichUnit, baseDamage, weaponIndex)
    return BlzSetUnitBaseDamage(whichUnit, baseDamage, weaponIndex)
  end

  function realWc3Api.SetUnitPosition(whichUnit, newX, newY)
    return SetUnitPosition(whichUnit, newX, newY)
  end

  function realWc3Api.SetUnitScale(whichUnit, scaleX, scaleY, scaleZ)
    return SetUnitScale(whichUnit, scaleX, scaleY, scaleZ)
  end

  function realWc3Api.SetUnitVertexColor(whichUnit, red, green, blue, alpha)
    return SetUnitVertexColor(whichUnit, red, green, blue, alpha)
  end

  function realWc3Api.QueueUnitAnimation(whichUnit, whichAnimation)
    return QueueUnitAnimation(whichUnit, whichAnimation)
  end

  function realWc3Api.SetUnitAnimationByIndex(whichUnit, whichAnimation)
    return SetUnitAnimationByIndex(whichUnit, whichAnimation)
  end

  function realWc3Api.SetUnitAnimationWithRarity(whichUnit, whichAnimation, rarity)
    return SetUnitAnimationWithRarity(whichUnit, whichAnimation, rarity)
  end

  function realWc3Api.AddUnitAnimationProperties(whichUnit, animProperties, add)
    return AddUnitAnimationProperties(whichUnit, animProperties, add)
  end

  function realWc3Api.SetUnitLookAt(whichUnit, whichBone, lookAtTarget, offsetX, offsetY, offsetZ)
    return SetUnitLookAt(whichUnit, whichBone, lookAtTarget, offsetX, offsetY, offsetZ)
  end

  function realWc3Api.SetUnitRescuable(whichUnit, byWhichPlayer, flag)
    return SetUnitRescuable(whichUnit, byWhichPlayer, flag)
  end

  function realWc3Api.SetHeroStr(whichHero, newStr, permanent)
    return SetHeroStr(whichHero, newStr, permanent)
  end

  function realWc3Api.SetHeroAgi(whichHero, newAgi, permanent)
    return SetHeroAgi(whichHero, newAgi, permanent)
  end

  function realWc3Api.SetHeroInt(whichHero, newInt, permanent)
    return SetHeroInt(whichHero, newInt, permanent)
  end

  function realWc3Api.GetHeroStr(whichHero, includeBonuses)
    return GetHeroStr(whichHero, includeBonuses)
  end

  function realWc3Api.GetHeroAgi(whichHero, includeBonuses)
    return GetHeroAgi(whichHero, includeBonuses)
  end

  function realWc3Api.GetHeroInt(whichHero, includeBonuses)
    return GetHeroInt(whichHero, includeBonuses)
  end

  function realWc3Api.UnitStripHeroLevel(whichHero, howManyLevels)
    return UnitStripHeroLevel(whichHero, howManyLevels)
  end

  function realWc3Api.GetHeroXP(whichHero)
    return GetHeroXP(whichHero)
  end

  function realWc3Api.SetHeroXP(whichHero, newXpVal, showEyeCandy)
    return SetHeroXP(whichHero, newXpVal, showEyeCandy)
  end

  function realWc3Api.GetHeroSkillPoints(whichHero)
    return GetHeroSkillPoints(whichHero)
  end

  function realWc3Api.UnitModifySkillPoints(whichHero, skillPointDelta)
    return UnitModifySkillPoints(whichHero, skillPointDelta)
  end

  function realWc3Api.AddHeroXP(whichHero, xpToAdd, showEyeCandy)
    return AddHeroXP(whichHero, xpToAdd, showEyeCandy)
  end

  function realWc3Api.SetHeroLevel(whichHero, level, showEyeCandy)
    return SetHeroLevel(whichHero, level, showEyeCandy)
  end

  function realWc3Api.GetHeroLevel(whichHero)
    return GetHeroLevel(whichHero)
  end

  function realWc3Api.GetUnitLevel(whichUnit)
    return GetUnitLevel(whichUnit)
  end

  function realWc3Api.SuspendHeroXP(whichHero, flag)
    return SuspendHeroXP(whichHero, flag)
  end

  function realWc3Api.IsSuspendedXP(whichHero)
    return IsSuspendedXP(whichHero)
  end

  function realWc3Api.SelectHeroSkill(whichHero, abilcode)
    return SelectHeroSkill(whichHero, abilcode)
  end

  function realWc3Api.KillUnit(whichUnit)
    return KillUnit(whichUnit)
  end

  function realWc3Api.RemoveUnit(whichUnit)
    return RemoveUnit(whichUnit)
  end

  function realWc3Api.FourCC(typeId)
    return FourCC(typeId)
  end

  function realWc3Api.CreateUnitByName(whichPlayer, unitname, x, y, face)
    return CreateUnitByName(whichPlayer, unitname, x, y, face)
  end

  function realWc3Api.CreateUnit(id, unitid, x, y, face)
    return CreateUnit(id, unitid, x, y, face)
  end

  function realWc3Api.GetUnitAbilityLevel(whichUnit, abilcode)
    return GetUnitAbilityLevel(whichUnit, abilcode)
  end

  function realWc3Api.DecUnitAbilityLevel(whichUnit, abilcode)
    return DecUnitAbilityLevel(whichUnit, abilcode)
  end

  function realWc3Api.IncUnitAbilityLevel(whichUnit, abilcode)
    return IncUnitAbilityLevel(whichUnit, abilcode)
  end

  function realWc3Api.SetUnitAbilityLevel(whichUnit, abilcode, level)
    return SetUnitAbilityLevel(whichUnit, abilcode, level)
  end

  function realWc3Api.UnitAddAbility(whichUnit, abilityId)
    return UnitAddAbility(whichUnit, abilityId)
  end

  function realWc3Api.UnitRemoveAbility(whichUnit, abilityId)
    return UnitRemoveAbility(whichUnit, abilityId)
  end

  function realWc3Api.UnitMakeAbilityPermanent(whichUnit, permanent, abilityId)
    return UnitMakeAbilityPermanent(whichUnit, permanent, abilityId)
  end

  function realWc3Api.BlzGetUnitMaxMana(whichUnit)
    return BlzGetUnitMaxMana(whichUnit)
  end

  function realWc3Api.BlzSetUnitMaxMana(whichUnit, mana)
    return BlzSetUnitMaxMana(whichUnit, mana)
  end

  function realWc3Api.BlzSetUnitMaxHP(whichUnit, hp)
    return BlzSetUnitMaxHP(whichUnit, hp)
  end

  function realWc3Api.BlzGetUnitMaxHP(whichUnit)
    return BlzGetUnitMaxHP(whichUnit)
  end

  function realWc3Api.GetHeroProperName(whichHero)
    return GetHeroProperName(whichHero)
  end

  function realWc3Api.IsHeroUnitId(unitId)
    return IsHeroUnitId(unitId)
  end

  function realWc3Api.GetObjectName(objectId)
    return GetObjectName(objectId)
  end

  function realWc3Api.GetUnitTypeId(whichUnit)
    return GetUnitTypeId(whichUnit)
  end

  function realWc3Api.GetConstructingStructure()
    return GetConstructingStructure()
  end

  function realWc3Api.GetCancelledStructure()
    return GetCancelledStructure()
  end

  function realWc3Api.GetConstructedStructure()
    return GetConstructedStructure()
  end

  function realWc3Api.UnitSetConstructionProgress(whichUnit, constructionPercentage)
    return UnitSetConstructionProgress(whichUnit, constructionPercentage)
  end

  function realWc3Api.CreateGroup()
    return CreateGroup()
  end

  function realWc3Api.DestroyGroup(whichGroup)
    return DestroyGroup(whichGroup)
  end

  function realWc3Api.GroupAddUnit(whichGroup, whichUnit)
    return GroupAddUnit(whichGroup, whichUnit)
  end

  function realWc3Api.GroupRemoveUnit(whichGroup, whichUnit)
    return GroupRemoveUnit(whichGroup, whichUnit)
  end

  function realWc3Api.GroupClear(whichGroup)
    return GroupClear(WhichGroup)
  end

  function realWc3Api.ForGroup(whichGroup, callback)
    return ForGroup(whichGroup, callback)
  end

  function realWc3Api.GetEnumUnit()
    return GetEnumUnit()
  end

  function realWc3Api.GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter)
    return GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter)
  end

  function realWc3Api.GroupEnumUnitsInRect(whichGroup, r, filter)
    return GroupEnumUnitsInRect(whichGroup, r, filter)
  end

  function realWc3Api.GroupEnumUnitsInRange(whichGroup, x, y, radius, filter)
    return GroupEnumUnitsInRange(whichGroup, x, y, radius, filter)
  end

  function realWc3Api.GroupImmediateOrder(whichGroup, order)
    return GroupImmediateOrder(whichGroup, order)
  end

  function realWc3Api.IsUnitInRange(whichUnit, otherUnit, distance)
    return IsUnitInRange(whichUnit, otherUnit, distance)
  end

  function realWc3Api.IsUnitInRangeXY(whichUnit, x, y, distance)
    return IsUnitInRangeXY(whichUnit, x, y, distance)
  end

  function realWc3Api.GetUnitX(whichUnit)
    return GetUnitX(whichUnit)
  end

  function realWc3Api.GetUnitY(whichUnit)
    return GetUnitY(whichUnit)
  end

  function realWc3Api.GetUnitFacing(whichUnit)
    return GetUnitFacing(whichUnit)
  end

  function realWc3Api.GroupImmediateOrderById(whichGroup, order)
    return GroupImmediateOrderById(whichGroup, order)
  end

  function realWc3Api.GroupPointOrder(whichGroup, order, x, y)
    return GroupPointOrder(whichGroup, order, x, y)
  end

  function realWc3Api.GroupTargetOrderById(whichGroup, order, targetWidget)
    return GroupTargetOrderById(whichGroup, order, targetWidget)
  end

  function realWc3Api.GroupTargetOrder(whichGroup, order, targetWidget)
    return GroupTargetOrder(whichGroup, order, targetWidget)
  end

  function realWc3Api.Rect(minx, miny, maxx, maxy)
    return Rect(minx, miny, maxx, maxy)
  end

  function realWc3Api.RemoveRect(whichRect)
    return RemoveRect(whichRect)
  end

  function realWc3Api.SetRect(whichRect, minx, miny, maxx, maxy)
    return SetRect(whichRect, minx, miny, maxx, maxy)
  end

  function realWc3Api.GetRectCenterX(whichRect)
    return GetRectCenterX(whichRect)
  end

  function realWc3Api.GetRectCenterY(whichRect)
    return GetRectCenterY(whichRect)
  end

  function realWc3Api.GetRectMinX(whichRect)
    return GetRectMinX(whichRect)
  end

  function realWc3Api.GetRectMinY(whichRect)
    return GetRectMinY(whichRect)
  end

  function realWc3Api.GetRectMaxX(whichRect)
    return GetRectMaxX(whichRect)
  end

  function realWc3Api.GetRectMaxY(whichRect)
    return GetRectMaxY(whichRect)
  end

  function realWc3Api.CreateRegion()
    return CreateRegion()
  end

  function realWc3Api.RemoveRegion(whichRegion)
    return RemoveRegion(whichRegion)
  end

  function realWc3Api.RegionAddRect(whichRegion, r)
    return RegionAddRect(whichRegion, r)
  end

  function realWc3Api.GetWorldBounds()
    return GetWorldBounds()
  end

  function realWc3Api.PlayMusic(musicName)
    return PlayMusic(musicName)
  end

  function realWc3Api.PlayMusicEx(musicName, frommsecs, fadeinmsecs)
    return PlayMusicEx(musicName, frommsecs, fadeinmsecs)
  end

  function realWc3Api.StopMusic(fadeOut)
    return StopMusic(fadeOut)
  end

  function realWc3Api.ResumeMusic()
    return ResumeMusic()
  end

  function realWc3Api.PlayThematicMusic(musicFileName)
    return PlayThematicMusic(musicFileName)
  end

  function realWc3Api.PlayThematicMusicEx(musicFileName, frommsecs)
    return PlayThematicMusicEx(musicFileName, frommsecs)
  end

  function realWc3Api.EndThematicMusic()
    return EndThematicMusic()
  end

  function realWc3Api.SetCameraFieldForPlayer(whichPlayer, whichField, value, duration)
    return SetCameraFieldForPlayer(whichPlayer, whichField, value, duration)
  end

  function realWc3Api.MeleeStartingVisibility()
    return MeleeStartingVisibility()
  end

  function realWc3Api.MeleeStartingHeroLimit()
    return MeleeStartingHeroLimit()
  end

  function realWc3Api.MeleeGrantHeroItems()
    return MeleeGrantHeroItems()
  end
  

  return realWc3Api
end
--luacheck: pop

