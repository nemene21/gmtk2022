
SPRSCL = 3

-- Spritesheets

function newSpritesheet(filename,w,h)
    local h = h or w
    local sheet = love.graphics.newImage(filename)
    local x = sheet:getWidth()/w; local y = sheet:getHeight()/h

    local images = {}
    for i=0,x do table.insert(images,{}) end

    for X=0,x do for Y=0,y do
        images[tostring(X+1)..","..tostring(Y+1)] = love.graphics.newQuad(X*w,Y*h,w,h,sheet)
    end end

    images.texture = sheet

    return images
end

function drawFrame(spritesheet,X,Y,x,y,sx,sy,r)
    local sx = sx or 1; local sy = sy or 1; local r = r or 0
    local quad = spritesheet[tostring(X)..","..tostring(Y)]
    qx, qy, qw, qh = quad:getViewport()
    love.graphics.draw(spritesheet.texture,quad,x-camera[1],y-camera[2],r,SPRSCL*sx,SPRSCL*sy,qw * 0.5, qh * 0.5)
end

-- Sprites

function drawSprite(tex,x,y,sx,sy,r,cx,cy)
    local sx = sx or 1; local sy = sy or 1; local r = r or 0
    love.graphics.draw(tex,x-camera[1],y-camera[2],r,SPRSCL*sx,SPRSCL*sy,tex:getWidth()*(cx or 0.5),tex:getHeight()*(cy or 0.5))
end

-- Shadows
SHADOWS = {}

function drawShadow(tex,x,y,sx,sy,r)

    table.insert(SHADOWS, {

        texture = tex, x = x, y = y, scaleX = sx, scaleY = sy, rotation = r

    })

end

function drawAllShadows()

    love.graphics.setCanvas(shadowSurface)
    clear(255, 255, 255)

    for id, shadow in ipairs(SHADOWS) do

        setColor(0, 0, 0)
        drawSprite(shadow.texture, shadow.x - 6, shadow.y + 6, shadow.scaleX, shadow.scaleY, shadow.rotation)

    end

    SHADOWS = {}

    setColor(255, 255, 255)
    love.graphics.setCanvas(display)

end