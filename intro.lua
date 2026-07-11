local intro = {}

-- 1. Import Mary's module
local mary = require("mary")

local backgroundImage
-- Keep track of which room/scene number we are currently in
local currentRoom = 1 

function intro.load()
    -- 2. Tell Mary to load her images
    mary.load()

    -- Load the initial background
    backgroundImage = love.graphics.newImage("scenes/startofgame.png")
end

function intro.keypressed(key)
    -- 3. Pass key presses to Mary
    mary.handleKeyPress(key)
end

function intro.update(dt)
    -- 4. Let Mary update her position
    mary.update(dt)

    -- 5. Check if Mary walked off the bottom of the screen
    local screenHeight = love.graphics.getHeight()
    
    -- Assuming mary.y is how her module tracks her vertical position
    if mary.y > screenHeight then
        
        -- Reset Mary to the top of the screen (y = 0 or slightly below so she's visible)
        mary.y = 10 
        
        -- Advance to the next room
        currentRoom = currentRoom + 1
        
        -- Change the background image based on the room
        if currentRoom == 2 then
            backgroundImage = love.graphics.newImage("scenes/frame2start.png") -- Change to your second room image
        -- Add more rooms as needed!
        end
    end
end

function intro.draw()
    if backgroundImage then
        -- background scale
        local scaleX = 1.4
        local scaleY = 1.4

        -- Draw using the scale and offsets
        love.graphics.draw(backgroundImage, 250, 10, 0, scaleX, scaleY, offsetX, offsetY)
    end
    
    love.graphics.print("Current Room: " .. currentRoom, 10, 10)

    -- 6. Draw Mary!
    mary.draw()
end

return intro