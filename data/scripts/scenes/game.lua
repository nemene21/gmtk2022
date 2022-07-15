
function gameReload()

    die = {newDice(400, 300)}

    diceTaken = nil

    lastDiceTakenPos = nil
    
end

function gameDie()
    
end

function game()
    -- Reset
    sceneAt = "game"
    
    setColor(255, 255, 255)
    clear(155, 155, 155)

    local kill = {}
    for id, dice in ipairs(die) do -- Process die

        dice:process()

    end die = wipeKill(kill, die)

    -- Die grabbing
    if mouseJustPressed(1) then

        local bestLen = 99999

        for id, dice in ipairs(die) do -- Find closest dice

            local diff = newVec(xM - dice.pos.x, yM - dice.pos.y)

            if diff:getLen() < bestLen then

                bestLen = diff:getLen()

                diceTaken = dice
                diceTaken.held = true

            end

        end

        if bestLen > 48 then diceTaken.held = false; diceTaken = nil end -- Set dice to nil if its too far

    end

    if not mousePressed(1) and diceTaken ~= nil then -- Reset grabbing if the dice is no longer held

        diceTaken.held = false

        diceTaken = nil

    end

    if diceTaken ~= nil then

        diceTaken.fakeVertical = lerp(diceTaken.fakeVertical, -64, dt * 10)

        lastDiceTakenPos = diceTaken.pos

        diceTaken.pos.x = lerp(diceTaken.pos.x, xM, dt * 20)
        diceTaken.pos.y = lerp(diceTaken.pos.y, yM, dt * 20)

        diceTaken.vel.x = diceTaken.vel.x + diceTaken.pos.x - lastDiceTakenPos.x
        diceTaken.vel.y = diceTaken.vel.y + diceTaken.pos.y - lastDiceTakenPos.y

    end

    for id, dice in ipairs(die) do -- Draw die

        dice:draw()

    end

    -- Return scene
    return sceneAt
end