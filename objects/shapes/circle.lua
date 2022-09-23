Circle = {}
Circle.__index = Circle

function Circle:new(world, x, y, radius, color, state, id)
    local body = love.physics.newBody(world, x, y, state)
    local shape = love.physics.newCircleShape(radius)
    local fixture = love.physics.newFixture(body, shape)
    fixture:setUserData(id)

    return setmetatable({
        radius = radius,

        body = body,
        shape = shape,
        fixture = fixture,
        color = color,

        type = "circle"
    }, Circle)
end

function Circle:draw()
    if self.color then
        love.graphics.setColor(self.color)
    end
    
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

return Circle