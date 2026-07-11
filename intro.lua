-- intro.lua
local intro = {}

-- Variables specific to the intro sequence / Mary
local playerSprite
local leftmary
local rightmary
local backmary
local frontmary
local playerX
local playerY
local playerSpeed
local direction
local playerScale

function intro.load()
    -- Load Mary's sprites
    playerSprite = love.graphics.newImage("sprites/frontspriteM.png")
    leftmary = love.graphics.newImage("sprites/leftspriteM.png")
    rightmary = love.graphics.newImage("sprites/rightspriteM.png")
    backmary = love.graphics.newImage("sprites/backspriteM.png")
    frontmary = love.graphics.newImage("sprites/frontspriteM.png")   
    
    -- Starting coordinates for the intro scene
    playerX = 100  
    playerY = 100

    -- Speed and scale
    playerSpeed = 900
    direction = "down"
    playerScale = 0.1
end

function intro.keypressed(key)
    -- Handle turning in the intro scene
    if key == "w" then
        playerSprite = backmary
        direction = "up"
    elseif key == "s" then
        playerSprite = frontmary
        direction = "down"
    elseif key == "a" then
        playerSprite = leftmary
        direction = "left"
    elseif key == "d" then
        playerSprite = rightmary
        direction = "right"
    end
end

function intro.update(dt)
    -- Handle walking in the intro scene
    if love.keyboard.isDown("d") and direction == "right" then
        playerX = playerX + playerSpeed * dt
    elseif love.keyboard.isDown("a") and direction == "left" then
        playerX = playerX - playerSpeed * dt
    end
    
    if love.keyboard.isDown("s") and direction == "down" then
        playerY = playerY + playerSpeed * dt
    elseif love.keyboard.isDown("w") and direction == "up" then
        playerY = playerY - playerSpeed * dt
    end
end

function intro.draw()
    -- Visuals for your intro
    love.graphics.print("Intro Scene - Press Space to Start", 10, 10)

    local rotation = 0
    love.graphics.draw(playerSprite, playerX, playerY, rotation, playerScale, playerScale)
end

return intro