
RADIO_IMAGE = newSpritesheet("data/graphics/images/radiosheet.png", 26, 18)

function newRadio(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processRadio,
        draw = drawRadio,

        held = false,

        lastThrowSpeed = 0,

        radius = 48,

        voiceLineOn = 1,

        directionChanges = 0,

        voiceLines = {
            
            love.audio.newSource("data/sounds/SFX/radio/hello.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/pickle.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/annoyances.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/noBattery.wav", "stream"),
            love.audio.newSource("data/sounds/SFX/radio/never.mp3", "stream")
        
        }

    }

end

function processRadio(radio)

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

    if radio.directionChanges >= 4 and not radio.voiceLines[(radio.voiceLineOn - 1 + boolToInt(radio.voiceLineOn == 1))]:isPlaying() then

        radio.directionChanges = 0

        radio.voiceLines[radio.voiceLineOn]:play()

        radio.voiceLineOn = radio.voiceLineOn + 1

        if radio.voiceLineOn > #radio.voiceLines then radio.voiceLineOn = radio.voiceLineOn - 1 end
    end

end

function drawRadio(radio)

    drawFrame(RADIO_IMAGE, 1, 1, radio.pos.x, radio.pos.y + math.floor(radio.fakeVertical))

    setColor(255, 255, 255)

end