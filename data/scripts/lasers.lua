
LASER_SPEED = 50

function newLaser()

    return {

        x = - 80, y = 0,

        process = processLaser, draw = drawLaser,

        endPoint = newVec(x, y)

    }

end

function laserGetPos(item)

    return newVec(item.pos.x, item.pos.y + item.fakeVertical)

end

function laserGetRadius(item)
    
    return item.radius

end

function processLaser(laser)

    laser.x = laser.x + dt * LASER_SPEED

    object, laser.endPoint = castRay(newVec(laser.x, laser.y), newVec(laser.x, 700), items, laserGetPos, laserGetRadius)

    if object ~= nil then object.gettingHitByLaser = true end

end

function drawLaser(laser)

    love.graphics.line(laser.endPoint.x, laser.endPoint.y, laser.x, laser.y)

end