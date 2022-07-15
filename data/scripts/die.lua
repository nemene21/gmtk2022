
function newDice(x, y)

    return {

        pos = newVec(x, y),

        fakeVertical = 0,
        verticalVel  = 0,

        held = false

    }

end

DICE_GRAVITY = 300

function processDice(dice)

    dice.pos.x = dice.pos.x + dice.vel.x * dt
    dice.pos.y = dice.pos.y + dice.vel.y * dt

    dice.verticalVel = dice.verticalVel - DICE_GRAVITY * dt * boolToInt(dice.held)

    dice.fakeVertical = dice.fakeVertical + dice.verticalVel * dt

    if dice.fakeVertical < 0 then

        dice.fakeVertical = 0

        dice.verticalVel = dice.verticalVel * - 0.5

    end

end

function drawDice(dice)

    setColor(0, 0, 0, 100)
    love.graphics.circle("fill", dice.pos.x, dice.pos.y, 24)

    setColor(255, 255, 255)
    love.graphics.circle("fill", dice.pos.x, dice.pos.y + dice.fakeVertical, 24)

end