-- main.lua

-- Require the scene files
local intro = require("intro")
local mary = require("mary")
local conf = require("conf")
local title = require("title") -- This is your title screen module

-- Track the current game state ("title" or "intro")
local gameState = "title"

function love.load()
    -- Initialize the title screen if it has a load function
    if title.load then
        title.load()
    end
    
    -- Initialize the intro scene
    intro.load()
end

function love.keypressed(key)
    -- Only send keypress events to the intro scene if we are actively playing it
    if gameState == "intro" then
        intro.keypressed(key)
    end
end

function love.mousepressed(x, y, button)
    -- If we are on the title screen, check for menu clicks
    if gameState == "title" then
        if title.mousepressed then
            local action = title.mousepressed(x, y, button)
            -- If your title screen button returns "play_clicked", switch to the intro
            if action == "play_clicked" then
                gameState = "intro"
            end
        end
    end
end

function love.update(dt)
    -- Update the active scene based on the current game state
    if gameState == "title" then
        if title.update then
            title.update(dt)
        end
    elseif gameState == "intro" then
        intro.update(dt)
    end
end

function love.draw()
    -- Draw the active scene based on the current game state
    if gameState == "title" then
        title.draw()
    elseif gameState == "intro" then
        intro.draw()
    end
end