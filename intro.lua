local intro = {}

-- 1. Import Mary's module
local mary = require("mary")

local backgroundImage
local treeLayerImage -- Variable to hold the foreground/extra tree layer
local currentRoom = 1 

-- We will calculate this dynamically when the room loads
local backgroundRightEdge = 1120 

function intro.load()
    -- 2. Tell Mary to load her images
    mary.load()

    -- Load the initial background
    backgroundImage = love.graphics.newImage("scenes/startofgame.png")
    treeLayerImage = nil -- No tree layer in room 1
end

function intro.keypressed(key)
    -- 3. Pass key presses to Mary
    mary.handleKeyPress(key)
end

function intro.update(dt)
    -- 4. Let Mary update her position
    mary.update(dt)

    local screenHeight = love.graphics.getHeight()

    -- ==========================================
    -- WALL BOUNDARIES FOR ROOMS 1, 2, & 3
    -- ==========================================
    if currentRoom == 1 then
        if mary.x < 300 then mary.x = 300 end
        if mary.x > 1120 then mary.x = 1120 end
        if mary.y < 120 then mary.y = 120 end
        
    elseif currentRoom == 2 then
        if mary.x < 300 then mary.x = 300 end
        -- REMOVED the hardcoded right wall constraint so she can reach the dynamic edge
        if mary.y < 120 then mary.y = 120 end
        if mary.y > 680 then mary.y = 680 end 

    elseif currentRoom == 3 then
        if mary.x < 300 then mary.x = 300 end 
        if mary.x > 1120 then mary.x = 1120 end 
        if mary.y < 120 then mary.y = 120 end
        if mary.y > 680 then mary.y = 680 end
    end
    -- ==========================================

    -- ==========================================
    -- ROOM TRANSITIONS
    -- ==========================================
    
    -- Transition 1 -> 2 (Walk off bottom)
    if currentRoom == 1 and mary.y > screenHeight then
        mary.y = 10 
        currentRoom = 2
        backgroundImage = love.graphics.newImage("scenes/frame2start.png")
        treeLayerImage = love.graphics.newImage("scenes/frame2starttrees.png") 
        
        -- Calculate exactly where the Room 2 drawing ends on the X axis:
        -- X Offset (250) + (Image Width * Scale of 1.4)
        backgroundRightEdge = 250 + (backgroundImage:getWidth() * 1.4)
    
    -- Transition 2 -> 3 (Walk to the exact edge of the artwork)
    elseif currentRoom == 2 and mary.x > backgroundRightEdge then
        mary.x = 310 -- Spawn her just inside Room 3's left wall boundary
        currentRoom = 3
        backgroundImage = love.graphics.newImage("scenes/NOTHINGYET .png") 
        treeLayerImage = nil 
    end
end

function intro.draw()
    local scaleX = 1.4
    local scaleY = 1.4

    -- 1. Draw the base background
    if backgroundImage then
        love.graphics.draw(backgroundImage, 250, 10, 0, scaleX, scaleY, offsetX, offsetY)
    end
    
    -- 2. Draw Mary
    mary.draw()

    -- 3. Draw the tree layer over everything else (Only for Room 2)
    if currentRoom == 2 and treeLayerImage then
        love.graphics.draw(treeLayerImage, 250, 10, 0, scaleX, scaleY, offsetX, offsetY)
    end
    
    love.graphics.print("Current Room: " .. currentRoom, 10, 10)
end

return intro