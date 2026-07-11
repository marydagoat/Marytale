-- intro.lua
local intro = {}

-- 1. Import Mary's module
local mary = require("mary")

function intro.load()
    -- 2. Tell Mary to load her images
    mary.load()
end

function intro.keypressed(key)
    -- 3. Pass key presses to Mary
    mary.handleKeyPress(key)
end

function intro.update(dt)
    -- 4. Let Mary update her position
    mary.update(dt)
end

function intro.draw()
    love.graphics.print("Intro Scene - Press Space to Start", 10, 10)

    -- 5. Draw Mary!
    mary.draw()
end

return intro