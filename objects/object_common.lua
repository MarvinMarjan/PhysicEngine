function collidePoint(obj, x, y)
    return obj.shape:testPoint(obj.body:getX(), obj.body:getY(), 0, x, y)
end

return {collidePoint}