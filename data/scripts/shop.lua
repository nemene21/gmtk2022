
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

        if mouseJustPressed(1) and money >= slot.price and won == nil then

            money = money - slot.price
            moneyTextAnimation = 0.6

            slot.slotAnimation = 2

            grabbedFromShop = true

            table.insert(items, deepcopyTable(slot.item))

            playSound("buy", love.math.random(80, 120) * 0.01)

        end

    else

        slot.slotAnimation = lerp(slot.slotAnimation, 0, rawDt * 8)

    end

end

function drawSlot(slot)

    slot.item.pos.y = slot.y + (1 - shopOpenAnim) * 200

    drawSprite(SLOT_IMAGE, slot.x, slot.y + (1 - shopOpenAnim) * 200, 1 + slot.slotAnimation * 0.2, 1 + slot.slotAnimation * 0.2)
    slot.item:draw()

    local canBuy = money >= slot.price

    outlinedText(slot.x + 16, slot.y + (1 - shopOpenAnim) * 200 + 24, 2, "$" .. tostring(slot.price), {255 * boolToInt(not canBuy), 255 * boolToInt(canBuy), 0})
    setColor(255, 255, 255)

end