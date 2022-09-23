Polygon = {}
Polygon.__index = Polygon

function Polygon:new(world, x, y, vertices, color, state, id)
    local body = love.physics.newBody(world, _, _, state)
    local shape = love.physics.newPolygonShape(vertices)
    local fixture = love.physics.newFixture(body, shape)
    fixture:setUserData(id)
    
    return setmetatable({
        vertices = vertices,

        body = body,
        shape = shape,
        fixture = fixture,
        color = color,

        type = "triangle"
    }, Polygon)
end

function Polygon:draw()
    if self.color then
        love.graphics.setColor(self.color)
    end

    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

return Polygon