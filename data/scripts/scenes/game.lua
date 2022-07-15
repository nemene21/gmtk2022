
function gameReload()

    die = {newDice(400, 300)}

    diceTaken = nil

    lastDiceTakenPos = nil

    money = 0

    diceTakenWay  = 0
    diceTakenTime = 0

    shadowSurface = love.graphics.newCanvas(800, 600)
    shadows = {}

    particleSystems = {}
    
end

function gameDie()
    
end

function game()
    -- Reset
    sceneAt = "game"
    
    setColor(255, 255, 255)
    clear(155, 155, 155)

    local kill = {}                                            -- Draw particles
    for id,P in ipairs(particleSystems) do
        P:process()

        if #P.particles == 0 and P.ticks == 0 and P.timer < 0 then table.insert(kill,id) end

    end particleSystems = wipeKill(kill,particleSystems)

    love.graphics.setShader(SHADERS.SHADOW)                    -- Draw shadows
    love.graphics.draw(shadowSurface)
    love.graphics.setShader()

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

        local speed = diceTaken.vel:getLen()

        local particles = newParticleSystem(xM, yM, deepcopyTable(DICE_THROW_PARTICLES))

        particles.rotation = diceTaken.vel:getRot()

        particles.particleData.width.a = particles.particleData.width.a * speed / 1500
        particles.particleData.width.b = particles.particleData.width.b * speed / 1500

        particles.particleData.speed.a = speed * love.math.random(20, 120) * 0.002
        particles.particleData.speed.b = speed * love.math.random(20, 120) * 0.002

        table.insert(particleSystems, particles)

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
    drawAllShadows()

    -- Return scene
    return sceneAt
end