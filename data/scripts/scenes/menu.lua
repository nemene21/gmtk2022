
function menuReload()

    PLAY_BUTTON = newButton(400, 260, "Play")
    QUIT = newButton(400, 340, "Quit")

    HAND = newSpritesheet("data/graphics/images/hand.png", 16, 16)
    handAnim = 0

    BG = love.graphics.newImage("data/graphics/images/menuBackground.png")

    bgOffset = 0

    TITLE = love.graphics.newImage("data/graphics/images/title.png")

    playTrack("menu")

end

function menuDie()

end

function menu()
    -- Reset
    sceneAt = "menu"

    bgOffset = bgOffset + dt * 100

    if bgOffset > 768 then bgOffset = bgOffset - 768 end
    
    setColor(120, 120, 120)

    drawSprite(BG, 400, 300 + bgOffset)
    drawSprite(BG, 400, 300 + bgOffset - 768)

    setColor(255, 255, 255)

    if PLAY_BUTTON:process() then sceneAt = "game" end

    if QUIT:process() then love.event.quit() end

    setColor(255, 255, 255)
    handAnim = lerp(handAnim, 0, rawDt * 12)

    if mouseJustPressed(1) then handAnim = 0.6 end

    drawFrame(HAND, 1 + boolToInt(not mousePressed(1)), 1, xM, yM, 1 - handAnim, 1 - handAnim)

    drawSprite(TITLE, 400, 80)

    -- Return scene
    return sceneAt
end