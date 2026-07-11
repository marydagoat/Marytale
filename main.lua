-- main.lua

-- Require the intro file
local intro = require("intro")

function love.load()
    -- Initialize the intro scene
    intro.load()
end

function love.keypressed(key)
    -- Send keypress events to the intro scene
    intro.keypressed(key)
end

function love.update(dt)
    -- Update Mary's position in the intro scene
    intro.update(dt)
end

function love.draw()
    -- Draw the intro scene
    intro.draw()
    
end