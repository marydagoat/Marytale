-- title.lua
local title = {}

-- Variables for the title image
local titleImage
local titleX = 0
local titleY = 100

-- Button configuration (Centered horizontally)
local button = {
    x = 0,             -- Will calculate dynamically in load based on window size
    y = 450,           -- Lowered slightly to give the image more space
    width = 200,
    height = 60,
    text = "PLAY"
}

function title.load()
    -- 1. Load your title image (Change "sprites/title_logo.png" to match your actual filename)
    titleImage = love.graphics.newImage("sprites/MARYTALEgit.png")
    
    local windowWidth = love.graphics.getWidth()
    
    -- 2. Dynamically center the title image
    titleX = (windowWidth / 2) - (titleImage:getWidth() / 2)
    
    -- 3. Dynamically center the button on the screen
    button.x = (windowWidth / 2) - (button.width / 2)
end

function title.update(dt)
end

function title.draw()
    -- 1. Draw the Title Image
    love.graphics.setColor(1, 1, 1) -- Reset color to white so the image colors display perfectly
    love.graphics.draw(titleImage, titleX, titleY)
    
    -- 2. Draw the Play Button Background
    love.graphics.setColor(0.3, 0.1, 0.4) -- Dark Purple box
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height, 10)
    
    -- 3. Draw the Play Button Text
    love.graphics.setColor(1, 1, 1) -- White for the button text
    love.graphics.printf(button.text, button.x, button.y + (button.height / 2 - 8), button.width, "center")
end

function title.mousepressed(x, y, buttonType)
    -- Look specifically for a Left Click (represented as 1 in LÖVE)
    if buttonType == 1 then
        -- Check if the mouse cursor coordinates fall inside the button boundary box
        if x >= button.x and x <= button.x + button.width and
           y >= button.y and y <= button.y + button.height then
               
               -- Return the specific string your main.lua expects to trigger the scene transition
               return "play_clicked" 
        end
    end
    return nil
end

return title