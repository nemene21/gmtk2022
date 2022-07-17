
RADIO_IMAGE = newSpritesheet("data/graphics/images/radioSheet.png", 26, 18)

function newRadio(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processRadio,
        draw = drawRadio,

        held = false,

        playing = false,

        lastThrowSpeed = 0,

        voiceLineOn = 1,

        directionChanges = 999,

        animation = 0,

        voiceLines = {
            
            love.audio.newSource("data/sounds/SFX/radio/hello.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/pickle.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/differently.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/annoyances.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/noBattery.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/never.mp3", "stream")
        
        }

    }

end

function processRadio(radio)

    radio.playing = false
    for id, vl in ipairs(radio.voiceLines) do

        if vl:isPlaying() then radio.playing = true end

    end

    -- Move

    radio.verticalVel = radio.verticalVel + DICE_GRAVITY * dt * boolToInt(not radio.held) * 2

    radio.fakeVertical = radio.fakeVertical + radio.verticalVel * dt

    if radio.fakeVertical > 0 then -- Bounce

        radio.fakeVertical = -1

        if radio.verticalVel < 100 then -- Stop when too low
            
            radio.verticalVel = 0

        else

            shake(1, 1, 0.05)

        end

        radio.verticalVel = radio.verticalVel * - 0.4

    end

    if radio.directionChanges >= 4 and not radio.voiceLines[(radio.voiceLineOn - 1 + boolToInt(radio.voiceLineOn == 1))]:isPlaying() and won == nil then

        radio.directionChanges = 0

        radio.voiceLines[radio.voiceLineOn]:play()

        radio.voiceLineOn = radio.voiceLineOn + 1

        if radio.voiceLineOn > #radio.voiceLines then radio.voiceLineOn = radio.voiceLineOn - 1 end
    end

    if radio.animation ~= 0 or radio.playing then

        radio.animation = radio.animation + dt * 2

        radio.directionChanges = 0

        radio.playing = true

    end

    if radio.animation > 1 then radio.animation = 0 end

end

function drawRadio(radio)

    drawFrame(RADIO_IMAGE, 1 + math.ceil(7 * radio.animation), 1, radio.pos.x, radio.pos.y + math.floor(radio.fakeVertical))

    setColor(255, 255, 255)

end