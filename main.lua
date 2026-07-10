--load everything
function love.load()
    -- Load the image file
    playerSprite = love.graphics.newImage("placeholder.jpg")
    
    -- coords
    playerX = 100
    playerY = 100

    -- Player speed
    playerSpeed = 900

end

-- handles game updates
function love.update(dt)
    -- movement keys

    --left and right keys
    if love.keyboard.isDown("right") then
        playerX = playerX + playerSpeed * dt
    elseif love.keyboard.isDown("left") then
        playerX = playerX - playerSpeed * dt
    end
   -- up down 
    if love.keyboard.isDown("down") then
        playerY = playerY + playerSpeed * dt
    elseif love.keyboard.isDown("up") then
        playerY = playerY - playerSpeed * dt
    end

end

-- draws things every frame
function love.draw()
    -- load sprite where needed
    love.graphics.draw(playerSprite, playerX, playerY, rotation, scaleX, scaleY)
    -- player scale
    local rotation = 0
    local playerX = 0.5
    local playerY = 0.5
end


