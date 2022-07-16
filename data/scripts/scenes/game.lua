
function gameReload()

    items = {newDice(300, 300), newWaterBalloon(500, 300)}

    itemTaken = nil

    lastItemTakenPos = nil

    money = 0

    itemTakenWay  = 0
    itemTakenTime = 0

    shadowSurface = love.graphics.newCanvas(800, 600)
    shadows = {}

    particleSystems = {}

    moneyTextAnimation = 0

    TABLE_SPRITE = love.graphics.newImage("data/graphics/images/table.png")

    CHIP_SPRITE  = love.graphics.newImage("data/graphics/images/chip.png")

    HAND = newSpritesheet("data/graphics/images/hand.png", 16, 16)
    handAnim = 0

    events = {"fire", "earthquake", "laser"}

    fires = {}

    eventTimer = 20
    eventTimerMax = 30

    shopItems = {newSlot(80, 520, newDice(), 10), newSlot(160, 520, newWaterBalloon(), 10)}
    shopOpen = false
    shopOpenAnim = 0

    earthquakeTimer = 0
    earthquakeShakes = 0

    EARTHQUAKE_PARTICLES = loadJson("data/graphics/particles/earthquake.json")

    ITEM_DIE_PARTICLES = loadJson("data/graphics/particles/itemDie.json")

    grabbedFromShop = false

    lasers = {}

end

function gameDie()
    
end

function itemSort(i1, i2)
    return i1.pos.y < i2.pos.y
end

function game()

    -- Reset
    sceneAt = "game"
    
    setColor(255, 255, 255)
    love.graphics.setShader()
    
    -- Draw background
    drawSprite(TABLE_SPRITE, 400, 300)

    eventTimer = eventTimer - dt
    if eventTimer < 0 then                     -- Events

        eventTimer = eventTimerMax

        local event = events[love.math.random(1, #events)]

        if event == "fire" then

            table.insert(fires, newFire(love.math.random(64, 736), love.math.random(64, 536)))

        end

        if event == "earthquake" then

            earthquakeShakes = 8

            earthquakeTimer = 0

        end

    end

    local kill = {}                                            -- Draw particles
    for id,P in ipairs(particleSystems) do
        P:process()

        if #P.particles == 0 and P.ticks == 0 and P.timer < 0 then table.insert(kill,id) end

    end particleSystems = wipeKill(kill,particleSystems)

    love.graphics.setShader(SHADERS.SHADOW)                    -- Draw shadows
    love.graphics.draw(shadowSurface)
    love.graphics.setShader()

    setColor(255, 255, 255)

    table.sort(items, itemSort)

    local kill = {}
    for id, item in ipairs(items) do -- Process die

        item:process()

        item.pos.x = item.pos.x or 100
        item.pos.y = item.pos.y or 100

        if item.dead then table.insert(kill, id); playSound("itemDestroyed", love.math.random(80, 120) * 0.01)
        else if item.pos.x < -24 or item.pos.x > 824 or item.pos.y < -24 or item.pos.y > 624 then table.insert(kill, id); playSound("itemDestroyed", love.math.random(80, 120) * 0.01) end end

    end items = wipeKill(kill, items)

    -- Die grabbing
    if mouseJustPressed(1) and not shopOpen then

        itemTakenWay  = 0
        itemTakenTime = 0

        local bestLen = 99999

        for id, item in ipairs(items) do -- Find closest dice

            local diff = newVec(xM - item.pos.x, yM - item.pos.y)

            if diff:getLen() < bestLen then

                bestLen = diff:getLen()

                itemTaken = item

            end

        end

        if bestLen > 48 and itemTaken ~= nil then itemTaken.held = false; itemTaken = nil else 

            if itemTaken ~= nil then

                itemTaken.vel = newVec(0, 0)
                itemTaken.held = true

                playSound("pickUp", love.math.random(80, 120) * 0.01)

            end

        end

    end

    if (not mousePressed(1) and itemTaken ~= nil) or (shopOpen and itemTaken ~= nil and (not grabbedFromShop)) then -- Reset grabbing if the dice is no longer held

        grabbedFromShop = false
        itemTaken.held = false

        itemTaken.vel.x = (itemTaken.pos.x - lastitemTakenPos.x) / dt
        itemTaken.vel.y = (itemTaken.pos.y - lastitemTakenPos.y) / dt

        local speed = itemTaken.vel:getLen()

        itemTaken.lastThrowSpeed = speed

        if speed < 300 then

            playSound("pickUp", love.math.random(80, 120) * 0.01)

        else

            playSound("throwItem", love.math.random(80, 120) * 0.01)

        end

        local particles = newParticleSystem(xM, yM, deepcopyTable(DICE_THROW_PARTICLES))

        particles.rotation = itemTaken.vel:getRot()

        particles.particleData.width.a = particles.particleData.width.a * speed / 1500
        particles.particleData.width.b = particles.particleData.width.b * speed / 1500

        particles.particleData.speed.a = speed * love.math.random(20, 120) * 0.002
        particles.particleData.speed.b = speed * love.math.random(20, 120) * 0.002

        table.insert(particleSystems, particles)

        if itemTaken.goodThrow ~= nil then

            if itemTaken.goodThrow < speed then

                local messages = {"Awesome", "Great", "Exceptional"}

                addNewText(messages[love.math.random(1, #messages)], xM, yM - 24, {0, 255, 0})

                itemTaken.thrownGood = true

            end

        end

        itemTaken = nil

    end

    if itemTaken ~= nil then

        itemTaken.fakeVertical = lerp(itemTaken.fakeVertical, -64, dt * 10)

        lastitemTakenPos = newVec(itemTaken.pos.x, itemTaken.pos.y)

        itemTaken.pos.x = xM
        itemTaken.pos.y = yM

    end

    for id, item in ipairs(items) do -- Draw die

        setColor(255, 255, 255)
        item:draw()

    end

    local kill = {}
    for id, fire in ipairs(fires) do -- Bad events

        fire:process()
        fire:draw()

        if fire.hp <= 0 then

            table.insert(kill, id)

        end

    end fires = wipeKill(kill, fires)

    setColor(255, 255, 255)

    earthquakeTimer = earthquakeTimer - dt

    if earthquakeTimer < 0 and earthquakeShakes > 0 then
        
        shake(8, 2, 0.15)

        earthquakeTimer = 1

        earthquakeShakes = earthquakeShakes - 1

        for id, item in ipairs(items) do

            local vel = newVec(love.math.random(200, 400))

            vel:rotate(love.math.random(0, 360))

            item.vel = vel

            item.verticalVel = love.math.random(300, 400)

            if item.fakeVertical > -1 then item.fakeVertical = -1 end

            table.insert(particleSystems, newParticleSystem(400, 300, deepcopyTable(EARTHQUAKE_PARTICLES)))

        end

    end

    moneyTextAnimation = lerp(moneyTextAnimation, 0, rawDt * 10)

    drawSprite(CHIP_SPRITE, 64, 64 + math.sin(globalTimer * 2) * 8, 1 - moneyTextAnimation, 1 + moneyTextAnimation)
    outlinedText(112, 64 + math.sin(globalTimer * 2 + 0.8) * 8, 3, tostring(money), {255, 255, 255}, 2 - moneyTextAnimation * 2, 2 + moneyTextAnimation * 2, 0)

    processTextParticles()
    drawAllShadows()

    if justPressed("space") then shopOpen = not shopOpen end

    if shopOpen then

        shopOpenAnim = lerp(shopOpenAnim, 1, rawDt * 10)

        timeScale = 1 - shopOpenAnim
        if timeScale < 0.05 then timeScale = 0 end

    else

        shopOpenAnim = lerp(shopOpenAnim, 0, rawDt * 10)

        timeScale = 1 - shopOpenAnim

    end

    if shopOpenAnim > 0.02 then

        love.graphics.setColor(0, 0, 0, shopOpenAnim * 0.5)
        love.graphics.rectangle("fill", 0, 0, 800, 600)

        setColor(255, 255, 255)

        for id, slot in ipairs(shopItems) do
            
            slot:process()
            slot:draw()

        end

    end

    setColor(255, 255, 255)
    handAnim = lerp(handAnim, 0, rawDt * 12)

    if mouseJustPressed(1) then handAnim = 0.6 end

    drawFrame(HAND, 1 + boolToInt(not mousePressed(1)), 1, xM, yM, 1 - handAnim, 1 - handAnim)

    -- Return scene
    return sceneAt
end