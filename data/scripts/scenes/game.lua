
function gameReload()

    die = {newDice(400, 300)}

    diceTaken = nil

    lastDiceTakenPos = nil

    money = 0

    diceTakenWay  = 0
    diceTakenTime = 0
    
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

        diceTakenWay  = 0
        diceTakenTime = 0

        local bestLen = 99999

        for id, dice in ipairs(die) do -- Find closest dice

            local diff = newVec(xM - dice.pos.x, yM - dice.pos.y)

            if diff:getLen() < bestLen then

                bestLen = diff:getLen()

                diceTaken = dice
                diceTaken.held = true

            end

        end

        if bestLen > 48 then diceTaken.held = false; diceTaken = nil else 

            diceTaken.vel = newVec(0, 0)

            diceTaken.validForPoints = true

        end

    end

    if not mousePressed(1) and diceTaken ~= nil then -- Reset grabbing if the dice is no longer held

        diceTaken.held = false

        diceTaken.vel.x = (diceTaken.pos.x - lastDiceTakenPos.x) / dt
        diceTaken.vel.y = (diceTaken.pos.y - lastDiceTakenPos.y) / dt

        diceTaken = nil

    end

    if diceTaken ~= nil then

        diceTaken.fakeVertical = lerp(diceTaken.fakeVertical, -64, dt * 10)

        lastDiceTakenPos = newVec(diceTaken.pos.x, diceTaken.pos.y)

        diceTaken.pos.x = xM
        diceTaken.pos.y = yM

    end

    for id, dice in ipairs(die) do -- Draw die

        dice:draw()

    end

    processTextParticles()

    -- Return scene
    return sceneAt
end