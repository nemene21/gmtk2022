
DICE_IMAGE = newSpritesheet("data/graphics/images/dicesheet.png", 14, 14)
DICE_GRAVITY = 1200

function newDice(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processDice,
        draw = drawDice,

        held = false,

        number = love.math.random(1, 6)

    }

end

function processDice(dice)

    -- Move
    dice.pos.x = dice.pos.x + dice.vel.x * dt
    dice.pos.y = dice.pos.y + dice.vel.y * dt

    dice.verticalVel = dice.verticalVel + DICE_GRAVITY * dt * boolToInt(not dice.held)

    dice.fakeVertical = dice.fakeVertical + dice.verticalVel * dt

    if dice.fakeVertical > 0 then -- Bounce

        dice.fakeVertical = -1

        if dice.verticalVel < 80 then dice.verticalVel = 0 end -- Stop when too low

        dice.verticalVel = dice.verticalVel * - 0.8

    end

end

function drawDice(dice)

    setColor(0, 0, 0, 100)
    love.graphics.circle("fill", dice.pos.x, dice.pos.y, 24)

    setColor(255, 255, 255)
    drawFrame(DICE_IMAGE, dice.number - 1, 0, dice.pos.x, dice.pos.y + math.floor(dice.fakeVertical))

end