
function endScreenReload()
    
    TRY_AGAIN = newButton(400, 260, "Try Again")
    MENU = newButton(400, 340, "Menu")
    QUIT = newButton(400, 420, "Quit")

    BG = love.graphics.newImage("data/graphics/images/menuBackground.png")

    bgOffset = 0

    text = ""
    if won then

        text = "You won, the debt is gone!"

    else

        text = "You lost all your die..."

    end

end

function endScreenDie()

end

function endScreen()
    -- Reset
    sceneAt = "endScreen"

    bgOffset = bgOffset + dt * 100

    if bgOffset > 768 then bgOffset = bgOffset - 768 end
    
    setColor(120, 120, 120)

    drawSprite(BG, 400, 300 + bgOffset)
    drawSprite(BG, 400, 300 + bgOffset - 768)

    setColor(255, 255, 255)

    outlinedText(400, 80, 5, text, {255, 255, 255}, 3, 3)

    if TRY_AGAIN:process() then sceneAt = "game" end
    if MENU:process() then sceneAt = "menu" end
    if QUIT:process() then love.event.quit() end

    setColor(255, 255, 255)
    handAnim = lerp(handAnim, 0, rawDt * 12)

    if mouseJustPressed(1) then handAnim = 0.6 end

    drawFrame(HAND, 1 + boolToInt(not mousePressed(1)), 1, xM, yM, 1 - handAnim, 1 - handAnim)

    -- Return scene
    return sceneAt
end