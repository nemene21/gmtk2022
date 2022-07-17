
SOUNDS = {

throwItem = love.audio.newSource("data/sounds/SFX/throwItem.wav", "stream"),

diceBounce = love.audio.newSource("data/sounds/SFX/diceBounce.wav", "stream"),

pickUp = love.audio.newSource("data/sounds/SFX/pickUp.wav", "stream"),

itemDestroyed = love.audio.newSource("data/sounds/SFX/itemDestroyed.wav", "stream"),

waterBalloonDie = love.audio.newSource("data/sounds/SFX/waterBalloonDie.wav", "stream"),

buy = love.audio.newSource("data/sounds/SFX/buy.wav", "stream"),

diceDie = love.audio.newSource("data/sounds/SFX/diceDie.wav", "stream"),

laser = love.audio.newSource("data/sounds/SFX/laser.wav", "stream"),

earthquake = love.audio.newSource("data/sounds/SFX/earthquake.wav", "stream"),

loose = love.audio.newSource("data/sounds/SFX/loose.wav", "stream"),
win = love.audio.newSource("data/sounds/SFX/win.mp3", "stream"),

awesome = love.audio.newSource("data/sounds/SFX/voicelineAwesome.mp3", "stream"),
great = love.audio.newSource("data/sounds/SFX/voicelineGreat.mp3", "stream"),
exceptional = love.audio.newSource("data/sounds/SFX/voicelineExceptional.mp3", "stream")

}

FIRE_SOUND = love.audio.newSource("data/sounds/SFX/fire.wav", "stream")

MUSIC = {

gameplay = love.audio.newSource("data/sounds/music/gameplay.wav", "stream"),

shop = love.audio.newSource("data/sounds/music/shop.wav", "stream"),

menu = love.audio.newSource("data/sounds/music/menu.mp3", "stream")

}

MASTER_VOLUME = 1
SFX_VOLUME = 2
MUSIC_VOLUME = 1
trackPitch = 1
trackVolume = 1

SOUNDS_NUM_PLAYING = {}
for id,S in pairs(SOUNDS) do SOUNDS_NUM_PLAYING[id] = 0 end
    
SOUNDS_PLAYING = {}

TRACK_PLAYING = "NONE"
NEW_TRACK = "NONE"

trackTransition = 0
trackTransitionMax = 0

function playTrack(track, transition)

    if MUSIC[TRACK_PLAYING] ~= nil then MUSIC[TRACK_PLAYING]:stop() end

    TRACK_PLAYING = track

end

function playTrackButDontReset(track, transition)

    if MUSIC[TRACK_PLAYING] ~= nil then MUSIC[TRACK_PLAYING]:pause() end

    TRACK_PLAYING = track

end
    
function playSound(string, pitch, maxPlays, vol)
    if (maxPlays or 12) > SOUNDS_NUM_PLAYING[string]  then
        local pitch = pitch or 1
        local NEW_SOUND = SOUNDS[string]:clone(); NEW_SOUND:setPitch(pitch); NEW_SOUND:setVolume((vol or 1) * MASTER_VOLUME * SFX_VOLUME); NEW_SOUND:play()
        table.insert(SOUNDS_PLAYING,{NEW_SOUND, string})
        SOUNDS_NUM_PLAYING[string] = SOUNDS_NUM_PLAYING[string] + 1
    end
end

trackPitch = 0.8

function processSound()

    for id,S in ipairs(SOUNDS_PLAYING) do
        if not S[1]:isPlaying() then table.remove(SOUNDS_PLAYING,id); SOUNDS_NUM_PLAYING[S[2]] = SOUNDS_NUM_PLAYING[S[2]] - 1 end
    end

    if MUSIC[TRACK_PLAYING] ~= nil then
        
        if not MUSIC[TRACK_PLAYING]:isPlaying() then MUSIC[TRACK_PLAYING]:play() end
    end

end