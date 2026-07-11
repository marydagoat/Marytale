-- title.lua
local title = {}

-- Button configuration (Centered horizontally)
local button = {
    x = 0,             -- Will calculate dynamically in load based on window size
    y = 400,           -- Vertical position
    width = 200,
    height = 60,
    text = "PLAY"
}

function title.load()
    -- Dynamically center the button on the screen
    local windowWidth = love.graphics.getWidth()
    button.x = (windowWidth / 2) - (button.width / 2)
end

function title.update(dt)
    -- Optional: Add title screen animations or particle updates here later!
end

function title.draw()
    -- 1. Draw the Game Title
    love.graphics.setColor(1, 1, 1) -- White text
    local defaultFont = love.graphics.getFont()
    
    -- Large title text (using default font scaling if no custom font file exists)
    love.graphics.printf("MARYTALE", 0, 200, love.graphics.getWidth(), "center")
    
    -- 2. Draw the Play Button Background
    love.graphics.setColor(0.3, 0.1, 0.4) -- Dark Purple box
    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height, 10)
    
    -- 3. Draw the Play Button Text
    love.graphics.setColor(1, 1, 1) -- Reset to White for the button text
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