require "engine/shape/shape_preview"
require "engine/shape/shape_drawing"

require "engine/util"

require "objects/object_common"

objects = require "engine/objects_handle"

Engine = {}
Engine.__index = Engine

local pressed = false

local x, y, width, height = nil
local vertices = {}

objects = Objects:new()

function Engine:new(meter, horizontalGravity, verticalGravity)
    love.physics.setMeter(meter) -- Create a world

    world = love.physics.newWorld(horizontalGravity, verticalGravity, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    return setmetatable({
        world = world,
        meter = meter,

        preview = nil,

        globalColor = {1, 1, 1, 1},
        currentShape = nil,
        currentState = "static"
    }, Engine)
end

function Engine:update(dt, sett_gui)
    local r, g, b, a = nuklear.colorParseRGBA(sett_gui.currentColor)

    -- World update
    self.world:update(dt)

    self.globalColor = {r/255, g/255, b/255, a/255}
    self.currentShape = sett_gui.currentShape
    self.currentState = sett_gui.currentState

    -- Prevent x and y from updating all loops
    if love.mouse.isDown(1) and not pressed and not sett_gui.isHovered then
        x, y = love.mouse.getPosition()
        pressed = true
        self.preview = true

    elseif not love.mouse.isDown(1) and pressed then
        pressed = false
    end

    -- Only update width and height after mouse is pressed (after x and y are set)
    if x and y and not love.mouse.isDown(1) then
        width = love.mouse.getX() - x
        height = love.mouse.getY() - y

        if self.currentShape == "Polygon" then
            if vertices[#vertices - 1] ~= x and vertices[#vertices] ~= y and #vertices < 16 then
                table.insert(vertices, x)
                table.insert(vertices, y)
            end
        end
    end 

    -- If x, y, width and height are set, create a new object
    if x and y and width and height then
        if self.currentShape == "Rectangle" then
            -- Physics doesn't work very well with negative numbers
            x, width = exchangeVerticesX(x, width)
            y, height = exchangeVerticesY(y, height)

            if width <= 0 then
                width = 2
            end

            if height <= 0 then
                height = 2
            end

            objects:add(Rectangle:new(self.world, x, y, width, height, self.globalColor, self.currentState))
            self.preview = false

        elseif self.currentShape == "Circle" then
            if width < 0 then
                width = -width -- To prevent a certain bug, never allow the width to be negative
            end

            if height < 0 then
                height = -height -- To prevent a certain bug, never allow the height to be negative
            end

            objects:add(Circle:new(self.world, x, y, (width + height) / 2, self.globalColor, self.currentState))
            self.preview = false

        elseif self.currentShape == "Polygon" and #vertices >= 6 and #vertices % 2 == 0 and love.keyboard.isDown("e") then
            objects:add(Polygon:new(self.world, x, y, vertices, self.globalColor, self.currentState))

            vertices = {}

            self.preview = false
        end

        x, y, width, height = nil
    end

    -- Delete object
    for i, _obj in ipairs(objects.obj) do
        if collidePoint(_obj, love.mouse.getPosition()) and love.keyboard.isDown("q") then
            _obj.body:destroy()
            _obj.body:release()
            table.remove(objects.obj, i)
        end
    end
end

function Engine:draw()
    -- Draw all objects
    objects:draw()
    
    if self.preview then
        love.graphics.setColor(1, 1, 1)

        if self.currentShape == "Rectangle" then
            drawRectanglePreview(x, y)
            
        elseif self.currentShape == "Circle" then
            drawCirclePreview(x, y)

        elseif self.currentShape == "Polygon" then
            drawPolygonPreview(vertices)
        end
    end

    checkSelect(objects.obj)
end

function beginContact(obj1, obj2, coll)
    
end

function endContact(obj1, obj2, coll)
    
end

function preSolve(obj1, obj2, coll)

end

function postSolve(obj1, obj2, coll, normalImpulse, tangentImpulse)

end


return Engine