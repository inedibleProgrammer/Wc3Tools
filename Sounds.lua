function map.Sounds_Create(wc3api)
  local sounds = {}

  -- TODO: Implement music and sounds using the wc3 sound api
  -- TODO: Add commands to get current music info

  sounds.music = {}

  sounds.victoryDialogSound = wc3api.CreateSoundFromLabel("QuestCompleted", false, false, false, 10000, 10000)
  sounds.music.tensionSong = wc3api.CreateSoundFromLabel("Tension", false, false, false, 10000, 10000)

  function sounds.PlayTension()
    wc3api.StartSound(sounds.music.tensionSong)
    wc3api.StartSound(sounds.victoryDialogSound)
  end

  return sounds
end
