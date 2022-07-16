
FIRE_PARTICLES = loadJson("data/graphics/particles/fireParticles.json")
SMOKE_PARTICLES = loadJson("data/graphics/particles/smokeParticles.json")

function newFire(x, y)

    return {
        
        x = x, y = y,

        process = processFire,
        draw = drawFire,

        particles = newParticleSystem(x, y, deepcopyTable(FIRE_PARTICLES)),
        particlesSmoke = newParticleSystem(x, y, deepcopyTable(SMOKE_PARTICLES)),

        hp = 3

    }
end

function processFire(fire)

    fire.particles:process()
    fire.particlesSmoke:process()

    fire.particles.spawning = not fire.wet
    fire.particlesSmoke.spawning = not fire.wet

    fire.hp = fire.hp - dt * boolToInt(fire.wet)

end

function drawFire(fire)

end