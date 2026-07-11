-- mary.lua
local mary = {}

-- All of Mary's properties live inside this table now
mary.x = 100
mary.y = 100
mary.speed = 900
mary.direction = "down"
mary.scale = 0.1

-- These will hold her images
local left, right, back, front

function mary.load()
	-- Load Mary's sprites
	left = love.graphics.newImage("sprites/leftspriteM.png")
	right = love.graphics.newImage("sprites/rightspriteM.png")
	back = love.graphics.newImage("sprites/backspriteM.png")
	front = love.graphics.newImage("sprites/frontspriteM.png")

	-- Set the starting active sprite
	mary.sprite = front
end

function mary.handleKeyPress(key)
	if key == "w" then
		mary.sprite = back
		mary.direction = "up"
	elseif key == "s" then
		mary.sprite = front
		mary.direction = "down"
	elseif key == "a" then
		mary.sprite = left
		mary.direction = "left"
	elseif key == "d" then
		mary.sprite = right
		mary.direction = "right"
	end
end

function mary.update(dt)
	if love.keyboard.isDown("d") and mary.direction == "right" then
		mary.x = mary.x + mary.speed * dt
	elseif love.keyboard.isDown("a") and mary.direction == "left" then
		mary.x = mary.x - mary.speed * dt
	end

	if love.keyboard.isDown("s") and mary.direction == "down" then
		mary.y = mary.y + mary.speed * dt
	elseif love.keyboard.isDown("w") and mary.direction == "up" then
		mary.y = mary.y - mary.speed * dt
	end
end

function mary.draw()
	love.graphics.draw(mary.sprite, mary.x, mary.y, 0, mary.scale, mary.scale)
end

return mary
