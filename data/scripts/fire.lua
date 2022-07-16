
FIRE_PARTICLES = loadJson("data/graphics/particles/fireParticles.json")
SMOKE_PARTICLES = loadJson("data/graphics/particles/smokeParticles.json")

FIRE_CIRCLE = love.graphics.newImage("data/graphics/images/fireCircle.png")

function newFire(x, y)

    return {
        
        x = clamp(x, 80, 720), y = clamp(y, 80, 520),

        process = processFire,
        draw = drawFire,

        particles = newParticleSystem(x, y, deepcopyTable(FIRE_PARTICLES)),
        particlesSmoke = newParticleSystem(x, y, deepcopyTable(SMOKE_PARTICLES)),

        hp = 3,

        spreadTimer = 5,

        animation = 0,

        wet = false

    }
end

function processFire(fire)

    fire.particles.spawning = not fire.wet
    fire.particlesSmoke.spawning = not fire.wet
    
    fire.animation = lerp(fire.animation, boolToInt(not fire.wet), dt * 5)

    fire.hp = clamp(fire.hp - dt * boolToInt(fire.wet), 0, 3)

    fire.spreadTimer = fire.spreadTimer - dt
    if fire.spreadTimer < 0 and #fires <= 10 and not fire.wet then

        fire.spreadTimer = 15

        table.insert(fires, newFire(fire.x + love.math.random(-128, 128), fire.y + love.math.random(-128, 128)))

    end

end

function drawFire(fire)

    setColor(255, 255, 255, 255 * fire.animation)
    drawSprite(FIRE_CIRCLE, fire.x, fire.y, 1 + math.sin(globalTimer) * 0.1, 1 + math.sin(globalTimer) * 0.1, (globalTimer * 15) / 180 * 3.14)

    fire.particles:process()
    fire.particlesSmoke:process()

end