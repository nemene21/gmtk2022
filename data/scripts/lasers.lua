
LASER_SPEED = 50

LASER_SPRITE = love.graphics.newImage("data/graphics/images/laser.png")

LASER_PARTICLES = loadJson("data/graphics/particles/laserParticles.json")

LASER_SHOOTER_SPRITE = love.graphics.newImage("data/graphics/images/laserShooter.png")

function newLaser(x)

    return {

        x = - 80 + (x or 0), y = 32,

        process = processLaser, draw = drawLaser,

        endPoint = newVec(x, y),

        activeTimer = 0,

        particles = newParticleSystem(80, 0, deepcopyTable(LASER_PARTICLES)),

        particlesShoot = newParticleSystem(80, 0, deepcopyTable(LASER_PARTICLES))

    }

end

function laserGetPos(item)

    return newVec(item.pos.x, item.pos.y + item.fakeVertical)

end

function laserGetRadius(item)
    
    return item.radius + 12

end

function processLaser(laser)

    laser.activeTimer = laser.activeTimer - dt

    if laser.activeTimer < - 1.5 then laser.activeTimer = 1.5 end

    laser.x = laser.x + dt * LASER_SPEED

    object, laser.endPoint = castRay(newVec(laser.x, laser.y - 100), newVec(laser.x, 600), items, laserGetPos, laserGetRadius)

    if object ~= nil and laser.activeTimer > 0 then object.gettingHitByLaser = true end

end

function drawLaser(laser)

    drawSprite(LASER_SHOOTER_SPRITE, laser.x, laser.y, 1, 1, 0, 0.5, 1)

    laser.particles.x = laser.x
    laser.particles.y = laser.endPoint.y or 0

    laser.particles.spawning = laser.activeTimer > 0

    laser.particlesShoot.x = laser.x
    laser.particlesShoot.y = laser.y

    laser.particlesShoot.spawning = laser.activeTimer > 0

    if laser.activeTimer < 0 then

        local width = 48 * math.sin(laser.activeTimer / 1.5 * 3.14)
        setColor(255, 0, 0, 100)
        love.graphics.rectangle("fill", laser.x - width * 0.5, laser.y, width, 800, width * 0.5, width * 0.5)

    else

        setColor(255, 255, 255)
        drawSprite(LASER_SPRITE, laser.x, laser.y, math.sin(laser.activeTimer / 1.5 * 3.14), (laser.endPoint.y - laser.y) * 0.33, 0, 0.5, 0)

    end

    laser.particles:process()
    laser.particlesShoot:process()

    setColor(255, 255, 255)

end