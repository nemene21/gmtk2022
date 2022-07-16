
DICE_IMAGE = newSpritesheet("data/graphics/images/dicesheet.png", 16, 16)
DICE_SHADOW_IMAGE = love.graphics.newImage("data/graphics/images/diceShadow.png")
DICE_GRAVITY = 1200

DICE_BOUNCE_PARTICLES = loadJson("data/graphics/particles/diceBounce.json")
DICE_THROW_PARTICLES  =  loadJson("data/graphics/particles/throwDice.json")

function newDice(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processDice,
        draw = drawDice,

        held = false,
        validForPoints = false,

        number = love.math.random(1, 6),

        bounceAnim = 0,

        lastThrowSpeed = 0,

        goodThrow = 1500,
        thrownGood = false

    }

end

function processDice(dice)

    -- Animation

    dice.bounceAnim = lerp(dice.bounceAnim, 0, dt * 14)

    -- Move
    dice.vel.x = lerp(dice.vel.x, 0, dt * boolToInt(not dice.held) * 3)
    dice.vel.y = lerp(dice.vel.y, 0, dt * boolToInt(not dice.held) * 3)
    
    dice.pos.x = dice.pos.x + dice.vel.x * dt
    dice.pos.y = dice.pos.y + dice.vel.y * dt

    dice.verticalVel = dice.verticalVel + DICE_GRAVITY * dt * boolToInt(not dice.held)

    if dice.held then dice.validForPoints = true end

    dice.fakeVertical = dice.fakeVertical + dice.verticalVel * dt

    if dice.fakeVertical > 0 then -- Bounce

        dice.fakeVertical = -1

        if dice.verticalVel < 100 then -- Stop when too low
            
            dice.verticalVel = 0
        
        end

        if dice.verticalVel > 160 then

            dice.number = love.math.random(1, 6)

            local particles = newParticleSystem(dice.pos.x, dice.pos.y, deepcopyTable(DICE_BOUNCE_PARTICLES))

            particles.rotation = love.math.random(0, 360)

            table.insert(particleSystems, particles)

            dice.bounceAnim = 0.6

            shake(1, 2, 0.1)
        else

            if dice.validForPoints then

                dice.validForPoints = false

                money = money + dice.number * (boolToInt(dice.thrownGood) + 1)

                moneyTextAnimation = 0.6

                local text = "+"..tostring(dice.number)

                if dice.thrownGood then text = text .. "x2" end

                addNewText(text, dice.pos.x, dice.pos.y - 36, {0, 255, 155 * boolToInt(not dice.thrownGood)}, 2)

            end

        end

        dice.verticalVel = dice.verticalVel * - 0.9

    end

end

function drawDice(dice)

    drawShadow(DICE_SHADOW_IMAGE, dice.pos.x, dice.pos.y, 1 - dice.bounceAnim, 1 + dice.bounceAnim)

    drawFrame(DICE_IMAGE, (6 - dice.number) + 1, 1, dice.pos.x, dice.pos.y + math.floor(dice.fakeVertical), 1 - dice.bounceAnim, 1 + dice.bounceAnim)

end