function checkSelect(objects)
    for i, _obj in ipairs(objects) do
        if collidePoint(_obj, love.mouse.getPosition()) then
            if _obj.type == "rectangle" then
                love.graphics.setColor(100/255, 1, 1)
                drawRectangleSelect(_obj)
            
            elseif _obj.type == "circle" then
                love.graphics.setColor(100/255, 1, 1)
                drawCircleSelect(_obj)

            elseif _obj.type == "polygon" then
                love.graphics.setColor(100/255, 1, 1)
                drawPolygonSelect(_obj)
            end
        end
    end
end

return {checkSelect} 