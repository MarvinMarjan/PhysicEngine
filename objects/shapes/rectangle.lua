Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(world, x, y, width, height, color, state, id)
    local body = love.physics.newBody(world, x + width / 2, y + height / 2, state)
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(body, shape)
    fixture:setUserData(id)

    return setmetatable({
        width = width,
        height = height,

        body = body,
        shape = shape,
        fixture = fixture,
        color = color,

        type = "rectangle"
    }, Rectangle)
end

function Rectangle:draw()
    if self.color then
        love.graphics.setColor(self.color)
    end

    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Rectangle