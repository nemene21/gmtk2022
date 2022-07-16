
FIRE_PARTICLES = loadJson("data/graphics/particles/fireParticles.json")
SMOKE_PARTICLES = loadJson("data/graphics/particles/smokeParticles.json")

FIRE_CIRCLE = love.graphics.newImage("data/graphics/images/fireCircle.png")

function newFire(x, y)

    return {
        
        x = x, y = y,

        process = processFire,
        draw = drawFire,

        particles = newParticleSystem(x, y, deepcopyTable(FIRE_PARTICLES)),
        particlesSmoke = newParticleSystem(x, y, deepcopyTable(SMOKE_PARTICLES)),

        hp = 3,

        animation = 0

    }
end

function processFire(fire)

    fire.particles.spawning = not fire.wet
    fire.particlesSmoke.spawning = not fire.wet
    
    fire.animation = fire.animation + (boolToInt(not fire.wet) * 2 - 1) * 3

    fire.hp = fire.hp - dt * boolToInt(fire.wet)

end

function drawFire(fire)

    setColor(255, 255, 255, 255 * fire.animation)
    drawSprite(FIRE_CIRCLE, fire.x, fire.y, 1 + math.sin(globalTimer) * 0.1, 1 + math.sin(globalTimer) * 0.1, (globalTimer * 15) / 180 * 3.14)

    fire.particles:process()
    fire.particlesSmoke:process()

end