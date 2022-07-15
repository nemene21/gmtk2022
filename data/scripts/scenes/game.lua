
function gameReload()

    die = {newDice(400, 300)}

    diceTaken = nil
    
end

function gameDie()
    
end

function game()
    -- Reset
    sceneAt = "game"
    
    setColor(255, 255, 255)
    clear(155, 155, 155)

    local kill = {}
    for id, dice in iapirs(die) do -- Process die

        dice:process()

    end die = wipeKill(kill, die)

    -- Die grabbing
    if mouseJustPressed(1) then

        local bestLen = 99999

        for id, dice in iapirs(die) do -- Find closest dice

            local diff = newVec(xM - dice.pos.x, yM - dice.pos.y)

            if diff:getLen() < bestLen then

                bestLen = diff:getLen()

                diceTaken = dice

            end

        end

        if bestLen > 48 then diceTaken = nil end -- Set dice to nil if its too far

    end

    if not mousePressed(1) then diceTaken = nil end -- Reset grabbing if the dice is no longer held

    if diceTaken ~= nil then

        diceTaken.fakeVertical = lerp(diceTaken.fakeVertical, 48)

    end

    for id, dice in iapirs(die) do -- Draw die

        dice:draw()

    end

    -- Return scene
    return sceneAt
end