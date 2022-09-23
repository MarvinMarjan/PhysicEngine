function drawRectanglePreview(x, y)
    love.graphics.rectangle("line", x, y, love.mouse.getX() - x, love.mouse.getY() - y)
end

function drawCirclePreview(x, y)
    love.graphics.circle("line", x, y, (((love.mouse.getX() - x < 0) and -love.mouse.getX() + x or love.mouse.getX() - x) + ((love.mouse.getY() - y < 0) and -love.mouse.getY() + y or love.mouse.getY() - y)) / 2)
end

function drawPolygonPreview(vertices)
    for i, vertex in ipairs(vertices) do
        if i % 2 == 0 then
            if vertices[i + 1] and vertices[i + 2] then
                love.graphics.line(vertices[i - 1], vertices[i], vertices[i + 1], vertices[i + 2])
            end
            love.graphics.line(vertices[#vertices - 1], vertices[#vertices], love.mouse.getPosition())
        end
    end
end

return {drawRectanglePreview, drawCirclePreview, drawPolygonPreview}