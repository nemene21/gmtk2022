
function newDice(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processDice,
        draw = drawDice,

        held = false

    }

end

DICE_GRAVITY = 800

function processDice(dice)

    -- Move
    dice.pos.x = dice.pos.x + dice.vel.x * dt
    dice.pos.y = dice.pos.y + dice.vel.y * dt

    dice.verticalVel = dice.verticalVel + DICE_GRAVITY * dt * boolToInt(not dice.held)

    dice.fakeVertical = dice.fakeVertical + dice.verticalVel * dt

    if dice.fakeVertical > 0 then -- Bounce

        dice.fakeVertical = -1

        dice.verticalVel = dice.verticalVel * - 0.25

    end

end

function drawDice(dice)

    setColor(0, 0, 0, 100)
    love.graphics.circle("fill", dice.pos.x, dice.pos.y, 24)

    setColor(255, 255, 255)
    love.graphics.circle("fill", dice.pos.x, dice.pos.y + dice.fakeVertical, 24)

end