
BALLOON_IMAGE = love.graphics.newImage("data/graphics/images/waterBalloon.png")

BALLOON_DIE_PARTICLES = loadJson("data/graphics/particles/waterSplash.json")

function newWaterBalloon(x, y)

    return {

        pos = newVec(x, y),
        vel = newVec(0, 0),

        fakeVertical = 0,
        verticalVel  = 0,

        process = processWaterBalloon,
        draw = drawWaterBalloon,

        bounceAnim = 0,

        lastThrowSpeed = 0,

        goodThrow = 1200,
        thrownGood = false

    }

end

function processWaterBalloon(balloon)

    -- Animation

    balloon.bounceAnim = lerp(balloon.bounceAnim, 0, dt * 14)

    -- Move
    balloon.vel.x = lerp(balloon.vel.x, 0, dt * boolToInt(not balloon.held) * 3)
    balloon.vel.y = lerp(balloon.vel.y, 0, dt * boolToInt(not balloon.held) * 3)
    
    balloon.pos.x = balloon.pos.x + balloon.vel.x * dt
    balloon.pos.y = balloon.pos.y + balloon.vel.y * dt

    balloon.verticalVel = balloon.verticalVel + DICE_GRAVITY * dt * boolToInt(not balloon.held)

    if balloon.held then balloon.validForPoints = true end

    balloon.fakeVertical = balloon.fakeVertical + balloon.verticalVel * dt

    if balloon.fakeVertical > 0 then

        balloon.fakeVertical = 0
        balloon.verticalVel  = 0

        if balloon.thrownGood then

            balloon.dead = true

            local particles = deepcopyTable(BALLOON_DIE_PARTICLES)

            particles.rotation = balloon.vel:getRot()

            table.insert(particleSystems, newParticleSystem(balloon.pos.x, balloon.pos.y, particles))

            for id, fire in ipairs(fires) do

                if newVec(fire.x - balloon.pos.x, fire.y - balloon.pos.y):getLen() < 128 then

                    fire.wet = true

                end

            end

        end

    end

end

function drawWaterBalloon(balloon)

    drawShadow(BALLOON_IMAGE, balloon.pos.x, balloon.pos.y, 1 - balloon.bounceAnim, 1 + balloon.bounceAnim)

    drawSprite(BALLOON_IMAGE, balloon.pos.x, balloon.pos.y + math.floor(balloon.fakeVertical), 1 - balloon.bounceAnim, 1 + balloon.bounceAnim)

end