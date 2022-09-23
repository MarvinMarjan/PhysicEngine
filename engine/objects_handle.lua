Objects = {}
Objects.__index = Objects

function Objects:new()
    return setmetatable({
        obj = {}
    }, Objects)
end

function Objects:add(object)
    table.insert(self.obj, object)
end

function Objects:get(objFixture)
    for i, object in ipairs(self.obj) do
        if object.fixture == objFixture then
            return object
        end
    end
end

function Objects:draw()
    for i = 1, #self.obj do
        self.obj[i]:draw()
    end
end

return Objects