
NAIL_IMAGE = love.graphics.newImage("data/graphics/images/nail.png")
NAIL_IN_IMAGE = love.graphics.newImage("data/graphics/images/nailIn.png")

function newNail(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processNail,
        draw = drawNail,

        held = false,

        lastThrowSpeed = 0,

        goodThrow = 1200,
        thrownGood = false,

        hp = 6,

        stabbed = false,

        isNail = true

    }

end

function processNail(nail)

    -- Move
    nail.vel.x = lerp(nail.vel.x, 0, dt * boolToInt(not nail.held) * 3)
    nail.vel.y = lerp(nail.vel.y, 0, dt * boolToInt(not nail.held) * 3)

    nail.verticalVel = nail.verticalVel + DICE_GRAVITY * dt * boolToInt(not nail.held)

    if nail.stabbed then

        if nail.held then nail.stabbed = false

        else

            nail.vel.x = 0; nail.vel.y = 0

            nail.verticalVel = 0

        end

    end
    
    nail.pos.x = nail.pos.x + nail.vel.x * dt
    nail.pos.y = nail.pos.y + nail.vel.y * dt

    nail.fakeVertical = nail.fakeVertical + nail.verticalVel * dt

    if nail.fakeVertical > 0 then -- Bounce

        if nail.thrownGood then nail.stabbed = true; nail.thrownGood = false
        
            table.insert(particleSystems, newParticleSystem(nail.pos.x, nail.pos.y, deepcopyTable(DICE_BOUNCE_PARTICLES)))
        
        end

        nail.fakeVertical = -1

        if nail.verticalVel < 100 then -- Stop when too low
            
            nail.verticalVel = 0
        
        end

        nail.verticalVel = nail.verticalVel * - 0.75

    end

    if nail.hp == 0 then nail.dead = true; table.insert(particleSystems, newParticleSystem(nail.pos.x, nail.pos.y + math.floor(nail.fakeVertical), deepcopyTable(ITEM_DIE_PARTICLES))) end

end

function drawNail(nail)

    if nail.stabbed then

        drawShadow(NAIL_IN_IMAGE, nail.pos.x, nail.pos.y)

        setColor(255, 255, 255)
        
        drawSprite(NAIL_IN_IMAGE, nail.pos.x, nail.pos.y + math.floor(nail.fakeVertical))

    else

        drawShadow(NAIL_IMAGE, nail.pos.x, nail.pos.y)

        setColor(255, 255, 255)
        
        drawSprite(NAIL_IMAGE, nail.pos.x, nail.pos.y + math.floor(nail.fakeVertical))

    end

end