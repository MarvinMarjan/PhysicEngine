function drawRectangleSelect(obj)
    love.graphics.push()
        love.graphics.translate(obj.body:getX(), obj.body:getY())
        love.graphics.rotate(obj.body:getAngle())
        love.graphics.rectangle("line", -obj.width/2 - 1, -obj.height/2 - 1, obj.width + 2, obj.height + 2)
    love.graphics.pop() 
end

function drawCircleSelect(obj)
    love.graphics.circle("line", obj.body:getX(), obj.body:getY(), obj.radius + 1)
end

function drawPolygonSelect(obj)
    love.graphics.polygon("line", obj.body:getWorldPoints(obj.shape:getPoints()))
end

function exchangeVerticesX(x, width)
    if width < 0 then
        x = love.mouse.getX()
        width = -width
    end

    return x, width
end

function exchangeVerticesY(y, height)
    if height < 0 then
        y = love.mouse.getY()
        height = -height
    end

    return y, height
end

return {exchangeVerticesX, exchangeVerticesY, drawRectangleSelect, drawCircleSelect, drawPolygonSelect}