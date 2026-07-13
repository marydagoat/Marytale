-- koyan.lua
local koyan = {}

-- All of koyans properties live inside this table now
koyan.x = 100
koyan.y = 100
koyan.speed = 400
koyan.direction = "down"

-- Target display height for koyan (adjust this to change her overall size in-game)
-- Originally, your scale was 0.7. If your walking sprites were around 250px tall, 
-- a target height of 175 matches that original scale.
koyan.targetHeight = 175 

-- Animation state variables
koyan.isMoving = false
koyan.animTimer = 0
koyan.animSpeed = 0.3 -- Lower = faster alternating footsteps
koyan.currentFrame = 1

-- This table will hold the nested frames
local sprites = {}

function koyan.load()
    -- Load koyan's sprites, inserting your new still frames as Frame 2 and Frame 4
    sprites = {
        up = { 
            love.graphics.newImage("sprites/walkback1K.png"),   -- Frame 1: Footsteps 1
            love.graphics.newImage("sprites/backspriteK.png"),  -- Frame 2: Still / Idle
            love.graphics.newImage("sprites/walkback2K.png"),   -- Frame 3: Footsteps 2
            love.graphics.newImage("sprites/backspriteK.png")   -- Frame 4: Still / Idle
        },
        down = { 
            love.graphics.newImage("sprites/walkfront1K.png"), 
            love.graphics.newImage("sprites/frontspriteK.png"), 
            love.graphics.newImage("sprites/walkfront2K.png"), 
            love.graphics.newImage("sprites/frontspriteK.png") 
        },
        left = { 
            love.graphics.newImage("sprites/leftwalk1K.png"), 
            love.graphics.newImage("sprites/leftspriteK.png"), 
            love.graphics.newImage("sprites/leftwalk2K.png"), 
            love.graphics.newImage("sprites/leftspriteK.png") 
        },
        right = { 
            love.graphics.newImage("sprites/rightwalk1K.png"), 
            love.graphics.newImage("sprites/rightspriteK.png"), 
            love.graphics.newImage("sprites/rightwalk2K.png"), 
            love.graphics.newImage("sprites/rightspriteK.png") 
        }
    }
end

function koyan.handleKeyPress(key)
    -- Keypress updates direction instantly for responsiveness
    if key == "w" then koyan.direction = "up"
    elseif key == "s" then koyan.direction = "down"
    elseif key == "a" then koyan.direction = "left"
    elseif key == "d" then koyan.direction = "right"
    end
end

function koyan.update(dt)
    koyan.isMoving = false

    -- Check movement and update position/direction continuously
    if love.keyboard.isDown("d") then
        koyan.x = koyan.x + koyan.speed * dt
        koyan.direction = "right"
        koyan.isMoving = true
    elseif love.keyboard.isDown("a") then
        koyan.x = koyan.x - koyan.speed * dt
        koyan.direction = "left"
        koyan.isMoving = true
    elseif love.keyboard.isDown("s") then
        koyan.y = koyan.y + koyan.speed * dt
        koyan.direction = "down"
        koyan.isMoving = true
    elseif love.keyboard.isDown("w") then
        koyan.y = koyan.y - koyan.speed * dt
        koyan.direction = "up"
        koyan.isMoving = true
    end

    -- 4-Frame Walking Animation Logic
    if koyan.isMoving then
        koyan.animTimer = koyan.animTimer + dt
        if koyan.animTimer >= koyan.animSpeed then
            koyan.animTimer = 0
            
            -- Cycle from 1 to 4, then loop back to 1
            koyan.currentFrame = koyan.currentFrame + 1
            if koyan.currentFrame > 4 then
                koyan.currentFrame = 1
            end
        end
    else
        -- When stopped, reset specifically to the STILL frame (Frame 2)
        koyan.currentFrame = 2
        koyan.animTimer = 0
    end
end

function koyan.draw()
    -- Pull the correct image out of the table based on direction and frame
    local activeSprite = sprites[koyan.direction][koyan.currentFrame]
    
    -- Dynamically calculate the scale factor based on the active image's height
    local spriteHeight = activeSprite:getHeight()
    local dynamicScale = koyan.targetHeight / spriteHeight
    
    -- Draw using the dynamically calculated scale so sizes always match perfectly
    love.graphics.draw(activeSprite, koyan.x, koyan.y, 0, dynamicScale, dynamicScale)
end

return koyan