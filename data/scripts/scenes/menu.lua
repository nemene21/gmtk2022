
function menuReload()

    PLAY_BUTTON = newButton(400, 300, "Play")

    HAND = newSpritesheet("data/graphics/images/hand.png", 16, 16)
    handAnim = 0
    
end

function menuDie()

end

function menu()
    -- Reset
    sceneAt = "menu"
    
    setColor(255, 255, 255)
    clear(155, 155, 155)

    if PLAY_BUTTON:process() then sceneAt = "game" end

    setColor(255, 255, 255)
    handAnim = lerp(handAnim, 0, rawDt * 12)

    if mouseJustPressed(1) then handAnim = 0.6 end

    drawFrame(HAND, 1 + boolToInt(not mousePressed(1)), 1, xM, yM, 1 - handAnim, 1 - handAnim)

    -- Return scene
    return sceneAt
end