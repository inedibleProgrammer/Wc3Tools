function map.Sounds_Create(wc3api)
  local sounds = {}

  -- TODO: Implement music and sounds using the wc3 sound api
  -- TODO: Add commands to get current music info
  sounds.effects = {}

  sounds.effects.kidlaughing = wc3api.CreateSoundFromLabel("H01VillagerC37", false, false, false, 10000, 10000)

  sounds.music = {}

  sounds.victoryDialogSound = wc3api.CreateSoundFromLabel("QuestCompleted", false, false, false, 10000, 10000)
  sounds.music.tensionSong = wc3api.CreateSoundFromLabel("Tension", false, false, false, 10000, 10000)
  

  function sounds.PlayTension()
    wc3api.StartSound(sounds.music.tensionSong)
    -- wc3api.StartSound(sounds.victoryDialogSound)
    -- wc3api.StartSound(sounds.effects.kidlaughing)
  end

  function sounds.PlayKidLaughing()
    -- wc3api.StartSound(sounds.music.tensionSong)
    -- wc3api.StartSound(sounds.victoryDialogSound)
    wc3api.StartSound(sounds.effects.kidlaughing)
  end

  return sounds
end
