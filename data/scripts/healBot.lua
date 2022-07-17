
HEALERBOT_IMAGE = love.graphics.newImage("data/graphics/images/healerbot.png")
HEAL_CIRCLE_IMAGE = love.graphics.newImage("data/graphics/images/healCircle.png")

function newHealBot(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processHealBot,
        draw = drawHealBot,

        held = false,

        bounceAnim = 0,

        lastThrowSpeed = 0,

        goodThrow = 1000,
        thrownGood = false,

        healTimer = 0,

        movement = newVec(0, 0),
        moveTimer = 3,
        move = false,

        isHealer = true

    }

end

function processHealBot(bot)

    bot.moveTimer = bot.moveTimer - dt

    if bot.moveTimer < 0 then

        bot.movement = newVec(100, 0)
        
        bot.movement:rotate(love.math.random(0, 3) * 90)

        bot.move = not bot.move

        if move then

            bot.moveTimer = 2

        else

            bot.moveTimer = 4 + love.math.random(0, 2)

        end

    end

    bot.healTimer = bot.healTimer - dt

    if bot.healTimer < 0 then

        bot.healTimer = 2

        for id, item in ipairs(items) do

            if item.isDice then

                if newVec(item.pos.x - bot.pos.x, item.pos.y - bot.pos.y):getLen() < 148 then

                    item.hp = clamp(item.hp + 1, 0, 5)
                    item.bounceAnim = 0.4

                    item.healAnim = 0.4

                end

            end

        end

    end

    -- Move
    bot.vel.x = lerp(bot.vel.x, 0, dt * boolToInt(not bot.held) * 3)
    bot.vel.y = lerp(bot.vel.y, 0, dt * boolToInt(not bot.held) * 3)
    
    bot.pos.x = bot.pos.x + bot.vel.x * dt
    bot.pos.y = bot.pos.y + bot.vel.y * dt

    bot.pos.x = bot.pos.x + bot.movement.x * dt * boolToInt(bot.move)
    bot.pos.y = bot.pos.y + bot.movement.y * dt * boolToInt(bot.move)

    bot.verticalVel = bot.verticalVel + DICE_GRAVITY * dt * boolToInt(not bot.held)

    bot.fakeVertical = bot.fakeVertical + bot.verticalVel * dt

    if bot.fakeVertical > 0 then -- Bounce

        bot.fakeVertical = -1

        if bot.verticalVel < 100 then -- Stop when too low
            
            bot.verticalVel = 0
        
        end

        bot.verticalVel = bot.verticalVel * - 0.5

    end

    if bot.hp == 0 then bot.dead = true; table.insert(particleSystems, newParticleSystem(bot.pos.x, bot.pos.y + math.floor(bot.fakeVertical), deepcopyTable(ITEM_DIE_PARTICLES))) end

end

function drawHealBot(bot)

    drawShadow(HEALERBOT_IMAGE, bot.pos.x, bot.pos.y, 1 - bot.bounceAnim, 1 + bot.bounceAnim)

    setColor(255, 255, 255)

    if not bot.inShop then drawSprite(HEAL_CIRCLE_IMAGE, bot.pos.x, bot.pos.y, 1 + math.sin(globalTimer) * 0.1, 1 + math.sin(globalTimer) * 0.1, (globalTimer * 15) / 180 * 3.14) end

    drawSprite(HEALERBOT_IMAGE, bot.pos.x, bot.pos.y + math.floor(bot.fakeVertical), 1 - bot.bounceAnim, 1 + bot.bounceAnim)

end