Player = {}
Player.__index = Player

function Player:new(game, x, y, radius, speed, restitution, color, id)
    local body = love.physics.newBody(game, x, y, "dynamic")
    local shape = love.physics.newCircleShape(radius)
    local fixture = love.physics.newFixture(body, shape)
    
    fixture:setUserData(id)
    fixture:setRestitution(restitution)

    return setmetatable({
        body = body,
        shape = shape,
        fixture = fixture,
        speed = speed,
        color = color
    }, Player)
end

function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.body:applyForce(0, -self.speed)
    end
    if love.keyboard.isDown("a") then
        self.body:applyForce(-self.speed, 0)
    end
    if love.keyboard.isDown("s") then
        self.body:applyForce(0, self.speed)
    end
    if love.keyboard.isDown("d") then
        self.body:applyForce(self.speed, 0)
    end
end

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

return Player