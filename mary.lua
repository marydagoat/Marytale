-- mary.lua
local mary = {}

-- All of Mary's properties live inside this table now
mary.x = 100
mary.y = 100
mary.speed = 800
mary.direction = "down"

-- Target display height for Mary (adjust this to change her overall size in-game)
-- Originally, your scale was 0.7. If your walking sprites were around 250px tall, 
-- a target height of 175 matches that original scale.
mary.targetHeight = 175 

-- Animation state variables
mary.isMoving = false
mary.animTimer = 0
mary.animSpeed = 0.3 -- Lower = faster alternating footsteps
mary.currentFrame = 1

-- This table will hold the nested frames
local sprites = {}

function mary.load()
    -- Load Mary's sprites, inserting your new still frames as Frame 2 and Frame 4
    sprites = {
        up = { 
            love.graphics.newImage("sprites/walkback1M.png"),   -- Frame 1: Footsteps 1
            love.graphics.newImage("sprites/backspriteM.png"),  -- Frame 2: Still / Idle
            love.graphics.newImage("sprites/walkback2M.png"),   -- Frame 3: Footsteps 2
            love.graphics.newImage("sprites/backspriteM.png")   -- Frame 4: Still / Idle
        },
        down = { 
            love.graphics.newImage("sprites/walkfront1M.png"), 
            love.graphics.newImage("sprites/frontspriteM.png"), 
            love.graphics.newImage("sprites/walkfront2M.png"), 
            love.graphics.newImage("sprites/frontspriteM.png") 
        },
        left = { 
            love.graphics.newImage("sprites/leftwalk1M.png"), 
            love.graphics.newImage("sprites/leftspriteM.png"), 
            love.graphics.newImage("sprites/leftwalk2M.png"), 
            love.graphics.newImage("sprites/leftspriteM.png") 
        },
        right = { 
            love.graphics.newImage("sprites/rightwalk1M.png"), 
            love.graphics.newImage("sprites/rightspriteM.png"), 
            love.graphics.newImage("sprites/rightwalk2M.png"), 
            love.graphics.newImage("sprites/rightspriteM.png") 
        }
    }
end

function mary.handleKeyPress(key)
    -- Keypress updates direction instantly for responsiveness
    if key == "w" then mary.direction = "up"
    elseif key == "s" then mary.direction = "down"
    elseif key == "a" then mary.direction = "left"
    elseif key == "d" then mary.direction = "right"
    end
end

function mary.update(dt)
    mary.isMoving = false

    -- Check movement and update position/direction continuously
    if love.keyboard.isDown("d") then
        mary.x = mary.x + mary.speed * dt
        mary.direction = "right"
        mary.isMoving = true
    elseif love.keyboard.isDown("a") then
        mary.x = mary.x - mary.speed * dt
        mary.direction = "left"
        mary.isMoving = true
    elseif love.keyboard.isDown("s") then
        mary.y = mary.y + mary.speed * dt
        mary.direction = "down"
        mary.isMoving = true
    elseif love.keyboard.isDown("w") then
        mary.y = mary.y - mary.speed * dt
        mary.direction = "up"
        mary.isMoving = true
    end

    -- 4-Frame Walking Animation Logic
    if mary.isMoving then
        mary.animTimer = mary.animTimer + dt
        if mary.animTimer >= mary.animSpeed then
            mary.animTimer = 0
            
            -- Cycle from 1 to 4, then loop back to 1
            mary.currentFrame = mary.currentFrame + 1
            if mary.currentFrame > 4 then
                mary.currentFrame = 1
            end
        end
    else
        -- When stopped, reset specifically to the STILL frame (Frame 2)
        mary.currentFrame = 2
        mary.animTimer = 0
    end
end

function mary.draw()
    -- Pull the correct image out of the table based on direction and frame
    local activeSprite = sprites[mary.direction][mary.currentFrame]
    
    -- Dynamically calculate the scale factor based on the active image's height
    local spriteHeight = activeSprite:getHeight()
    local dynamicScale = mary.targetHeight / spriteHeight
    
    -- Draw using the dynamically calculated scale so sizes always match perfectly
    love.graphics.draw(activeSprite, mary.x, mary.y, 0, dynamicScale, dynamicScale)
end

return mary