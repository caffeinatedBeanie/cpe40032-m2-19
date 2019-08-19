--[[
    Bird Class

    The Bird is what we control in the game via clicking or the space bar; whenever we press either,
    the bird will flap and go up a little bit, where it will then be affected by gravity. If the bird hits
    the ground or a pipe, the game is over.
]]

Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dy = 0
    ctrpressed = 0
end

--[[
    AABB collision that expects a pipe, which will have an X and Y and reference
    global pipe width and height values.
]]

function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end
        return false
end


function Bird:update(dt)
    if self.y <= 5 then
        self.dy = 1
    else
    self.dy = self.dy + GRAVITY * dt
    end

    if love.keyboard.wasPressed('space') then
        self.dy = -4
        ctrpressed = 0
        sounds['jump']:getVolume(1)
        sounds['jump']:play()
    end

    if love.mouse.isDown(1) then
        if ctrpressed == 0 then
            self.dy = -4
            sounds['jump']:getVolume(1)
            sounds['jump']:play()
        end
        ctrpressed = 1
    end
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function love.mousereleased( x, y, button)
    if button == 1 then
        ctrpressed = 0
    end
end