
SLOT_IMAGE = love.graphics.newImage("data/graphics/images/slot.png")

function newSlot(x, y, item, price)

    item.pos.x = x; item.pos.y = y

    return {

        x = x, y = y, item = item,

        draw = drawSlot, process = processSlot,

        price = price,

        slotAnimation = 0

    }

end

function processSlot(slot)

    if xM > slot.x - 36 and xM < slot.x + 36 and yM > slot.y - 36 and yM < slot.y + 36 then

        slot.slotAnimation = lerp(slot.slotAnimation, 1, rawDt * 8)

    else

        slot.slotAnimation = lerp(slot.slotAnimation, 0, rawDt * 8)

    end

end

function drawSlot(slot)

    slot.item.pos.y = slot.y + (1 - shopOpenAnim) * 200

    drawSprite(SLOT_IMAGE, slot.x, slot.y + (1 - shopOpenAnim) * 200, 1 + slot.slotAnimation * 0.2, 1 + slot.slotAnimation * 0.2)
    slot.item:draw()

end