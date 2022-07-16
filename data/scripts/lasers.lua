
LASER_SPEED = 300

function newLaser()

    return {

        x = - 80, y = 0,

        process = processLaser, draw = drawLaser

    }

end

function processLaser()

    laser.x = laser.x + dt * LASER_SPEED

end

function drawLaser()

end